Return-Path: <stable+bounces-152750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDFADC0FD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 06:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51C91659D1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 04:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7645B2367A9;
	Tue, 17 Jun 2025 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="doM/DNkC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003ED1C2324;
	Tue, 17 Jun 2025 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135462; cv=none; b=QvnV/ws/mVUACBvOo/nG1q/GKzJNg4Pedd7UG21o1UM6Fk3GMSsOttWS95IAYrqFUgSUNdwUv8Njb01ox7oQbD53LZJtiDD3ABtyJS/MnVlwnK3ewvVWk3ir8R37t5Gc+nNKfVsLFmWzrvYyEMkqiU5Ro/e4bne3eoH9CSPhTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135462; c=relaxed/simple;
	bh=5KBa+R1tdlOHE+ZXYldd1KYSQaKJNKKrgl09m283kjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6g+WPFQVj/ndRcdsw8595a8gvld3OgLips+c1deX4C29mZJBaStabb7Gnu/gZu24MUWIL+1gNnTmdT+C4+AhvVJ9fXGJDUg3y0epG/eYQRcl073/yBjCCiDuw1wGBO63zuPyMN84ZxfJ8kdGKhuWp3tPmlw//fP5Qj08vRWXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=doM/DNkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0967CC4CEE3;
	Tue, 17 Jun 2025 04:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750135461;
	bh=5KBa+R1tdlOHE+ZXYldd1KYSQaKJNKKrgl09m283kjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doM/DNkC2x/imx8GgAkEYJmA/AvK7I+fKikJREBdlD6ipSp0ZE4caJ7rprjJz134o
	 e6eZbNgiC4thh5nADhlY4lMgIePF/56xg/LTpR0YHYYxD6BQZ/ruqYKKKtF7WmOcMm
	 P9SBh+KvG9KYrz31m8TvSCTONMYf7x8k0I7lqSRI=
Date: Tue, 17 Jun 2025 06:44:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aidan Stewart <astewart@tektelic.com>
Cc: jirislaby@kernel.org, tony@atomide.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: restore of_node information in sysfs
Message-ID: <2025061746-raking-gusto-d1f3@gregkh>
References: <20250616162154.9057-1-astewart@tektelic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616162154.9057-1-astewart@tektelic.com>

On Mon, Jun 16, 2025 at 10:21:54AM -0600, Aidan Stewart wrote:
> Since in v6.8-rc1, the of_node symlink under tty devices is
> missing. This breaks any udev rules relying on this information.
> 
> Link the of_node information in the serial controller device with the
> parent defined in the device tree. This will also apply to the serial
> device which takes the serial controller as a parent device.
> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aidan Stewart <astewart@tektelic.com>
> ---
>  drivers/tty/serial/serial_base_bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 5d1677f1b651..0e4bf7a3e775 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -73,6 +73,10 @@ static int serial_base_device_init(struct uart_port *port,
>  	dev->bus = &serial_base_bus_type;
>  	dev->release = release;
>  
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		device_set_of_node_from_dev(dev, parent_dev);
> +	}

Did this pass checkpatch.pl?

And why is the if statement needed?

thanks,

greg k-h

