Return-Path: <stable+bounces-118910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF3A41E82
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FD23AB980
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9D42192EE;
	Mon, 24 Feb 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OuyGjVsi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5B2192E8
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398652; cv=none; b=Gh6CnmcM7GURoREkMiuBrOJfktEIB4nZ/8KXQIxzownFFvtz4Zcuo57kl5Vk5K5TSFw686uagAEZBsAzNFHYy1j+mEvTcJ+vGxqDRsl7NKyKhnCEetcOan25gZrzkYoroWaD2kYoptRDZv/wVBpO+SAeRHot2oZDv4dq4zYTfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398652; c=relaxed/simple;
	bh=+L3PhZEmgQaSbRAuJHWLglYt4qjvAOIrF1s42gg9W6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRqr2k6Ynt1vtiLAypyUJ+jHL0+Mkl5A90DfYWgJz9spibUCFmK/EqRD5nfiWR1crMhyovHynjoA70mMptaG8Od7ahJ+DY+Vxy+fmOZYUdgVwicx1Drht09GX2J3dcqvd+E+UE79ILggA4+D+URufNU7sClrCYse0/fAD/gsh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OuyGjVsi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so4485981f8f.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 04:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740398646; x=1741003446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0onFnRxIs2kBe+jELL7hIQKKJxUK1QSzk168t3wEz8E=;
        b=OuyGjVsi0z40guKq/yLMns9O69WhUyg5/ww9DyvsjsWoTKLbuhYaPy5toSyCNZbFhP
         Nt9mWOVxzC2IrPcYYEEEzELdIwYnQv0URlGr62FU+c6MeogXORACb/G+OcC3K3VRkeBe
         kwWEu6HwRzhZaEV5NCqrG0fE6cNbR+RyQWnZfGZ5qol/rSewIt0Mwt9w8HZfLGd6Run7
         +YoOa8iRNamF6+7p+ONrXMbyZUMuQx1W/Ho0ujUy97ZA8K4ZuvTKe4ts/4695iQmnAE7
         5myDGC5hJxmN6mXOFXO8OvHXdNZQ6EHq/ojv6nYJQ6+iFAV0tIltNm6syymGLxDoq2Nq
         i8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398646; x=1741003446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0onFnRxIs2kBe+jELL7hIQKKJxUK1QSzk168t3wEz8E=;
        b=gpuITtBJ7x8uY7XXEwm4/khcOWlxqXnvWousDPJtppdTDVxnibL7eL9vOJkzPN1eCl
         sC/CJCmB4pp+krY9EW5l7l+G/jUPSmHPWpWzESFUIqo77FbRS4iCaPH6QmCiOAkDD3yl
         Xzy4A2TbEHFsMqZb9THsA0htuDgeJNKFcf3P0A7oAkEUAuoZpLgtUu8K/TDFxmqfjBEk
         30EWWsb9GbPWxhVL6NjEeIB+28ry5B7VFCia7h1BYd84AW+R5hD/iwvzGjzD3HaDMKlg
         En15Da2FgQL9dzYzVxBFpkYTDWlhHs5swdgnVMYotsoZgBlBPF1Z7rkU91P0S3My1CJe
         zmSg==
X-Forwarded-Encrypted: i=1; AJvYcCVE2n+5ktrhe+aoRTriAiIFCvMLWSf3bHYFIwflyy/eGAnSnCeuDNXoOeaaKS321SsfJflxzpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ur6W5MwLWa5raJOZw7mEb0fqyt/kWyK9oqgbnOr6p6in4XmH
	rr/lfoDiVgxrKx6vvS8IN2NsHhE3yBv3NXHTir7M1Is1XE4ESAHYGLfp1/PJwYk=
X-Gm-Gg: ASbGncufXY287ZEM5WMQMmzgLHjHX1RV4l3SFffxYlf2ebDnjTrTHGYVQX4MkpeG6nS
	WCHXwEsK8Pe7xoBXba/ZKXiPPYKIRgUpBTcyDSse83H4vuCdNxozYXzutDEA3AKeQpid35PLdAH
	8PrGsGxPByjnX7tUZwbrS82CItN/MXKPGXcaxDDfO/nKjscklZLL7wmVdUL/VJKnuC3PgvA+zpo
	G/MKDBkjE3g6gOFOInjjZGcFHrZNaBqVv6Tsn63hJrBIneempGi0Nq2PpObl3393UMod7ivV4Yt
	c20jaUoDXZ2H1pOTJPN2T0VMONyWuWGxwu3mlQTVGp4fzqc0CEFC
X-Google-Smtp-Source: AGHT+IGRKIPeXT1LNLoxtMfDiXfqTI3VfaUvrkEcTwnu3mVHJKxvqex6Qwlkx3D50c356CoRnS0VIw==
X-Received: by 2002:a5d:6daa:0:b0:38f:474f:f3f3 with SMTP id ffacd0b85a97d-38f6e95bd66mr11180365f8f.13.1740398646115;
        Mon, 24 Feb 2025 04:04:06 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm30819875f8f.41.2025.02.24.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:04:05 -0800 (PST)
Date: Mon, 24 Feb 2025 13:04:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, 
	"Glaza, Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
Message-ID: <kwdkfmt2adru7wk7qwyw67rp6b6e3s63rbx4dqijl6roegsg3f@erishkbcfmbm>
References: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
 <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>

Mon, Feb 24, 2025 at 10:31:27AM +0100, arkadiusz.kubalewski@intel.com wrote:
>Hi Jiasheng, many thanks for the patch!
>
>>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>Sent: Sunday, February 23, 2025 9:17 PM
>>
>>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>>dst->freq_supported is equal to src->freq_supported.
>>In this case, if the subsequent kstrdup() fails, src->freq_supported may
>
>The src->freq_supported is not being freed in this function,
>you ment dst->freq_supported?
>But also it is not true.
>dst->freq_supported is being freed already, this patch adds only additional
>condition over it..
>From kfree doc: "If @object is NULL, no operation is performed.".
>
>>be freed without being set to NULL, potentially leading to a
>>use-after-free or double-free error.
>>
>
>kfree does not set to NULL from what I know. How would it lead to
>use-after-free/double-free?
>Why the one would use the memory after the function returns -ENOMEM?
>
>I don't think this patch is needed or resolves anything.

I'm sure it's not needed.


>
>Thank you!
>Arkadiusz
>
>>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>>Cc: <stable@vger.kernel.org> # v6.8+
>>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>---
>> drivers/dpll/dpll_core.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 32019dc33cca..7d147adf8455 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct
>>dpll_pin_properties *src,
>> err_panel_label:
>> 	kfree(dst->board_label);
>> err_board_label:
>>-	kfree(dst->freq_supported);
>>+	if (src->freq_supported_num)
>>+		kfree(dst->freq_supported);
>> 	return -ENOMEM;
>> }
>>
>>--
>>2.25.1
>

