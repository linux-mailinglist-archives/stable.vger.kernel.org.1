Return-Path: <stable+bounces-155060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0928AE175A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E364A6620
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C5280333;
	Fri, 20 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ryLqeAg/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A61E2607
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411204; cv=none; b=nM9Jx7F2d35vXDxzLfThDzQ+0vM/q1S7KATIFJlI49U3ihAPuS+m5WOtL7FTamUcDJrlv0wIKP1kc4T/w59j+WxJ+KtOFOZ9S7XSkfrKNnVmzgGX5qHtT+a0nv8N6RXez7lNCiaEFIIUq5YQC8v9xlshE308Lksf5RVJYErThPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411204; c=relaxed/simple;
	bh=lhtA70pmXd1LCdTVUBf+iDOGxzZZ0L55CVkfsP9sSZw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rjmqxr24VeyOVixKb7FfPcixUKqhjgh+1sGpEU+qOlvF6DhsRUpgHBH5wYHm0UHMnrO06nNc/vPJYB5nWm9rb/W8pbHYTzklofSftyc/mt4KXZ24bYksHjIT7KTaqMAlRhD0f30eSPHXODApOC+L1aC9PdViMOPob6tpXOKpYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ryLqeAg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A61C4CEED;
	Fri, 20 Jun 2025 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750411204;
	bh=lhtA70pmXd1LCdTVUBf+iDOGxzZZ0L55CVkfsP9sSZw=;
	h=Subject:To:Cc:From:Date:From;
	b=ryLqeAg/hnnQYzIcbb2IkYapnCw5D9ym66D0stlcfi1CFfC6PLeisKCQ8Ro40eSny
	 XN3032w6NRp9XVf32zRGPwc/JmnmDk+nZdCfJLK3d+lmYT4UptCVBlLzYymiqdDGV1
	 NzDUxS09Xu11HWAUFpF74BOAlmw8INdSbgS7eb2Y=
Subject: FAILED: patch "[PATCH] cifs: dns resolution is needed only for primary channel" failed to apply to 6.1-stable tree
To: sprasad@microsoft.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:20:01 +0200
Message-ID: <2025062001-pueblo-aching-e101@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b4f60a053a2534c3e510ba0c1f8727566adf8317
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062001-pueblo-aching-e101@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4f60a053a2534c3e510ba0c1f8727566adf8317 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Mon, 2 Jun 2025 22:37:16 +0530
Subject: [PATCH] cifs: dns resolution is needed only for primary channel

When calling cifs_reconnect, before the connection to the
server is reestablished, the code today does a DNS resolution and
updates server->dstaddr.

However, this is not necessary for secondary channels. Secondary
channels use the interface list returned by the server to decide
which address to connect to. And that happens after tcon is reconnected
and server interfaces are requested.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index ca1cb01c6ef8..024817d40c5f 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -392,7 +392,8 @@ static int __cifs_reconnect(struct TCP_Server_Info *server,
 		try_to_freeze();
 		cifs_server_lock(server);
 
-		if (!cifs_swn_set_server_dstaddr(server)) {
+		if (!cifs_swn_set_server_dstaddr(server) &&
+		    !SERVER_IS_CHAN(server)) {
 			/* resolve the hostname again to make sure that IP address is up-to-date */
 			rc = reconn_set_ipaddr_from_hostname(server);
 			cifs_dbg(FYI, "%s: reconn_set_ipaddr_from_hostname: rc=%d\n", __func__, rc);


