Return-Path: <stable+bounces-136660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C2CA9BF98
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C4A167409
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE022A4CC;
	Fri, 25 Apr 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="X9vAHPVG";
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="X9vAHPVG"
X-Original-To: stable@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CED1EF1D
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565524; cv=none; b=UAujIkX/luUZumDEVUOVPKN2JZEJViQZ6GZP2mfw3vRmhifSeaum3uHbRdo7rlP7DAr/aVHu7WHJRJEluz6xXUGtMAclbairrf/6bO0RYjEwicjK9aOSPxkPFND+N4iCWHGCo4HZwvhKneZNE+ZinhyrKoVWw3RzPYSA/Ckjv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565524; c=relaxed/simple;
	bh=DAJxaeNcQpafQW9RWCFBUEcxCekz3ge+dhl6fsdlwNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eisTicmTc/PkNlbkuRJLBtIgNnQHnzYxJuNfy9VYDDFKy1pnZXfSwbfvkJ4HSKcwnSOFUcwDiZmDqtY1EPkOktsDdhe/ASeepBcu2ZVyboUyTTrmrP6XUdbf/FqLWdJuaxmLIHZUIb2Rnl7mvnW+ovaofh3UJiQntPbA7d95HX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz; spf=none smtp.mailfrom=triops.cz; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=X9vAHPVG; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=X9vAHPVG; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=triops.cz
Received: from lenoch ([91.218.190.200])
	by cmgsmtp with ESMTPSA
	id 8DKUuWeN4wQNX8DKVu08QG; Fri, 25 Apr 2025 09:18:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1745565516; bh=bwAr5Ed2p9bCNr8Z5GzKgXrMEOb2uSCig8vtwMn1B0c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=X9vAHPVGftH+zVzahCtO8VFrI7zOxICVTdFeAttImGXj/ZQw9CKrAM4yxd1/Anr2M
	 TOFe+tQHMkyDWyWhHK0pXznN0w9/P5u5wnH+s5KitQQ7fuaYWU4t2vTiLurscZqwNy
	 R4AN0RGojd88Iwbi6IbEpeSmS3vI8pnIXGHfzWuAQO8yoe3FkG2Xv03qZbzs6MZQNe
	 Jnw8OQI0RsG0zxq8zmOZuaS0rKrM9GZzD0qFUTOIpWoFRK7VBgWzYRqTdShEdtPJPS
	 A9RAcxVuvTRZOknfp88pO/GQPVo9PvzmvlqTWC833umHWXQOd5XzWcmTMzcxzE3sh+
	 Qdkndn5mQBrNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1745565516; bh=bwAr5Ed2p9bCNr8Z5GzKgXrMEOb2uSCig8vtwMn1B0c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=X9vAHPVGftH+zVzahCtO8VFrI7zOxICVTdFeAttImGXj/ZQw9CKrAM4yxd1/Anr2M
	 TOFe+tQHMkyDWyWhHK0pXznN0w9/P5u5wnH+s5KitQQ7fuaYWU4t2vTiLurscZqwNy
	 R4AN0RGojd88Iwbi6IbEpeSmS3vI8pnIXGHfzWuAQO8yoe3FkG2Xv03qZbzs6MZQNe
	 Jnw8OQI0RsG0zxq8zmOZuaS0rKrM9GZzD0qFUTOIpWoFRK7VBgWzYRqTdShEdtPJPS
	 A9RAcxVuvTRZOknfp88pO/GQPVo9PvzmvlqTWC833umHWXQOd5XzWcmTMzcxzE3sh+
	 Qdkndn5mQBrNQ==
Date: Fri, 25 Apr 2025 09:18:34 +0200
From: Ladislav Michl <oss-lists@triops.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX
 skb
Message-ID: <aAs3Sp3ziDQlwn1a@lenoch>
References: <aAowy1C3tCewoMDT@lenoch>
 <20250424161853-e0ead2eb3d14df4c@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424161853-e0ead2eb3d14df4c@stable.kernel.org>
X-CMAE-Envelope: MS4xfOpCSrOIs98CdYo6c7FObN3zPKniG3nnFRA4vit+EQn27eNd2VEJuV9uPDHrHhX92JGRPPKj1idQljn9f/BuiYuKu7qPptkJ6dmhs0YPNCZfLg1aAbDh
 JAdtnRYA8YNH83Znhn+djELOyGFTHKwqmVpoGcOrjpSrN4uVFItXEBqfmGqrqcCxO3WZoH6CJKhdGzz/P5fTzTkAPopT7kh9ll0=

Hi,

On Thu, Apr 24, 2025 at 09:14:46PM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]

Hopefully this reply can reach also non-bots...

> Hi,
> 
> Summary of potential issues:
> ❌ Build failures detected
> ⚠️ Found matching upstream commit but patch is missing proper reference to it

Patch was intended for 6.1. branch only and this intention is expressed in
the Cc: tags where also additional patch prerequisite was specified, but
obviously not picked up.

> Found matching upstream commit: 3e5e4a801aaf4283390cc34959c6c48f910ca5ea
> 
> WARNING: Author mismatch between patch and found commit:
> Backport author: Ladislav Michl<oss-lists@triops.cz>
> Commit author: Ping-Ke Shih<pkshih@realtek.com>

Also noted in the patch description. Driver undergone significant rewrite
after 6.1 so change needed to be done different way. Backtrace also mine
from 6.1 kernel.

> Note: The patch differs from the upstream commit:
> ---
> 1:  3e5e4a801aaf4 < -:  ------------- wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
> -:  ------------- > 1:  d12acd7bc3d4c Linux 6.14.3
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.14.y       |  Success    |  Success   |
> | stable/linux-6.12.y       |  Success    |  Success   |
> | stable/linux-6.6.y        |  Success    |  Success   |
> | stable/linux-6.1.y        |  Success    |  Failed    |
> | stable/linux-5.15.y       |  Success    |  Failed    |
> | stable/linux-5.10.y       |  Success    |  Success   |
> | stable/linux-5.4.y        |  Success    |  Success   |
> 
> Build Errors:
> Build error for stable/linux-6.1.y:
>     drivers/net/wireless/realtek/rtw88/main.c: In function 'rtw_core_deinit':
>     drivers/net/wireless/realtek/rtw88/main.c:2149:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Wimplicit-function-declaration]
>      2149 |         ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~
>           |         ieee80211_wake_queue
>     make[6]: *** [scripts/Makefile.build:250: drivers/net/wireless/realtek/rtw88/main.o] Error 1
>     drivers/net/wireless/realtek/rtw88/tx.c: In function 'rtw_tx_report_purge_timer':
>     drivers/net/wireless/realtek/rtw88/tx.c:172:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Wimplicit-function-declaration]
>       172 |         ieee80211_purge_tx_queue(rtwdev->hw, &tx_report->queue);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~
>           |         ieee80211_wake_queue
>     make[6]: *** [scripts/Makefile.build:250: drivers/net/wireless/realtek/rtw88/tx.o] Error 1
>     make[6]: Target 'drivers/net/wireless/realtek/rtw88/' not remade because of errors.
>     make[5]: *** [scripts/Makefile.build:503: drivers/net/wireless/realtek/rtw88] Error 2
>     make[5]: Target 'drivers/net/wireless/realtek/' not remade because of errors.
>     make[4]: *** [scripts/Makefile.build:503: drivers/net/wireless/realtek] Error 2
>     make[4]: Target 'drivers/net/wireless/' not remade because of errors.
>     make[3]: *** [scripts/Makefile.build:503: drivers/net/wireless] Error 2
>     make[3]: Target 'drivers/net/' not remade because of errors.
>     make[2]: *** [scripts/Makefile.build:503: drivers/net] Error 2
>     make[2]: Target 'drivers/' not remade because of errors.
>     make[1]: *** [scripts/Makefile.build:503: drivers] Error 2
>     make[1]: Target './' not remade because of errors.
>     make: *** [Makefile:2010: .] Error 2
>     make: Target '__all' not remade because of errors.
> 
> Build error for stable/linux-5.15.y:
>     drivers/net/wireless/realtek/rtw88/main.c: In function 'rtw_core_deinit':
>     drivers/net/wireless/realtek/rtw88/main.c:1912:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Werror=implicit-function-declaration]
>      1912 |         ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~
>           |         ieee80211_wake_queue
>     cc1: some warnings being treated as errors
>     make[5]: *** [scripts/Makefile.build:289: drivers/net/wireless/realtek/rtw88/main.o] Error 1
>     drivers/net/wireless/realtek/rtw88/tx.c: In function 'rtw_tx_report_purge_timer':
>     drivers/net/wireless/realtek/rtw88/tx.c:168:9: error: implicit declaration of function 'ieee80211_purge_tx_queue'; did you mean 'ieee80211_wake_queue'? [-Werror=implicit-function-declaration]
>       168 |         ieee80211_purge_tx_queue(rtwdev->hw, &tx_report->queue);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~
>           |         ieee80211_wake_queue
>     cc1: some warnings being treated as errors
>     make[5]: *** [scripts/Makefile.build:289: drivers/net/wireless/realtek/rtw88/tx.o] Error 1
>     make[5]: Target '__build' not remade because of errors.
>     make[4]: *** [scripts/Makefile.build:552: drivers/net/wireless/realtek/rtw88] Error 2
>     make[4]: Target '__build' not remade because of errors.
>     make[3]: *** [scripts/Makefile.build:552: drivers/net/wireless/realtek] Error 2
>     make[3]: Target '__build' not remade because of errors.
>     make[2]: *** [scripts/Makefile.build:552: drivers/net/wireless] Error 2
>     make[2]: Target '__build' not remade because of errors.
>     make[1]: *** [scripts/Makefile.build:552: drivers/net] Error 2
>     make[1]: Target '__build' not remade because of errors.
>     make: *** [Makefile:1911: drivers] Error 2
>     make: Target '__all' not remade because of errors.

