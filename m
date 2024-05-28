Return-Path: <stable+bounces-47555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B38D1659
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 10:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE931C21D9B
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922A13C692;
	Tue, 28 May 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c50dkOdm"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729861FE6;
	Tue, 28 May 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885380; cv=none; b=OveC23X2Mjvre57z2DPBfsG/ErRCvjD2WWIOlyF0KPvIdE77RsODUDWxbQpMh8K3wTD+bbJD7bGXE4yFUGMOOhGZBxeEqr8XgBw20B9jOc431ZnKVOtdzUyCjLNEHVWfHDcIWd31vdb/VDJrJE8jGlXCQ6uaRSfDHsn0kIc6fng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885380; c=relaxed/simple;
	bh=ek3GrqlY84Q06jk77iRWBRKj9BVLS70A3KDY0CS4zUY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FVR5DX8DfX8391OYE3taB/6gdvLQQUSsluPi0AU1BkuLFmORNa04QvFelA12L4I7wHn7ELFHTHNM8A0qbfwHzZfCqsw7GY6iZxZaaYfXk51BPtMZmSdvfIz/LN8RpsVdykIyBANKMkqBmfUnWXLofW3Z/mL6XPLXxldu+KCoqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c50dkOdm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-529682e013dso626958e87.3;
        Tue, 28 May 2024 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716885376; x=1717490176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bwfQhGLTMj4hFoy7VGzqwfW2WbFygxoA6ri2lFOZaw=;
        b=c50dkOdmAzAv8cakbWvpgDjhsTs69dVNrOHFKndi/iaU1+S077cTXgfbvXqlpeXzjD
         W1yLOoxXiI+2KRWGKHA38aGZOhtvrypMSOxW8n24scJAvjimyctAE7/xP/yKEY4Gc03k
         OE6O2xXo3hKFDxl78pxqXWo5vqOxo+A8Dv2WCknGf75cSEQmS1oK+4fJvNRCFRDYXtQJ
         flccXqFEKwW0ghNA0ZND6Md09x0901ZqnTMndf7joxdlD77TseXtsyAk7X8b5uKSzU9n
         jHc/BdYufHskyGtjAA+XCuSbHwZrh7ywEqnoqvV1g9RCYW1C8zXUxa4Yp030O0FAJiv8
         dgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885376; x=1717490176;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bwfQhGLTMj4hFoy7VGzqwfW2WbFygxoA6ri2lFOZaw=;
        b=ibOp5pGX+/Pfas30EJs3Sb3euz9CZ+ogG8vfi/qX1t3GB6YIaOzO7qpWlpcj1q/KxC
         GpsT/uwmpiwMkRy+OyFb5CYyQdNeLpIB41liCR12HEBUJVPjZ+vFtQ/Ncca4PNt/cqF4
         JpXoUzi5WEgX3kqlygQdG7Z14gamw3w9TZVz+GF05ORIoPi4cnT9p6y1I+ayZYcbcS/G
         kVKTGb+amd5kPNzWe0+Cr7F0tqMx0yezSo4fJ2P01QZZAVfELQ1XyatgwfOM43bC81OB
         C6Ag8h8tOq6L3YPIuJwFmGx3U50rVabJbqbAo4eFiwqQmeKGmGfX2oRk1ogl/LJSLE/s
         NI7g==
X-Forwarded-Encrypted: i=1; AJvYcCU25fbju9wzb9H1ab4OGw6pkRXgzAgPkmwA1ti4GhdZ/uHJc5UGjvFjf2ucMWhW9QuD+VRZjC5KQD+lmnWeRxoBbV+8ZbbdZYo1DTyVJPGohcvpBSp/vX0XyOWHFUNOBl+HJ3sd
X-Gm-Message-State: AOJu0YxpdK44qI0mSEiqwKO/WHtsvVnH5o2glpS8zEOyEVoOQsb0rRT7
	TKrENRzoC6BY/369aguQPJiC8Qf7LZ+HXLheec9rd5bVkvFtmzK9UHWIIA==
X-Google-Smtp-Source: AGHT+IHIoKJ1HbtUskcfzhLaGGPbzPhd19YSGtQTeDJHcjxFS0wELuRKNKsKAc6qvVfucPd+Hg7yyQ==
X-Received: by 2002:a05:6512:34c5:b0:523:8a99:f68b with SMTP id 2adb3069b0e04-529649c5d3bmr6850582e87.19.1716885376036;
        Tue, 28 May 2024 01:36:16 -0700 (PDT)
Received: from [192.168.1.105] ([178.176.72.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529a50b1d85sm689027e87.113.2024.05.28.01.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:36:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI
 host
To: Kuangyi Chiang <ki.chiang65@gmail.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240528033136.14102-1-ki.chiang65@gmail.com>
 <20240528033136.14102-2-ki.chiang65@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <40d075d0-7075-6ece-ffe3-797d7b49db4a@gmail.com>
Date: Tue, 28 May 2024 11:36:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240528033136.14102-2-ki.chiang65@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 5/28/24 6:31 AM, Kuangyi Chiang wrote:

> As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk for
> asrock p67 host"), EJ188 have the same issue as EJ168, where completely
> dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> ---
> Changes in v2:
> - Porting to latest release
> 
>  drivers/usb/host/xhci-pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index c040d816e626..b47d57d80b96 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
[...]
> @@ -395,6 +396,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  	}
> +	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> +			pdev->device == PCI_DEVICE_ID_EJ188) {
> +		xhci->quirks |= XHCI_RESET_ON_RESUME;
> +	}

   You don't need {} around a single statement, according to CodingStyle.

[...]

MBR, Sergey

