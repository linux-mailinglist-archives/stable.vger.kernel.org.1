Return-Path: <stable+bounces-257915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIVLNvohG2oN/ggAu9opvQ
	(envelope-from <stable+bounces-257915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:44:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978661046F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCAF308A5EC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27161349CCF;
	Sat, 30 May 2026 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QndqrGs0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FD32B11F;
	Sat, 30 May 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162597; cv=none; b=Q2+aziw9Ew043ctmM17EboJzmK6rZBgIr3A0VHJTsURJXuel/WKGByWpWU3mrDS9WNYFxgj4RuFxoTPlxDbVpA6PsN+IrqyghhCZHyMnPf5Qy/dcUIHGRB8TjqkQwuwUyLQ7q9Gj4D2EJUdxXlBSyFbu3v9Cs8Va4Vvm82jkFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162597; c=relaxed/simple;
	bh=Di6qQdAVIwmV26ZqOOV8TGmNfdsxSKbbkL2xk+FWZ5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2Euqxcs/AZ+bWbsxzdh8WNsXAAL3qqydtPoCP0cJk5M2FDBsCOdT+AWPKIt/HE4b31wEkp2cWlSuGpPz0+CLD4N2SaFfMsmyGN05ViArxUChdaVu4UuwcsIs/cRlxZedVYjXlYwNXxMfAiVP6MclnakMoEva/Vu6tJZbrXk4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QndqrGs0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3A41F00893;
	Sat, 30 May 2026 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162596;
	bh=7Lj9Es4c+r2Bz4L3dLXNw9Vw+8Ob2zrgZEe1S/EBIUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QndqrGs0tXXo6vi433WiTYbUO8YdBtMkyoLXKGkDLoNDX9EI1sH75a5pcz2+/6mey
	 eitLEQkSPOA9halKiC9xXZeUHFAyVCpA2QhQ0V8lyoHpX+tbblxO/o+WINI+Gdx0jR
	 G0Fu2pUZH1C1ouodA6tVL0tnU7IBxu/kgYxWxe/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Carlini <npc@anthropic.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 969/969] security/keys: fix missed RCU read section on lookup
Date: Sat, 30 May 2026 18:08:13 +0200
Message-ID: <20260530160327.539304944@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-257915-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,namei.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,paul-moore.com:email]
X-Rspamd-Queue-Id: 4978661046F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 43a1e3744548e6fd85873e6fb43e293eb4010694 upstream.

Nicholas Carlini reports that the keyring code calls assoc_array_find()
in find_key_to_update() without holding the RCU read lock, while the
assoc_array_gc() code really is designed around removing the node from
the tree and then freeing it after an RCU grace-period.

The regular key handling doesn't see this because holding the keyring
semaphore hides any lifetime issues, but the persistent key handling
uses a different model.

Instead of extending the keyring locking, just do the simple RCU locking
that the assoc_array was designed for.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris James Morris <jmorris@namei.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/keys/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index b39038f7dd31..5a9887d6b7be 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1109,6 +1109,7 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 	kenter("{%d},{%s,%s}",
 	       keyring->serial, index_key->type->name, index_key->description);
 
+	guard(rcu)();
 	object = assoc_array_find(&keyring->keys, &keyring_assoc_array_ops,
 				  index_key);
 
-- 
2.54.0




