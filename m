Return-Path: <stable+bounces-86392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAC99FA81
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EAE1C23C4B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB041D63CE;
	Tue, 15 Oct 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cpFpC9AR"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F761B6D05
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028816; cv=none; b=gS1Hel3PnCoMI40l81+A2SPs7P++pnjA5qy2oJqrRNYFX54JA55q82yfOuL/r9EQ6F0nOAFeZ6e5C+xjrleGFFYhZNjP29WW4tpD7iteIyAP3GEI5ZsE8Vm9j23dCrRPrIkqCccsvmUwRA5rp0+dETQ+jw91sg1un8WP7QNi0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028816; c=relaxed/simple;
	bh=LMvLeRCJRaz89xRRPBDqNMWEHvGWzreZxA1B8GWDg7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/8yiHEPrPVObxk7DteuVMSsRXylw9IqiH/8H46iGNVNzynQ62afwxiYPWODJ2S4H+8thV4CRCR9cWi4DmjgkroqEh7Z6k463oIs4OyBLFo4Pzt9MGeQeKi3OJ5TbwLftJTJVY4wFHqChdEYnGRosSbaaTyBiLF1X5O/L9RxW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cpFpC9AR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RUPcqvj52wd/KjEg+PkVdtP+IR/bopp5LHO/Jp2z01M=; b=cpFpC9ARaM8RcbFr8RHpRDm14t
	tOVx/wx1A9POxxO+hU821j+9zVuC+0PBN9oxjAb3hoqsdNz+JJcHJvJo5bbqnRblcVey9kaiDjg7i
	aalEeuurdqp4+hg4qrAH1v1/dsTW3m/ZTvPyfiWueMlGYIibThGgwfgoWVLM3JNbzNF3DBasKoi8I
	B2wnM8BFagGHtpMi7AYVuCTZuYwrGxq3JmDikzTCJ09QJuy+nEJ29cZshbqbSVUc7n6ejTO+TTqER
	JH3AEknjgDIqXTdPUJAkcK40sPPnW7rF2lDmFIHzUJYvgkxCYXvJkaN3dyBLqyC1SOHIUOf97rCvI
	g8ckQE7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t0pNJ-0004Co-17;
	Tue, 15 Oct 2024 22:46:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t0pNG-0004cP-2r;
	Tue, 15 Oct 2024 22:46:38 +0100
Date: Tue, 15 Oct 2024 22:46:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: ioremap: Flush PGDs for VMALLOC shadow
Message-ID: <Zw7ivkeqKWzkQrN2@shell.armlinux.org.uk>
References: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org>
 <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 15, 2024 at 11:37:14PM +0200, Linus Walleij wrote:
> @@ -125,6 +126,12 @@ void __check_vmalloc_seq(struct mm_struct *mm)
>  		       pgd_offset_k(VMALLOC_START),
>  		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
>  					pgd_index(VMALLOC_START)));
> +		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> +			memcpy(pgd_offset(mm, (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START)),
> +			       pgd_offset_k((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START)),
> +			       sizeof(pgd_t) * (pgd_index((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END)) -
> +						pgd_index((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START))));

Maybe the following would be more readable:

static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
{
	return (unsigned long)kasan_mem_to_shadow((void *)addr);
}

static void memcpy_pgd(struct mm_struct *mm, unsigned long start,
		       unsigned long end)
{
	memcpy(pgd_offset(mm, start), pgd_offset_k(start),
	       sizeof(pgd_t) * (pgd_index(end) - pgd_index(start)));
}

		seq = ...;
		memcpy_pgd(mm, VMALLOC_START, VMALLOC_END);

		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
			unsigned long start =
				arm_kasan_mem_to_shadow(VMALLOC_START);
			unsigned long end =
				arm_kasan_mem_to_shadow(VMALLOC_END);

			memcpy_pgd(mm, start, end);
> +		}

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

