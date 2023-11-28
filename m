Return-Path: <stable+bounces-2919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06BF7FC147
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 19:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B59CB2025C
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6239ADC;
	Tue, 28 Nov 2023 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="I2+NYEUO"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB219AB
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 10:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:To:From:
	Date:cc:subject:date:message-id:reply-to;
	bh=qkBMKA7yIw1UsjlCrKPeb+tr7FQXd+lwMz2MjBkPkkI=; b=I2+NYEUONGIPNxCx1SCVINpLNx
	nbB8s5758N0eIcpR7dVn60sokDC8xWzIRZPGh+VprEAxUkZ4w7+dYUyEOINSCWxi28jcqfqJ0X0i3
	+INkAbls5kitgpk1w2wm2owlX3m8Rky4H1iVl95cxZzb7fLET3JRT3O6b2t388svTgDk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56002 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r82bu-0006xl-Jd
	for stable@vger.kernel.org; Tue, 28 Nov 2023 13:15:04 -0500
Date: Tue, 28 Nov 2023 13:15:01 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org
Message-Id: <20231128131501.3a3345477530cfdeeb2f0c62@hugovil.com>
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
Subject: arm64: dts: imx8mn-var-som: add 20ms delay to ethernet regulator
 enable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,
the following patch:

26ca44bdbd13 arm64: dts: imx8mn-var-som: add 20ms delay to ethernet
regulator enable

Was introduced in kernel 6.5.

It needs to be applied to the stable kernels:
  6.1
  6.2
  6.3
  6.4

Without it, the PHY is not detected and the ethernet port is not
working.

Tested on a custom board with a Variscite IMX8MN NANO SOM for the
following stable kernels:
  6.1
  6.2
  6.3
  6.4

Hugo Villeneuve

