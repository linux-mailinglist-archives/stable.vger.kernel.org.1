Return-Path: <stable+bounces-242654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KcziE1Ur92mjdAIAu9opvQ
	(envelope-from <stable+bounces-242654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:02:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D95764B531A
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BCE7300146B
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A12EACEF;
	Sun,  3 May 2026 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H5Yq4a+I"
X-Original-To: stable@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FB40DFD0
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777806160; cv=none; b=g/6I3S5cM/VWtuhpp5UBdOHFTUKAm3wzCbivoPiNKmlrG2S9CupGEjg7k+fnyDAKs3nOgY/+KEJ+xa2f8nHJrzk4esSgdgclktGmmg/Z3yPP5D7RW7aC6764TyPjTTLrw0HsKE7qS1lUE7Jn0hA/FQyBA1tiO3Y4+t+1M9nEdCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777806160; c=relaxed/simple;
	bh=8d3bGKH1aJFZEACewe5lQlAx62hibO8Qt/j/aLAFEto=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fk85pA+iAY4H2aGtATCT3u27xRayRzfkLRRmSh7hY2fwO4aJBK6Uch7GHfahB4a+V9iVgE82NLdhn5kIdBNL/aR9c2OL6T0i/P3l9gNgYKT490oFKS2rvwTmQW1pLs24ZMIQ8B8fbHgXMijyFbCL70ydPDpNec46oCDkBCFlfhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H5Yq4a+I; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1777806148; x=1778065348;
	bh=SKE3Ugo/mIRiVSapBF5o7vZtk+cyx8mm6MO2sc2wIuM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H5Yq4a+I0WmL/03WeQRebNKCo7zPgm2viJekK4dXYeWgkclhRK1Rkey+prKsiOSSr
	 0oExsAYEzc/a6Ql8Qrp6qqE/CWsw7NvbFf5MkwbyPeDRFeCXMkqYV33asS0sDJnjZS
	 5gTPSkyMHG0sJqE8cADV0OuEz6zWF0wqwOVVOqHP3+ZiqZ15/tvEXgghMJMh5oUY7C
	 5vfh37Ubcjw3buD3ynCV/rWRqSIjuoQPNSakzMk+60lxoGLxqBt2bnGBze0LY5lYgH
	 pRetARARdjZ0DhAkdIm1fD0p3thI6nbwuRhmFsp194ZyiWCYBWwpiDdFVYTIeaz6QS
	 lskp3le1IqHGg==
Date: Sun, 03 May 2026 11:02:25 +0000
To: gregkh@linuxfoundation.org
From: 0nsec <0nsec@proton.me>
Cc: security@kernel.org, herbert@gondor.apana.org.au, stable@vger.kernel.org, Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] crypto: af_alg - convert inflight to atomic_t to fix data race
Message-ID: <20260503110135.382130-1-0nsec@proton.me>
In-Reply-To: <2026050335-spiny-lullaby-2559@gregkh>
References: <rM7uJ0oBopViOraMoC0Ya0_hMtNwV4CLor-vdwN4vIH7BOKqCuuC0OWUOQoOS-0XOcJmSIT5vhR4UmZlIJxD7mllIkq1UVqEop3T0e4bjis=@proton.me> <2026050304-greeting-prankster-910b@gregkh> <QACE4BCfRIeL8Dm_ETPxjem791yvR3Lj6Iw3ArtLWxEU5FwAmjTCS6DZA_hdQfyhi2MYJTIu-p36nDpUwQbhWwxc1X2LgZSCMikbNFdOGCE=@proton.me> <2026050328-civic-monoxide-0a54@gregkh> <20260503095345.375711-1-0nsec@proton.me> <2026050335-spiny-lullaby-2559@gregkh>
Feedback-ID: 179448204:user:proton
X-Pm-Message-ID: 3291e979550fd0b55219deac2ee39d070d0ffcb5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D95764B531A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gondor.apana.org.au,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242654-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,proton.me:dkim,proton.me:mid]

From: Muhammad Bilal <meatuni001@gmail.com>

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
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
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



