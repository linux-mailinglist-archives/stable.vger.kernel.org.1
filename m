Return-Path: <stable+bounces-273646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kmxOC9TIVGrQSwAAu9opvQ
	(envelope-from <stable+bounces-273646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:15:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3174A388
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:15:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EjONWQge;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273646-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273646-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AE93036410
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBC383C67;
	Mon, 13 Jul 2026 11:10:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A7381EB9
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941046; cv=none; b=cjtDVxKpE8u5zwOI/aYoz00bKPxdGxHY7f8yRclyclhxVRPj6iongK+pFg4YNF736NUcxJPvETUfkKwcuu1wH2vi2r7ox3USY5FASsnrKGbjM4gFzDpDRLvX6w0IxiraOc4HaKkvMsL2b24kNIOsOiZ5Hdc8jb9FWoxG2eC82Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941046; c=relaxed/simple;
	bh=w7ElCMjLkYLkyB+bROUj878GRmag6+SaeE+dMid5A7M=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k42okoIDvsekR2thwqPHQJxJwi9vBOWtOrKc0DHUH7UMeEPAKd+M6I6ZipSODKnDope67CdcSqGaYzXrpm+aoTnMlvBJH1FSqltXXaR1YbjF9mJqmQJghKmRuMewEP2XReTwrv2AicDmTRy/fLXbmgpmBMU5093bBi349581F5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjONWQge; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3711F00ADE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783941043;
	bh=euGOGq/jybJAzlTSdL+ChBakGwyhbx52kI/Gq1xLLZY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=EjONWQgeikBTJ2FOQy+gyBDoYY8/FNnmBzWQa2d/vSEM1ESAzS+snz/iGdirgROU5
	 AN7zz7TgnhyYoGr1+xSNfdbJaCicZrS5GoogZXiicAuANUQO8Gk9fvbpHyyPw/15gD
	 U8ur8J6RTNJRminr6TpHK8X1ySKDbtH2cGunkFYUDUllIusnoef588jcMULzT27dl9
	 dZnGaw50eIsQFeKI110CnzssLpqQKOb7rn8Zh3W6/mbnGmYUWyq1B56YnbKB2sbC7E
	 e4Bi619ezSDIuGMutVWcpEihVEJD/j3U/6o4eLB7mrh7ZXEe6NUXMBLl3TmwUc6TKB
	 IevHr5lfsnIXw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so26166891fa.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:10:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrNl/wI1FzwJ2ji3IwxMhEgVsCW8cOUaA5k2z6uKzTXGzY+ExNuTTe1pRlQhlduarMPJKICwp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/qcBzqNbNsmQ9Qn3cmkvQyHBruEG7aLVj2n16fxnWlSE6kxt
	D7JRnQjYh0/0YwM4PZoX2jeSx+s5OHw0TDHa7P9IN8owA4xOZFNgFSpakzTgFR0hY2esrsAWczP
	0a47/CI0YkHW0Halh1YyeCyE1BEF+oFK7YqXpVB6/EA==
X-Received: by 2002:a2e:bcc7:0:b0:39c:8f36:8104 with SMTP id
 38308e7fff4ca-39caa834fdfmr18180491fa.19.1783941042464; Mon, 13 Jul 2026
 04:10:42 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 04:10:41 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 04:10:41 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 04:10:41 -0700
X-Gmail-Original-Message-ID: <CAMRc=McqBwG8qSYvgsmvCpJvtYDy24yhW1FMRuUpdu-dqWcYwQ@mail.gmail.com>
X-Gm-Features: AVVi8Ce019xBHlwdOviPJt1Xf4Hj7OQrNGjXwrTA9vUYlWrVB9i66XRbDv2XoLc
Message-ID: <CAMRc=McqBwG8qSYvgsmvCpJvtYDy24yhW1FMRuUpdu-dqWcYwQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] crypto: qce - Fix crypto self-test failures
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, 
	Eneas U de Queiroz <cotequeiroz@gmail.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273646-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:linux-crypto@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:brgl@kernel.org,m:stable@vger.kernel.org,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:svarbanov@mm-sol.com,m:cotequeiroz@gmail.com,m:kuldeep.singh@oss.qualcomm.com,m:ebiggers@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,gondor.apana.org.au,davemloft.net,mm-sol.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77C3174A388

On Mon, 6 Jul 2026 15:53:51 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> This extends the initial submission from Kuldeep.
>
> The QCE hardware crypto engine has several limitations that cause it to
> produce incorrect results or stall on certain inputs. This series fixes
> several bugs and adds workaround allowing the deiver to pass crypto
> self-tests.
>
> The failures addressed are:
>
> - HMAC self-test failures for empty messages
> - AES-XTS returning success on zero-length input (should be -EINVAL)
> - AES-CTR: partial final block causes the engine to stall, output IV
>   derivation was incorrect
> - AES-XTS with key1 == key2 is not supported by the CE
> - AES-CCM: partial final block and fragmented payload both stall the
>   engine
>
> All fixes were tested on an SM8650 QRD board with
> CONFIG_CRYPTO_SELFTESTS=y and CONFIG_CRYPTO_SELFTESTS_FULL=y.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v5:
> - Dropped patch 1/8 that's already queued
> - Use the pre-allocated fallback ahash for HMAC transforms (Herbert)
> - Link to v4: https://patch.msgid.link/20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com
>
> Changes in v4:
> - Remove remaining ECB and DES3 bits
> - Pick up tags
> - Link to v3: https://patch.msgid.link/20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com
>
> Changes in v3:
> - Remove even more algorithms and dead code in patch 1/8
> - Link to v2: https://patch.msgid.link/20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com
>
> Changes in v2:
> - Add fixes for the full suite of crypto self-tests
> - Add Fixes and Cc tags
> - Link to v1: https://patch.msgid.link/20260610-qce_selftest_fix-v1-0-1b0504783a46@oss.qualcomm.com/
>
> ---
> Bartosz Golaszewski (5):
>       crypto: qce - Fix HMAC self-test failures for empty messages
>       crypto: qce - Reject empty messages for AES-XTS
>       crypto: qce - Use a fallback for AES-CTR with a partial final block
>       crypto: qce - Use a fallback for CCM with a partial final block
>       crypto: qce - Use fallback for CCM with a fragmented payload
>
> Kuldeep Singh (2):
>       crypto: qce - Fix CTR-AES for partial block requests
>       crypto: qce - Fix xts-aes-qce for weak keys
>
>  drivers/crypto/qce/aead.c     | 32 +++++++++++++++++++++++++++++-
>  drivers/crypto/qce/cipher.h   |  1 +
>  drivers/crypto/qce/sha.c      | 23 ++++++++++++++++++++++
>  drivers/crypto/qce/skcipher.c | 46 ++++++++++++++++++++++++++++++++++---------
>  4 files changed, 92 insertions(+), 10 deletions(-)
> ---
> base-commit: 86855fca1d5d84fcfd6b93dfe8bff4eab6029ad3
> change-id: 20260610-qce-fix-self-tests-492ffd2ef955
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
>

Hi Herbert,

Gentle ping, if this looks good to you now, could you please queue it for v7.2?

Thanks in advance,
Bartosz

