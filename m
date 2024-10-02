Return-Path: <stable+bounces-78647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B60F98D2BA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFA6284B76
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7561CF5F7;
	Wed,  2 Oct 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kUU5GykY"
X-Original-To: stable@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC091CF5E9;
	Wed,  2 Oct 2024 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870904; cv=none; b=lZHKKCkINcs9DxABAPkzxqg0ivrw0lJgQiVf9A25YgaFvgYQg0vYaWbe/D0FTqXVxSP+Zy1V3eHN7FPZaTjzelJecmRFW1/m3KkaK625XMI4qctrvklRqnANiVE+PvxKlbB+HGB9R1hg507d7OIGCHP8XfOLIh/ssMAjNVcXzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870904; c=relaxed/simple;
	bh=HF9gz9cxrtZHNXVfCdvFAGxweX1II3r/tm/pbiXkiv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTM47LiMp8Bjpc0SRaAiai2BAY1hSvNdSwTkZZ3DAUt4mCemDijoKmItUnXbYJbHz79SL21fFSqx352QwPZeuC4rg/fKANz3RHx//F4ZxQzR42gwIMxbA3/h3m+woQxJmdoKhYUlunWutMnLbGyifycjqo3P80Kq6fLZG4r4QCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=kUU5GykY; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 809AC89080;
	Wed,  2 Oct 2024 14:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727870898;
	bh=0JG7OQOTRkzyuh9OdleZmDit4I1RGWrnOFEmIqhEZTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kUU5GykYmQcwr2E3a5J0zltE7sIjHkrhD87rXvbbPQa2L7xq/N41iCba7u9JEbQsk
	 s2OUM61cGLH50QMqNDhMd19fSOW025fJ+1Jp6kMyi1XuZcmMiiilfscgXESAD/5c3p
	 2A78tQoLmSUWeETfvwSRsgh8UIDtyqMowfHhOM0qfmBX05fGPQwX51Kpj4k8MY1LpT
	 UjOYXP6enPx11V7vzHCPu4krxIVjSt7rTxaKg8i2ZG1BTdTMruNjRqVQf7w5DqOt+M
	 V1Ai1s2mPrw8ixO+i0yss2pwHQmQGNt9XvxH1TKaL1gFkcU4G5kMBiUDc6EN2xQUkB
	 h/wOCHagUQyUg==
Message-ID: <6b5c27ad-7f9b-4989-ada3-fbebb9537737@denx.de>
Date: Wed, 2 Oct 2024 13:56:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: Update mctrl old_status on RTSD interrupt
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-serial@vger.kernel.org,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Esben Haabendal <esben@geanix.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Rickard x Andersson <rickaran@axis.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20241002041125.155643-1-marex@denx.de>
 <hgxxa2qsyr6c5jbzofzaarqkty4uccdtrteun5qlwyc66yqnbq@vb7xyeskjhhy>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <hgxxa2qsyr6c5jbzofzaarqkty4uccdtrteun5qlwyc66yqnbq@vb7xyeskjhhy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/2/24 9:49 AM, Uwe Kleine-König wrote:
> On Wed, Oct 02, 2024 at 06:11:16AM +0200, Marek Vasut wrote:
>> When sending data using DMA at high baudrate (4 Mbdps in local test case) to
>> a device with small RX buffer which keeps asserting RTS after every received
>> byte, it is possible that the iMX UART driver would not recognize the falling
>> edge of RTS input signal and get stuck, unable to transmit any more data.
>>
>> This condition happens when the following sequence of events occur:
>> - imx_uart_mctrl_check() is called at some point and takes a snapshot of UART
>>    control signal status into sport->old_status using imx_uart_get_hwmctrl().
>>    The RTSS/TIOCM_CTS bit is of interest here (*).
>> - DMA transfer occurs, the remote device asserts RTS signal after each byte.
>>    The i.MX UART driver recognizes each such RTS signal change, raises an
>>    interrupt with USR1 register RTSD bit set, which leads to invocation of
>>    __imx_uart_rtsint(), which calls uart_handle_cts_change().
>>    - If the RTS signal is deasserted, uart_handle_cts_change() clears
>>      port->hw_stopped and unblocks the port for further data transfers.
>>    - If the RTS is asserted, uart_handle_cts_change() sets port->hw_stopped
>>      and blocks the port for further data transfers. This may occur as the
>>      last interrupt of a transfer, which means port->hw_stopped remains set
>>      and the port remains blocked (**).
>> - Any further data transfer attempts will trigger imx_uart_mctrl_check(),
>>    which will read current status of UART control signals by calling
>>    imx_uart_get_hwmctrl() (***) and compare it with sport->old_status .
>>    - If current status differs from sport->old_status for RTS signal,
>>      uart_handle_cts_change() is called and possibly unblocks the port
>>      by clearing port->hw_stopped .
>>    - If current status does not differ from sport->old_status for RTS
>>      signal, no action occurs. This may occur in case prior snapshot (*)
>>      was taken before any transfer so the RTS is deasserted, current
>>      snapshot (***) was taken after a transfer and therefore RTS is
>>      deasserted again, which means current status and sport->old_status
>>      are identical. In case (**) triggered when RTS got asserted, and
>>      made port->hw_stopped set, the port->hw_stopped will remain set
>>      because no change on RTS line is recognized by this driver and
>>      uart_handle_cts_change() is not called from here to unblock the
>>      port->hw_stopped.
>>
>> Update sport->old_status in __imx_uart_rtsint() accordingly to make
>> imx_uart_mctrl_check() detect such RTS change. Note that TIOCM_CAR
>> and TIOCM_RI bits in sport->old_status do not suffer from this problem.
> 
> Why is that? Just because these don't stop transmission?

If imx_uart_mctrl_check() does not detect the RTS asserted->deasserted 
transition, it will never call uart_handle_cts_change(), which will 
never clear port->hw_stopped and the port will remain stopped 
indefinitely, and never be able to transmit more data AFTER this event 
happens (port close/open will reset the flag too, but that is undesired 
workaround).

>> Fixes: ceca629e0b48 ("[ARM] 2971/1: i.MX uart handle rts irq")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>>   drivers/tty/serial/imx.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 67d4a72eda770..3ad7f42790ef9 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -762,6 +762,10 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *dev_id)
>>   
>>   	imx_uart_writel(sport, USR1_RTSD, USR1);
>>   	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
>> +	if (usr1 & USR1_RTSS)
>> +		sport->old_status |= TIOCM_CTS;
>> +	else
>> +		sport->old_status &= ~TIOCM_CTS;
>>   	uart_handle_cts_change(&sport->port, usr1);
>>   	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
> 
> I didn't grab the whole picture, but I think this deserves a code
> comment.

Added in V2.

> Would it make sense to replace the current code in __imx_uart_rtsint by
> a call to imx_uart_mctrl_check()?
No, the __imx_uart_rtsint() only handles RTS state change interrupt and 
no other interrupts, so calling imx_uart_mctrl_check() would handle 
other unrelated signals for no reason and make the interrupt handler 
slower. I don't think this is an improvement.

