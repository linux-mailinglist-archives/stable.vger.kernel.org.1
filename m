Return-Path: <stable+bounces-253601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SXA2Bi4tD2oiHgYAu9opvQ
	(envelope-from <stable+bounces-253601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:05:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 976155A8DC6
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 738A13075BF7
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32409349CC5;
	Thu, 21 May 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF6SqBjc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D242BE7AC
	for <stable@vger.kernel.org>; Thu, 21 May 2026 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377125; cv=none; b=JrVw11K0Vd+AMfFe696p3/gS/IFCd7pORGOpr15+PLRLfprcYU6Xu/5N/dIDUuc99AFXyBzdDjdpxdZYt26A8AUiHT4+FDJqUa6ZCAApWhPn8k59QQtGc3geps7TIdMjc1FfaC4dfQyO5yN35benrahXIWC2XdSqUzckg/H2j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377125; c=relaxed/simple;
	bh=QwJcNq6DwfRcfYtNuuboeWq6WH6NMFni3xDvmdLT4D8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PbNVABVquecGQH+5aJlup7Ok0dhrrCQC18dSpK8NoayauIjDzz8GLFtNa9q49/GEAaUQjmmAg7orQlCylEVNtD039YwsROCfEVtd1FSdiqkIEo/+HVky4//URpSxEcOSJKLCi95Kz4ureTgjhOg4iJaqVI1Vn47xo8QlHk/4i4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF6SqBjc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48909558b3aso64356395e9.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779377122; x=1779981922; darn=vger.kernel.org;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=US8Xi9z03A9vExvROAP26gREM63X2E/RakjDkVuRW24=;
        b=OF6SqBjcP2fzMBdiwpc2E6nsSR2rODvQnR4wZ24+XowuCKUM16tfBc+b4BkOSzXEMe
         /QZberazYA4y0/Mzy6EF05PEG8O13eN/SVy7URKGzKGqr6pWGbG+ep/WVjJGfm7BtdNK
         v0kHZWoYxxwxSaVL6QvS/mLUin2sEzQs0NUe+AIv7xWxopMKAHiRl06ubQRbsAMeuROc
         S9ax/d8eeIRKuROsUFT2Uy122a408AkjKReuT4hn9ET9K1S+yjVOvpIaWtb8mugsqqJR
         hz7Mw9hH10WDROuUj52J/4tG/XIWZKs0/8af+ytDYRIJNwEzyy3DRq1LuNBnQOt/5XoD
         Obhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779377122; x=1779981922;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=US8Xi9z03A9vExvROAP26gREM63X2E/RakjDkVuRW24=;
        b=n4ESGPwq3/Btv/45s8NuU/Kz5TkHUPxziUvTahgRSGvFayIesbPGjj/SPhcwZTkIOR
         rnKZU59Vc3A/oXndDo90ncHjfHWJPM4+bCAiM/ryeS9SqdMeWu0fKbVkFrqE9aHuK9M4
         NfjJGmPUQnDH1h171GdPxY/B98wAeyvRk3Qw9X+EGzWgSI3k8ErqnhsNBQJqxF3OWu2R
         J2s5xRHd/sMXNt63KaUVCdZ3krcq6+0gws5p5Lv9amVyfdjJKA2X65NRz8/80WSHRJBN
         N34GOxISjrjFKGLgyRtA7tvPpb59RmMsINy7P/cSAtFIrDGYyv8QD77hH8/+T7zl//G0
         BzcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6JhyUAD0fDVK9QxOsL572JCsMxTI0Hvi9NJe6wP/0duwEymY3toZ8C4E+aS+KLYiwmcy99Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhF+F22qUZYKZcDWn4m/L2G52jJcaWvpwAVNqj4MDRGCxrdU1n
	xaY9V9EFmIp3iqPa9rKOBFehtNyDSb8pOuaUgsGjv/MmfJ6TyueRNYnkbysuIplk
X-Gm-Gg: Acq92OFvNXHNlq3qTyqe1xmLMvIeg0igHa/Vt6Okfk8Hyg89XvKWC5CgKGC6V5DD4DG
	AVRzPjwCTkkINbUwwQES2VNvNmG4k7fgRh99Xqb1VW6L2YrIWW5aPGK94f+r9kMjsykUV4DW6ya
	RqmGaznOi/mtuMxy4Na4f7ewl2LV2qL+v6SSw9+b0hhpFKQpbk3k32cL0f0QV5WRyJka3HSlE4k
	qPoKIudFVKZciK+hiLHhja92CxQITlCSG3eo5RvUQi/cdLW0CQx0Q2IL2EMsEkkIyEs7/Y2kSjS
	GQyH7WRSxOfio1BETMD/20KXUexy8RghxNH7aLfUtSYUkfZ1biJ03w2IbpPSMiyDd01/ogSHPKw
	rNXqqogn/lZs0HAqybEKbktFHpNLMde4nGlArhuwoHB/k1HlyIL6M0Xr+k1PvOxzgZkx1eJB3gN
	SQVruzAlGInxC13VRrPvpRjBm9aJtEHf5b0yFS/98+UBS4kc2SGlwfL8d7mjC77srVj1RcV2PKW
	5FfS2t0qVJprpRcYg==
X-Received: by 2002:a05:600c:1f89:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-4903606b594mr44755095e9.18.1779377121600;
        Thu, 21 May 2026 08:25:21 -0700 (PDT)
Received: from appsuite-core-mw-groupware-85f8f85758-9d9q7 (gate-4.heinlein-hosting.de. [80.241.60.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c9abbadsm33716505e9.8.2026.05.21.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:25:20 -0700 (PDT)
Date: Thu, 21 May 2026 17:25:18 +0200 (CEST)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: Paul Louvel <paul.louvel@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: herve.codina@bootlin.com, miquel.raynal@bootlin.com,
	stable@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Message-ID: <1464270648.58006.1779377119607@app.mailbox.org>
In-Reply-To: <DIOA24QU02W5.2RSVK05RE7BJK@bootlin.com>
References: <142603430.61540.1779296295550@app.mailbox.org>
 <DIO9YUHO5VGT.3BLGH04NVJNHP@bootlin.com>
 <DIOA24QU02W5.2RSVK05RE7BJK@bootlin.com>
Subject: Re: [PATCH] crypto: talitos - fix rename first/last to
 first_desc/last_desc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.48.98
X-Originating-Client: open-xchange-appsuite
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,app.mailbox.org:mid]
X-Rspamd-Queue-Id: 976155A8DC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Paul,

Thank you for this review and feedback.

> > Instead of renaming req_ctx->last, commit 9826d1d6ed5f8 ("crypto: talitos - stop
> > using crypto_ahash::init") should be applied. Ideally before commit
> > 655ef638a2bc ("crypto: talitos - fix SEC1 32k ahash request limitation") to
> > avoid any compilation breakage and ensure correctness of the code.
> 
> Small correction:
> 
> Ideally before commit 00463d5f864a ("crypto: talitos - fix SEC1 32k ahash
> request limitation") to avoid any compilation breakage and ensure correctness of
> the code.

I can confirm your recommendation. Appyling this commit before, fixes the problem. Please disregard my patch.

Greg could you please backport the mentioned commit to 6.6.y in the correct order for the next update?

I have fixed it for our downstream users for now.

Thank you,
Goetz

