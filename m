Return-Path: <stable+bounces-217591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HzSNYu5mGkdLgMAu9opvQ
	(envelope-from <stable+bounces-217591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 20:44:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FAC16A674
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 20:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63C7630479C6
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 19:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B25366829;
	Fri, 20 Feb 2026 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WlIlj2IP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43636604A
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616645; cv=none; b=tXGrmb0AblvPQhMkw+gydy1KKylUWcRzhpueXFqLPjkJiLAgLzT/Him9EB6+3tLY+ZwgP0+XY4nFrfVzm5LLqVr15lKnshJ64oGYfK/83NoDhGgJk0YrbJqQ8IK5PZzRMGX0Z7Y6LMOUerifTG2UgPHO0ewUKb/N87ntm9g0JQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616645; c=relaxed/simple;
	bh=Ly4iEjx6uZ+rJ9+G/vlKsJCinNauJ5e6oyNiW9ulKl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MeelHFd1n3G22XWEc0T8hWldlGNX+kgg5FS32x6L3n5MLZKmxzjnc4lrAFY1VfewZHINPNvE9LJxSrX3WFYOjuBEUDC31FMb0/aikWdmOViFmw595y4zxLLP1cWyrrI4QUIlfxq0UW8GYZFiV23ukZYX98OHbXrpFBuuOu0lnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WlIlj2IP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48371119eacso23669455e9.2
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 11:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771616642; x=1772221442; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfuC8wYvmgXv6e0lpDTw84mMEMfi1vaHFSvb7DY2Jxo=;
        b=WlIlj2IP6whDkow6qSzCbUwFzy2AOFnPl5lr37msHGgkWKIqb0FjPF3dwaLCQaTCf2
         nFBaYskmr1dB/hQiVbUlGcWE27C+pTQC+h9bhN1LbpAdLki1FsgDSuadVoFNdKnmX7jp
         7QBIwpdTnOc9i5ILiPXNUSKOJ1gzr0oU/FBjiCbvM3tTTyRapwHn1jX/9gSuMj12c/AF
         kuGyvXkEclbcV+GKcT75H7vXocdSiA0cl+mmZDdidE1cpY13jm+uZ+oLQpQ+zfBVUPCc
         93gHHoRzIX+kwwobQJW5G9udXAcy8N9dfWF/6aOVw/yejkQT9H+DjSxoFcrWlthi4cfR
         Q4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616642; x=1772221442;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfuC8wYvmgXv6e0lpDTw84mMEMfi1vaHFSvb7DY2Jxo=;
        b=IbLhOpU4b6HN2LdfMxSiKmndHLSyvME7GO0/3hFY5jLqCnb8GB8WPH9sGMNPIbeGWc
         NJY92PbO9xC3VU4ihp+T6WQM+Ozg99HfEmklQt0ACXp/kqnGSqPRO4RkSJ6s45reitcX
         Bzs0OsQTJaIoNo9sdNQxG4SiuZ+YiIm79nnfxELEieg/kAKQ4LJKv+Tzf96HALyzkrDo
         Lt1XMY/xwDD2xlXTBxG5nPO5QWrac8OXrw5YxakyFubeo5MRtf52uZpitrlcKkn760OV
         J53hHNkfFDXYhaXQkJYuSy5zvuQCerewNFj3GBtK/XJrOVZpeBroZZmXhi04iPyH6hjs
         ELSw==
X-Forwarded-Encrypted: i=1; AJvYcCXbHSFMb6xRBSk/0xcvxS97+iLpv/7srwHIvejUWEGgt5sNtFgnZHMjwsMI9/wx54G2diccNEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3okgptYqdmABAfuQeecgS5C0Y/QJCEEal83bky6LA8In9MJIY
	Yi5z6ETzShirCdOzzIG7ssRWLWlkUrYF9XT7ovL1hZwyGWkPkW85Mp0yiMU8RVlvtOY=
X-Gm-Gg: AZuq6aKWKS0wFFBAls40Rw7K9LQ6T9Mry5lemleym0KL+RX+WieVUCTt3UM/p9sHhea
	0PQ8lGJupZ53aQ0ha2hS1Jej5JnOU0yw6lks85gkIo4YlJ0hQp+nBy7uALr+zCCndhV1IwumLnF
	GbnukPK8XJt0LHQcpBuexhdwni5G/9L7hJ4u4TwrP3ge17CYY6GDjSrPjx8gSjL4q1euB8hHYpk
	xB4gg9DYH18YZICDYY2hgv6DHzFKHtx31sj50qLe0BGxfbMoUDUxOwXmEWkD1dR6+1MsvbogBTE
	6CZHjx27vTuLVjfR9c7FTgA6ts617eiiLCNWat+St7J8rog9HSWX4id2qkar17Un1/3xnCHCmk0
	Myt/Iz4GGs7MDqTBLwu8K6nbOmppVQYBidffhqEeMzhnLkNdoEZw6cz0fAcIoiE3kXiDkafciWS
	Rkn3mdMX8KQlaWpJ+eSwNa
X-Received: by 2002:a05:600c:6298:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-483a95fb23amr11365705e9.10.1771616641935;
        Fri, 20 Feb 2026 11:44:01 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e1b7ccsm24460755e9.11.2026.02.20.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:44:01 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Subject: [PATCH 0/5] dmaengine: sf-pdma: critical fixes and FU740 support
Date: Sat, 21 Feb 2026 03:43:52 +0800
Message-Id: <20260221-pdma-v1-0-838d929c2326@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHi5mGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0ND3YKU3ERdAxMjwySDVBOLREMDJaDSgqLUtMwKsDHRsbW1AEiI36l
 WAAAA
X-Change-ID: 20260111-pdma-0421b0e48a10
To: Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Green Wan <green.wan@sifive.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Palmer Debbelt <palmer@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 devicetree@vger.kernel.org, Max Hsu <max.hsu@sifive.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=Ly4iEjx6uZ+rJ9+G/vlKsJCinNauJ5e6oyNiW9ulKl8=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmLl7l/9teiwq1b0uEqS6AzBQvvq9KwMuuyxvo
 Hllat95F1qJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZi5ewAKCRDSA/2dB3lA
 vfitC/wNrgFNBVPVRVSl1TVKWOE7GbVcK8IJOazLaHl6+IC6NBJKUSQaBtYSLNPntLIfd4Zq/3S
 A3IqmGTSo+JJPcTGgaMfNEBazujzQ3UPslRRGOyMXg/spiAJs7IqnD03WYZZ0Pajntzc1cpz7XV
 OK9BEc/q6wn/GKslOuz5cWvUhEd5IXo+7OvSWvYrOhDF0bNmPKOZzJh2xuVfQaViupGywWxwgbb
 hgB5nkavL5jSOu0/mR00PAjr9NF+Ug+enB2Ap8eW7Mw6hWogEAXih7V7kbvdQ6S9Ll7PERBnoPQ
 EufsAIGwP91QJRlQt9+XvgWoIRm1QfmVEfC3ObbQ0LZyvpxExqVUSnDSvW8CN5+prB4bekwXe3/
 ZFAAhitkqABVNl0lBx/MVrG6xcyQ1NwsMHoWFOLdHIcRAXQs1bgNQ2hergH5V3U3KeVVVZojJmL
 mVoqRcz5BDnQY1LuDAzEwDa6xyvSQPxs0+wyofj20dWS3DuGRCzM1FQy+OXssQtibHM4A=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217591-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:mid,sifive.com:dkim,sifive.com:email]
X-Rspamd-Queue-Id: 85FAC16A674
X-Rspamd-Action: no action

This series addresses critical bugs in the SiFive Platform DMA (PDMA)
driver and adds support for the FU740 SoC.

The first three patches fix serious issues in the existing sf-pdma driver:

1. Missing PDMA base offset (0x80000) in register calculations. While
   the hardware provides an alias at offset 0x0, the driver should use
   the canonical offset 0x80000 as documented in the specification to
   ensure consistency and maintainability.

2. Race condition between done and error interrupts on SMP systems. Per
   the FU540-C000 and FU740-C000 specs, both DONE and ERROR interrupt
   bits are set simultaneously when a DMA error occurs, which can cause
   concurrent execution of done_isr and err_isr on different CPUs,
   leading to undefined behavior.

3. NULL pointer dereferences in both error and done tasklets due to race
   conditions during channel termination. Both tasklets unconditionally
   dereference chan->desc, which can be NULL during legitimate scenarios
   like sf_pdma_terminate_all() or when interrupts fire after channel
   cleanup. The fix adds NULL checks in both tasklets, protected by
   vchan.lock to ensure atomicity.

These three fixes are tagged for stable as they address bugs present
since the driver's introduction in commit 6973886ad58e ("dmaengine:
sf-pdma: add platform DMA support for HiFive Unleashed A00").

The last two patches add FU740 support:

4. Add "sifive,fu740-c000-pdma" compatible string to the dt-bindings.

5. Add PDMA device node to the FU740 device tree to enable DMA support.

All patches have been tested on HiFive Unmatched (FU740-C000) hardware.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
Max Hsu (5):
      dmaengine: sf-pdma: add missing PDMA base offset to register calculations
      dmaengine: sf-pdma: fix race between done and error interrupts
      dmaengine: sf-pdma: fix NULL pointer dereference in error and done handlers
      dt-bindings: dma: sifive,fu540-c000-pdma: add fu740 support
      riscv: dts: sifive: fu740: add PDMA device node

 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |  1 +
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |  9 ++++
 drivers/dma/sf-pdma/sf-pdma.c                      | 63 +++++++++++++++++-----
 drivers/dma/sf-pdma/sf-pdma.h                      |  4 +-
 4 files changed, 63 insertions(+), 14 deletions(-)
---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260111-pdma-0421b0e48a10

Best regards,
-- 
Max Hsu <max.hsu@sifive.com>


