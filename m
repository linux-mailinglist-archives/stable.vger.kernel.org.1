Return-Path: <stable+bounces-185651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE55DBD9706
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111FC501C07
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165FF21CC55;
	Tue, 14 Oct 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjM4nkWr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DE19F135
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445953; cv=none; b=ayyvtZCNuh7Ks0KQnIaOtViD/JK4kkjd7ZLpr8lMgt2L7ieGdOXQSkKKLzk06cyRQQGmXUbagt+KJHZ7WDYw6+OCi03E+fqeVzrqHAJlxl7g2Xhqawb931wGwWyvmGQ4lxMiPBJpC16VB4EuP6jp7AyvAP7Oa3gb5URkmy9G6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445953; c=relaxed/simple;
	bh=uH9Jx6CBy3u8z1GhKitex81nD8smmfL/NfAyoCTwaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evKLbnx+ATUjkVt4NLmZbpo+p8RP1WujoqVceXZhjEZpWsRrFvx2rDbUXbvW2IENjmqxwdT41UbKCy7qs4uNABrm7i53occQ2AS+EM1Gb0JWadFDqTB8xdpenwr81b792AZ38pCELVeN1MmRf01sja6pwXprVoaQ/fSrztNUWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjM4nkWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D63C4CEE7;
	Tue, 14 Oct 2025 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760445953;
	bh=uH9Jx6CBy3u8z1GhKitex81nD8smmfL/NfAyoCTwaOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjM4nkWreL5T++Hm7cSOOenAC3iVW99yFERX5TahCXozQ2PFOq6ZU1hMcq9TZgV3d
	 I6riWPfsWHZMHCtbowWa979YFaZzkxu+kLrB8GeautqC7fC0PRTA1cu+WkManW2JtC
	 E1xgOGsQeEI9KTjtvMc8dePyRILW1YoMjvxEqjj93SNcCp7y+ILPZMTQ1T/iyFJvI0
	 9b5tA7qDUc6tARpTdUVgXO6YmuEcY323bUMruxvKbKQ3V/VPShrhgootpblitgwQJF
	 1H0KN2Sj7XxfN9QErQiZVy9KooWoMbGSF9u+ZNkcv4LAYZsNc85AkMI0483PpGvCMu
	 WArPY1oPcP/5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matvey Kovalev <matvey.kovalev@ispras.ru>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix error code overwriting in smb2_get_info_filesystem()
Date: Tue, 14 Oct 2025 08:45:50 -0400
Message-ID: <20251014124550.2777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101324-echo-cardinal-3043@gregkh>
References: <2025101324-echo-cardinal-3043@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matvey Kovalev <matvey.kovalev@ispras.ru>

[ Upstream commit 88daf2f448aad05a2e6df738d66fe8b0cf85cee0 ]

If client doesn't negotiate with SMB3.1.1 POSIX Extensions,
then proper error code won't be returned due to overwriting.

Return error immediately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ adjusted file path from fs/smb/server/smb2pdu.c to fs/ksmbd/smb2pdu.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 3439dbad93895..c0b5985701bf8 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5204,7 +5204,8 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
-			rc = -EOPNOTSUPP;
+			path_put(&path);
+			return -EOPNOTSUPP;
 		} else {
 			info = (struct filesystem_posix_info *)(rsp->Buffer);
 			info->OptimalTransferSize = cpu_to_le32(stfs.f_bsize);
-- 
2.51.0


