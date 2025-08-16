Return-Path: <stable+bounces-169852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC01B28BE3
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020F51891198
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60652367D9;
	Sat, 16 Aug 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Vm4A/m+Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342E21D3E2
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755332998; cv=none; b=Ao3f46UWz1ahqu4pV2ivyZ0DFUB7CXMB311xcBUE/UHRTmEIuN4QvcLsgaFBoq87Hqm4YjeR9CvyveC6bHEc04aSjy1c6Znz4WZp6BaWxFmoqX487ytMlRfc9rDpjnZ3NE8tHOuWKafayxq9RlTOQYTku9ROn4K21YsV10eVEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755332998; c=relaxed/simple;
	bh=wI6Ec8BoUG/NmF1YwKgbv+tFQEwL5oAgpG/qkP9faBU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oUmtHicGSeKonScHMnb/ZcUwFOH8CuAdRu0L4hIiGxf2Mok5D9CO2mMPo7wuB5H1APoi2uboH1y0djBXRC2ys4QZn7lZ0OKLWqpcQ6Lj7+xTEI0flqlGXwM+pSEvAroA5zzGirksKavK11+DihMJNa2zMOL6sG9Tnsod7pd95nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Vm4A/m+Q; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755332986; x=1755592186;
	bh=Y7zpf7qlriftdcKumQXayVqjnzbWJ2DI41mBojQ8srE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Vm4A/m+QbDQrBD6UWqlCaAsWFmz4897ZefsQta0PWbCfbibxuCDCvEejlW58k2ylk
	 N7mxgk+LJFBJXoBavD7Nx6kZac4Yt2rwYfNxBcVpMEd7JWb22ViMImDO0sYyLzZsE/
	 7B1rXve4U/zonvyuARvFjXaJD/UMYQT3k1UfvoFeVGa5+GueUJkF3Hu9PZ/hNTICHy
	 z57ws4wEPVK+dj9vZa9OA76PdTSGOKkUtIwK/8kD1jNUzJx/FQgTrYKgNY6blgyLnJ
	 p/iRWZYWMa3xrWtN/HF0TpFHRLXLTdlXre/XdN9DMZwddcyhbEuqp/11M+4736Kcm6
	 BtrXXku8Y8onw==
Date: Sat, 16 Aug 2025 08:29:41 +0000
To: stable@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: savy@syst3mfailure.io, sd@queasysnail.net, john.fastabend@gmail.com, borisp@nvidia.com, kuba@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH 6.1.y] tls: separate no-async decryption request handling from async
Message-ID: <20250816082913.359043-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 4c5b72ae7d28b138ab1bd21bce639e3ee257dea6
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 41532b785e9d79636b3815a64ddf6a096647d011 ]

If we're not doing async, the handling is much simpler. There's no
reference counting, we just need to wait for the completion to wake us
up and return its result.

We should preferably also use a separate crypto_wait. I'm not seeing a
UAF as I did in the past, I think aec7961 ("tls: fix race between
async notify and socket close") took care of it.

This will make the next fix easier.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/47bde5f649707610eaef9f0d679519966fc31061.17=
09132643.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ William: The original patch did not apply cleanly due to deletions of
  non-existent lines in 6.1.y. The UAF the author stopped seeing can still
  be reproduced on systems without AVX in conjunction with cryptd.
  Also removed an extraneous statement after a return statement that is
  adjacent to diff. ]
Link: https://lore.kernel.org/netdev/he2K1yz_u7bZ-CnYcTSQ4OxuLuHZXN6xZRgp6_=
ICSWnq8J5FpI_uD1i_1lTSf7WMrYb5ThiX1OR2GTOB2IltgT49Koy7Hhutr4du4KtLvyk=3D@wi=
llsroot.io/
Signed-off-by: William Liu <will@willsroot.io>
---
Tested with original repro and all tests in selftests/net/tls.c
---
 net/tls/tls_sw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 6ac3dcbe87b5..e1e3207168e3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -274,9 +274,15 @@ static int tls_do_decryption(struct sock *sk,
 =09=09DEBUG_NET_WARN_ON_ONCE(atomic_read(&ctx->decrypt_pending) < 1);
 =09=09atomic_inc(&ctx->decrypt_pending);
 =09} else {
+=09=09DECLARE_CRYPTO_WAIT(wait);
+
 =09=09aead_request_set_callback(aead_req,
 =09=09=09=09=09  CRYPTO_TFM_REQ_MAY_BACKLOG,
-=09=09=09=09=09  crypto_req_done, &ctx->async_wait);
+=09=09=09=09=09  crypto_req_done, &wait);
+=09=09ret =3D crypto_aead_decrypt(aead_req);
+=09=09if (ret =3D=3D -EINPROGRESS || ret =3D=3D -EBUSY)
+=09=09=09ret =3D crypto_wait_req(ret, &wait);
+=09=09return ret;
 =09}
=20
 =09ret =3D crypto_aead_decrypt(aead_req);
@@ -289,7 +295,6 @@ static int tls_do_decryption(struct sock *sk,
 =09=09/* all completions have run, we're not doing async anymore */
 =09=09darg->async =3D false;
 =09=09return ret;
-=09=09ret =3D ret ?: -EINPROGRESS;
 =09}
=20
 =09atomic_dec(&ctx->decrypt_pending);
--=20
2.43.0



