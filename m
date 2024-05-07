Return-Path: <stable+bounces-43195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293928BE8A9
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0071F287CB
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9A16D4CF;
	Tue,  7 May 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="i2EWCR3b"
X-Original-To: stable@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B316C45D;
	Tue,  7 May 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098766; cv=none; b=eyGEWAvnj5Q6Hqt4lDRvjpMJyaG8ejtU8sYRopPeTCsEeR6Q9TdWGUzt+w4R/XxYdn1nfla1so3WhD5luP0VZGcPaaravm6AsVk8iBBYQY5XBIDHywWHKAwntahyGcJt2k2+ioQ/c4ErSvMjB4jo/e5LpNBFWs68IlsJpZgZPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098766; c=relaxed/simple;
	bh=wPfBBBqz4mWAHQz6NwLA3VhGyV0ey36YDnag2Ti6L8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nyb/ItFnLXZrBCqx8KU+JDnIY8ZOLIysI21pyJiqLawIhwQvDWWDpfR0Gnu/L9t53VLLPpAhpofGOPfiUZ0drCx+zyWG+e1jEetZgNcT3ovC9H43pUQBq52g4mIZmMVyVM2gpq5tlItW8RrZRrRz4TFuFtEPLx0xepRB1aO/DUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=i2EWCR3b; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1715098754; bh=wPfBBBqz4mWAHQz6NwLA3VhGyV0ey36YDnag2Ti6L8U=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=i2EWCR3bNy9bWRT9zukZaUGi24OmEe3DfnT3nOg9HZarTot8adruRC2klo9I3yCaY
	 v1qz3xF8PmF1mfBwz8SkKd2yJE3D6wzt7nXo6y4xfDzk6H+K0xujtzOuo+u2h+sKBm
	 Vg1wX2wooUyLByC0p64y4rpA+lafXjZszPkfphdk=
Date: Tue, 7 May 2024 18:19:13 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, badhri@google.com, rdbabiera@google.com, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] usb: typec: tcpm: unregister existing source caps
 before re-registration
Message-ID: <y4lla7vqsrl75qhesmyexq7yvcu6hl6kryh3ctwq5ci3r4mlpw@rsnhfkmlmtt7>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Amit Sunil Dhamne <amitsd@google.com>, linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, badhri@google.com, rdbabiera@google.com, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240424223227.1807844-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424223227.1807844-1-amitsd@google.com>

On Wed, Apr 24, 2024 at 03:32:16PM GMT, Amit Sunil Dhamne wrote:
> Check and unregister existing source caps in tcpm_register_source_caps
> function before registering new ones. This change fixes following
> warning when port partner resends source caps after negotiating PD contract
> for the purpose of re-negotiation.
> 
> [  343.135030][  T151] sysfs: cannot create duplicate filename '/devices/virtual/usb_power_delivery/pd1/source-capabilities'
> [  343.135071][  T151] Call trace:
> [  343.135076][  T151]  dump_backtrace+0xe8/0x108
> [  343.135099][  T151]  show_stack+0x18/0x24
> [  343.135106][  T151]  dump_stack_lvl+0x50/0x6c
> [  343.135119][  T151]  dump_stack+0x18/0x24
> [  343.135126][  T151]  sysfs_create_dir_ns+0xe0/0x140
> [  343.135137][  T151]  kobject_add_internal+0x228/0x424
> [  343.135146][  T151]  kobject_add+0x94/0x10c
> [  343.135152][  T151]  device_add+0x1b0/0x4c0
> [  343.135187][  T151]  device_register+0x20/0x34
> [  343.135195][  T151]  usb_power_delivery_register_capabilities+0x90/0x20c
> [  343.135209][  T151]  tcpm_pd_rx_handler+0x9f0/0x15b8
> [  343.135216][  T151]  kthread_worker_fn+0x11c/0x260
> [  343.135227][  T151]  kthread+0x114/0x1bc
> [  343.135235][  T151]  ret_from_fork+0x10/0x20
> [  343.135265][  T151] kobject: kobject_add_internal failed for source-capabilities with -EEXIST, don't try to register things with the same name in the same directory.
> 
> Fixes: 8203d26905ee ("usb: typec: tcpm: Register USB Power Delivery Capabilities")
> Cc: linux-usb@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ab6ed6111ed0..d8eb89f4f0c3 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2996,7 +2996,7 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  {
>  	struct usb_power_delivery_desc desc = { port->negotiated_rev };
>  	struct usb_power_delivery_capabilities_desc caps = { };
> -	struct usb_power_delivery_capabilities *cap;
> +	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
>  
>  	if (!port->partner_pd)
>  		port->partner_pd = usb_power_delivery_register(NULL, &desc);
> @@ -3006,6 +3006,9 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
>  	caps.role = TYPEC_SOURCE;
>  
> +	if (cap)
> +		usb_power_delivery_unregister_capabilities(cap);

This certainly looks like it's asking for use after free on port->partner_source_caps
later on, since you're not clearing the pointer for the data that you just freed.

> +
>  	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
>  	if (IS_ERR(cap))
>  		return PTR_ERR(cap);

This can easily fail if caps contain invalid PDOs, resulting in keeping pointer
to freed memory in port->partner_source_caps.

Kind regards,
	o.

> base-commit: 0d31ea587709216d88183fe4ca0c8aba5e0205b8
> -- 
> 2.44.0.769.g3c40516874-goog
> 

