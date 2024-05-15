Return-Path: <stable+bounces-45169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF308C67BE
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D22F1F2298C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357858615E;
	Wed, 15 May 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="qhG1Whfe"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1548595C;
	Wed, 15 May 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780981; cv=none; b=nmyBRUylMdCbgaFmzHBgv1Bl+fh+vGWjaQVwgh5v89rkRDEBb+mrRsxHebwtjr66ZIl6LqKRZymELmZ/FlXYM8GM9mm/gf2hNWehsQVXdkxWnnwUrZ0Rkx/TFSEI/B3sMxSOw4sCXlRyRmbz+fUF4mRJaCrZXDdPkhIlAtSw2Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780981; c=relaxed/simple;
	bh=0MlvzVZzue7/R2CDCoNlouGliEq8QcFEwGfHzAdAXIM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=W/FIi7C5URVOAYGjNxG/CiiTX1MFgHQcEJTy6iifEGBsu91Ahb6N5FTHRq/xJCiy+z7/jLU0+PmlnKUC4ovGCuM5QqQrRCQmRMx1qYpj3S795bf9j4SReNJEB6VKfUnGHZpw8F8kzWGc50IQ3Is2Dx5g3bLhEC8W0yfCISYAdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=qhG1Whfe; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0MlvzVZzue7/R2CDCoNlouGliEq8QcFEwGfHzAdAXIM=; t=1715780979; x=1716212979;
	 b=qhG1WhfeFZ21Yx9+s8EOusIxSQBzgZmbWfWyARR9rJ3THxANPtfQSWtCNH3tAxia/z/ds2vAX8
	OsW3wi6U3jDS1V6uIj/bonluN6Hu2ojKrYypal2Sb93QLqSpcqrc0LB+P9uG1w89YUoUhHp/AZIUs
	GUSTHspDeTOb/GeGezJJYaAZ6PqfMOA6GI/70HGPD19Y+AAmfrwbu0zckeIyh+0huC7dCneZxxor0
	GHRVmATyuSFqF1HIRY+oRPhZ0LoPUMtaiGHJb+yz53RxJ76PEPPoAePunipRS9WbSgOe2BtstrGiC
	0XLdm1f4tdhWImYggj5RjX4Ig7lf7C/AsjMxQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s7F0c-0003mR-L4; Wed, 15 May 2024 15:49:30 +0200
Message-ID: <9e40badb-c4fa-4828-a4c5-3a170f624215@leemhuis.info>
Date: Wed, 15 May 2024 15:49:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Subject: three commits you might or might not want to pick up for 6.9.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715780979;b452fbda;
X-HE-SMSGID: 1s7F0c-0003mR-L4

Hi Greg. Here are three reports for regressions introduced during the
6.9 cycle that were not fixed for 6.9 for one reason or another, but are
fixed in mainline now. So they might be good candidates to pick up early
for 6.9.y -- or maybe not, not sure. You are the better judge here. I
just thought you might wanted to know about them.


* net: Bluetooth: firmware loading problems with older firmware:
https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/

Fixed by 958cd6beab693f ("Bluetooth: btusb: Fix the patch for MT7920 the
affected to MT7921") – which likely should have gone into 6.9, but did
not due to lack of fixes: an stable tags:
https://lore.kernel.org/all/CABBYNZK1QWNHpmXUyne1Vmqqvy7csmivL7q7N2Mu=2fmrUV4jg@mail.gmail.com/


* leds/iwlwifi: hangs on boot:
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

Fixed by 3d913719df14c2 ("wifi: iwlwifi: Use request_module_nowait") –
not sure if that one is worth it, the regression might be an exotic
corner case.


* Ryzen 7840HS CPU single core never boosts to max frequency:
https://bugzilla.kernel.org/show_bug.cgi?id=218759

Fixed by bf202e654bfa57 ("cpufreq: amd-pstate: fix the highest frequency
issue which limits performance") – which was broken out of a patch-set
by the developers to send it in for 6.9, but then was only merged for
6.10 by the maintainer.


Ciao, Thorsten

