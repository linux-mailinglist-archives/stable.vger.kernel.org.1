Return-Path: <stable+bounces-4956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12358809238
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727FEB20D37
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4B5026A;
	Thu,  7 Dec 2023 20:23:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id E85B41717
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 12:23:23 -0800 (PST)
Received: (qmail 18390 invoked by uid 1000); 7 Dec 2023 15:23:23 -0500
Date: Thu, 7 Dec 2023 15:23:23 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, greg@kroah.com, kuba@kernel.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com,
  stable@vger.kernel.org
Subject: Re: [PATCH v6] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <d8c331dd-deb1-4f12-8e66-295bfac8b1d7@rowland.harvard.edu>
References: <0bd3204e-19f4-48de-b42e-a75640a1b1da@rowland.harvard.edu>
 <20231207175007.263907-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207175007.263907-1-jtornosm@redhat.com>

On Thu, Dec 07, 2023 at 06:50:07PM +0100, Jose Ignacio Tornos Martinez wrote:
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
> informing about the disconnecting status is enabled.
> 
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Follow the suggestions from Alan Stern and Oliver Neukum to check the
> result of the operations (-ENODEV) and not the internal state of the USB 
> layer (USB_STATE_NOTATTACHED).
> V2 -> V3
> - Add cc: stable line in the signed-off-by area.
> V3 -> V4
> - Follow the suggestions from Oliver Neukum to use only one flag when
> disconnecting and include barriers to avoid memory ordering issues.
> V4 -> V5
> - Fix my misundestanding and follow the suggestion from Alan Stern to 
> syncronize and not order the flag.
> V5 -> V6
> - Remove the unnecessary mutex. Thank you Alan for your teaching and
> patience!

Acked-by: Alan Stern <stern@rowland.harvard.edu>

