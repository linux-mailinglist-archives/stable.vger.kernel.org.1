Return-Path: <stable+bounces-100793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28E19ED656
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D139B188BDDC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6622689C;
	Wed, 11 Dec 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtVdi7YN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WthjLd8C"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444222210F2;
	Wed, 11 Dec 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944094; cv=none; b=jt3YItAYJprvrRfK/riwgQ3uhhGArqk2SCxq7/G/pAQdXAnq1Pz6IwBtrFJZjZELrsvXgrcQEWElymbrNmi+7rQoXdhcJNKlM0Ug0UDDbf47MX32HRSX0PMK1kQvfwpFw5Ijfxc4e6A0girHKZRJ7v+vW+nfW438kF3UIuO9V10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944094; c=relaxed/simple;
	bh=M+DupdA6IRRWF9CpDQb87UKJ61ynW6uM2yqiBrtuWeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HndCUx+fgMpDEbuaJBV7azlB43CAlk/IwPXzdvMjGU+O3Sq+QfAGd0gxwyCb53fYcuJsHxP6sAPEkjYX43kTKc3yLyI8nyDBEQ9df2Aehyv4ES2iFlXEVrOOS1i73K4ucZ/qvx6fL5amNAOg0K5LjC1u+iNzQBtCfhPec9ee4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AtVdi7YN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WthjLd8C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733944091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rWngjwQetvTl0XVmO9YzEtcBKoN9SMORBj+IGk0JUJA=;
	b=AtVdi7YN6cQWTQWtJavxctpC10b5/YK5snQhd4sDL5DdpL3YJKF12I+hYP+JdvSHawdHGs
	19EQzRfAzo7gyhy8FGzOQPGG3Cbw+4d19r7UbV8nJGY6hThpNh9EOaR8oYACjrGURGrBvy
	wKlCAwEDGR52vzhgLcYA+bXC6OCRkFH09iGEEGjN6r+znCWxCwjoYSrMhjtYq3fYcQdp9t
	tZ67Y55sNg6NRKCh7raHxOZyRb4M8sNOmW7fJZkeBd5RJbmrWrl8tcGifK/hIgyEBL0iXr
	alKsAx8thlbwyEE4W2Iqpklb9A7O6diBl5jflfyyZFYN+CAKOIA7/eTVfTEi4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733944091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rWngjwQetvTl0XVmO9YzEtcBKoN9SMORBj+IGk0JUJA=;
	b=WthjLd8CUjhMhsnj475sWa+xonQEYiWwM10tVPzGNqhJMYlnfc2VPxsDdSQdbqc4M0XWo2
	jX4Hxj9tU4JRcXBg==
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: Patch "platform-msi: Prepare for real per device domains" has
 been added to the 6.6-stable tree
In-Reply-To: <20241211183908.3808070-1-sashal@kernel.org>
References: <20241211183908.3808070-1-sashal@kernel.org>
Date: Wed, 11 Dec 2024 20:08:11 +0100
Message-ID: <875xnqavhg.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 11 2024 at 13:39, Sasha Levin wrote:
>     platform-msi: Prepare for real per device domains
>     
>     [ Upstream commit c88f9110bfbca5975a8dee4c9792ba12684c7bca ]
>     
>     Provide functions to create and remove per device MSI domains which replace
>     the platform-MSI domains. The new model is that each of the devices which
>     utilize platform-MSI gets now its private MSI domain which is "customized"
>     in size and with a device specific function to write the MSI message into
>     the device.
>     
>     This is the same functionality as platform-MSI but it avoids all the down
>     sides of platform MSI, i.e. the extra ID book keeping, the special data
>     structure in the msi descriptor. Further the domains are only created when
>     the devices are really in use, so the burden is on the usage and not on the
>     infrastructure.
>     
>     Fill in the domain template and provide two functions to init/allocate and
>     remove a per device MSI domain.
>     
>     Until all users and parent domain providers are converted, the init/alloc
>     function invokes the original platform-MSI code when the irqdomain which is
>     associated to the device does not provide MSI parent functionality yet.
>     
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Link: https://lore.kernel.org/r/20240127161753.114685-6-apatel@ventanamicro.com
>     Stable-dep-of: 64506b3d23a3 ("scsi: ufs: qcom: Only free platform MSIs when ESI is enabled")

See my other reply. Please don't backport the world if it's not really
required. I'll send a backport of 64506b3d23a3 in a minute.

Thanks,

        tglx


