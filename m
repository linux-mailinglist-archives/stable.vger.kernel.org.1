Return-Path: <stable+bounces-236444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HIzDw8Z3Wn3ZwkAu9opvQ
	(envelope-from <stable+bounces-236444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E743EEE46
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D6ED3196A7D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75F528B4FD;
	Mon, 13 Apr 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0fv/+m9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3202F6931;
	Mon, 13 Apr 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096921; cv=none; b=Cq7Z8ccCn4H/AkfmOgKdn2sqadNJR/boocibvbkjuHLhBm3deJEfQehlPIT0FVlFKaGxrRce7rjVmQ2Nf4NWTBqvnWjlUmGiq4XbjLugoJk3TpyY3YEHIs7aQP9IyJYP1Ot63hwEgtODlmEX4nWn8sweIJntu5WfMSBC7soehPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096921; c=relaxed/simple;
	bh=hU5B5e/VsFwNSd+2ce7IrOwXIC2TGnnmHAJZoKV2uhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAxgYL3vtmSGRUtjkg1T6/nr9zM3LToxeCQj16ddXsWqGkFb4GRDi/4NVZjUZ84QOwOeAy9CVtN1rHmDBJQ+EIyJKrPYMDpwkMi5kU5W+kSETlvAF7C1vpv6OUWaVl+tkD9aLX17+BrHvDHuPQHT3afwOuqruLjd28iDiHBg8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0fv/+m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D084DC2BCAF;
	Mon, 13 Apr 2026 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096921;
	bh=hU5B5e/VsFwNSd+2ce7IrOwXIC2TGnnmHAJZoKV2uhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y0fv/+m95ZhF6asAtyw1jimdUm9ubZwCYtx16ykkwGicvLPCHeKd8XqEXBlp+cXik
	 42OFfiSC19jstmzw7FTkhvAMoveSRCdLOLRJAfpj/zqvNRfAvj3qnoyhodnjYPibLX
	 abutzQWCPYtoufOf/sDSqcWhWFtdtbtMFuPpnNX0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anderson Nascimento <anderson@allelesecurity.com>,
	David Howells <dhowells@redhat.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 44/50] rxrpc: Fix key reference count leak from call->key
Date: Mon, 13 Apr 2026 18:01:11 +0200
Message-ID: <20260413155726.154723440@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236444-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.212.49:email,auristor.com:email,allelesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,infradead.org:email]
X-Rspamd-Queue-Id: B5E743EEE46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anderson Nascimento <anderson@allelesecurity.com>

commit d666540d217e8d420544ebdfbadeedd623562733 upstream.

When creating a client call in rxrpc_alloc_client_call(), the code obtains
a reference to the key.  This is never cleaned up and gets leaked when the
call is destroyed.

Fix this by freeing call->key in rxrpc_destroy_call().

Before the patch, it shows the key reference counter elevated:

$ cat /proc/keys | grep afs@54321
1bffe9cd I--Q--i 8053480 4169w 3b010000  1000  1000 rxrpc     afs@54321: ka
$

After the patch, the invalidated key is removed when the code exits:

$ cat /proc/keys | grep afs@54321
$

Fixes: f3441d4125fc ("rxrpc: Copy client call parameters into rxrpc_call earlier")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-9-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/call_object.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -695,6 +695,7 @@ static void rxrpc_destroy_call(struct wo
 	rxrpc_put_bundle(call->bundle, rxrpc_bundle_put_call);
 	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
 	rxrpc_put_local(call->local, rxrpc_local_put_call);
+	key_put(call->key);
 	call_rcu(&call->rcu, rxrpc_rcu_free_call);
 }
 



