Return-Path: <stable+bounces-83552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E1B99B3DE
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EB2B23C06
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198719B3EC;
	Sat, 12 Oct 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/ORg131"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71519AD97;
	Sat, 12 Oct 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732503; cv=none; b=H4EhnOzYeFcrmi2WweAOIcn/LBYkmVTvEYaDK4f5shD61zC4FylnyKDcg7wl1PltUwE8q4BB/mVZbhK2SyLHeTu2HgaFKMkrz4EKyzOmQ6RBCFg0uO9OWImWBi2opmVbUFKhVc7uE+XhFEjQGq3YxtTDhBLIenWZWltRD8rU4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732503; c=relaxed/simple;
	bh=eIkWCsCR3NMdmMgKN/NA1unm/enojmFve45QFyCY8tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Davv7PfyLc+ZA1hCRuA4NXzewPY6ymGasiqtMS4fuGiX4+Zmqm5NpUXNziuD+LrNFpQVcwo+lXjC7RKX1Y+cuFsiYvmjLNKI672RPSwkTdoMbniuBucqdGrW6iBYESQEMT37MxiQkUwEdv0JfW0kWpwd7lHEsWwiPwGnBWPAelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/ORg131; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6ABC4CECE;
	Sat, 12 Oct 2024 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732503;
	bh=eIkWCsCR3NMdmMgKN/NA1unm/enojmFve45QFyCY8tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/ORg1317O0Lws7XSTavjJsCkyVFaoFzizCA4r5pnE4mZ9gV9jRpuVZegBsXofM9I
	 uolRGLxCFOoh1xDtyPGlAsQBpNcJoTZyyeL7iLmn6nyfPch0VWpMwPGaqb6/kkCVkC
	 Ds4O0p1LP9BQ3Bu1FRUgru+1/Q5OlBWr8jQ6KuvW33MFn1rAxdeYPYXL/b14goyjrB
	 JJn114DUibtNqAdLVvBISefYOfu49iwCJZh5i8burqxMehRJusp0mczlhNehTafqtI
	 u1WJcjrzI+IBIIM6IpUXGTYNaPZwKviP89/VON7kMdojIzpkJ6yXEnTTTfKI/iUQH/
	 8g6YhMIHQ3OmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sangsoo Lee <constant.lee@samsung.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/13] ksmbd: override fsids for smb2_query_info()
Date: Sat, 12 Oct 2024 07:27:51 -0400
Message-ID: <20241012112818.1763719-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit f6bd41280a44dcc2e0a25ed72617d25f586974a7 ]

Sangsoo reported that a DAC denial error occurred when accessing
files through the ksmbd thread. This patch override fsids for
smb2_query_info().

Reported-by: Sangsoo Lee <constant.lee@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d97c7982bb3ee..d018148913615 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5321,6 +5321,11 @@ int smb2_query_info(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "GOT query info request\n");
 
+	if (ksmbd_override_fsids(work)) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
@@ -5339,6 +5344,7 @@ int smb2_query_info(struct ksmbd_work *work)
 			    req->InfoType);
 		rc = -EOPNOTSUPP;
 	}
+	ksmbd_revert_fsids(work);
 
 	if (!rc) {
 		rsp->StructureSize = cpu_to_le16(9);
@@ -5348,6 +5354,7 @@ int smb2_query_info(struct ksmbd_work *work)
 					le32_to_cpu(rsp->OutputBufferLength));
 	}
 
+err_out:
 	if (rc < 0) {
 		if (rc == -EACCES)
 			rsp->hdr.Status = STATUS_ACCESS_DENIED;
-- 
2.43.0


