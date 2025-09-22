Return-Path: <stable+bounces-181406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9620DB9334A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F102A6AB0
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069F2F28F1;
	Mon, 22 Sep 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REGKL9+0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D982E2DC1;
	Mon, 22 Sep 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572418; cv=none; b=BE6URJY3m4dLnLKg8fN7rMQGlV4sJxstgoKzfjlmayozhE9B/kpIaOctl+1PYbeS+tKsrdFyat9dLb8xx5FrqlJSOklFy24IuSyCqZytWfj626Uu7OV78YdkNXkpWSBYqslEc1jpMSuXv1/egK+0yCMaa2onF2NkpHoHpjBZSbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572418; c=relaxed/simple;
	bh=SKHIwH86g+4PIdxQd+vsl7x9QVwZsHHhDsTe90dtEXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRrEjwIwzszEFcg0yMqLecYbypqKlL5Rnocz+O/H2bowhNxlM2sY5lUKApA8LdCfrb18QXLDJmzHCD87ZY5wLzd17+aOn80JpUMIlmJbwe8Tllq2VS3fu7o1/AElRVh9YSlyLtkPmcMMcXHo+W7IlVRiVGbSjzANDUBwJMlk5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REGKL9+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCADC4CEF0;
	Mon, 22 Sep 2025 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572415;
	bh=SKHIwH86g+4PIdxQd+vsl7x9QVwZsHHhDsTe90dtEXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REGKL9+0p0aAaSu9XbgwQD9Yjw9tk6kRwRyRwQOEon1DMRnpg2q/ZXmIJpXp5aUcN
	 tINWgKWq0xMRb6DUjaJRNqoGezQr0N7pda3g/m/xcs4rK2L3xJrbykE2/qFl0uyshX
	 LnDA1U2DYi7PIqUxBKO183APHCWGo1YG31Pa+pSU0pSrSgY84+HZVpT/bE4ZVQNeqW
	 lJJZUUm6nWy+TJ4wwtOXw3joLmeOsj5CkLTX46Z+ZclGwUw9OcfiT+Tsg62bJlbdu2
	 ytdJD0iMiG7fJKs8IG1jDum2RbOBxc+l9JMfac3vt5ExdoeM55ujfHdSXSmLFoYWe/
	 HWFQqohmPxnmw==
Date: Mon, 22 Sep 2025 15:20:14 -0500
From: Rob Herring <robh@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: saravanak@google.com, lizhi.hou@amd.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] of: unittest: Fix device reference count leak in
 of_unittest_pci_node_verify
Message-ID: <20250922202014.GA1254345-robh@kernel.org>
References: <20250920085135.21835-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920085135.21835-1-make24@iscas.ac.cn>

On Sat, Sep 20, 2025 at 04:51:35PM +0800, Ma Ke wrote:
> In of_unittest_pci_node_verify(), when the add parameter is false,
> device_find_any_child() obtains a reference to a child device. This
> function implicitly calls get_device() to increment the device's
> reference count before returning the pointer. However, the caller
> fails to properly release this reference by calling put_device(),
> leading to a device reference count leak.
> 
> As the comment of device_find_any_child states: "NOTE: you will need
> to drop the reference with put_device() after use".
> 
> Cc: stable@vger.kernel.org
> Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index e3503ec20f6c..d225e73781fe 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -4271,7 +4271,7 @@ static struct platform_driver unittest_pci_driver = {
>  static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
>  {
>  	struct device_node *pnp, *np = NULL;
> -	struct device *child_dev;
> +	struct device *child_dev = NULL;
>  	char *path = NULL;
>  	const __be32 *reg;
>  	int rc = 0;
> @@ -4306,6 +4306,8 @@ static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
>  	kfree(path);
>  	if (np)
>  		of_node_put(np);
> +	if (child_dev)
> +		put_device(child_dev);

This can go in the else clause. Then child_dev doesn't need to be 
initialized to NULL.

>  
>  	return rc;
>  }
> -- 
> 2.17.1
> 

