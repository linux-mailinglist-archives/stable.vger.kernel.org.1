Return-Path: <stable+bounces-155578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9564AE42BA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2987189B806
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08B253958;
	Mon, 23 Jun 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkI2qK+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86AC253B52;
	Mon, 23 Jun 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684789; cv=none; b=Y3bpmqoleBIzjGiiljuFx3r6lZFyR9Y6smejAhfYPk3t8Tk+CiqDB9nnBOpRzyjFkiShAqLA8/T7MlCd8vIXjF38xkjSV0UVr/g8ZLKU66eaO8mQBI9YQIRGTU2+wAbCtL7k0PNEpyApzp0P/6kxe+akDKpE/eUZGt7KXwEfyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684789; c=relaxed/simple;
	bh=82yQVSshHw97MmAC6ToF7YR8mufkoknd92jlmZMznVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uC9Cx5ed2ooSwk/EEPmnHcagj4+OL/REhbJPIt8SBEjoXmBkkDbCEgQgRpP6zMv4YwEyJxfPmszaHq8M69DHIrpTmHLvOlulxu0PsZqxH+N+9p9AKn0evtigYUOR+WZoL5sEKbF2n11clH4hsZJXecL+lqO1ZKMU2WMPkG8Oe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkI2qK+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6D0C4CEF0;
	Mon, 23 Jun 2025 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684789;
	bh=82yQVSshHw97MmAC6ToF7YR8mufkoknd92jlmZMznVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkI2qK+2UPvVAkRVC2Q/iKolqaZSwCAjcMJMUnEa2w1RhXQXp+NmcJsyy3Y2fsBR7
	 UakHHmseIm9BRkyk1MVcKb2ryuaFc/RAeJrsRv8CeUIuw4kXHyARx3VwXjZe3/A0+k
	 2GKzgdk1OzUyprJn0LPB/K7t/sryxHl9BDBLu2kc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.15 173/592] cifs: reset connections for all channels when reconnect requested
Date: Mon, 23 Jun 2025 15:02:11 +0200
Message-ID: <20250623130704.393071093@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit 1f396b9bfe39aaf55ea74a7005806164b236653d upstream.

cifs_reconnect can be called with a flag to mark the session as needing
reconnect too. When this is done, we expect the connections of all
channels to be reconnected too, which is not happening today.

Without doing this, we have seen bad things happen when primary and
secondary channels are connected to different servers (in case of cloud
services like Azure Files SMB).

This change would force all connections to reconnect as well, not just
the sessions and tcons.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -377,6 +377,13 @@ static int __cifs_reconnect(struct TCP_S
 	if (!cifs_tcp_ses_needs_reconnect(server, 1))
 		return 0;
 
+	/*
+	 * if smb session has been marked for reconnect, also reconnect all
+	 * connections. This way, the other connections do not end up bad.
+	 */
+	if (mark_smb_session)
+		cifs_signal_cifsd_for_reconnect(server, mark_smb_session);
+
 	cifs_mark_tcp_ses_conns_for_reconnect(server, mark_smb_session);
 
 	cifs_abort_connection(server);



