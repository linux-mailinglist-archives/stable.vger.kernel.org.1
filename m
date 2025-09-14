Return-Path: <stable+bounces-179590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5AB56C2A
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 22:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A66F3A7947
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A8221703;
	Sun, 14 Sep 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AlV/4yJO"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567038DDB
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881894; cv=none; b=f2BkBsyWSdt+xhfC0FwWIlzLQW+l57cwznGXLAfviF62gr+TE3CNniaHRmPjEFuxCkY4mqtJuexSWKR72aIrY3dToxjme2GqJ7oJFnQhy33zudtY/7E04bpgsUFfCDt57cCpqCBoze5CLOysT1PT2Y5VMAbaPxdaVJZjGxeETk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881894; c=relaxed/simple;
	bh=nyU6g/YyKcQCKJcz+Ftzb4Tj9xRJ3xTCyqnFXZF5yYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLw+ZeKfBYeO4TqBxxF5+5zp9t79KEYsZQU9YwOQxjR44NhfzmRVYWDZTyUy+gEBPbjwbbyDofRoZkyrmaZ3MsRaGQ/1bCnZyF7HjtbcbL7enwz09H4vWPj0klR71VG52o5eHxiEc5wRZ5PEF7vEuIiyk9trk9V/Gp9dXx1LuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AlV/4yJO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ADE9E1A0DC1;
	Sun, 14 Sep 2025 20:31:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 833AB6063F;
	Sun, 14 Sep 2025 20:31:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D350102F29EC;
	Sun, 14 Sep 2025 22:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757881887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1Qcyn4NnyhNNIw4hqoYXQ807lVMNnOD7WkvqhmoR/SY=;
	b=AlV/4yJOgyZZlnkhqFPM4cBMZodZy/bdV/FMfrVtE7Yj1/5PmgjBgLdLLXcslsk6g4BV9O
	mb2M87cDO/t1nqD0SSgNRn5ZCkLfekzvLD5n8oO7p/BAN5+p1Hi2B4tFY8JzFwO1J34H9j
	gFORJlGSIXDfhcIDK5S72QhZfyb03kVaJXbocA9Skolu9/JmJcagejFhpKfzIFKmlh58UT
	xlUnlrZ8xdkVjFyo6mmraU3QUVT0GafXysQAy4naezXofizKMHOKwTkBKs7lwgTQXoDWaO
	UP1V7uB5Q6j0rNdBvU8hOZwhjxxeaA0riXERcjBUUikOvgO0u1fwJfxzjphaHA==
Date: Sun, 14 Sep 2025 22:31:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>,
	stable@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2] i3c: Fix default I2C adapter timeout value
Message-ID: <175788160628.376561.12355074762741116990.b4-ty@bootlin.com>
References: <20250905100320.954536-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905100320.954536-1-jarkko.nikula@linux.intel.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 05 Sep 2025 13:03:20 +0300, Jarkko Nikula wrote:
> Commit 3a379bbcea0a ("i3c: Add core I3C infrastructure") set the default
> adapter timeout for I2C transfers as 1000 (ms). However that parameter
> is defined in jiffies not in milliseconds.
> 
> With mipi-i3c-hci driver this wasn't visible until commit c0a90eb55a69
> ("i3c: mipi-i3c-hci: use adapter timeout value for I2C transfers").
> 
> [...]

Applied, thanks!

[1/1] i3c: Fix default I2C adapter timeout value
      https://git.kernel.org/i3c/c/f6fecd2759be

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

