Return-Path: <stable+bounces-78347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2798B7BD
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E851C2219C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B219CC01;
	Tue,  1 Oct 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJS/mkti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1019C565;
	Tue,  1 Oct 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773091; cv=none; b=CNvCwf1FJKa4R/tm0ZlTWsuyyfEFCZvk5E3vc5cLLeHolwMCi6NEEta2jcZbNwRPqbNEu/DFb5ZA4UKtW674ewa4gbgWG3U9abplsCjCsTfW5CSvNEaPQbFnUScdBrI3W/cEvPcMseQFpPp54vzQe2JJg5HKiLzjMjF4rjWlDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773091; c=relaxed/simple;
	bh=KHGu4Z0SeqGjTf1xDZyug+1WEM3RQXujUZCjcJPl+2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njuxOJMiMDOxSkIalH9WZsczbv1hPFf64fR0OhVGCxRw+R129k8gTBMNyf/ZbJIQMa/B7yyduvvNflBYDDYbgQy2ygISNxM3CW1bm6bJIFZVhTwX2eu2I8WHpSTuYHWMiugHnJusBEQ0+OTO9WS0inGVgA3mUcxX3jMqfo0aYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJS/mkti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E4CC4CEC6;
	Tue,  1 Oct 2024 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727773091;
	bh=KHGu4Z0SeqGjTf1xDZyug+1WEM3RQXujUZCjcJPl+2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJS/mktiqnmsGvmlTLsRlyCWHeweWuCbHDaxKaUCs8J6TFj6J1uiTu9TUcEK3qb/Z
	 AgBkoql0XVmFnhfoERg23gZy2wmSl33c70Y0JJkrq8f47uesTNLsYfOB61dbmAveyy
	 MaXTFrXaQT/jMDAt5rcwhaTb1Yk9tu9RcZbqEbhYedHJH2hF0Sd9czLprke+XOTEDC
	 kwLUfgZqeQcny+L7OrDXeZZchszf5fJElZPg1gsmQbNSAjfEwZkSqvq8iHfnYM/Nfh
	 f9SKwsJ14THolTjB7QZiWIH4Jtx7hrMwuSfH9VSjo5tQnBitE07TWwi4EbLtOZHDE0
	 y0aH5P2AhJ21Q==
Date: Tue, 1 Oct 2024 10:58:05 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: fix missing '%u' format literal in
 kthread_create_on_cpu()
Message-ID: <Zvu5nR50xNc+aAlE@lpieralisi>
References: <20240930154433.521715-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930154433.521715-1-aleksander.lobakin@intel.com>

On Mon, Sep 30, 2024 at 05:44:33PM +0200, Alexander Lobakin wrote:
> kthread_create_on_cpu() always requires format string to contain one
> '%u' at the end, as it automatically adds the CPU ID when passing it
> to kthread_create_on_node(). The former isn't marked as __printf()
> as it's not printf-like itself, which effectively hides this from
> the compiler.
> If you convert this function to printf-like, you'll see the following:
> 
> In file included from drivers/firmware/psci/psci_checker.c:15:
> drivers/firmware/psci/psci_checker.c: In function 'suspend_tests':
> drivers/firmware/psci/psci_checker.c:401:48: warning: too many arguments for format [-Wformat-extra-args]
>      401 |                                                "psci_suspend_test");
>          |                                                ^~~~~~~~~~~~~~~~~~~
> drivers/firmware/psci/psci_checker.c:400:32: warning: data argument not used by format string [-Wformat-extra-args]
>      400 |                                                (void *)(long)cpu, cpu,
>          |                                                                   ^
>      401 |                                                "psci_suspend_test");
>          |                                                ~~~~~~~~~~~~~~~~~~~
> 
> Add the missing format literal to fix this. Now the corresponding
> kthread will be named as "psci_suspend_test-<cpuid>", as it's meant by
> kthread_create_on_cpu().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408141012.KhvKaxoh-lkp@intel.com
> Closes: https://lore.kernel.org/oe-kbuild-all/202408141243.eQiEOQQe-lkp@intel.com
> Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
> Cc: stable@vger.kernel.org # 4.10+
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/firmware/psci/psci_checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> index 116eb465cdb4..ecc511c745ce 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -398,7 +398,7 @@ static int suspend_tests(void)
>  
>  		thread = kthread_create_on_cpu(suspend_test_thread,
>  					       (void *)(long)cpu, cpu,
> -					       "psci_suspend_test");
> +					       "psci_suspend_test-%u");
>  		if (IS_ERR(thread))
>  			pr_err("Failed to create kthread on CPU %d\n", cpu);
>  		else
> -- 
> 2.46.2
> 

