Return-Path: <stable+bounces-54875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59569136A1
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 00:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E791C224AB
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0686F2F0;
	Sat, 22 Jun 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TsUUcctj"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290C7E0F6
	for <stable@vger.kernel.org>; Sat, 22 Jun 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095644; cv=none; b=aK8jHZa1fUJRBlPb7TpzXe4iqWuntY0rZpnsu3CouF4qKX06qrIZMwfOfA8oknJJ2RG/xR/sUPl7dCqwf/NR9Kjy5IwkxAUWtij7tD01H+RBiv5Lr+9zafZlvKqEqoa987ZS6B530eQSINCDuoKn+jarq0Gi3gmgRAn+SrYmaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095644; c=relaxed/simple;
	bh=WHC33O4dHcxo+ERMAsfGxr5LrcnFvIRSUBKjCtBcaJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8r/R9sYpEPOweqHS2VE2yWNrtIQ0PbFaIovwsjz1v7sX86Gv2/GQKRAx2C/y+5xqfYWPDn2zADmsyyk2BMYSHO0vwaSf7RGGwBRPHlAltDfJGT9KyEqLzOjnKSBBRlTuuZvIjWHKxhSPhnR9pO+9dPXC5sdWI9AcM+lJ/GUjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TsUUcctj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 675F31BF203;
	Sat, 22 Jun 2024 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719095641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgFWJS2IRsrEQYnSwEJOI9RPmtNPLLE8Zp84vCIF7Qc=;
	b=TsUUcctjjWpLSlMbJbrCHr7KBW6ag6FR/+akiXJRz0QI7figAFddKfDyPfHjnRDWE5yvy0
	PnE26Bc3wrKjNqwJkm9VhwNjEkDpVFfkFT7LCg5iK8jodRzsyE6fJRGXyuapiCjQikUWjs
	L7S7DoNCB4XoEyzhMdy1T1PqlKO9IuUO3oM7/JopS+h8Q837hXxg032bjIOgHlhQBDeL5W
	vy/P/xdaybtfczrshFFmL/Rn/cwf6V9BwONZIqo9fcohVFxadcEeSsL0zmO/KW2qPOoA2c
	brco/FT0LME5HVqYyq0ZI05eDrXoY8Zl0x8nzMHb+u7UvMjFqzRRhqlqi54AsA==
Date: Sun, 23 Jun 2024 00:34:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI
 versions < 1.1
Message-ID: <171909557751.2164405.18080145631407814648.b4-ty@bootlin.com>
References: <20240614140208.1100914-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614140208.1100914-1-jarkko.nikula@linux.intel.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 14 Jun 2024 17:02:08 +0300, Jarkko Nikula wrote:
> I was wrong about the TABLE_SIZE field description in the
> commit 0676bfebf576 ("i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes").
> 
> For the MIPI I3C HCI versions 1.0 and earlier the TABLE_SIZE field in
> the registers DAT_SECTION_OFFSET and DCT_SECTION_OFFSET is indeed defined
> in DWORDs and not number of entries like it is defined in later versions.
> 
> [...]

Applied, thanks!

[1/1] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1
      https://git.kernel.org/abelloni/c/17bebfeab08b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

