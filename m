Return-Path: <stable+bounces-210431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D8ED3BF2D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 198FD3521B8
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ACB36CE1D;
	Tue, 20 Jan 2026 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNvsZae0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391536C5B2
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890539; cv=none; b=SxCHFiLzRBwo21tm5nJGd8pUZxn0JXkbFDdGTqfQBn1C3kvu5wFg2VSao1dwgNVB+ecJz+PnXpwjBLFoMnEzCb42nLWt1XB52DYzv6uDolqZae8z9r3FVA81PMnWXaF+8Y2yHPhBylo+RMtOR5AYvxFqbLOBJ7L/pJihv2xSitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890539; c=relaxed/simple;
	bh=cf6IGNMMMwXticxB+OfAHFQxcYExa32hB22vyjEMBAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK8mp9tZwi/hd12Uk+whgg4VCvL5ocmGTvdmannAbOqTy4AtqjdXcUNcpUw06v1EG1lw6mXQhrABQjdIoFVArnPOcD4yIZ1mdlNfeEmqoNf2qPPWbfG9P1YrjtlCHq2P50VBbR09Ua4UuzAsSiAAgeEJj80vYfRbWdOcBwicLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNvsZae0; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ae5af476e1so2382417eec.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890537; x=1769495337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YznedogKosCYjQoxhmZaws4K9eCkq32zETWn/NeO/UE=;
        b=GNvsZae07r9PFfsyRE30OwIfMWfbjvQSnhWShXOOiYAMXHtcWPJ3m9OkA2sFadnGdw
         fiT9fuRxJGodb0NLjANKiFCutMsN/mqBAGq7Xh8iBCHuJiNlKiy5qCePoUKxdMk4sbEg
         QvNHHhTG6DdgbF537biavjYJBPb63Ye2ZArnxNEpj/lhdkg2Tr3TWGhEXpCND9IscMn2
         tRmFLapIJ0ITtfoy87D+wpGrHHO/UOGwsprUwcJ5R6/r5kkUCp6k7aGpemMM5TjWWrFB
         c2aVzTf46ljyhg5pyVwD84Pb9cVdZaZ5Y4MQcE/c5xMvbZTfa9bsSa6Cj5S6Orm+C4pT
         /tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890537; x=1769495337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YznedogKosCYjQoxhmZaws4K9eCkq32zETWn/NeO/UE=;
        b=cn2BuOSnzQ5mIEDVftK8ErLFYyNPd/bl0Kn/Cr9JTfMX/uDf87tdPtKG2W5y0p84lq
         +JinMHii3ju79DTaR7E7QjcINa8L7/TW6FOtVbdFrvFLhPPenWU3m9OI58gNzThpnzhn
         e554mnIYI252baPIrszOdAxA3hG1D9BRPWwnGIZrApa/v+cVBaPbz4Vi1zrE1mHUeBHi
         O9QxoHwXcrguZfRg23Gs1u09XE5LMvMDf/3o4JeCKeNinJdNAaEL00e2SzkLu1b+8xyv
         mqaq8vUHalDsfJ0SRtTJo7osMdlT4jxw3P/RH4ZI0+MhTD2dqsjL2vP+KhWwEFEJbJ3p
         x9hw==
X-Forwarded-Encrypted: i=1; AJvYcCVMXQR8D+au8M7eVZPXgViLWgFp21Ew0Ge8Vv6rIWsb26iGVUOKnu6SbEhm3mLm3vdm/8K2Dh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf4Vd5zOyUXBOTfziWJSrF+W+crQ0oMxfhmYVnV2MFZCb99y0a
	uBI7TWkZAfy5G6+Tf9aukqPZflorDkxsTszprrj0FoqmuFEPIZW4lJ9y
X-Gm-Gg: AZuq6aKvK2HKVlgVzqWgUMKPZbSFCudW2p5r3iSYpwKYQ/dhu/jjkwCiMdhI9z9yi2A
	J2bynuuunI/v06KcPWQ6z2YmisnTz0UBH/8fKevCLC5lqeERpOBhv7+Aj1yLvQs7DIQ/Nu+xis1
	kyNFp2HzKnw+cxVaJwRQPXuLfDYdLAyzLqUoEMkF7y6Cd4Ylhy8ekPo1TVcQf24zj5YDlJKPJ7t
	KwAIuGGzaQ9gPYCjTtZaG3bCuyJDhLkdgFmnh9OndiMcob23nmk91YzjnTufZPpAWJe0D8x8Kgj
	kQf4B7MIqhHBGahMstI8q6lN8CrQQIXUYkhkKWvnJ95XePJYj1mxIo9YUkoJQo1WrLNRXtu/nj7
	O0bmDxw6GM5vSHKTge9kWpeQDmSbuDQ78ctohpw9wOn+48wLUdH31RYZVqUEDcb8N58OY9nwSjX
	6PWrMEVOWCjeV9pv7lWoB/SNYJFoHqoAqkgVKCtGkl+tmHrwK7P6C0hEK6YGLI
X-Received: by 2002:a05:7300:7493:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2b6b357e24dmr9383608eec.14.1768890536577;
        Mon, 19 Jan 2026 22:28:56 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:28:56 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v5 00/11] wifi: mt76: mt7925/mt7921 stability fixes
Date: Mon, 19 Jan 2026 22:28:43 -0800
Message-ID: <20260120062854.126501-1-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

This series addresses stability issues in the mt7925 (WiFi 7) and mt7921
drivers, focusing on NULL pointer dereferences, mutex protection, MLO
(Multi-Link Operation) handling, and ROC (Remain-On-Channel) state machine
fixes.

Changes since v4:
- Reorganized 27 patches into 11 cleaner, logically-grouped patches for
  easier review. Patches are now ordered by subsystem dependency:
  mt76 core -> mt792x shared -> mt7921 -> mt7925

- Consolidated ROC-related fixes (previously patches 22-27) into a single
  comprehensive patch (11/11) that addresses the interconnected deadlock
  and race condition issues discovered through extended testing

- New issues fixed since v4:
  * ROC deadlock in sta removal path - cancel_work_sync() was waiting for
    roc_work which needed the mutex already held by sta_remove
  * ROC timer race during suspend - timer could fire after suspend started
    but before ROC was properly aborted
  * Async ROC abort race condition - double-free when async abort raced
    with normal ROC completion
  * Added ROC rate limiting with exponential backoff to mitigate MLO
    authentication failures caused by rapid ROC requests overwhelming
    the MT7925 firmware
  * Fixed spurious ieee80211_remain_on_channel_expired() callback when
    ROC wasn't actually active (found via code review)

- Added corresponding mt7921 fixes (patches 3-4) since the older driver
  shares similar code paths and exhibited the same deadlock patterns

- Firmware reload fix (patch 2) addresses crashes when the device needs
  recovery after a failed firmware load - the semaphore wasn't being
  released, causing subsequent loads to hang

Investigation and Testing:
  All issues were discovered through real-world testing on Framework 16
  laptops with the MT7925 (RZ616) WiFi module. Crash dumps, dmesg logs,
  and detailed analysis are available in the repository below.

  A DKMS version with extensive debug logging is available for community
  testing. This has been instrumental in tracking down the more subtle
  race conditions and deadlocks that only manifest under specific timing
  conditions.

  Repository: https://github.com/zbowling/mt7925
    - kernels/    - Pre-built patches for 6.17, 6.18, 6.19-rc, nbd168
    - dkms/       - DKMS module with extra debug logging
    - crashes/    - Crash investigation logs and analysis

Acknowledgments:
  Thank you to the community members who tested the DKMS version and
  provided crash reports, dmesg dumps, and helped track down the more
  elusive deadlocks. Your patience and detailed bug reports made these
  fixes possible.

Tested on MT7925 (RZ616) with kernels 6.17.13, 6.18.5, and 6.19-rc5.

Zac Bowling (11):
  wifi: mt76: fix list corruption in mt76_wcid_cleanup
  wifi: mt76: mt792x: fix NULL pointer and firmware reload issues
  wifi: mt76: mt7921: add mutex protection in critical paths
  wifi: mt76: mt7921: fix deadlock in sta removal and suspend ROC abort
  wifi: mt76: mt7925: add comprehensive NULL pointer protection for MLO
  wifi: mt76: mt7925: add mutex protection in critical paths
  wifi: mt76: mt7925: add MCU command error handling
  wifi: mt76: mt7925: add lockdep assertions for mutex verification
  wifi: mt76: mt7925: fix MLO roaming and ROC setup issues
  wifi: mt76: mt7925: fix BA session teardown during beacon loss
  wifi: mt76: mt7925: fix ROC deadlocks and race conditions

 drivers/net/wireless/mediatek/mt76/mac80211.c    |   8 +
 drivers/net/wireless/mediatek/mt76/mt76.h        |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  |   2 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  37 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  |   2 -
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c |   2 -
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |   8 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 257 +++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  46 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  |   4 +
 drivers/net/wireless/mediatek/mt76/mt792x.h      |   7 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  17 +-
 12 files changed, 340 insertions(+), 51 deletions(-)

--
2.52.0


