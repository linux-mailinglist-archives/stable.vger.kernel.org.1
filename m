Return-Path: <stable+bounces-118623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A9A3FC51
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF3F16AD14
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD612215F41;
	Fri, 21 Feb 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="FpQcBHdI"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC8214A96;
	Fri, 21 Feb 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156829; cv=none; b=jFPdyMIXzbeZWCbRPL77fAdJfUlvDBVGmace/VerhxnxxdPIw3yILpNio5dUc7JFcQXcKFtdEWdr/LvRw/o8zln9lcWDPDi9hCs4cnKi9YQbiINKwkHftNsGCx4yFAOFrXUZQ7Zwcf1ylAVL78e0uz57JcrwR6ihvyl5F8TY2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156829; c=relaxed/simple;
	bh=MMcdtRGcqIRiBtTCiGiKF93/eqGt1efuXo61hW6flX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFm4POBVnbLw4dSt6GsdxBDkmR+tH+1LHi98e5porDsxybPUkAqoXaCTMxPP94cb5Zs/pM5obbaX8qIOl1LT7TMaYzOTJER9weLhIn8TqQSO2qBkWLzN50o4JzAdlPcUl/SM1QLMbJqj8rKwHkMprbzGFaSmphiWxEeV9ErO7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=FpQcBHdI; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 505F9260EB;
	Fri, 21 Feb 2025 16:53:40 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id BA6C83E8A8;
	Fri, 21 Feb 2025 16:53:31 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id E5D664023E;
	Fri, 21 Feb 2025 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740156810; bh=MMcdtRGcqIRiBtTCiGiKF93/eqGt1efuXo61hW6flX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FpQcBHdIe+I0ux0K9OxlNy68XpdnhWwEw6S4Mka8vK6EYsh87M87kE7sBTmWBqUg6
	 0hZR9rE/IBLo1mIzpi/fpM72Ay7ppi9f5j99By2ZdcDSo8T2YYKpo8K80grBy3JvD6
	 yUmw7EhrhTMPdcMheOLDcfVAsYDdiR9K/4QzAxco=
Received: from [172.29.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 8C8B4407D9;
	Fri, 21 Feb 2025 16:53:26 +0000 (UTC)
Message-ID: <8a39c1ef-b39b-4c28-b026-26bbb4dbaf7f@aosc.io>
Date: Sat, 22 Feb 2025 00:53:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add battery quirk for
 ThinkPad X131e
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Fan Yang <804284660@qq.com>,
 Xi Ruoyao <xry111@xry111.site>, Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 stable@vger.kernel.org
References: <20250221164825.77315-1-jeffbai@aosc.io>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20250221164825.77315-1-jeffbai@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: E5D664023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,804284660.qq.com:server fail,xry111.xry111.site:server fail,stable.vger.kernel.org:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[aosc.io,qq.com,xry111.site,hmh.eng.br,redhat.com,linux.intel.com,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	TO_DN_SOME(0.00)[]

Hi all,

在 2025/2/22 00:48, Mingcong Bai 写道:
> Based on the dmesg messages from the original reporter:
> 
> [    4.964073] ACPI: \_SB_.PCI0.LPCB.EC__.HKEY: BCTG evaluated but flagged as error
> [    4.964083] thinkpad_acpi: Error probing battery 2
> 
> Lenovo ThinkPad X131e also needs this battery quirk.
> 
> Reported-by: Fan Yang <804284660@qq.com>
> Tested-by: Fan Yang <804284660@qq.com>
> Co-developed-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>   drivers/platform/x86/thinkpad_acpi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 1fcb0f99695a7..64765c6939a50 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9960,6 +9960,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
>   	 * Individual addressing is broken on models that expose the
>   	 * primary battery as BAT1.
>   	 */
> +	TPACPI_Q_LNV('G', '8', true),       /* ThinkPad X131e */
>   	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
>   	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
>   	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */

I forgot to include a Cc to stable. This issue dates back to as far as 
5.19 (the oldest version available in our distro repository).

Cc: stable@vger.kernel.org

Best Regards,
Mingcong Bai

