Return-Path: <stable+bounces-186171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B4BE42B2
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 17:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DC502CB8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A532860A;
	Thu, 16 Oct 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eE9ss8AO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFED19E81F
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627751; cv=none; b=mAsHO4ypAKEECsQRo0tfqsnXM/Q3gZp8WfTw/SttxhPGM9/gtPaaPPFgoHRIJajltYj4o6BN9wsByi8VdzdUYRnJZzxshdA1PPp+U1hpTtlkL3WXcajmmRVYWLBw5Pz9e+u3PcQd7Ik7Ym0NwYbzYGl5H1DUDYf8sDdRD9FyWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627751; c=relaxed/simple;
	bh=X2/kTpFBBQ6WyDqZ26VZzjBYgtkXd3RqWrkg9KLKoNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkvkOPzqPf24Ws9OsB9Aym5+zSCX+q30HR+kWjeLOdD5oD0db0xsnRxk20DHwpfxrLCPJf5v9YrR+kBIsekniABXgDOJEadWv0SG0tuYxrjkV4KApGyoVPKC7WAvsINMEsYBeM9S5x5xKCwsSKuAnZoc+S9jKnfiBscpD+t0rKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eE9ss8AO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269639879c3so8544535ad.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760627749; x=1761232549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPMIYF0ZUID6UAikMi26BjQpzXBsCb83bwf3UxpgfZ8=;
        b=eE9ss8AOGSnlF7WzHuI5dtR48oNmnE7ZB8o0+xvhLZw5IO7QIpDz5DVb1mQFbSDuI7
         qBx1KG898ouoyCxEe/vgpBrH4/tzDIWx18mwjybCNZA5OfUU+5MIHGILrbXIwvhzcsnc
         gE3IZmUt0DoHvh5NZxO7uWkUKtOAWLXLjCGts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627749; x=1761232549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPMIYF0ZUID6UAikMi26BjQpzXBsCb83bwf3UxpgfZ8=;
        b=lz06yjaycvpzQQ2ijrFApC5afXkdHSbjv1odGLyfW9aMcVcEgRzJX8Wg45RT7/jy6o
         ciL0wczb4tnMOwWl1Wskxn9zGshbQM6RRvyvCVnWHgnMNa3aDJapo4jnJK0myQgSfS/F
         Fzmy6BpBMid0UOisdbxnEZKGzq9oi+/XNDSsCiultmUF9XvXsM24t2dREWvgUJstF3ZO
         cpX1374AkW0B1tO0q81S9cxV0Lh4HBX7lz0qwwnM461tIlhwt/ZpHGBmhibbGefUhvFe
         Mx3MOE2cYpAQd4+4LkMPnx5ChY31n+KgC5NfI69BgDkX+trdORmyUieSZ3VOT3K5zvQJ
         tCwA==
X-Forwarded-Encrypted: i=1; AJvYcCURWrUiGwaSBV9dNXNS40dV8XnG/I9Osmoj2oQP2NGf7jm+L1sdxC0pNHUHkGHqnc0R0lKt5fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2sRD7Ze9x1+0eFqpm2DrjA9dr8mYJ3ds8yHI/J2qtvro5RfN
	jUL2CuqHj9UssCUweRLyNZ6v1vmaZeYGVwviJouYh7yo6PRQ0843ohRvINijJg8W4Q==
X-Gm-Gg: ASbGncvFaUeL2MYYA0Izw4/KkWXHcikxPFnJJdaqkWcX11fEorIvCHYMQ7Y2fgjP/HE
	gPF+vVkW9vsLBMgn2sY5iAmNd4LDUUfHNuwHLS33xGkSDVfCMvvRv+Ycsbj+C7yqbviQIm6v/+1
	Vs3xUHumOjDpZIZ9PfEtZFgT73IZNw9J/wjSpOjFCBmpeHbC1a1mBn1rhyHFybotxYpfJ4Gj1Tj
	RvX6eBx6BDuXz3yj4ZsZp2GXg5O/Mt//wcfNkzPswEj6uSN8berqPXcavf2YmqOCVE0zKiCH3mk
	852mr4QQ7TiAV9PYCqPEXSy9w5TH4PlLtR5xwtfeOPm6vm9MBoZ38JpVDBfI3mB6EhdPK4kFxC6
	0Hlsfw5cpO5l6Zhr+Hi2LHtgqPTs3k9srfJMM7/5S5RT+URkj+7WZWTSGUdrdZwgrrXRMsk9JQV
	zkKimFJDkizptkv6+Hgx5HyZb6J46Bi3cxUn2NlA==
X-Google-Smtp-Source: AGHT+IEbZNaQ5R0CCt0FlwbzXzQjgUjcbHc4AUYpefGsxhJ1DkB8BQyOzdv9RZLXV+F528mdL7gLWw==
X-Received: by 2002:a17:902:cf0d:b0:290:bd71:3a23 with SMTP id d9443c01a7336-290c9cb57f0mr3928135ad.16.1760627748611;
        Thu, 16 Oct 2025 08:15:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:9d53:f773:cd17:93c3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29099aa32c4sm33562595ad.79.2025.10.16.08.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:15:47 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:15:46 -0700
From: Brian Norris <briannorris@chromium.org>
To: gregkh@linuxfoundation.org
Cc: bhelgaas@google.com, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "PCI/sysfs: Ensure devices are powered for config reads"
 has been added to the 6.6-stable tree
Message-ID: <aPEMIreBYZ7yk3cm@google.com>
References: <2025101627-purifier-crewless-0d52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101627-purifier-crewless-0d52@gregkh>

Hi,

On Thu, Oct 16, 2025 at 03:09:27PM +0200, Greg Kroah-Hartman wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     PCI/sysfs: Ensure devices are powered for config reads
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      pci-sysfs-ensure-devices-are-powered-for-config-reads.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Adding to the stable tree is good IMO, but one note about exactly how to
do so below:

> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> rest of the similar sysfs attributes.
> 
> Notably, "max_link_speed" does not access config registers; it returns a
> cached value since d2bd39c0456b ("PCI: Store all PCIe Supported Link
> Speeds").

^^ This note about commit d2bd39c0456b was specifically to provide hints
about backporting. Without commit d2bd39c0456b, the solution is somewhat
incomplete. We should either backport commit d2bd39c0456b as well, or we
should adapt the change to add pci_config_pm_runtime_{get,put}() in
max_link_speed_show() too.

Commit d2bd39c0456b was already ported to 6.12.y, but seemingly no
further.

If adapting this change to pre-commit-d2bd39c0456b is better, I can
submit an updated version here.

Without commit d2bd39c0456b, it just means that the 'max_link_speed'
sysfs attribute is still susceptible to accessing a powered-down
device/link. We're in no worse state than we were without this patch.
And frankly, people are not likely to notice if they haven't already,
since I'd guess most systems don't suspend devices this aggressively.

Brian

> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20250924095711.v2.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pci/pci-sysfs.c |   20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -196,8 +196,14 @@ static ssize_t max_link_width_show(struc
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t ret;
>  
> -	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
> +	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
> +	pci_config_pm_runtime_get(pdev);
> +	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
> +	pci_config_pm_runtime_put(pdev);
> +
> +	return ret;
>  }
>  static DEVICE_ATTR_RO(max_link_width);
>  
> @@ -209,7 +215,10 @@ static ssize_t current_link_speed_show(s
>  	int err;
>  	enum pci_bus_speed speed;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> @@ -226,7 +235,10 @@ static ssize_t current_link_width_show(s
>  	u16 linkstat;
>  	int err;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> @@ -242,7 +254,10 @@ static ssize_t secondary_bus_number_show
>  	u8 sec_bus;
>  	int err;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> @@ -258,7 +273,10 @@ static ssize_t subordinate_bus_number_sh
>  	u8 sub_bus;
>  	int err;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> 
> 
> Patches currently in stable-queue which might be from briannorris@google.com are
> 
> queue-6.6/pci-sysfs-ensure-devices-are-powered-for-config-reads.patch

