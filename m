Return-Path: <stable+bounces-136648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFFCA9BC2C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 03:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEDE920AF4
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045520DF4;
	Fri, 25 Apr 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEHu8FNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C02C859
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543691; cv=none; b=ejqfkexg3LXmfrdX/wTW/7ri+f7WRIyPTsSOIqDIS2xpuXPF6QLViq4nNCfBKRuET2p6bfWal3/gj/jGEoX/EkQbAtdy8FYuMWTNO2ZS16maEHUU5vw4f94xoDsx/rxaoNGdkV8PQTqYqb5qK/lgXsOBhCcDH6f8BV9ZRmR894g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543691; c=relaxed/simple;
	bh=lR7uorPCYKo58hh8nyymmzhOWq1gw8idymf0cG+5cjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpEg4ALD3lb0hyKSoGyALhhZ6HmhKY4jkkADmXl+aJmGgCJgaJ4x9d5uwq3ASgirAy9VYlTVRKOQzoF8rLMxtPBvdPwzEwYFGUK+pHZAYPGZ2Cf1uOy34Ran9qwtc6snHMaVQ4m0B17nl0GU6vs//hRQ64nX+0JUTegUobX1ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEHu8FNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7343DC4CEE3;
	Fri, 25 Apr 2025 01:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745543691;
	bh=lR7uorPCYKo58hh8nyymmzhOWq1gw8idymf0cG+5cjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEHu8FNyQergROrvZgxo4ypf7BRjjFrxEPJEiX+7WSv1lXp8AH89CjkYqrX7QGhIF
	 xTm4BRA/IKmlYXWKcU/EvSuVdkSufjNeIiDmfbVJvOuS2FgddhUJOOHXvsDsSMQHwF
	 ogoe740cUs8w/AOBSUQ0TQOHJPMBpCrteSYbnXxG92D+xXeMUeU9fD/B1rdHVFPsc6
	 G7OtgC9RnzKXsOcwbN/5Ee1HOb0u8kKP3tu6GTTQZ433BwoVKR0S/62DP41Csbowfn
	 /UgBIFXuNnvueUV7IHTvvIDeYDhetRVW6zf44+JCO9jUPbea4wCiRtA22BoJXZwLAM
	 FJQcL0XmbrhVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	oss-lists@triops.cz
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Date: Thu, 24 Apr 2025 21:14:46 -0400
Message-Id: <20250424161853-e0ead2eb3d14df4c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <aAowy1C3tCewoMDT@lenoch>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 3e5e4a801aaf4283390cc34959c6c48f910ca5ea

WARNING: Author mismatch between patch and found commit:
Backport author: Ladislav Michl<oss-lists@triops.cz>
Commit author: Ping-Ke Shih<pkshih@realtek.com>

Note: The patch differs from the upstream commit:
---
1:  3e5e4a801aaf4 < -:  ------------- wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
-:  ------------- > 1:  d12acd7bc3d4c Linux 6.14.3
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

Build Errors:
Build error for stable/linux-6.1.y:
    drivers/net/wireless/realtek/rtw88/main.c: In function 'rtw_core_deinit':
    drivers/net/wireless/realtek/rtw88/main.c:2149:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Wimplicit-function-declaration]
     2149 |         ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~
          |         ieee80211_wake_queue
    make[6]: *** [scripts/Makefile.build:250: drivers/net/wireless/realtek/rtw88/main.o] Error 1
    drivers/net/wireless/realtek/rtw88/tx.c: In function 'rtw_tx_report_purge_timer':
    drivers/net/wireless/realtek/rtw88/tx.c:172:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Wimplicit-function-declaration]
      172 |         ieee80211_purge_tx_queue(rtwdev->hw, &tx_report->queue);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~
          |         ieee80211_wake_queue
    make[6]: *** [scripts/Makefile.build:250: drivers/net/wireless/realtek/rtw88/tx.o] Error 1
    make[6]: Target 'drivers/net/wireless/realtek/rtw88/' not remade because of errors.
    make[5]: *** [scripts/Makefile.build:503: drivers/net/wireless/realtek/rtw88] Error 2
    make[5]: Target 'drivers/net/wireless/realtek/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:503: drivers/net/wireless/realtek] Error 2
    make[4]: Target 'drivers/net/wireless/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:503: drivers/net/wireless] Error 2
    make[3]: Target 'drivers/net/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: drivers/net] Error 2
    make[2]: Target 'drivers/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: drivers] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2010: .] Error 2
    make: Target '__all' not remade because of errors.

Build error for stable/linux-5.15.y:
    drivers/net/wireless/realtek/rtw88/main.c: In function 'rtw_core_deinit':
    drivers/net/wireless/realtek/rtw88/main.c:1912:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Werror=implicit-function-declaration]
     1912 |         ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~
          |         ieee80211_wake_queue
    cc1: some warnings being treated as errors
    make[5]: *** [scripts/Makefile.build:289: drivers/net/wireless/realtek/rtw88/main.o] Error 1
    drivers/net/wireless/realtek/rtw88/tx.c: In function 'rtw_tx_report_purge_timer':
    drivers/net/wireless/realtek/rtw88/tx.c:168:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Werror=implicit-function-declaration]
      168 |         ieee80211_purge_tx_queue(rtwdev->hw, &tx_report->queue);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~
          |         ieee80211_wake_queue
    cc1: some warnings being treated as errors
    make[5]: *** [scripts/Makefile.build:289: drivers/net/wireless/realtek/rtw88/tx.o] Error 1
    make[5]: Target '__build' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:552: drivers/net/wireless/realtek/rtw88] Error 2
    make[4]: Target '__build' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:552: drivers/net/wireless/realtek] Error 2
    make[3]: Target '__build' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:552: drivers/net/wireless] Error 2
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: drivers/net] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1911: drivers] Error 2
    make: Target '__all' not remade because of errors.

