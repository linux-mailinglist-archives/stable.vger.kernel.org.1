Return-Path: <stable+bounces-244145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGnjBpzt+WlqFQMAu9opvQ
	(envelope-from <stable+bounces-244145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E314CE44C
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08433022A8D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6047B409;
	Tue,  5 May 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfhiZ3/h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99A242D72
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986835; cv=none; b=Yyf3Uu2Xb+r+ZMNY0psbq8beseXebaK+etfXSVhnlUV7mHVysB0Q2hVOwYFZwnRiJc2lTWvn1JFyuZB6l+bIqwx16hAFWECMZHzFGbxB/E9LymsIb9PYbLntrvBA5bLG6sZBqX2c7uEq/eJS8/2fx0yISlXDr8OE2zq1Cf4tUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986835; c=relaxed/simple;
	bh=wivIsrOrOOiUhQN35CYh7ZIXSWFpSvCVQrdHqBKvTe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UPBPtP/DCbwJgsbblRAKikOHceTm28+gmraloknLIU8rUusDPbikzoHJxfGi5KIZdRs2avTP/5l1yWtb3ZprWqxSVwm9Kcj2QBwtE3VS5ByfTshf2i9XNJuMO71KixBME9CFZnY8agPlWtvCtKRbyymiTkpAou42OnOMlR23nnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfhiZ3/h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso55527525e9.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986831; x=1778591631; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WTpRXtFTscssgW//d4BsVFh1NygaJXve5EIy5ifUx0=;
        b=sfhiZ3/hsGskmZEUcvOwYkXwVjT9Ath+se8KTso9PyfSz9khiuU3QD9RA06T1zo1zb
         dUJ1ibDs9Gdr7Z1V0uc55wP5MfqDDqW4Bm+pGtwuuLXcDci6M6QECJdoYH1TKqKr1GLy
         raFFK/ob4ZMLZ6RPIPaIxL8DHnBQJZfHkFfc92y1xa/2MP+4W71iYhaeak/jJUd9YThm
         +ICRBBlr2FUqHHUsxV3vpUjuDfQSub+j4S9FZUrEPlMFotuuS2uUnjuJ7ZGnl6vlpBAy
         ICWD7lcsLaxTyvfvPaJJ+A5X+U+CmNYcgdahdrATlJt9M4ESu5PpojedRE0N38C/qHLQ
         gQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986831; x=1778591631;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WTpRXtFTscssgW//d4BsVFh1NygaJXve5EIy5ifUx0=;
        b=sar582o6BuA2/94/o1aq8taR5GzcmwQ6k6IDDlEm+gNwunYa4jSizkXFh7EPOOG7IL
         /0nFN+GWDUll4KLSky0U5+K04yPhn6HWYEFacm+x8AfHFAEjVdH6lgc5z3wGB773lwfY
         7CyTeomSIMS19HzLbwPMnU9NmsJJ2gEPPCrlLBDUX2nrBHGYMiUH46D1BCKfycmqtyWG
         jqRkLU/LFHCOImfC/vi+BrBMZwiwXXG9rbijsJZnrY0sPAJbz5KGNFIeruXC9PbKxoow
         wmRE2vaVan705nzWSf9tBxUuL5ASVw+k5deBqvYSIKV8AAaCQoTehR1/9g6WZS4WssSI
         Jkcg==
X-Forwarded-Encrypted: i=1; AFNElJ+ngx9ymgL+kd+lUi3Sy289uNEDckDRBoL+rF0qHIbaJM0dzQVKG8K6miAe0RDSwD4nmq16w58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwI2la/p+686iXno7KTCL72T5VEIgNgEmCxWMscLg0CoC8/A66
	+Y+enl5uJdIhBlcvgQhQvRKVEBNc/yWYH4O9rauiXRCDnu1YEk12WoD+TbPnloco0aA=
X-Gm-Gg: AeBDiet0PfEUZBrvx+ZSrhNjYsxqDQN2cNSCtyPIA1mMt0lSgecVcL8Vvk/BgOavF/E
	Z9Hm9ImWxYeF4g0BhNTwDQ8BvW+Zb7bOotz4ij5VnCn9tpy+pBQhBK0FyYWKVg0PECcPeV8FOu9
	Nd0p3Rzc+NmEvVU8sHOHK9yrGNoiU45/gvgBtmnfeeEJrf9e7q2IApSQ3s4o6KRgW6z+Xphs3lM
	mrsoa7MnesH+wIHEA13klFbBtSo5GCECucT5qzMJu/XMZN7VsD4a0y/vWBE2KFxzUG2AJTNiGI+
	xUGGRlmAL+Xpn7/FpoYuAPQ2GuCIOjcx2Vi3CeMvyEqUJMUGWxFGhcLueTNqdZF5OV8YUODACAV
	sUh1hiWoQpDvGnSZ8839aa18m0zwycZNLaHdelaH05uKyOP2yYdexMyicae026FeqSSUeD7TUgW
	8sZbYGRl1UjXzj5ZyZY3Zq4t2CdK64Xq1ppfjAtSosquZhP95Ecj4ahb2gMJoeXRfwbm+gXWsGk
	5EmfYPK2fbqna/ofQ==
X-Received: by 2002:a05:600c:c089:b0:48a:7965:b943 with SMTP id 5b1f17b1804b1-48a98676d56mr203077035e9.29.1777986831533;
        Tue, 05 May 2026 06:13:51 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:51 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 0/7] firmware: samsung: acpm: Various fixes for sashiko
 bug reports
Date: Tue, 05 May 2026 13:12:57 +0000
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANns+WkC/43NwQ6CMAyA4VcxOzuzlY0xT76H8bBBkUVlZCNEQ
 3h3BxcxJsTj37RfRxIxOIzkuBtJwMFF59sUcr8jZWPaK1JXpSbAIGcCMmrK7kFr98RIo4mNu3k
 asPOhj9QgFDbHSsqCkwR0AZfFdH++pG5c7H14Lb8GPk//YgdOGQXgyirNNEg83V1rgj/4cCWzO
 8DaUpsWJIvXdVGhFkZr9WNla0tvWlmyhCprJYxl2lQ/lvhYkolNSyRLggaRW8wt2C9rmqY3wdj
 k06kBAAA=
X-Change-ID: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org, 
 Titouan Ameline <titouan.ameline@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=3844;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=wivIsrOrOOiUhQN35CYh7ZIXSWFpSvCVQrdHqBKvTe8=;
 b=aEK9MQsKZxlVWGLIEhKEu90rjntliZ7E+u0ZHa5Qd5IirP4CClxnf4EwhhYhDUcP0cM28hhtg
 v8sZQCM/392CUw8B+mejQzCnPkBIJdPiHQ9XMjSUPzZuQvC3onGRe6c
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 67E314CE44C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,google.com,android.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-244145-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid]

Fixes for concurrency and memory ordering bugs that were identified by
the Sashiko review tool when proposing the GS101 ACPM TMU addition.

While these bugs are genuine flaws, we haven't hit them yet, likely
because we don't have enough ACPM clients upstreamed to trigger the
race conditions.

These fixes can go in either at the -rc phase or as regular patches for
the next merge window. If the latter, we'll need a dedicated branch, as
these patches, together with the other ACPM thermal preparatory patches
will be needed by the upcoming GS101 ACPM thermal driver.

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v5:
- updates to the ACPM polling state machine and sequence allocator
  to resolve cross-thread Use-After-Free races, false timeouts, and
  LKMM memory ordering violations identified during code review
  (Sashiko)
- add parallel credits to Titouan Ameline on patch 1.
- Link to v4: https://lore.kernel.org/r/20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org

Changes in v4:
- Drop the SRAM boundary checks patch, incomplete band-aid.
- Split the concurrency and memory ordering into dedicated logical
  patches. It involved reordering of the last patches to avoid
  modifying the same code twice.
- Add a missing memory barrier in acpm_get_rx() to prevent weakly
  ordered CPUs from advancing the hardware RX pointer before the
  payload reads have completed.
- Fix a false-timeout race in the polling path by decoupling the
  polling thread from the global allocator bitmap.
- Use test_and_set_bit_lock. address dependency was not enforced
  when using the plain non-atomic read with find_next_zero_bit().
- Fix kernel doc.
- Link to v3: https://lore.kernel.org/r/20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org

Changes in v3:
- validate more SRAM parameters and queue pointers (sashiko)
- consider/fix the acquire path (Krzysztof) - patch was moved
  last in the series to avoid touching the same code twice.
- Link to v2: https://lore.kernel.org/r/20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org

Changes in v2:
- drop patch "firmware: samsung: acpm: Fix sequence number leak and infinite loop"
  The patch freed sequence numbers on mailbox failures or timeouts. Because
  the message is already in SRAM and tx.front was advanced, a delayed
  firmware wake-up will process that abandoned message, stealing the
  sequence number from a new thread and causing silent data corruption.
- fix mailbox channel leak when `acpm_achan_alloc_cmds()` failed. Did it
  by  moving the `devm_add_action_or_reset()` call.
- new patches, last 3 in the set, they fix some more sashiko reports.
- Link to v1: https://lore.kernel.org/r/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org

---
Tudor Ambarus (7):
      firmware: samsung: acpm: Fix cross-thread RX length corruption
      firmware: samsung: acpm: Fix mailbox channel leak on probe error
      firmware: samsung: acpm: Fix dummy stubs to return ERR_PTR
      firmware: samsung: acpm: Add memory barrier before advancing RX pointer
      firmware: samsung: acpm: Fix false timeouts and Use-After-Free in polling
      firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator
      firmware: samsung: acpm: Fix infinite loop on sequence number exhaustion

 drivers/firmware/samsung/exynos-acpm-dvfs.c        |   3 +
 drivers/firmware/samsung/exynos-acpm.c             | 145 ++++++++++++++-------
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |   3 +-
 3 files changed, 106 insertions(+), 45 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


