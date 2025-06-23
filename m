Return-Path: <stable+bounces-156652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF02AE507B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84434401BA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D551F4628;
	Mon, 23 Jun 2025 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vCLK8AA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B21E51FA;
	Mon, 23 Jun 2025 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713937; cv=none; b=UEnrd0jXvmOyxgYL5nxYE6FDohLJVxcHlwG02LIChrgW8kDxev27N9wX0KucGpS+SQkkDJIaqhQD8y9tU77OfXfmSTbvMmrPw1edLrB/HaPlrLnlEANNsm7uNQg7pxLlU89xMuVhhfwzg65uBg29Hcdn50ijyjmMpO2/SfgcOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713937; c=relaxed/simple;
	bh=32FkWqIu3wM5sCrl7XrYFT09VBq1Rm0Gwe1qtsC/3B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORMXiryA3qG0yh60ux0ZgvP212X63E2XDtQdG7Q/H4gjqDwJWwAXw1Y+ZI1R1A9WX4jqeP8swMVMrllEvsVg5AYFhL4vtaJt2gW8m++6i94FJBZG6TJ93+tgaQaaafVF7s8gv+UY1GwRJuQ2FYtZNvc8mdLkpVZBu1RtWlQpUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vCLK8AA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AEAC4CEEA;
	Mon, 23 Jun 2025 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713937;
	bh=32FkWqIu3wM5sCrl7XrYFT09VBq1Rm0Gwe1qtsC/3B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCLK8AA+yt/ii4eJaoFHmcx/3rRrMgLlxbCvHIfm2c9z2CKuW1B2VuyvQqBB5JxdW
	 juTFwgPPiHHRw7DeJmLf7Ir2VEfuj6TzctECEihHMw0KvDidi7ciImxqDesnN9FCeU
	 3MX5XFCuCd9AepgwCxm5AZPYpV6FggL/Od4hlKFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 104/290] cifs: dns resolution is needed only for primary channel
Date: Mon, 23 Jun 2025 15:06:05 +0200
Message-ID: <20250623130630.086054430@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit b4f60a053a2534c3e510ba0c1f8727566adf8317 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -408,7 +408,8 @@ static int __cifs_reconnect(struct TCP_S
 		try_to_freeze();
 		cifs_server_lock(server);
 
-		if (!cifs_swn_set_server_dstaddr(server)) {
+		if (!cifs_swn_set_server_dstaddr(server) &&
+		    !SERVER_IS_CHAN(server)) {
 			/* resolve the hostname again to make sure that IP address is up-to-date */
 			rc = reconn_set_ipaddr_from_hostname(server);
 			cifs_dbg(FYI, "%s: reconn_set_ipaddr_from_hostname: rc=%d\n", __func__, rc);



