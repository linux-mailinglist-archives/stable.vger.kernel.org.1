Return-Path: <stable+bounces-184079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D97BCF844
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 18:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F83AAE80
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69C2749F2;
	Sat, 11 Oct 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ktu1mU4O"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56D1624C5
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760199695; cv=none; b=W65Lrl1KAF22rH9XAjzI848V/dlg8M1X6Py4+CgfbTn1WS0hqdDZkGVd0rP8PvJ8ikiBObo8+gV33ZPv7KJnwRPKfFsIKCrcFnuIXLASAfOb68Ez4+qto4/K5kBTlSLWJRrjcrdSvCewVdgjs0CwXcNfznQpK5W4nnX3exCS1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760199695; c=relaxed/simple;
	bh=LsPT3j03FjH0WuLyWIaQ9v8q5iHAbDNGXpbhOXoX7T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYHDfLmHrwzugHhpc/pbo8GOmUyT0zEYboNbiq/VcHOMYNbjT7cL6WOKp8KBVQtVvARwvooScyTu/FTsTPvCFrPF7SYugcEN2UpNcj1ErcaKEuzgcJNeXC0Mew0LK8YfSV5xWQ1mg47RBdtLzdeBEvG/8HgL4EsH5m7S4yNOmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ktu1mU4O; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ADC211A1183;
	Sat, 11 Oct 2025 16:21:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78A66606EC;
	Sat, 11 Oct 2025 16:21:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E03CC102F222F;
	Sat, 11 Oct 2025 18:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760199685; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XkjM0zby/ZXNMw5BOq1xgd5rRfLeQwnBiSFFspFSujs=;
	b=ktu1mU4OxDqK649s6HW/JMOYQjzaLv6UMHBjGPZPgikmplOX/f5Vt179x0fhdsNjYGF+RM
	ZTqACoug23PT0wbdb3gkq24EdD7fGsQ/KM+BmXWN3Ekp9Nu73/AZ96Fl95QhSdbmtScxbv
	4x44SGiv//wY5nBVEY+IwvzbO8U40s2a8geO2wWk3XlDzgvbaHpjQvn+YHa/VfSCb7bCpj
	UOVMCkqEqLAJYfHEPZkSvFJEDvZIMlTJVCdO3susBNxB2NB0wUaU4Kz4bMDB7iRJ9Adlny
	HBSmhx1X/0XaQBxolOnIli94nydqvVp7ghYjSDKCCMu9/Tl+ylI/PH6RHoCTLw==
Date: Sat, 11 Oct 2025 18:21:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] rtc: Fix problems with missing UIE irqs
Message-ID: <176019962507.48002.14768476957818198664.b4-ty@bootlin.com>
References: <20250516-rtc-uie-irq-fixes-v2-0-3de8e530a39e@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-rtc-uie-irq-fixes-v2-0-3de8e530a39e@geanix.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 16 May 2025 09:23:34 +0200, Esben Haabendal wrote:
> This fixes a couple of different problems, that can cause RTC (alarm)
> irqs to be missing when generating UIE interrupts.
> 
> The first commit fixes a long-standing problem, which has been
> documented in a comment since 2010. This fixes a race that could cause
> UIE irqs to stop being generated, which was easily reproduced by
> timing the use of RTC_UIE_ON ioctl with the seconds tick in the RTC.
> 
> [...]

Applied, thanks!

[1/5] rtc: interface: Fix long-standing race when setting alarm
      https://git.kernel.org/abelloni/c/795cda8338ea
[2/5] rtc: isl12022: Fix initial enable_irq/disable_irq balance
      https://git.kernel.org/abelloni/c/9ffe06b6ccd7
[3/5] rtc: cpcap: Fix initial enable_irq/disable_irq balance
      https://git.kernel.org/abelloni/c/e0762fd26ad6
[4/5] rtc: tps6586x: Fix initial enable_irq/disable_irq balance
      https://git.kernel.org/abelloni/c/1502fe0e97be
[5/5] rtc: interface: Ensure alarm irq is enabled when UIE is enabled
      https://git.kernel.org/abelloni/c/9db26d5855d0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

