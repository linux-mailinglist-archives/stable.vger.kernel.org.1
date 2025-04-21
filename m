Return-Path: <stable+bounces-134825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A313A95235
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B0F1894600
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A1F510;
	Mon, 21 Apr 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BvMJCvFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB3266588
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243917; cv=none; b=uKNZoArJ3quV0X5rDLPDi89/ADR6Px5eu5JGRnHRNxkDJ62ch5Fvqfsr+eLD5xzheniHFY5y38n2qkzrn6AXOL57eiNVs2TYq68Q/5paEUoKHfykGBoRAXlKKnZA/8BssSHoIZQ+wWvLzpZTGnUWzWzbIta9TqYmGTEYBQr82bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243917; c=relaxed/simple;
	bh=GRwJcijUf5SEUMs+G9JjsBaTFYWO1ZBh/2zTbUo9KDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vB3cUEku8wSIx77yvAUq4PMDQdoBQLPg3sJPVjQpr4BMCz4BTl45BosAbIL65XXxSlZBWmNt7cLg9107swL7NnzLDRQ5XNMJtR/talxVnPghoPfcrPyaU5vZwFdi+3X8h6CGOKOp4wjpju0J1TNvST2KxWrzY4Zbej2fo50DZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BvMJCvFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8231C4CEE4;
	Mon, 21 Apr 2025 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243917;
	bh=GRwJcijUf5SEUMs+G9JjsBaTFYWO1ZBh/2zTbUo9KDE=;
	h=Subject:To:Cc:From:Date:From;
	b=BvMJCvFDOutHjaDFHGAp1vyKUdfhrrwA65Vokp4c9nmsQUMpqusq7appQ7Lvvkdl2
	 T0MiySSEE+7D0NfbZSvJvNH4zICm07RnKyLsI0AEPuMyVJXdKH6oV2M2qNzL30COMx
	 Sjx4WA3i3stCJTw2chRy89LdXuvuNeqXf9U/DVZk=
Subject: FAILED: patch "[PATCH] ksmbd: Prevent integer overflow in calculation of deadtime" failed to apply to 5.15-stable tree
To: arefev@swemel.ru,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:58:34 +0200
Message-ID: <2025042134-thriving-decimeter-0201@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a93ff742820f75bf8bb3fcf21d9f25ca6eb3d4c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042134-thriving-decimeter-0201@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a93ff742820f75bf8bb3fcf21d9f25ca6eb3d4c6 Mon Sep 17 00:00:00 2001
From: Denis Arefev <arefev@swemel.ru>
Date: Wed, 9 Apr 2025 12:04:49 +0300
Subject: [PATCH] ksmbd: Prevent integer overflow in calculation of deadtime

The user can set any value for 'deadtime'. This affects the arithmetic
expression 'req->deadtime * SMB_ECHO_INTERVAL', which is subject to
overflow. The added check makes the server behavior more predictable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 3f185ae60dc5..2a3e2b0ce557 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -310,7 +310,11 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	server_conf.signing = req->signing;
 	server_conf.tcp_port = req->tcp_port;
 	server_conf.ipc_timeout = req->ipc_timeout * HZ;
-	server_conf.deadtime = req->deadtime * SMB_ECHO_INTERVAL;
+	if (check_mul_overflow(req->deadtime, SMB_ECHO_INTERVAL,
+					&server_conf.deadtime)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	server_conf.share_fake_fscaps = req->share_fake_fscaps;
 	ksmbd_init_domain(req->sub_auth);
 
@@ -337,6 +341,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	server_conf.bind_interfaces_only = req->bind_interfaces_only;
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
+out:
 	if (ret) {
 		pr_err("Server configuration error: %s %s %s\n",
 		       req->netbios_name, req->server_string,


