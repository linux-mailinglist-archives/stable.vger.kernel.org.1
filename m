Return-Path: <stable+bounces-6190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495BC80D94C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7984D1C216AC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D7151C3B;
	Mon, 11 Dec 2023 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSmJx1Ca"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6551C2D;
	Mon, 11 Dec 2023 18:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C633EC433C8;
	Mon, 11 Dec 2023 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320755;
	bh=m3vtbQ6prVvjbD3Dp0xaNUO/Sia+JuoyFPATWzsR73s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSmJx1CaiLnYV7QaA8dlsw587dDIvrwnodwpODdW5RXfTSg7Nu7FXqttjJYkJq7Bk
	 19vYgdUQMy/Lml44FBlE/0nbV6LBRjhLTCZfCdZvpbrisvou+eT5UW41+tBOLMQbZj
	 1eob+2RpOKmGse3UjLC5k5mNFZNOKujTZiDXQ8WA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Morris <rtm@csail.mit.edu>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 171/194] smb: client: fix potential NULL deref in parse_dfs_referrals()
Date: Mon, 11 Dec 2023 19:22:41 +0100
Message-ID: <20231211182044.299351032@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

commit 92414333eb375ed64f4ae92d34d579e826936480 upstream.

If server returned no data for FSCTL_DFS_GET_REFERRALS, @dfs_rsp will
remain NULL and then parse_dfs_referrals() will dereference it.

Fix this by returning -EIO when no output data is returned.

Besides, we can't fix it in SMB2_ioctl() as some FSCTLs are allowed to
return no data as per MS-SMB2 2.2.32.

Fixes: 9d49640a21bf ("CIFS: implement get_dfs_refer for SMB2+")
Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2ops.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2834,6 +2834,8 @@ smb2_get_dfs_refer(const unsigned int xi
 		usleep_range(512, 2048);
 	} while (++retry_count < 5);
 
+	if (!rc && !dfs_rsp)
+		rc = -EIO;
 	if (rc) {
 		if (!is_retryable_error(rc) && rc != -ENOENT && rc != -EOPNOTSUPP)
 			cifs_tcon_dbg(VFS, "%s: ioctl error: rc=%d\n", __func__, rc);



