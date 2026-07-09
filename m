Return-Path: <stable+bounces-273026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VimLI4D3T2oHrQIAu9opvQ
	(envelope-from <stable+bounces-273026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 21:33:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC30735064
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 21:33:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KzUqQ+Z+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273026-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273026-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BB1530AB33A
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 19:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595F3B993B;
	Thu,  9 Jul 2026 19:29:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A93B42CE
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:29:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625396; cv=none; b=tT4QXgyzGbrwX/4IWwcazR/dn7YLfJN3+5TSIVUVP55OBi354xmGeha0F4zXqTjH94h+Hc+2rMwsER/FQLW8EpA5BJko/MirBi82yBko+za8ADtLQ+Zq+h79bu2rRChwWs54k55nLLoDdZOMmPPmIa9OmSOYnAm9xrgtX+1gKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625396; c=relaxed/simple;
	bh=UUhgffiwFMqsLRQqvi2m0+DFuWzKSUAEaQL9vakFVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj5GZuG0g05gv8i4PLqSIcx6aD18yV+Ufn6OOOsN9zMQQTXpD5Us/2JAUHvRlO8n/DTkgn53l17D4qZlLjiefTwYtr/iWzpa8pLyum0zg66xJY88onWPpDusE0TIwQvcMf/95zxDe0H2lXjHExqS18Ws89JG0NNxYMZw48/Mkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzUqQ+Z+; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so599085e9.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625394; x=1784230194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2u3pE1lizLe5VYoor11/eZUDKU8SqIFjsOoWnG1c0g=;
        b=KzUqQ+Z+w52Bfib6bJ8pXN7/OGhxEkwBzVDmlWa0nFVXG6bfLQtf/CKc2RGZ1m+4j5
         XHQayRMPJfJrchz+Efycxl5A/tK/nPhP0TRmp5sEi9HYJi2ut6Cv6rvklHl3s/mBncIt
         rPHYUXcaFwtexdfuzyhu1UDbItCzrZ2G3YVi6yyEqL31xQsK7ou8X1PRHJeGND3xrs8z
         F3OKiPu4sPNJT9bjm4q+XFy6gaEM3eJTaGKZZzxw5bxJnCJ9Y+s8AVEYUB1l+OfcVNin
         i3mdIUHyzEUUoC5EEK6E+diRkNb0FDFZsUHC+DOhma6+Y20MMJf3WnpbgL/6qqQF7MnN
         wvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625394; x=1784230194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2u3pE1lizLe5VYoor11/eZUDKU8SqIFjsOoWnG1c0g=;
        b=rhvsHzGPK5uQWuU0h8J78Kt+BiVmOMMrPrtyePJJCVjGMBNSYSq+y5uGS10nmkOY8C
         Hk3Vtawp2kx9OQjXM1byPnjYqSGA8fx6s7CXT2JBNMbdpdFpmk89vyPEZ/BG8CLI6BQy
         FiqkcTbtg7vsy+dAODlp2GSgVz65bHUpOQ9IDzLJ5fo9mUO2chqP101s3XlskPE9LMqZ
         9FVy34+hhRz+PvXWgEi3AY3isJxrisfdULbTWXUtq1Mldce+r/bxsWhhNUKfdd+ujmfJ
         rlGhQ4eSVz3QMqIvv6IYYf3dIinAhCgoIPfJTKxGUyhxSG7yrf/MMWwtlgt1OKuZs0Te
         hJFg==
X-Forwarded-Encrypted: i=1; AHgh+RqAASF34eO5xAG7IE9K98PgMBQ194gIJrLsJOxFvYV/hd7PeQorCOOXTaoF3kzpGBitrVcgEaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmd4D6+BG9N53m0v1rxa0dY67p0m5CuNPeJAoRSu1BU0jTmgY6
	RWZoDCHzj7sr7wSAV2NWcZcO/quGxuHfA7zxJdQkzBKE+8FkL+EXuD0OreXdwUkM6Xk=
X-Gm-Gg: AfdE7cn63IR7rF2XVLwySzA9wyuErxoVcCZiImc8uf4wBFOVe8Rxj46OtLpc8G2jf6X
	3FYywR25mw2RWVrPUmFx1Wgnj3IbifYDHEuIXgQlrA+9Cat82g47NDRjr/tmRWYVyF4hkYnGHVP
	yg1rbY7VF2uvi24gYSeg0duu5sF7dZuuim+P3mxUnDiN6vOFKKCiTvXWubgPpEIzXbC7Z8Srym0
	kLxi0svPTIOax4dbzswbXGnnvqGFrT3BVRnDXkeVJ/vSR8PMJmm5CbrnKERyfK+Dqe3E+Z06xt5
	a86m0MTaAwL8bFjkga43rzVMK8NvPrPc43I7Su0PFcyX87gMseTA2v7HTfoOZImKxlUnfP1xXA0
	0N/zhh7dcnmI4pl9JJuJclSGJiAu8Jq+pMeBJymDJhyAPPmZmapiw4kRf3EbWt7uPkhie1bwPZX
	a30vePy7bs3ncimZxYQxKfmiHU
X-Received: by 2002:a05:600d:8444:10b0:493:ba6b:b6e6 with SMTP id 5b1f17b1804b1-493e689b0bemr68230185e9.31.1783625393415;
        Thu, 09 Jul 2026 12:29:53 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:d9f3:ab2b:ac6e:fc84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm53873509f8f.5.2026.07.09.12.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:52 -0700 (PDT)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ggoerisch@gmail.com,
	herbert@gondor.apana.org.au,
	herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org,
	miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 6.6.y v2 0/5] crypto: talitos - fix rename first/last to first_desc/last_desc
Date: Thu,  9 Jul 2026 21:28:21 +0200
Message-ID: <20260709192826.12699-1-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026070912-pluck-bagful-2a71@gregkh>
References: <2026070912-pluck-bagful-2a71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273026-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,bootlin.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:ggoerisch@gmail.com,m:herbert@gondor.apana.org.au,m:herve.codina@bootlin.com,m:linux-crypto@vger.kernel.org,m:miquel.raynal@bootlin.com,m:paul.louvel@bootlin.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:thomas.petazzoni@bootlin.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEC30735064

Thank you Greg for this feedback.
v2: add reason and SoB to revert commit which was missing.


Commit a1b80018b8cec27fc06a8b04a7f8b5f6cfe86eae
was backported to 6.6.y with a866e2b1c65edaee2e1bb1024ee2c761ced335f8
It renames last to last_desc but misses one occurrence which leads to compile errors on mpc85xx

drivers/crypto/talitos.c: In function 'ahash_digest':
drivers/crypto/talitos.c:2204:16: error: 'struct talitos_ahash_req_ctx' has no member named 'last'
 2204 | req_ctx->last = 1;
      |        ^~~~

Instead of renaming req_ctx->last, commit 9826d1d6ed5f8 ("crypto: talitos - stop
using crypto_ahash::init") should be applied.
Ideally before commit 00463d5f864a ("crypto: talitos - fix SEC1 32k ahash
request limitation") to avoid any compilation breakage and ensure correctness of
the code.
 
> > Greg could you please backport the mentioned commit to 6.6.y in the correct order for the next update?

> Can you send a series of backported patches in the correct order for us
> to apply, so we know to get them correct?  Trying to dig out from an
> email like this is usually quite easy to get wrong :)

Hope this is correct.
Goetz


Eric Biggers (1):
  crypto: talitos - stop using crypto_ahash::init

Goetz Goerisch (2):
  Revert "crypto: talitos - rename first/last to first_desc/last_desc"
  Revert "crypto: talitos - fix SEC1 32k ahash request limitation"

Paul Louvel (2):
  crypto: talitos - fix SEC1 32k ahash request limitation
  crypto: talitos - rename first/last to first_desc/last_desc

 drivers/crypto/talitos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.54.0


