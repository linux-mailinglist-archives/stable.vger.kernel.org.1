Return-Path: <stable+bounces-104395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1359F399C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE43164CC7
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AD208990;
	Mon, 16 Dec 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BW5fkgWH"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024B2080F3;
	Mon, 16 Dec 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376733; cv=none; b=OK651kfwBJPU+QBptPE1UUCjbIosCDCtr34xoGFGN5LkpADCLcUO49y5LrFt+5u7EpYzkQn13CyJgFOSPw44mn4JOpmTNsj1tV21bE5z1MbvpM1quGiBPVGjiNz2oeFh+50NNxdkXfCSq0QhT6QFLdDYg9TqQzhDul7idKGjkrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376733; c=relaxed/simple;
	bh=hl0pGQEB7/82kKxzA62tg8G5O7Jqdqf1ZVY7lOSt/EE=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Type:Subject; b=Q6ZKtguEjs48vEZxm6TrZvEgJAkqfKNMEaO84wQSWnubgpNiT1k8S1p5V7sD4YObZR0p2TRvrxhGU3fReJ0ZnPzQvlYb0jrvlA917ZPQhPgQcaQlcTFpAM4Dw4hpeuriuKb23oMiQCzCUKmbuaW3UqlnuljPCpZdZUxq636ksQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=BW5fkgWH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=O/i0topftM8ipSFp4ROmDf2I1pusEubFlDlXJTK2PAk=; b=BW5fkgWHfImXkhWpHmIWTmmivJ
	LbPQ+BKOTLTPmDC3VWOnGwzWUi/h+f2KLNyNUew7RbLZfv732yTpF1Of3uce3mobhm81JaT14065m
	OT/cT+Wx7+KeYC5BOtYAa/dp2CuH/3JL+OV+ooQ/Cy8ZEggcgBTzA+vuC5VpWZk8Cam4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42958 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tNGc5-0002CS-Uj; Mon, 16 Dec 2024 14:18:42 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	hui.wang@canonical.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Mon, 16 Dec 2024 14:18:15 -0500
Message-Id: <20241216191818.1553557-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216191818.1553557-1-hugo@hugovil.com>
References: <20241216191818.1553557-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 1/4] serial: sc16is7xx: add missing support for rs485 devicetree properties
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Retrieve rs485 devicetree properties on registration of sc16is7xx ports in
case they are attached to an rs485 transceiver.

Reworked to fix conflicts when backporting to linux-5.15.y.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Link: https://lore.kernel.org/r/20230807214556.540627-7-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 692c14d7f7d1a..3d3f66563b73b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1307,6 +1307,10 @@ static int sc16is7xx_probe(struct device *dev,
 
 		mutex_init(&s->p[i].efr_lock);
 
+		ret = uart_get_rs485_mode(&s->p[i].port);
+		if (ret)
+			goto out_ports;
+
 		/* Disable all interrupts */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
 		/* Disable TX/RX */
-- 
2.39.5


