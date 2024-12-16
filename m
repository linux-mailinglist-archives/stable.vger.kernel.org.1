Return-Path: <stable+bounces-104392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA89F3995
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA1B16AAE3
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C859207DF7;
	Mon, 16 Dec 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="KhL93ajK"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F1207DF4
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376725; cv=none; b=T/4OOdFSv4CQBL0Ks93IJ+dnSTMkWqp0j9aMPRL7coa8MQPhZbca3JpD0INPQE2q3CZcwDtLTHzL//WyIeZS1GXC3E4HlQ5SeYIHskt9SeyM+Go4qy5uzXU2LPdm7pwstIyOJmmLxN99NKNEY7ZyALVhJ5Dnvu7og7wPuLhCQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376725; c=relaxed/simple;
	bh=FcDPFipqqPQ8k6yqf0odccIYRw/CdZh2wu8OxGuDbC8=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Content-Type:Subject; b=hGdHys1MPoAw5/YTX0RR2gv3EWMAkVkjqTraMQ27G9v+89fXWIbGROk+0j1ya+WlDBrWgZC3BSuZJOsLOB959wIGQMfK3+/2Gycpc2MfspLEkcDyil05AbcY0Jd4rYzgh6gkPmprLmVGe+4f/Zb0+ST4Or/kb+zEtuTbyORnNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=KhL93ajK; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=7o0I5v4ry4KF9/4BgmwUjyK8B3b8QxULHBto7wtpFyQ=; b=KhL93ajK/LfrLs3QyjjJCvLSh1
	P7g1i6lxlOf0kvT8UDCuE9FVZfTfajs9TqJWiqj1zhAjTxe4DvSmH/X3Sof9HivuP7g+uA1QFj01O
	VyLn4Sg8YXxDwxhn2NoDpd21NHbVnGYZ2mQNKo5pAz284vrl6S1LnD10PHr96SVmDyTQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42958 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tNGc4-0002CS-NZ; Mon, 16 Dec 2024 14:18:41 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org
Cc: hugo@hugovil.com,
	hui.wang@canonical.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 16 Dec 2024 14:18:14 -0500
Message-Id: <20241216191818.1553557-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
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
Subject: [PATCH 0/4] serial: sc16is7xx: backport FIFO fixes for linux-5.15.y
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings additional patches to fix some FIFO issues when
backporting to linux-5.15.y for the sc16is7xx driver.

Commit ("serial: sc16is7xx: add missing support for rs485 devicetree
properties") is required when using RS-485.

Commit ("serial: sc16is7xx: refactor FIFO access functions
to increase commonality") is a prerequisite for commit ("serial:
sc16is7xx: fix TX fifo corruption"). Altough it is not strictly
necessary, it makes backporting easier.

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

Thank you.

Hugo Villeneuve (4):
  serial: sc16is7xx: add missing support for rs485 devicetree properties
  serial: sc16is7xx: refactor FIFO access functions to increase
    commonality
  serial: sc16is7xx: fix TX fifo corruption
  serial: sc16is7xx: fix invalid FIFO access with special register set

 drivers/tty/serial/sc16is7xx.c | 38 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)


-- 
2.39.5


