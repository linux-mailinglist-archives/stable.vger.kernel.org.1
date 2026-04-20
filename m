Return-Path: <stable+bounces-239721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CObCIZpa5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:55:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF994303B3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 111A131B00DD
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E9233D6FC;
	Mon, 20 Apr 2026 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JIiXfb1A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026D3396EE;
	Mon, 20 Apr 2026 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701047; cv=none; b=lFhgg2KtspqE15bYubbGa2eObsuqOL0fmLudLdaoBk02bnU7gEcZmNSB8zW8YMhWAMH1FUHfgX9EbAq2BulHUZUO+e7uHY9/LAuuWRwreVwK9M8wdvzQnYAybimGm/P8Hai+dV4k5fCp8FZo5gzYfSxKmCGZMijroKEbuUrKq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701047; c=relaxed/simple;
	bh=SfVrtRfkFPP7Ft8CkDEohLASef10k2fFJjc/Y/WAdDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfeOkx5iGU97WT/6XgaUDH2goA2uQchuiW5U/MneCy1ibHnO1FcZLDWHZG3nV9oJQ96g8NIiqPy1U97+QoXkTBJsU5O6ZZ3O/W95M+L22cGLXkd4X+XxsjCBuM+59c2K1OURasGFqnARVww/gydrsAg6ycxIb8zTsHDG9g6SWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JIiXfb1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E7CC19425;
	Mon, 20 Apr 2026 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701046;
	bh=SfVrtRfkFPP7Ft8CkDEohLASef10k2fFJjc/Y/WAdDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JIiXfb1AKiZ0BKJAIBaoYzZ4/rMeJpHbRUSiZHXttwVIO7dVDOEas7o13dZsaIIaj
	 XbRG4i9AEELz/1akeUa7Rlm1tGpnW6RV+TxP1H56h9NzAUBJ7dny8HhVpdUQqq/9u7
	 nSWVCTIzIarkq0YYgEUmdUzNSAd/vfw3km4rtUcc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ruikai Peng <ruikai@pwno.io>,
	stable@kernel.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	security@kernel.org,
	Stefan Metzmacher <metze@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 143/198] smb: server: avoid double-free in smb_direct_free_sendmsg after smb_direct_flush_send_list()
Date: Mon, 20 Apr 2026 17:42:02 +0200
Message-ID: <20260420153940.758013934@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239721-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,pwno.io,kernel.org,gmail.com,talpey.com,chromium.org,vger.kernel.org,lists.samba.org,samba.org,manguebit.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,manguebit.org:email,samba.org:email,talpey.com:email]
X-Rspamd-Queue-Id: 1EF994303B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

commit 84ff995ae826aa6bbcc6c7b9ea569ff67c021d72 upstream.

smb_direct_flush_send_list() already calls smb_direct_free_sendmsg(),
so we should not call it again after post_sendmsg()
moved it to the batch list.

Reported-by: Ruikai Peng <ruikai@pwno.io>
Closes: https://lore.kernel.org/linux-cifs/CAFD3drNOSJ05y3A+jNXSDxW-2w09KHQ0DivhxQ_pcc7immVVOQ@mail.gmail.com/
Fixes: 34abd408c8ba ("smb: server: make use of smbdirect_socket.send_io.bcredits")
Cc: stable@kernel.org
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Ruikai Peng <ruikai@pwno.io>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: security@kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Tested-by: Ruikai Peng <ruikai@pwno.io>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/transport_rdma.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1473,15 +1473,21 @@ static int smb_direct_post_send_data(str
 	if (ret)
 		goto err;
 
+	/*
+	 * From here msg is moved to send_ctx
+	 * and we should not free it explicitly.
+	 */
+
 	if (send_ctx == &_send_ctx) {
 		ret = smb_direct_flush_send_list(sc, send_ctx, true);
 		if (ret)
-			goto err;
+			goto flush_failed;
 	}
 
 	return 0;
 err:
 	smb_direct_free_sendmsg(sc, msg);
+flush_failed:
 header_failed:
 	atomic_inc(&sc->send_io.credits.count);
 credit_failed:



