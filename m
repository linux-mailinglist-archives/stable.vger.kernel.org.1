Return-Path: <stable+bounces-158018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44590AE56A9
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CE14E0D3A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F2223DE5;
	Mon, 23 Jun 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUW74p2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA22192EC;
	Mon, 23 Jun 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717282; cv=none; b=QLfmO3L12QSHnsQpQwp91ZYnDwLBoE+IXSWtbCMub3Y3WSgK+K84dUqwUUJS0dK6Sb64ewo2ne7n8Rc3O/D70TX0/QDY6s1RC1w8RN/R2GzUp5ix8vx51ZezH5NyUcJqd3Xzgo9cyNxzPP4plE/uyD/JltdSYO/++k2H5rqfdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717282; c=relaxed/simple;
	bh=R83DXez0/BevVHHBAnJUScvQYbamP9INLpsRwC7o1Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDxRzAI2Kv5EjfvwJXiyVCrnsVlJRh8j1YylL7DstnF+5ZRaXk03WCIIF0oCH1a4RG8h7T6O9u0/YR6OO9YoQ8RXnJq6dJE1xLpAOaBYDa3S65Y5JytHypF739c6QQpLR/gEBrj1y9+6Qvw7FrM5CYMG9aXjgHFnNz9uhm1to9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUW74p2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF361C4CEED;
	Mon, 23 Jun 2025 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717282;
	bh=R83DXez0/BevVHHBAnJUScvQYbamP9INLpsRwC7o1Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUW74p2WBQ5FZFO1lmLTqo7x0ixfojbnMc2rMTPYGyBtBl5ku4xPk0knJ96ZmBpST
	 Uz6zLGk+NrJBxIxTcvFtwtSrEJWfWr/wPw9kBr11j/6ZBWQOhmWs+nnCmZxmqmkvjU
	 rIwwI26mlFbNWJQQN7JHXvIy4NpbM4x3Occ7I5ec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	xfuren <xfuren@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 352/414] smb: fix secondary channel creation issue with kerberos by populating hostname when adding channels
Date: Mon, 23 Jun 2025 15:08:09 +0200
Message-ID: <20250623130650.774601200@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharath SM <bharathsm@microsoft.com>

commit 306cb65bb0cb243389fcbd0a66907d5bdea07d1e upstream.

When mounting a share with kerberos authentication with multichannel
support, share mounts correctly, but fails to create secondary
channels. This occurs because the hostname is not populated when
adding the channels. The hostname is necessary for the userspace
cifs.upcall program to retrieve the required credentials and pass
it back to kernel, without hostname secondary channels fails
establish.

Cc: stable@vger.kernel.org
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reported-by: xfuren <xfuren@gmail.com>
Link: https://bugzilla.samba.org/show_bug.cgi?id=15824
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/sess.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -526,8 +526,7 @@ cifs_ses_add_channel(struct cifs_ses *se
 	ctx->domainauto = ses->domainAuto;
 	ctx->domainname = ses->domainName;
 
-	/* no hostname for extra channels */
-	ctx->server_hostname = "";
+	ctx->server_hostname = ses->server->hostname;
 
 	ctx->username = ses->user_name;
 	ctx->password = ses->password;



