Return-Path: <stable+bounces-3264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099157FF449
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B866C281968
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610CB54660;
	Thu, 30 Nov 2023 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GVr05Am8"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E019AE
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 08:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:To:From:
	Date:cc:subject:date:message-id:reply-to;
	bh=o5Wg29YVE1BGRiVs4P66jnTMNHUXDs8zz+7y6KPtWUw=; b=GVr05Am8Rq3b02T6Pm8TAGxyCU
	7OmkdGBvl1txbgXZQHLJRzv8NthJHX57RHS1EO4XMqwPWlOCw3NqJQ/K4P5EsGTGjspk0gPUieS7u
	lExKbfTnv6ijOW0U8rOd0dcundRWAAUuuwDl6wTc3jz1nv26ad7txWEAKh00T/tJAql8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56788 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r8jUM-0001UC-6h
	for stable@vger.kernel.org; Thu, 30 Nov 2023 11:02:06 -0500
Date: Thu, 30 Nov 2023 11:02:05 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org
Message-Id: <20231130110205.f4c71f8719f8b3ff3c631de2@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: serial: sc16is7xx: Put IOControl register into regmap_volatile
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,
the following patch:

77a82cebf0eb serial: sc16is7xx: Put IOControl register into
regmap_volatile

Was introduced in kernel 6.5.

Without it, the debugfs register display can be incorrect for this
register.

I would like it to be applied to the stable kernel 6.1.

It applies cleanly and was tested on this kernel using a
custom board with a Variscite IMX8MN NANO SOM, a NewHaven LCD, and two
SC16IS752 on a SPI bus.

Thank you,
Hugo Villeneuve

