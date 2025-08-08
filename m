Return-Path: <stable+bounces-166844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E861B1E983
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52857585BD7
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E678F37;
	Fri,  8 Aug 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DcwFJFQg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHJyut+X"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E182E62C;
	Fri,  8 Aug 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661022; cv=none; b=jNvDPJ/RRHzvEoYvNZInZW77PzFpoUjAdrimN0eRGzCy6bSM6fAauZiDKskNgR6+6cVnY8xjSwJjtMuI0E94qqpW6H35rh1ASl32l068OJwVZMgD+DzWgmQE+OilB0sU32jmVix484rx3lATJTwHoeSwwXa/62uxdr+vZGYdlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661022; c=relaxed/simple;
	bh=gfk1YcUJLZRk1tM/elLznY8hRMaF9ZOT/cGJ68rVJ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1ExMRwjX95/ageA+ahUrwBSPDHZtRDHarJB3ehRHZc78QrMXEZ7djPpVGBX8pp1B/T00WW/I75kEKknjMbySxIIq1CvLN+oPCZZNBZVMSGg3Iy4Bt1RJiPU7tvKcQENcN0q79ORHVm3K00IOxWqqpC7FkeEmjhgNKHCOqMmPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DcwFJFQg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHJyut+X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 15:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754661015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfk1YcUJLZRk1tM/elLznY8hRMaF9ZOT/cGJ68rVJ+8=;
	b=DcwFJFQgJF/DZyg3N82IkHk0LxFYBHub4MpmyawL2xxF3nSwHxcYjKZ4ZXQl4XSb2mYtHc
	VyRyJEovkisBBneQjznjlMImd4ugYBNkmUWNyYA+XHFIk1C/ofb/ephQWwZY3zedrCrINd
	+A2KBoHt/Vri2kEEuqnc0PkQgZmasaCbjHQot8E7/DSXeJxsj7RQADSXt1rG/6Xg/Cv7kD
	Ql/MLnNn1/qT/OVnYaOgTyi588HoufrCn2MCPSG9vl5qZ0pvFsuPRmV3nvP01m6hS/LHIy
	1nvAZD81C0yFE5k+9gHLv6wZ7uTB8WqVAF98L5XFtv9RvHR8DETKH1JLTZYNqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754661015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfk1YcUJLZRk1tM/elLznY8hRMaF9ZOT/cGJ68rVJ+8=;
	b=AHJyut+XFzRFI5KROG1DW/xcKt6rFzTonQEj9v0csfL619G9r2SrBxMU29WIFFTi2Dnman
	6bri30KQpRFJefDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	m.grzeschik@pengutronix.de, balbi@ti.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	muhammed.ali@samsung.com, thiagu.r@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Message-ID: <20250808135013.UMcO2oA1@linutronix.de>
References: <CGME20250808125457epcas5p111426353bf9a15dacfa217a9abff6374@epcas5p1.samsung.com>
 <20250808125315.1607-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250808125315.1607-1-selvarasu.g@samsung.com>

On 2025-08-08 18:23:05 [+0530], Selvarasu Ganesan wrote:
> This commit addresses a rarely observed endpoint command timeout
=E2=80=A6
> Cc: stable@vger.kernel.org
> Co-developed-by: Akash M <akash.m5@samsung.com>
> Signed-off-by: Akash M <akash.m5@samsung.com>
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

