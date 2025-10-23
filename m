Return-Path: <stable+bounces-189078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7EBFFF6D
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE43A2070
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B730171C;
	Thu, 23 Oct 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n1GsVp6i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF8301484
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208696; cv=none; b=hbP0N8MKcPyX/n67BAX1KZcRPpMpWsnRF45qxt8o/+u6kVxeVnypNV1zKGFsfGrXgsfCwxW46gHpm6D1RgBnEQL83G6BZgcZEhd82td85+8klLJ7bO+cgBKu/zWmF2NnBeELq8xLeX3l643DGUzRG+JyOO0axIWnX9gY3wGrqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208696; c=relaxed/simple;
	bh=aFCgRoWn6hr4O8owO6CsgHqO3QDo17jbxuWEH1cK73c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqdEEmr8nPdrqro5Rk0U3twgYLZOzS4aV2uPNgH0HW3LBp24IwuzqwKZlcCEBKT7RPMoneYiRhsYp4cphjlzgtFm+3J1Gkg/4ADqMKWGlgwU9MPbsRyim38rjyckS+rDy7G9XXrnqzjLdpGrfAjwn8+3TiDXcuy1f4dNjVMB0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n1GsVp6i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d5b756284so31040766b.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761208691; x=1761813491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUt/inqRNvCStH0GgE4cyP1lzFZ0UUVf4yEz/ZUZ2wM=;
        b=n1GsVp6iD2vwk03pMqjHdxS2dgNFtZWO70yeXIRynU2d29NDbHkyKkLvPXGo7R9TfG
         sVUjSRr22oEqvgaXACweSspqcOt37a1NSuUw67PAAQc9apZuCcbUn6CsB+FPvkVTM0VS
         0cZ64oTc0iuqsxaiHPgkf4XyD24TA9ZpMQt4G+8c4kHrmqlto3adbKaAyHC+irkHZWXK
         Hy0C05CklCaOg4/Ki05L08RTojP9Wq+EUoXCaNfaq0OiE9bp7zwCxiqf//w42Ey+IN0G
         SpyBbQTIYs9DnRsForEEiK5ql8EyLoT7ZuPVWtfZXJkgZIjJeCmyV4LZTdc/rX0Sx7jW
         hriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208691; x=1761813491;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUt/inqRNvCStH0GgE4cyP1lzFZ0UUVf4yEz/ZUZ2wM=;
        b=Y6wmApezsD3v1/EVX4RwoIrcc6NkTQ7FuBDzXVJC3NLo85pfHVah6N+m0Kx9zrM8PH
         7MlfsMpbyRTSxlWjMxmyDBFPmG+wfhyNMoRC6fCpx3j4H8veVl8WuuQ9tLmmtk/yKh/4
         t5PmLzyicU5qMmfQry2WdRGXsPZGfe8jrH/nKACnU2VOw2n8V3nE/bCHg0eYhEMAsoQU
         1S0gBDSCA5HjuIz7hYvoEq9bl2DbNrfUyjPZkWnE6aCl8PwaMiiIDAtZR/UvZdmlIWaQ
         aAzzm57oTxzwHvx+HX1PQUvl09yes8rwhqXaS2HreqwOCtVvmwZU0q2xm45nekc5j0Ci
         E4VA==
X-Forwarded-Encrypted: i=1; AJvYcCVbXNy6ZT3x5egRR4btD578P+GGDK3UCBgDcEFbs9ShC1B0r6tdVMsSQZtJLSd2TkSOY7BU/F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6tuEwk1tyHMU2QZttw4dNsx7AFrRs8xaiUbPS5sdDKvVcvmY
	c9nL1+Dycil+4yp1gksTLjVcvyMhvJsiQsoSVZ8a4PY5ljFVqjnmCoHcvoEGEuJ3aUw=
X-Gm-Gg: ASbGncuVYRDlMjs9XNeaPGN5utDXBT/UNMIN0FNHINLepqbbNHZS9tbgAYEJHVf+50L
	MhMwp78LQDsbgncAaBwDsvftTKqz8AFlA3CVhcVHzCgZ5Ff2rqUZZyqKwezeiwyp0osEo80pNxf
	Fgnn9GNT2tco3O6UQsqRNJnlF7vwl9KMh5h9qJDnFgENZumlgu9cb6SFD9kvqmyhf/w+8TD3RJZ
	FzcHdTX18iQX2k+MBuMEq47p57b133u4HWfVgFhwPK1D6NwQz1HUnGOgctrOTrpwxKME83MN/eu
	28iHAYSwYkiRbqHu9E37rXlBu4p5vgFwndXyU9ykwFIxVipaQfwCdQniIdI+N8q6ckO0/xqFlV+
	NIkc6ZqFFffmoHP66Ilv78H0Y1sfH5waStQqAAL4bu8/MkxGsJjQkfxMBns4LwGNf9SkRQsVF40
	VqCStnivAx
X-Google-Smtp-Source: AGHT+IEYctlT509BIkD5r6RIEyIRhDk3R9yLwlPD0q+eO8PeE5EUYZN1xaUEvKp653FWiTfMauLsCA==
X-Received: by 2002:a17:907:7ba7:b0:b3f:f207:b748 with SMTP id a640c23a62f3a-b6471e3c961mr3124511166b.10.1761208690969;
        Thu, 23 Oct 2025 01:38:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511d41a4sm157071566b.9.2025.10.23.01.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:38:10 -0700 (PDT)
Message-ID: <4de8ed54-e850-4685-b486-623a45145ab1@tuxon.dev>
Date: Thu, 23 Oct 2025 11:38:08 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: renesas_usbhs: Fix synchronous external abort on
 unbind
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com,
 geert+renesas@glider.be, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20251022124350.4115552-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 10/23/25 11:07, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, 22 Oct 2025 at 15:06, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> A synchronous external abort occurs on the Renesas RZ/G3S SoC if unbind is
>> executed after the configuration sequence described above:
> 
> [...]
> 
>> The issue occurs because usbhs_sys_function_pullup(), which accesses the IP
>> registers, is executed after the USBHS clocks have been disabled. The
>> problem is reproducible on the Renesas RZ/G3S SoC starting with the
>> addition of module stop in the clock enable/disable APIs. With module stop
>> functionality enabled, a bus error is expected if a master accesses a
>> module whose clock has been stopped and module stop activated.
>>
>> Disable the IP clocks at the end of remove.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/usb/renesas_usbhs/common.c
>> +++ b/drivers/usb/renesas_usbhs/common.c
>> @@ -813,18 +813,18 @@ static void usbhs_remove(struct platform_device *pdev)
>>
>>         flush_delayed_work(&priv->notify_hotplug_work);
>>
>> -       /* power off */
>> -       if (!usbhs_get_dparam(priv, runtime_pwctrl))
>> -               usbhsc_power_ctrl(priv, 0);
>> -
>> -       pm_runtime_disable(&pdev->dev);
>> -
>>         usbhs_platform_call(priv, hardware_exit, pdev);
>>         usbhsc_clk_put(priv);
> 
> Shouldn't the usbhsc_clk_put() call be moved just before the
> pm_runtime_disable() call, too, cfr. the error path in usbhs_probe()?

You're right! I missed it. Thank you for pointing it.

Claudiu

