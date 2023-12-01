Return-Path: <stable+bounces-3664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF9800F8D
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 17:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD04281C1B
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FD94C617;
	Fri,  1 Dec 2023 16:13:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 63DCF10D0
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 08:13:09 -0800 (PST)
Received: (qmail 291284 invoked by uid 1000); 1 Dec 2023 11:13:08 -0500
Date: Fri, 1 Dec 2023 11:13:08 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: greg@kroah.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com,
  stable@vger.kernel.org
Subject: Re: [PATCH v3] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <140e912f-8702-4e85-8d6c-ef0255e718f8@rowland.harvard.edu>
References: <2023120130-repair-tackle-698e@gregkh>
 <20231201132647.178979-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201132647.178979-1-jtornosm@redhat.com>

On Fri, Dec 01, 2023 at 02:26:47PM +0100, Jose Ignacio Tornos Martinez wrote:
> When the device is disconnected we get the following messages showing
> failed operations:
> Nov 28 20:22:11 localhost kernel: usb 2-3: USB disconnect, device number 2
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: unregister 'ax88179_178a' usb-0000:02:00.0-3, ASIX AX88179 USB 3.0 Gigabit Ethernet
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to read reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to write reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0001: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
> 
> The reason is that although the device is detached, normal stop and
> unbind operations are commanded from the driver. These operations are
> not necessary in this situation, so avoid these logs when the device is
> detached if the result of the operation is -ENODEV and if the new flag
> informing about the stopping or unbind operation is enabled.
> 
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

> @@ -242,7 +245,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>  		 value, index, data, size);
>  
> -	if (unlikely(ret < 0))
> +	if (unlikely(ret < 0 && !(ret == -ENODEV && ax179_data->stopping_unbinding)))

Would it be good enough just to check for ret != -ENODEV and not do the 
stopping_unbinding check at all?

Alan Stern

