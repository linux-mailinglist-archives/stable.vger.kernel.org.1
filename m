Return-Path: <stable+bounces-242649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q/ffLGkb92l9cAIAu9opvQ
	(envelope-from <stable+bounces-242649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 11:54:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F41B34B5173
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0B730075F5
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EAB3AEF3B;
	Sun,  3 May 2026 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MRryfWbh"
X-Original-To: stable@vger.kernel.org
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8791A6830
	for <stable@vger.kernel.org>; Sun,  3 May 2026 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777802084; cv=none; b=lbnw4XXVHadYYfQpJt9jy56MAzqHAiqo5paDUN4PLX1/Zb1LHTJFg+PY5jY3/z6I6E4Jri3cFFa3XEeruV0bpsxA1uK0uMQAPK3qJU1cmuNJk/a6URukBnfz7V/scUNG6it7GoT7SfPT4l/a9f5mnQz1XWEf3murBui0M52Jw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777802084; c=relaxed/simple;
	bh=qaKdlYi9mh75yvY2vaFX7bI/dT+6B8plMsy+RA7q504=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9NFtZoRJrdTkgK9n8Cmy7gRi7lizofB92i5FNk4r8mmGs4miYKc240fAv1sbwgARuqafIvD+d+U2pWY2hDrk5lT1QP+wrOwCwIUMZoyP26tTRlouaAeS/javHrff787nBd5opBnC50SOC5QmBzpM26rLZsx6KBsxU3GopiKAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MRryfWbh; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1777802071; x=1778061271;
	bh=DMPl+I7gCIBAicLvSvd1qcqrOBY5VIr4aLfhMjh04u8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MRryfWbhmg5qgNSrYdmITLQAUYjvMYmYpDqpC7cOYIGJS3O8nBF6atg+cJi+O1LbW
	 g23PSFdrtuj8fpL5JgmV/taP+QFhysY9sgettuE2/WzCEUCXMjjgdaP1IqY8K19e0M
	 XOX5o+RXYiKoPm4FdLTK7lapZjTlJqMcv4y8+kmzrXzKUncyeAdEne3GDHN6A16NTa
	 phiYVjOOZfZxxdWU+cESrbNMe8mBJvank8CRiF8HJUrxvDs2l2avbI0DsXiZX5Nc0r
	 KthzKZLk6WrlE6WuLD4p0W6HTw/NvugjoVD9AlRXwankwZRyg4JXfIzAAZJ5aJh1qq
	 zG1Jisaiabwlg==
Date: Sun, 03 May 2026 09:54:27 +0000
To: gregkh@linuxfoundation.org
From: 0nsec <0nsec@proton.me>
Cc: security@kernel.org, herbert@gondor.apana.org.au, 0nsec <0nsec@proton.me>, stable@vger.kernel.org
Subject: [PATCH] crypto: af_alg - convert inflight to atomic_t to fix data race
Message-ID: <20260503095345.375711-1-0nsec@proton.me>
In-Reply-To: <2026050328-civic-monoxide-0a54@gregkh>
References: <rM7uJ0oBopViOraMoC0Ya0_hMtNwV4CLor-vdwN4vIH7BOKqCuuC0OWUOQoOS-0XOcJmSIT5vhR4UmZlIJxD7mllIkq1UVqEop3T0e4bjis=@proton.me> <2026050304-greeting-prankster-910b@gregkh> <QACE4BCfRIeL8Dm_ETPxjem791yvR3Lj6Iw3ArtLWxEU5FwAmjTCS6DZA_hdQfyhi2MYJTIu-p36nDpUwQbhWwxc1X2LgZSCMikbNFdOGCE=@proton.me> <2026050328-civic-monoxide-0a54@gregkh>
Feedback-ID: 179448204:user:proton
X-Pm-Message-ID: ae4203a209f840802d7569c4c58070361b2e5185
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F41B34B5173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242649-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0nsec@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:email,proton.me:dkim,proton.me:mid]

The inflight field in struct af_alg_ctx guards the invariant that only
one AIO crypto request may be in flight at a time.  It is declared as a
plain unsigned int but accessed from two unsynchronized contexts:
process context under lock_sock() and the async crypto completion
callback which runs without any socket lock.

Data race under the C11 memory model.  On weakly-ordered architectures
the store in the completion path could be observed out of order relative
to the preceding areq free, widening the window for state confusion
between a completing first request and a newly allocated second one.

Convert inflight to atomic_t.  Use atomic_xchg() for the check-and-set
in af_alg_alloc_areq() so check and set are one atomic operation,
eliminating the TOCTOU that separate atomic_read + atomic_set would
leave.  The ENOMEM rollback path must also clear inflight since
atomic_xchg() sets it before the allocation attempt; without this a
failed allocation permanently blocks further AIO on that socket.

Follows the precedent of af955bf15d2c ("crypto: af_alg - Fix race
around ctx->rcvused by making it atomic_t").  The inflight field
introduced in 67b164a871af repeated the same locking gap.

CVE-2025-71113 fixed uninitialized garbage in inflight via memset.
That is a distinct bug.  This race exists independently.

Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requ=
ests")
Cc: stable@vger.kernel.org
Signed-off-by: 0nsec <0nsec@proton.me>
---
 crypto/af_alg.c         | 10 +++++-----
 include/crypto/if_alg.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 5a00c18eb..3e62b7e6d 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1102,7 +1102,7 @@ void af_alg_free_resources(struct af_alg_async_req *a=
req)
 =09sock_kfree_s(sk, areq, areq->areqlen);
=20
 =09ctx =3D alg_sk(sk)->private;
-=09ctx->inflight =3D false;
+=09atomic_set(&ctx->inflight, 0);
 }
 EXPORT_SYMBOL_GPL(af_alg_free_resources);
=20
@@ -1176,17 +1176,17 @@ struct af_alg_async_req *af_alg_alloc_areq(struct s=
ock *sk,
 =09struct af_alg_async_req *areq;
=20
 =09/* Only one AIO request can be in flight. */
-=09if (ctx->inflight)
+=09if (atomic_xchg(&ctx->inflight, 1))
 =09=09return ERR_PTR(-EBUSY);
=20
 =09areq =3D sock_kmalloc(sk, areqlen, GFP_KERNEL);
-=09if (unlikely(!areq))
+=09if (unlikely(!areq)) {
+=09=09atomic_set(&ctx->inflight, 0);
 =09=09return ERR_PTR(-ENOMEM);
+=09}
=20
 =09memset(areq, 0, areqlen);
=20
-=09ctx->inflight =3D true;
-
 =09areq->areqlen =3D areqlen;
 =09areq->sk =3D sk;
 =09areq->first_rsgl.sgl.sgt.sgl =3D areq->first_rsgl.sgl.sgl;
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 0cc8fa749..b3b1908dd 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -160,7 +160,7 @@ struct af_alg_ctx {
=20
 =09unsigned int len;
=20
-=09unsigned int inflight;
+=09atomic_t inflight;
 };
=20
 int af_alg_register_type(const struct af_alg_type *type);
--=20
2.54.0



