Return-Path: <stable+bounces-270356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TgqZIPkcRmrGKAsAu9opvQ
	(envelope-from <stable+bounces-270356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 10:10:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29C6F49DD
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 10:10:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gZBwuBbG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270356-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270356-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6121302F717
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0543D25BC;
	Thu,  2 Jul 2026 07:54:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA703D47A5
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 07:54:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978859; cv=none; b=mUQyxxaOzyplp2QGP+pVPHVcT9P2iuh543Arl4jrDzNRXmxclRC5z83a7m/w8yjO/NUyiU7Fupe89hFMxn5ZeM0U8EGXnlaz3wzMxtjrT6v2MWSLJ5ZBi73jGBCAsotTghUIjcPuJSYDyziLNof8B1ZQDdrDxKou3Raemwo5LIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978859; c=relaxed/simple;
	bh=rVijp0nlmGV+Ju2yCMfrmoukOWN+2WozFFnA0k+xkpE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Elh1eqjUkx64AjqRyfxR+Pw+Y080kgdCQSdRiyxJCCFKJOWDFZtpDfcnN7Ib0EcHlA1APUbDR4/YsIhx4U3JMHdkinlSQvWJOU8sx6FFt5wro3Ol2uWPA4xOwFjAQLa2iYfQa/Ial09s/myqV4eLrkIpSPpzdJVlnyPznRA6NhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZBwuBbG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629D91F00A3A
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782978852;
	bh=zmq7OfLX+kZuXykmUR0HxngBMRAeN34POlk7udWG8oc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=gZBwuBbGlSnHCAzdA0MoclkW1GhHlhrU70hyIjbDHAQLL4sOKag6bGiV590PeLZs6
	 H3xcApnE0R0Wbivb8XDkxvdFlZp0xqscXMWn86qIrjhKy3RC8y1xiy+c89teRb40kY
	 EIq+NO58YWNBi8RktLH5CnhkkKgxvFfALPm2pqHG6wNRLuIIIuSP59wjFpcjE0DRhq
	 g0/BENkL6f+Tw2NIpkslrZA9OwJZM3xjJ6BUi+OtDNr8/AJYJrc9A1k7Zi/76qnTPn
	 hMHjtKL1Pj63cCy/rRyE2WoYUBrM2isC00uYNu2tOBqx8DAl7v2PmAQH6lTtXlxhu/
	 fCWl3060NfIcA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb11c7347so1234199e87.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 00:54:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqsAK/n71PAyq9Cl//H0rt/0H3ii8XyE/4elVbPpm6Z7prqnde4M21T0qqj7lrWM5ztJEOPNQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvitrRogjJ19GfrtBECiraMx8ACaygFtNwP7MY3B7rEzm1vXRk
	r566SzlogoCbxKCQdJpjaukT0au2vHGSpjOzrHHh3kKbqDjKerZyfX4Tn+fFZsAiAH/M9pMu07Y
	Re3xWrTevGxcaHkbdt2pLSR5XoS5NqkBm8rxkQQuAyA==
X-Received: by 2002:ac2:4f04:0:b0:5ae:b8fe:88bf with SMTP id
 2adb3069b0e04-5aec67a402emr1119953e87.20.1782978851074; Thu, 02 Jul 2026
 00:54:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Jul 2026 02:54:08 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Jul 2026 02:54:08 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 02:54:08 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mfnq9QcB88zQ_7C9eqDCTeCB7t9Em39DNyrUYnYPYynJA@mail.gmail.com>
X-Gm-Features: AVVi8CdIRdZkOTSFZHkS9Ls1pktf5hicJEG2vGYh8IaOGvhFMznMlz7OlVgHtxU
Message-ID: <CAMRc=Mfnq9QcB88zQ_7C9eqDCTeCB7t9Em39DNyrUYnYPYynJA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] crypto: qce - Fix crypto self-test failures
To: Herbert Xu <herbert@gondor.apana.org.au>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org, 
	Thara Gopinath <thara.gopinath@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Stanimir Varbanov <svarbanov@mm-sol.com>, Eneas U de Queiroz <cotequeiroz@gmail.com>, 
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270356-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:bartosz.golaszewski@oss.qualcomm.com,m:linux-crypto@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:brgl@kernel.org,m:stable@vger.kernel.org,m:thara.gopinath@gmail.com,m:davem@davemloft.net,m:svarbanov@mm-sol.com,m:cotequeiroz@gmail.com,m:kuldeep.singh@oss.qualcomm.com,m:ebiggers@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davemloft.net,mm-sol.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC29C6F49DD

On Mon, 22 Jun 2026 15:18:08 +0200, Bartosz Golaszewski
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

Herbert,

Should I make PRs to you with changes in this driver or do you prefer to queue
the patches yourself?

Bartosz

