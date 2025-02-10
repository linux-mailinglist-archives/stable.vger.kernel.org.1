Return-Path: <stable+bounces-114538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFAA2ED33
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4D3A02BB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9F8222574;
	Mon, 10 Feb 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fiDuaJ0N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBBF223323
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192782; cv=none; b=QwJIDVLVC2GY1B+klxSlcnGMCioR4MJmXgpWCqCnRN6ieKERc3lBMx43Gtwr8F262PO11YX60GCKPCnY/K29HK3mA2ZuVYtn7nkFhTrTHr08RfYZjivZkST+9oA8V+q667U1aQirkAGYeb93wo9Et06emQB/wZzSvpWyVqF3g3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192782; c=relaxed/simple;
	bh=X7qO+Gl+V12ISABk0nUMVp0u7EwTZh+1AKeL2l4nLx4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cBCWeKDA0RGTaJZ10cMkNEDytb+LbBUwV6TJOTpK9CrNml0dOZYmdQY5+HMU8OBajDj3qQTTm79CS/J2nQVInO2x6gcXmHtqPI90h+Py4QJgM3HqloboUAzGP9dqbXoT7Js8w/85z177smA/8Ej5AHC4NfbgonVbU4liz/8FkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fiDuaJ0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3308C4CED1;
	Mon, 10 Feb 2025 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739192781;
	bh=X7qO+Gl+V12ISABk0nUMVp0u7EwTZh+1AKeL2l4nLx4=;
	h=Subject:To:Cc:From:Date:From;
	b=fiDuaJ0NfcZJH+jNlMaCGHimobDrDUb7FuCOIyy0v8aWbJlsKRlQZe/wnL7H6a+F3
	 EbW6dMbEZWWn8ijB5l7qoxBYiPZwf32W6NLESQ0WivZ+Ko9egP8fG0xdSIeELJzuBF
	 eR9d87PWZp0WfS802A5gOqi/2b66wIP550HsWHLU=
Subject: FAILED: patch "[PATCH] ksmbd: fix integer overflows on 32 bit systems" failed to apply to 5.15-stable tree
To: dan.carpenter@linaro.org,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:06:18 +0100
Message-ID: <2025021018-blurry-lukewarm-5d5d@gregkh>
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
git cherry-pick -x aab98e2dbd648510f8f51b83fbf4721206ccae45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021018-blurry-lukewarm-5d5d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aab98e2dbd648510f8f51b83fbf4721206ccae45 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Wed, 15 Jan 2025 09:28:35 +0900
Subject: [PATCH] ksmbd: fix integer overflows on 32 bit systems

On 32bit systems the addition operations in ipc_msg_alloc() can
potentially overflow leading to memory corruption.
Add bounds checking using KSMBD_IPC_MAX_PAYLOAD to avoid overflow.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index c0bb8c7722d7..0460ebea6ff0 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -627,6 +627,9 @@ ksmbd_ipc_spnego_authen_request(const char *spnego_blob, int blob_len)
 	struct ksmbd_spnego_authen_request *req;
 	struct ksmbd_spnego_authen_response *resp;
 
+	if (blob_len > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_spnego_authen_request) +
 			blob_len + 1);
 	if (!msg)
@@ -806,6 +809,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	struct ksmbd_rpc_command *req;
 	struct ksmbd_rpc_command *resp;
 
+	if (payload_sz > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
 	if (!msg)
 		return NULL;
@@ -854,6 +860,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	struct ksmbd_rpc_command *req;
 	struct ksmbd_rpc_command *resp;
 
+	if (payload_sz > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
 	if (!msg)
 		return NULL;


