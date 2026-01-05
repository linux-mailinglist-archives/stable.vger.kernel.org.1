Return-Path: <stable+bounces-204717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E49CF34F3
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB21D30373B3
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8F13161A9;
	Mon,  5 Jan 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Bjrl0KLu"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A708329E69
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612403; cv=none; b=RSO2VFs6/yNE7vKj2uvST/rVPz+jpLS8sTf20SzlUP+rSJ0MVNBV0Lh/pXAowsygOoWiiyDmQewJC7fI5rxKrO4n4yEIhGiGwGEKH4D1RvZHY4jVxiWi9T18qRcKK8OW//rS6W+497AzJ90VG6mdt+QxIOgni9qIjcKnH4/1ThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612403; c=relaxed/simple;
	bh=TDS5KiYlE+OV8vL/0T7qnbPj0yZ2MaXiKsyvvNu6Z9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPy098HDM7Sw6aD6M/OnnpWDJdsjAQvFATP9PrxAShiU3zS7BgyMqj1Ylf6xXKTvnRgKz26KrLz+Xhpmdp+nzaIdgUiNgqhrEX3BVDY+i0qUuGjPliTs4QxcJLfjKMyVvpzXaMITPK18BonwX1sZHRKQFiLKnjqie9b4q2/Sdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Bjrl0KLu; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202601051116290f2f9a8ec6000207d3
        for <stable@vger.kernel.org>;
        Mon, 05 Jan 2026 12:16:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZtCgw+NRGu5rSbTjV408jt7hG/zRI1D3Ytl7rQF6fGA=;
 b=Bjrl0KLuivek0UDLvspzK6kARD4G7IP6eXVQrVzUs8yUW/TOmMVhCZZ1O2Xklya5xnaJEI
 AOcBqWXc+pdY6OXjI29pgPT0BNrRSZaXkQI9RgWlXikd2Kq9GxRTtZw1+mkbLIWmTi3AHoL6
 lt9sI3+8vgVLd7S62bGEqOhcvG7Kz76/HwGf9e0kffnfWSMNPvP0w7ptH2PftcUkl+5Uyk1y
 A5MRvVDw4/priqDkcaDAmRuqgmPih2Wjs+GE1GMhGvJex6dcQju5JuLQgrV3DewLiGIWPXdA
 Bj9FUp1R6nAzFeIYN6tPa5HzRxHtqIDQNFrf1p0FT+4E0aJzvsKLrfJg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Fietkau <nbd@nbd.name>,
	Quan Zhou <quan.zhou@mediatek.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.12 0/3] wifi: mt76: mt7925: fix suspend regression
Date: Mon,  5 Jan 2026 12:16:25 +0100
Message-ID: <cover.1767611788.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Suspend to RAM with the mt7925 running is broken since 6.12.31 due to
having ac3af695c4b0 without its dependencies. This brings them in as
well.

Jan

Quan Zhou (3):
  wifi: mt76: mt7925: fix the unfinished command of regd_notifier before
    suspend
  wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
  wifi: mt76: mt7925: add handler to hif suspend/resume event

 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  6 +--
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 24 +++++++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 49 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 21 ++++++++
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 33 ++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/usb.c   | 20 ++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 +
 15 files changed, 154 insertions(+), 36 deletions(-)

-- 
2.51.0


