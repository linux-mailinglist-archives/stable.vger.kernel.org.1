Return-Path: <stable+bounces-256008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I4cJ4qoGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-256008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4791A5F9572
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 177CA30A59DD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7EB33372A;
	Thu, 28 May 2026 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lk6yvr6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD472F1FEC;
	Thu, 28 May 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000497; cv=none; b=KCcCVvBs+3QBzZLgq2/4G6dHVObYuI5cXeB7UJELj/AGSXKjS7rKiaRm0OSLek5aNuOTuwitOkGi4OKJ9dLXKuTM+Rij0Gok7npIv0a8IG9wijx9P8LWclRRTZWDYhjdRvGe0UqhRhQs6h7YfQ+LLN0aa0Ln/OSXhDoxILF4kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000497; c=relaxed/simple;
	bh=0wSvuOAL5KhCRo+9lOEeHso1TXj2guotSDw7OeZRRdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXkrbuFFIVrW28fjgJyiVKiULUdOP6dWaCZNhowxrEbfY2rSXvW14/rxC7dU+YGoG8Xbjn6gR37Eh2D9Yagpn9PL1WZqYHVN5DGZ7zXLEgMpSsEN9C+XJ8FROg3BWqtbuChxHufoghUjeNvX1V6UC5TeDKg5yBo2qggtoUFazfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lk6yvr6d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968D61F000E9;
	Thu, 28 May 2026 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000496;
	bh=fEVBkcLhwdR+w5tlX+D02/CZ9ITVHG+H6KiK2fSS0+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lk6yvr6dZiIhUBG8+5lPX7DgoL8avZfiDxQLpsjavM4i6bmg6JSha3KU0beCBausW
	 pnuatbwIGiLkIQXIRA0090BiMxys47pUtYjnnysQF9Khq/KxGuFkt7qynDhCj+eqIJ
	 3uR9dqLa/o6XGqz0kEZqYs593lFSlQvjYQusPc3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 048/272] smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()
Date: Thu, 28 May 2026 21:47:02 +0200
Message-ID: <20260528194630.727278364@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256008-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4791A5F9572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henrique Carvalho <henrique.carvalho@suse.com>

commit 4d8690dace005a38e6dbde9ecce2da3ad85c7c41 upstream.

Commit 96c4af418586 ("cifs: Fix locking usage for tcon fields")
refactored cifs code to change cifs_tcp_ses_lock for tc_lock around
tc_count changes.

There was missing lock around tc_count increment inside
smb2_find_smb_sess_tcon_unlocked().

Cc: stable@vger.kernel.org
Fixes: 96c4af418586 ("cifs: Fix locking usage for tcon fields")
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2transport.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -214,7 +214,9 @@ smb2_find_smb_sess_tcon_unlocked(struct
 	list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 		if (tcon->tid != tid)
 			continue;
+		spin_lock(&tcon->tc_lock);
 		++tcon->tc_count;
+		spin_unlock(&tcon->tc_lock);
 		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 				    netfs_trace_tcon_ref_get_find_sess_tcon);
 		return tcon;



