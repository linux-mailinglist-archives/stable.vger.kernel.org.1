Return-Path: <stable+bounces-1328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545207F7F1F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5C128247A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F954364A4;
	Fri, 24 Nov 2023 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="osN6U/IH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D812F86B;
	Fri, 24 Nov 2023 18:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C47DC433C8;
	Fri, 24 Nov 2023 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851125;
	bh=tK+oAe0yZHVZ87OoFloS7QMYJm+LLpvgmoAHpproNkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osN6U/IH8S+JI3SSGzp9hjxY1OSUQ26l0EbsGoDDO8iPKj2ZjZ9VDwCfoILirnri+
	 5UWJ7GF8IKlTsIoRnOm0FpmcHyS/m79rb70msKkSLCrnaxqHDNpwyspZ1CZuYXBc96
	 V3tEykQ5v+SATmTOQA9mK/9JcbN0vtU2DxnT27ME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 6.5 299/491] ksmbd: fix slab out of bounds write in smb_inherit_dacl()
Date: Fri, 24 Nov 2023 17:48:55 +0000
Message-ID: <20231124172033.555724824@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit eebff19acaa35820cb09ce2ccb3d21bee2156ffb upstream.

slab out-of-bounds write is caused by that offsets is bigger than pntsd
allocation size. This patch add the check to validate 3 offsets using
allocation size.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-22271
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smbacl.c |   29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1107,6 +1107,7 @@ pass:
 		struct smb_acl *pdacl;
 		struct smb_sid *powner_sid = NULL, *pgroup_sid = NULL;
 		int powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
+		int pntsd_alloc_size;
 
 		if (parent_pntsd->osidoffset) {
 			powner_sid = (struct smb_sid *)((char *)parent_pntsd +
@@ -1119,9 +1120,10 @@ pass:
 			pgroup_sid_size = 1 + 1 + 6 + (pgroup_sid->num_subauth * 4);
 		}
 
-		pntsd = kzalloc(sizeof(struct smb_ntsd) + powner_sid_size +
-				pgroup_sid_size + sizeof(struct smb_acl) +
-				nt_size, GFP_KERNEL);
+		pntsd_alloc_size = sizeof(struct smb_ntsd) + powner_sid_size +
+			pgroup_sid_size + sizeof(struct smb_acl) + nt_size;
+
+		pntsd = kzalloc(pntsd_alloc_size, GFP_KERNEL);
 		if (!pntsd) {
 			rc = -ENOMEM;
 			goto free_aces_base;
@@ -1136,6 +1138,27 @@ pass:
 		pntsd->gsidoffset = parent_pntsd->gsidoffset;
 		pntsd->dacloffset = parent_pntsd->dacloffset;
 
+		if ((u64)le32_to_cpu(pntsd->osidoffset) + powner_sid_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
+		if ((u64)le32_to_cpu(pntsd->gsidoffset) + pgroup_sid_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
+		if ((u64)le32_to_cpu(pntsd->dacloffset) + sizeof(struct smb_acl) + nt_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
 		if (pntsd->osidoffset) {
 			struct smb_sid *owner_sid = (struct smb_sid *)((char *)pntsd +
 					le32_to_cpu(pntsd->osidoffset));



