Return-Path: <stable+bounces-87571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FFB9A6B91
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3E2280353
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1F1F4FB9;
	Mon, 21 Oct 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4UpGvdc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E421D1F4D;
	Mon, 21 Oct 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519596; cv=none; b=Kfz8rrbz1arUZFlSPoEQH5yPlAR2Uk63MAstiAihhCf8YgPrnNOjeScu4XtNuVnYaTf/ERCy7mlN0N0fR9XiKiv4yWYUmVSR0YzJQmjzmivNfIhpXVBzxJlNeEnDM56T94Ib1WiaGwLsmkMcVYag3a8fj1xEuqfA1cFWHyRfKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519596; c=relaxed/simple;
	bh=eP1fDyUF7bFuQF2oOdZEQOS2WQRSCIIBiTAx6ZomrAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/VAiGavfK+r21skveIOfpuuk+/oUnX3iMGsnPIDfN8lNC+dfIAqhOZFayuD1hvE5RKGnAWuhANx1fwYDVnSckT+rxouUoiTAyattqMH9kHThW6WDPfIMVTfsc0OU1uw7ahH854q+qsHYOfq2pif4p6cyQGgcRLkYFionnxBMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4UpGvdc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a007743e7so5330783e87.1;
        Mon, 21 Oct 2024 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729519593; x=1730124393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+85Xs81Oqw0pwrBvljab4ggzyLZvu8EH15lYNIIZqwg=;
        b=Q4UpGvdcUm9HmJ47aeoSvPSb9F8RgAVXjIfZH/rm1uVn0jPtrB6cIy/s463q74V+QC
         PFbvjLnups0+PXVdbyUU1B3Pw75bQbfNfoGayX+q/I/hYx3gcePyGJMgABdMO0ap6tlx
         c7hWvsdhVweD8yt7TgGABNprAdFAJh0R8u3d/TH09iwjWlw0vGwyqud+CLV3mB8ZVtVj
         oP6nGlMUtK3xwhELL1Ol8Oil4YHuHSH3u1Sr81AUj2VZhAuAbi9sO04Zmg+PPqkdkMzJ
         EpKuAWbGJubCtX/xbg4jS5lACgA1QiM9PD4NuZCcKxFGM5HoE6VQNW5rBIBNqePVg9kz
         3xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729519593; x=1730124393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+85Xs81Oqw0pwrBvljab4ggzyLZvu8EH15lYNIIZqwg=;
        b=WylctWYpVIkKx7fvtevfgsaPGSylMnXKtQ6zCsnI8Y5HppZjpT846C73jPURcdtnZT
         T8j3C7vF1a6fZluQDEWib/kuuMGf4xU+r4MUCZzl7MPO6RixLLySCKAOwiC2ubfouTzV
         W/GmncEpGQvXFtCljXY/v7YELUfiazcTIfFshL/KN2XlGUHczaQ53Js5Dg4Bt2zn3nCt
         pFmAJ0xEMOr64ym6D8n8glU/0RXSPpyjbOOaNSEm6eYOmak3NDNwTovFtYLHKO+BhfuI
         YZIQ4pBO8BKwGXisst5rB0CdX5R9pDf4YMqumIhazzZLjyMGxn2nNbmePOcYWfct54dc
         qGLA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZFRtwq+C0yLwTSm3z9QsurfdlClApznv5T7SqY1GLw1SSKZnE+Xpr2tH8VhjxarYS01YHane@vger.kernel.org, AJvYcCWbPkOtAKYuzzif6odKtyaAnoIhftBTTnPi3QvmlQTzpnjwgLKC4l9i+F9J45zCqhJbVFqwBFPW1bFZSuA=@vger.kernel.org, AJvYcCWyBpsaa7ya7inab4t0YyXDq3Lqaf6w+GYPzWXK28uZ+OBCj1bjljapzSdUk527/qyj3YVcSf9MIyEx@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNEqJZuTK0vxn0/2eIakvLCDpxnzHoke6RJOgHplWCCs3h5H6
	kJyQQYyfXsm3cCLMXWMycieQQVIK4pNNQFFQTCNPvYzfBRbCZXe2
X-Google-Smtp-Source: AGHT+IFHTAFWRwDiVkOYOoo0IYZ1ls4JP7uq3nFMj3NwgfRG6pfnrmvkV2zG1afKE4uOqOZNr3Xw2g==
X-Received: by 2002:a05:6512:3b82:b0:539:fc23:1497 with SMTP id 2adb3069b0e04-53a154410ebmr5177522e87.9.1729519592279;
        Mon, 21 Oct 2024 07:06:32 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:6d78:abde:f86d:eb66? (2a02-8389-41cf-e200-6d78-abde-f86d-eb66.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d78:abde:f86d:eb66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb66sm4384804f8f.95.2024.10.21.07.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:06:31 -0700 (PDT)
Message-ID: <d5733f9e-6eb5-4b03-b264-a3f9f35791f6@gmail.com>
Date: Mon, 21 Oct 2024 16:06:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: fix unreleased fwnode_handle in
 typec_port_register_altmodes()
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241019-typec-class-fwnode_handle_put-v1-1-a3b5a0a02795@gmail.com>
 <ZxZPS7jt4mI1TUG-@kuha.fi.intel.com> <ZxZaRUmZS4upPvv8@kuha.fi.intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZxZaRUmZS4upPvv8@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2024 15:42, Heikki Krogerus wrote:
> Hi,
> 
> On Mon, Oct 21, 2024 at 03:55:43PM +0300, Heikki Krogerus wrote:
>> On Sat, Oct 19, 2024 at 10:40:19PM +0200, Javier Carrasco wrote:
>>> The 'altmodes_node' fwnode_handle is never released after it is no
>>> longer required, which leaks the resource.
>>>
>>> Add the required call to fwnode_handle_put() when 'altmodes_node' is no
>>> longer required.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>>> ---
>>>  drivers/usb/typec/class.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
>>> index d61b4c74648d..1eb240604cf6 100644
>>> --- a/drivers/usb/typec/class.c
>>> +++ b/drivers/usb/typec/class.c
>>> @@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct typec_port *port,
>>>  		altmodes[index] = alt;
>>>  		index++;
>>>  	}
>>> +	fwnode_handle_put(altmodes_node);
>>>  }
>>>  EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
> 
> Sorry to go back to this, but I guess we should actually use those
> scope based helpers with fwnodes in this case. So instead of a
> dedicated fwnode_handle_put() call like that, just introduce
> altmodes_node like this:
> 
>         ...
>         struct fwnode_handle *altmodes_node __free(fwnode_handle) =
>                 device_get_named_child_node(&port->dev, "altmodes");
> 
>         if (IS_ERR(altmodes_node))
>                 return;
> 
>         fwnode_for_each_child_node(altmodes_node, child) {
>         ...
> 
> thanks,
> 

That would have to be a second patch, because it does not apply to all
affected stable kernels. I can send it separately, though.

Best regards,
Javier Carrasco


