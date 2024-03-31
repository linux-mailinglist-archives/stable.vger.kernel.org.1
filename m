Return-Path: <stable+bounces-33852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A2892EB8
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 08:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A63D1C20B30
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 06:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E26FB2;
	Sun, 31 Mar 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quaintcat.com header.i=@quaintcat.com header.b="QJViYUcS"
X-Original-To: stable@vger.kernel.org
Received: from mx3.quaintcat.com (mx3.quaintcat.com [51.222.159.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFFD6FA7
	for <stable@vger.kernel.org>; Sun, 31 Mar 2024 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.159.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711865236; cv=none; b=S7kVgzQO12VMjbTp+Q3+sVdwOA1+rmz+GQl/qiUjU5dzKEkYEi9RVc3fMkIXGcTOPiS06Yb/WEDRMblM1DaOeMxXrxl+izAMTYv+kKPes+3hLfC+9WbtBNzpvC7BGM/Bqb55CEOFxTsx4a7pUgwwJxe5VXtO+khuQbdT84YiZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711865236; c=relaxed/simple;
	bh=Ft2ZyO38MJAyx+xz3hc0o+PsDVYPeZWdszawndIz8ag=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=hdUH5s5DCnCpOVHIC+bpm6YC3Uw2bTGlzQwKTNuC93A9RiTr+0c+RYh1SW8N1qAsHIylAjVThXAHI3JQoHkPPsHXJayToXSWgIm6RLGGheLCO5O16JMrcl/vQofx1jS81xMztuPjDlVwtUwCnTaB+9K5kmC+RhTJSXOnPyiPazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quaintcat.com; spf=pass smtp.mailfrom=quaintcat.com; dkim=pass (2048-bit key) header.d=quaintcat.com header.i=@quaintcat.com header.b=QJViYUcS; arc=none smtp.client-ip=51.222.159.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quaintcat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quaintcat.com
Date: Sun, 31 Mar 2024 00:59:51 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx3.quaintcat.com 0C4292004C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quaintcat.com;
	s=mx3v3; t=1711864803;
	bh=226hwrhacq+TC1h/KzA3HIs/y5L5HvPLLdDsJkeKcBc=;
	h=Date:From:To:cc:Subject:From;
	b=QJViYUcSdJsOdnVsav7dIPAFtGc5NwF1UCFB2uJK+UT5kKLugWxrzzYh/LNJqIzRA
	 HO2cqMNcPHPCdCD3SWLK73Bt1Fa9fKwXBPMETe1+QbDrRcJYSQZyJl7OUt48jC/+B3
	 oST5muc0JADU6DtP36fx5SXgXQJ0jxNXubdSaWmG2Hx4FaJTifBum151YPwB36OEoI
	 addWQwICUoeHrzYbD3kteOrmQkSwduRFQpLIj4DNQi/JgvL+8WkoauJRZT4sCfnT+1
	 QxB2hsqcZWcepM2x/rjObmegMOaiTn/EUASHiifC64bDwgXxak/ypnHAvc7uMWiUS9
	 SWSZn4Iatg7Mw==
From: Andrei Gaponenko <beamflash@quaintcat.com>
To: stable@vger.kernel.org
cc: regressions@lists.linux.dev, regressions@leemhuis.info
Subject: [REGRESSION] external monitor+Dell dock in 6.8
Message-ID: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello,

I noticed a regression with the mailine kernel pre-compiled by EPEL.
I have just tried linux-6.9-rc1.tar.gz from kernel.org, and it still
misbehaves.

The default setup: a laptop is connected to a dock, Dell WD22TB4, via
a USB-C cable.  The dock is connected to an external monitor via a
Display Port cable.  With a "good" kernel everything works.  With a
"broken" kernel, the external monitor is still correctly identified by
the system, and is shown as enabled in plasma systemsettings. The
system also behaves like the monitor is working, for example, one can
move the mouse pointer off the laptop screen.  However the external
monitor screen stays black, and it eventually goes to sleep.

Everything worked with EPEL mainline kernels up to and including
kernel-ml-6.7.9-1.el9.elrepo.x86_64

The breakage is observed in

kernel-ml-6.8.1-1.el9.elrepo.x86_64
kernel-ml-6.8.2-1.el9.elrepo.x86_64
linux-6.9-rc1.tar.gz from kernel.org (with olddefconfig)

Other tests: using an HDMI cable instead of the Display Port cable
between the monitor and the dock does not change things, black screen
with the newer kernels.

Using a small HDMI-to-USB-C adapter instead of the dock results in a
working system, even with the newer kernels.  So the breakage appears
to be specific to the Dell WD22TB4 dock.

Operating System: AlmaLinux 9.3 (Shamrock Pampas Cat)

uname -mi: x86_64 x86_64

Laptop: Dell Precision 5470/02RK6V

lsusb |grep dock
Bus 003 Device 007: ID 413c:b06e Dell Computer Corp. Dell dock
Bus 003 Device 008: ID 413c:b06f Dell Computer Corp. Dell dock
Bus 003 Device 006: ID 0bda:5413 Realtek Semiconductor Corp. Dell dock
Bus 003 Device 005: ID 0bda:5487 Realtek Semiconductor Corp. Dell dock
Bus 002 Device 004: ID 0bda:0413 Realtek Semiconductor Corp. Dell dock
Bus 002 Device 003: ID 0bda:0487 Realtek Semiconductor Corp. Dell dock

dmesg and kernel config are attached to 
https://bugzilla.kernel.org/show_bug.cgi?id=218663

#regzbot introduced: v6.7.9..v6.8.1

Andrei

