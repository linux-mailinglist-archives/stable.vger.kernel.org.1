Return-Path: <stable+bounces-242985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AByPGNtx+GlCvAIAu9opvQ
	(envelope-from <stable+bounces-242985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:15:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9D4BB906
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43FBC3006691
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50598395DAC;
	Mon,  4 May 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csElEh77"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E538CFE7
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889751; cv=none; b=bQsc1oWlynA0qGp4o+th1LX5g0qzx2JLDUxrcIdOlT64BSygCwEMwdu1Cj8kQvs5xqcq5KtfyM6DyPVn1fdXLjpFFGMbNSJVh7QIPz50TDoFoGYVaBKz6DCJhpoYSeI4kfzWd87gcPQ6/mpjhMILgwQ2cUd6MRTxMNKqN7fEkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889751; c=relaxed/simple;
	bh=oVghwXEaGFO+mpqTUByC0AmUIQGtr/LpRywd/Udsh78=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZC3CVKSwBNigrsNJvpG41CGzhaBwDBDLbjHp0V2o0m4b/HSCmrLRG2+jqzycM213/DAt0toQj9Dn+Lfk5Fvtp49ozsO8Cizh35oGsiYhTBYVJIi+PpSWRnX2pWzr+X9Jr45FHCujpUrAwASsua9FY9cHpWZQSukxOY2tqhA6t5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=csElEh77; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d734223e4so2235040f8f.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777889747; x=1778494547; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXPt5HpxBahR86o/HeRzM3lfXAfvN85/ZCFAeD5ZDhk=;
        b=csElEh77xyETlfa9q9KvLEwkAMir1NeBDJYiefJHTrMwwFu18N+NJADB1KOadzXJS3
         A/l5hv1ykdP77BxbEyx45Grbg7xU9nMKiTEtBVkKp6KYrSnJNQoIMLsUzcytGWdHliYu
         Oz/f8A5U9il0Ex7VHYR1d9RWxHpo2Kchjp9x+FvywN0eaH3XPSV6WLA+cwxQ3ax8npvF
         scIrNix6TlMJ51OYsbQ+kkvhLeM4DeGGkEKzlGqkuTeCuCkUIvrgAyPVr92wl4yBFHmI
         s/F0VYltIIDFjMoUCACHrqf3Psf7vX5L5qjvj9Qv1jVK66D1n7j7MyzNHSKiIaf7ouqY
         KjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889747; x=1778494547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXPt5HpxBahR86o/HeRzM3lfXAfvN85/ZCFAeD5ZDhk=;
        b=NwX5xdyNYNJdKONHqHJbMx8rMBPd3S0WmXb0g4YmVober3DYV5dZP5ZdXl292C4dXd
         QK0H6KZGrLimXhjaMHty4P4GpqpQmhaBTxcv3UAtlFRpzkNqoXbIAYgO3L0ph1ad3rhN
         YQzK4mtckd5IoPsH/yQpBjGdVIO80AB9HDiYEMnCzeWUE93OXDT+rw9oY5R+qYQdO0T2
         anzGfy4ob8J73o81xyyI3YqoTF5+DkGl60UrCPZtsNezOLbTJS8VNrqP+zoa+qqrGIFL
         koYFxU8QRzaoXuZ+KQRXUDHlV6Wzl6YM0kwySfxx67uVxCAcJ3xvbyYdU7x/0XPpFg12
         sfbg==
X-Forwarded-Encrypted: i=1; AFNElJ+w8vR3Rmsa6tOxlbRFBikaByljQLiil0BfRDWnCWHhwUmMuUXvIX2hvdkAuYULIz0EpanxpQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXadnPToliZwxF7uZnN6JUy4fqBb3xZXq42a8opn0Cu2nKaDXG
	q2NzDAJ85IXA3wSndt0X8l7NJj5TTnNInpKMS3acuGYG8cdFhFvlL78pz7dennr+lcc=
X-Gm-Gg: AeBDiet32b3X3Z2g0MeOfOYjeBdhqsXlBWwZYmXxEkiS3TgD/G13QBSQisPSR6+fCS3
	+j0zXUw7UjbB7YW5X6YZsT248lS4xjiPtgs3Pl3uXCVE7IO7xhilLhZ+jQpVfCxTp6rsiQvI54T
	SjHXyD1sAVicoZbRAWiXAa0sc8wVZPslLwDhbpYQdkUgoiVJcgmId5LmaKpmrKIjSRuF6gjwUl7
	jmsQut0ivLthogFTfrU1L0AY5gNQjMFrcWNbwcJFGuPCjCRl9wa1Yar4SdNRoYLN2UjOLq9c0xk
	T5H11v8GBgNlKly7bH/uoc53GTEW8/42E3Z3HU3aNnS6ZkHYzLjyh8FYc5Io/wyMaefxmM9m5ms
	FvWkfizbchki4Ipu3/NUceU7onldjIzO7zE4jFxfgwEOQew6annN0j0974Dp38h3NiV9494hsFp
	ILBfkXT8OQSNgL06HEFTiiIZUB5WPjzrwkv61smM6BIy4BAEQ64DiFtqkqo9fTOVRh+gpofEwpH
	2bIYuvQ7s9J1DPGMA==
X-Received: by 2002:a05:6000:288e:b0:444:2db8:d07a with SMTP id ffacd0b85a97d-44bb34e62b4mr14894990f8f.3.1777889747455;
        Mon, 04 May 2026 03:15:47 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm28545366f8f.30.2026.05.04.03.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:15:47 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 0/7] firmware: samsung: acpm: Various fixes for sashiko
 bug reports
Date: Mon, 04 May 2026 10:15:43 +0000
Message-Id: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9x+GkC/43NwQ6CMAyA4VcxOzuzlcGYJ9/DeBiswKIyspFFQ
 3h3ByeMCfH4N+3XiQT0FgM5HybiMdpgXZ9CHA+k7nTfIrUmNQEGBROQUV0PT9rYFwYadOjs3VG
 Pg/NjoBqhrAo0eV5ykoDB47qY7q+31J0No/Pv9Vfky/QvNnLKKACXlVRMQY6Xh+21dyfnW7K4E
 baW3LUgWbxpSoNKaKXkj5VtLbVrZckSsm6k0BVT2nxZ8zx/ALcAwh5dAQAA
X-Change-ID: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777889746; l=3432;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=oVghwXEaGFO+mpqTUByC0AmUIQGtr/LpRywd/Udsh78=;
 b=voi8crt+8GfhFajHco5uShZAg9TtsMgq7FvCTHws0Ox4uzv85b6/H/AKZ9OX/bnVGCNmN/026
 WSvQjnVhGfODLDt/Z2xQYjglqoL157mZFKileoL4u1DzIBywuhNloqf
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 4BB9D4BB906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242985-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
      firmware: samsung: acpm: Fix false timeouts in polling path
      firmware: samsung: acpm: Fix missing LKMM barriers in RX and TX paths
      firmware: samsung: acpm: Fix infinite loop on sequence number exhaustion

 drivers/firmware/samsung/exynos-acpm-dvfs.c        |   3 +
 drivers/firmware/samsung/exynos-acpm.c             | 119 ++++++++++++++++-----
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |   3 +-
 3 files changed, 96 insertions(+), 29 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


