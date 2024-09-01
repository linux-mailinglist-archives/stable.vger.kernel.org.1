Return-Path: <stable+bounces-72590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBFD967B3E
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216A91F222DC
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88243BB48;
	Sun,  1 Sep 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="riKWb3Yk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B426AC1;
	Sun,  1 Sep 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210427; cv=none; b=dvmwwMmJGNQJ3JcylRovDx2+saWLS3TJ4aDM0I6tbLh1Yy40GcTU/OWUU9iSzDQq0f6DlNj5NIM+ut0rZRDYtCYBqUMgKNsUdGayGqPxGPzp+8i62cDATf42WVh1N4jGpaPegU/v3VFbcvP1/UM5iIU1jvGf3/MB0xL72Tbx1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210427; c=relaxed/simple;
	bh=R8z8UEIGJuufqgN+RcMielTXqsoA3JB0CfmcNzspq38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBdvEuIgba9cUT2t5mLv9WZyW8Ja2Ju8MydycS4U5gH9n/luxo3vv5bhy2lv67fsf9ckFG7MAtA+98SWDVtbpTUQ9gv8/2cAnmBWaX+ZvirmvisqgMbuVyQS2HTxR6Flx4zPb7W2ffw551RQmbt08oqPzTUAaCep3S7I57yqrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=riKWb3Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BD9C4CEC3;
	Sun,  1 Sep 2024 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210427;
	bh=R8z8UEIGJuufqgN+RcMielTXqsoA3JB0CfmcNzspq38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=riKWb3YkIF++OBvax0g+b0oZjtu8kio7FiMVc6eCZCPedUYNBwYfktnm8H3dmFddL
	 P5qfz5Me9U2NywiGpzr5FKGPtrYVXCaYSPPRQvh/p0DeK6CkdzJnz4lUtqkht0PJvY
	 ZyZ7f83RuRNK8cxG7sn2Wb66275E6BWt963IhcuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 187/215] ksmbd: the buffer of smb2 query dir response has at least 1 byte
Date: Sun,  1 Sep 2024 18:18:19 +0200
Message-ID: <20240901160830.426516431@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit ce61b605a00502c59311d0a4b1f58d62b48272d0 ]

When STATUS_NO_MORE_FILES status is set to smb2 query dir response,
->StructureSize is set to 9, which mean buffer has 1 byte.
This issue occurs because ->Buffer[1] in smb2_query_directory_rsp to
flex-array.

Fixes: eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with flex-arrays")
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 57f59172d8212..3458f2ae5cee4 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4160,7 +4160,8 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->OutputBufferLength = cpu_to_le32(0);
 		rsp->Buffer[0] = 0;
 		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
-				       sizeof(struct smb2_query_directory_rsp));
+				       offsetof(struct smb2_query_directory_rsp, Buffer)
+				       + 1);
 		if (rc)
 			goto err_out;
 	} else {
-- 
2.43.0




