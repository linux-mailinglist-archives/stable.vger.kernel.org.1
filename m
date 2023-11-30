Return-Path: <stable+bounces-3265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A97FF458
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0591C20CC8
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EF53809;
	Thu, 30 Nov 2023 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="YUKhp6yY"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E08390
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:To:From:
	Date:cc:subject:date:message-id:reply-to;
	bh=48gsNzd/qiOjfEtMQ7X8oI8Y79krufJaj/LnTk7t7LQ=; b=YUKhp6yYle0iubJU2saz9+NdLZ
	1b4eBnXRDmxBnG7tmHqW6tQ05H/daznaKCKAa0J6Z82lRlgkMN66RDyCwq5uMzGO2N3CPBFvUQnYj
	je6mdKMajesbsGgP9n1OSs8jyX+rxdAXbEQNQ8eTwtjNPTXcgrnmGpIdvGUaLdgAO23g=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35336 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r8jXQ-0001W2-0J
	for stable@vger.kernel.org; Thu, 30 Nov 2023 11:05:16 -0500
Date: Thu, 30 Nov 2023 11:05:15 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org
Message-Id: <20231130110515.acac54a1a0552b4535388f55@hugovil.com>
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
Subject: serial: sc16is7xx: add missing support for rs485 devicetree
 properties
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,
the following patch:

b4a778303ea0 serial: sc16is7xx: add missing support for rs485
devicetree properties

Was introduced in kernel 6.5.

Without it, the rs485 devicetree properties are not applied and the
RS-485 ports do not work.

I would like it to be applied to the stable kernel 6.1.

It applies cleanly and was tested on this kernel using a
custom board with a Variscite IMX8MN NANO SOM, a NewHaven LCD, and two
SC16IS752 on a SPI bus. The four UARTs are using RS-485 mode.

Thank you,
Hugo Villeneuve

