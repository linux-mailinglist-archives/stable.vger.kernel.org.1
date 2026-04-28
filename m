Return-Path: <stable+bounces-241481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCJoOsda8Gn/SAEAu9opvQ
	(envelope-from <stable+bounces-241481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:59:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A647E5D6
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7FB3067CB0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54514361DD9;
	Tue, 28 Apr 2026 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY/SCFCU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761A35F18D
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359375; cv=pass; b=Vtrdff2Jjz9HZfZbfdbE8wc1zxW/maoY/t4Nb6yuL0dF+7fv0AN9viriolO5ySy/cPFlHZV2/1D48r+BeONzk8Q861FIBWquEn/CEL8RB8yP7xtCXrVuo7LJMTb21JFC5rZvAiI726GN3bDGyoxcbL8i78ESG5ZYvk2+iZDuAbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359375; c=relaxed/simple;
	bh=nwuWT1phn1en8n18dvBdTOTEU1b68JKoOn1+J+UbF4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgIGPPbmG4iQzFeWbjjm2fbeCmNN085tdCn/3AaCZA43SRtT7G7oTLXWC1lFR0FM2XR6GQWHYcM40gqstBhu6CJ4YzJTuvmrESe5n4oew5tMaDV0VffeKuerXOzNNRlCn12JrrcaUFkoDUR4M02f0i2CsnIksc8I4C9kwV47v0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY/SCFCU; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba545100a13so1255702066b.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 23:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777359372; cv=none;
        d=google.com; s=arc-20240605;
        b=biviw1F+g2ml5KFGDJcAdgFS8Vx8yY+7N9zy/21ys6Gyz2liqUCp0wI2mTxmYntSW+
         tqhqGNJbH4xzQwnXjvzQzH6Hd1hJGvJSwfb6vw/Q7xuFONTG74yiqcld/0ObKEkqGVjF
         yOCcC28zO/0csflrxc1MfkmXAhxY0R3rJIXTYWRhQJYtdt84uiAkvuaWeUznRZC25kNn
         fl46aVffXbUTyo34DTG88XlFiKO60S3Kj7oZWM8arRaeKMF8j5xfXbPOZvLSInMhWY/L
         Up8wJhatFwYJEtfdSt3ZFtnnoRUpdL1JgoP1mNNzqNGNMIUXmf+FB/k8Ygafp1MWuSYy
         7FIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nwuWT1phn1en8n18dvBdTOTEU1b68JKoOn1+J+UbF4Q=;
        fh=svCGosRoIvJupGj1SMv9/OgkprGG9vScSe/rJGaxD6o=;
        b=gjVs9yr/ElCCrl6MtRev+KVPF/+O54hoyZHCoCP6/OGoh3zb4C/yaQFOWlEg+8eUT6
         FfGIrCINC5E3UvKtygTEoEG+4zxEER8Tw77u39V+SsIdZrqgVx2ZI5zbiG6Alr9+KrxF
         ObC1kIvSMSscsh5iZyExusO/1oTFX7dKZvJNIpG39zD1QBwO8kbNVc/RkqhzdDe6mY7i
         jyGIVgt2gCygAQfabYo/UR13fv+CKID3P7dM4aFBeimwC2Rxz+kqksJLuMgAQueOS909
         Ct6RwJy38CFwpz84rAv3qvlq1mwvCGSrs/VxA45hihe7MRLjhTzzbjAiM4bRzvon0DdN
         246w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777359372; x=1777964172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwuWT1phn1en8n18dvBdTOTEU1b68JKoOn1+J+UbF4Q=;
        b=HY/SCFCUJqSLwk/PTVSoGSsKtPrgm4b8CjQqU7pEFzLvNXDeGq5NzgFnhJ8ooGZSvI
         ZvKAvPU6l5FqcUp7fmGFO7idXCRolIUehNtMmt/UJW+B+G98RyrSLqh7HJCJkIgA8ZOA
         rZNtMPxgU7spdknNmwCdBBFDMi8iD5EsSEpXgChzprf2OXoEpO01PzvZmKIjrwGZ3eQs
         8hhqWr5Ln9i18sy+D2+U3e5lGlqLLzb+Dq/jHzBh5Ek5Kzf09Qi+btCD8NbBrnGojvTX
         r8X/4IGdZwtTwd4qeI4gd2RljWL/+T5TLM0T5FobAZL4+HDRjdXAR4L37fhJIfPYbZhQ
         NpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359372; x=1777964172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwuWT1phn1en8n18dvBdTOTEU1b68JKoOn1+J+UbF4Q=;
        b=CP/heFoaruPAC/JSMYmzZoTluM8JEpE5l+h/uUDD6ZI1PCfQr3MTvVvFRPpJTbOROW
         XwPxeBkU1dOESYRsivwFzcl4i3Bh6b6PmZjo98FiO62k5LU5v2iiOXqzp+BAAJeFKTEq
         8+o5mDIqtBacmbFOZt/7R963NYAJbND1b6cIw071+HjWWKm9/AOpDLqjDJPzFeD7WiaF
         gdMuizuXOC1cPUNFCDuAsQPJst8JJkJs+0ksdI3//C0xwSTnT8dTbW7VCKDzdpVSIMYf
         R0SLCuAM17IjF0pkG3s55hlRbnfbaM5lQFkG1vYuex4fnQdBLNZUUrzv1NDvT3K4Cwqd
         +/7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+PlCDOtf0BR2cStwCWjuikpdFZ62tjt4CBOX0bLPnQ/lix4uSTc5bmCltQeFxlgTOl/MJHCjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMb2Fvm87a1GfnHZKKIeoY8zjMUboZqJRwVrT0oSR8B98YwLnn
	ByUg+xeD+WcpPH/uwPol+k7rF2nBRYY31YOTBris3HPaiMWIxoqpsPKhotMIlJZ7YmD3iMwm6Ul
	kbAronMMMl9R39ABuU6YgaGPfkK8dt9o=
X-Gm-Gg: AeBDiessMV/Z63Z6wR22J1KdjHbNMldPwDCRk76KXpwEOyPxknB7HfLobp3qd+Fqd/A
	Or66Yh7hccHMQYivFGG2g1SFaXIfNR8nVGRByPexqlTcfeVr0h8giCcjzBhciACSmbMK9MbqrEO
	NevzFQmeHlqHXBme+Yu7g5zqYLxAziwdt7GFUj8lnV4kLZpcaeXFEGAkhJDVjkAkyQrDGkYHj1Y
	DjQkqkzfg99qZPxMEgIZ+hsJJV+gdSqff0KlhEy/822sdI3KFyrfkkI2Xt1qpy8H67yeMi93Ysl
	EFJZaJzFwdziuDsThU9X3EC4XSzpmsHw9Ra8h/wccYereSjtE2/NHA2hdlJFTO1QofZsy1Zs9dM
	z588UhjQ7mNMQIeY11w==
X-Received: by 2002:a17:907:7fa5:b0:ba5:7cce:979f with SMTP id
 a640c23a62f3a-bb80404ed9dmr96050166b.40.1777359372038; Mon, 27 Apr 2026
 23:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
In-Reply-To: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 Apr 2026 09:55:35 +0300
X-Gm-Features: AVHnY4Jcn3zCFVDK1JOKYf8q6o4hYCT_F_LlxJGQ6NfjTnUM3Zm0SmcR0HK3ynw
Message-ID: <CAHp75VdMEXag0oeRd620YJn5TpgqGy4YProDcR7EZE__cwwC2g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on
 platform_clock_control error
To: =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
	Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hansg@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 499A647E5D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241481-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 5:38=E2=80=AFAM C=C3=A1ssio Gabriel
<cassiogabrielcontato@gmail.com> wrote:
>
> If byt_wm5102_prepare_and_enable_pll1() fails in the
> SND_SOC_DAPM_EVENT_ON() path, platform_clock_control() returns after
> clk_prepare_enable(priv->mclk) without disabling the clock again.
>
> This leaks an MCLK enable reference on failed power-up attempts. Add the
> missing clk_disable_unprepare() on the error path, matching the unwind
> used by the other Intel platform_clock_control() implementations.

There are 6 drivers that do the same, why is only this one special?
Have you checked the flow on the error path of the caller of this
`platform_clock_control()`? Maybe there it calls with the opposite
event to shut the clock down?

...

TL;DR: If it's a real issue, it has to be fixed for all affected drivers.


--=20
With Best Regards,
Andy Shevchenko

