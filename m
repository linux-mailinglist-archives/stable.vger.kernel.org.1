Return-Path: <stable+bounces-119497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD444A43EDE
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DC21888D76
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A3267B9C;
	Tue, 25 Feb 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O0bl42Jf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01120266F17
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485311; cv=none; b=KtTfkqk9ZLR0BKAOLJczKg4OB7p0al6mBXJ1jwFg9HkDKrl6zNUh294WrUjHnMe3hvIvj6mnAEtvDKaBKQBqnw81u5/z+v4WaSoKCkhvBEyplG4KEjesFkw1a7ZqQoR7gB9iEACEGxgrsDl4HzjogD5OZggFvmeOneFOjSpgHVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485311; c=relaxed/simple;
	bh=Q9LTud62PiNP68Npcecb+Y8o1+UPT1AVOMCQPZBgGqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMPoKTZrhal9jzjCOIs5gZcMhuwLkMShII4OViyybJGd8sOTG2pTTchVPP5JCv39x94tB4v6yMxIM/N6nhkTkC+3eFkLx3m/Fsvcw3313reRZlMJO/bimX6T5dzlppbwiH2ayOjEpvrnt6KlCz/7Prf5JrVmBa4+mOjLAJDB8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O0bl42Jf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so8530516a12.0
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740485307; x=1741090107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSFcV+r5E4WxO2+xTlVlzsifVYmK0gkUHuM2wDK2xfs=;
        b=O0bl42JfY9iW9MVVQmivUg+zLcrBvsDb1fxDe857MejbJOhKV++ywxFzxdGE5zAWS5
         gzsaR+V9C+DnsxbwKuryVhd0Tl9f6rJyv50w8HY/Wt1b/VLiuJAMB70b71+sJNUypyWe
         I0TgZUbKv4FfJxop1eTMAKrJ0T/vvwqlg8efNcDcXRtHSS7HCMFlxHE3Y7ftRSOnePhF
         LQACcCDB+q8TFXvb0HQHUbtSBD4U4QWLcjsrgSJMmK1TnW5Tg0nUQH7PizlFwoOxvjTh
         P+GnZyrCGT4CQemAhPQHglyZgG2S0qsSdWIbFuY87BlFpVuZ8C5NfjCu79cKcWoGR4nS
         zE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485307; x=1741090107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSFcV+r5E4WxO2+xTlVlzsifVYmK0gkUHuM2wDK2xfs=;
        b=Y6JUWk/ZKwft4cHEN58lAUtRDMQF08o4TVTkaYKAE3KzD2yYQZiDR2NKrYhrz4dHhG
         lqEepX42/EYdm8pac3dyWBcdkfFpoYJXX+2SWIFwfrico0UakTNLSd53hguORR661aA3
         DWavfhtKozo/F0ixiP8kP6JkNlof91NDV3ngFSYV7Qc+iZuyL3mMYv4snx1r6kvE/diU
         +vMUdD/Ioip0dKXLEKxZti4vonW8IFe8UUwQ+zL7W2lFE6iy2PQBo4/A6OFGu7WFl23F
         W3mYA91uIYCV9IqVx1ird/2aRQsOiYGvmzuoj4aH/BLvK26xb20tJ8XDY2drrxkNdtcZ
         MEyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLrRr2y18+1CYqAZXpFNQmAnh3RKJK7p0Yhp9+oHWkg6XboYnnvq0V7Am/UiHFt9kXxWGZKZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuwMXQsxxucyC27+aaZ1UHm6zx7GgRq3UXf0c9O7CzmFwzbIp+
	E1p5OIED5hHEUF1kV7mSPDnHnjLIw9MMYdRi7a+PX7wQLXtcUN0pThc3Cthhl1c=
X-Gm-Gg: ASbGncsvkTqy//2WVFkNwjzRzQfHmevwVDG0xrTFBwVE8eLDY+hH1EIaMrzUcVKZXi6
	RqXN4IRgiSULKo2yWSvdq1I1QkCO+K4WCUDsu7Z+eG1ps4FdmYrawCx6SDEJgzOMfhMqqjHNbFW
	6am2op2c6O0P/CsJfv8KxQu2u6HopQpufijBG4XBHjY1Obf9vUA9jptclYt09tYtWNGCvzzUOBR
	IUGZ5HBLEQGj3Rb0/Dw9jVe5dE+RncZJ5pGfrGu9wJh4wzuQb3F2RV5sng1//Fy041xH6Qf3ARC
	GHEKq6bywdFIIR+dvX4/XQu+ba7jP+Fyme30FhFn/STzBSqRFNpnwyjSHGNz52hTWYnh9601np1
	0tOirfXhdPkXWWy8=
X-Google-Smtp-Source: AGHT+IH3gdzX3PeChiwCGAsoV3Kg3a9bzz9OmkI9aT6t+gpVTMMM2ymgKcITTcD1763s9dbf6zqhuA==
X-Received: by 2002:a17:907:9686:b0:ab7:d7fd:6250 with SMTP id a640c23a62f3a-abed1015488mr297536566b.43.1740485306884;
        Tue, 25 Feb 2025 04:08:26 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com (194-212-255-194.customers.tmcz.cz. [194.212.255.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2057276sm131230566b.142.2025.02.25.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:08:26 -0800 (PST)
Date: Tue, 25 Feb 2025 13:08:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, 
	"Glaza, Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
Message-ID: <txrxpe7tmpsyiu4cwjd2gbs3udogmzdo5ertjwmhbeynu23iep@dcryfdoi7o5x>
References: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
 <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>
 <kwdkfmt2adru7wk7qwyw67rp6b6e3s63rbx4dqijl6roegsg3f@erishkbcfmbm>
 <CANeGvZVoy20axVTOd4L=d0rwgMWvH_TJqV6ip=_TaDNPJVEqkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANeGvZVoy20axVTOd4L=d0rwgMWvH_TJqV6ip=_TaDNPJVEqkQ@mail.gmail.com>

Mon, Feb 24, 2025 at 05:47:04PM +0100, jiashengjiangcool@gmail.com wrote:
>Hi Jiri,
>
>On Mon, Feb 24, 2025 at 7:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Feb 24, 2025 at 10:31:27AM +0100, arkadiusz.kubalewski@intel.com wrote:
>> >Hi Jiasheng, many thanks for the patch!
>> >
>> >>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>> >>Sent: Sunday, February 23, 2025 9:17 PM
>> >>
>> >>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>> >>dst->freq_supported is equal to src->freq_supported.
>> >>In this case, if the subsequent kstrdup() fails, src->freq_supported may
>> >
>> >The src->freq_supported is not being freed in this function,
>> >you ment dst->freq_supported?
>> >But also it is not true.
>> >dst->freq_supported is being freed already, this patch adds only additional
>> >condition over it..
>> >From kfree doc: "If @object is NULL, no operation is performed.".
>> >
>> >>be freed without being set to NULL, potentially leading to a
>> >>use-after-free or double-free error.
>> >>
>> >
>> >kfree does not set to NULL from what I know. How would it lead to
>> >use-after-free/double-free?
>> >Why the one would use the memory after the function returns -ENOMEM?
>> >
>> >I don't think this patch is needed or resolves anything.
>>
>> I'm sure it's not needed.
>>
>
>After "memcpy(dst, src, sizeof(*dst))", dst->freq_supported will point
>to the same memory as src->freq_supported.
>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>dst->freq_supported still points to the same memory as src->freq_supported.
>Then, if the subsequent kstrdup() fails, dst->freq_supported is freed,
>and src->freq_supported becomes a Dangling Pointer,
>potentially leading to a use-after-free or double-free error.

Okay. This condition should not happen, driver is broken in that case.
Better add an assertion for it.


>
>-Jiasheng
>
>> >
>> >Thank you!
>> >Arkadiusz
>> >
>> >>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>> >>Cc: <stable@vger.kernel.org> # v6.8+
>> >>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>> >>---
>> >> drivers/dpll/dpll_core.c | 3 ++-
>> >> 1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>> >>index 32019dc33cca..7d147adf8455 100644
>> >>--- a/drivers/dpll/dpll_core.c
>> >>+++ b/drivers/dpll/dpll_core.c
>> >>@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct
>> >>dpll_pin_properties *src,
>> >> err_panel_label:
>> >>      kfree(dst->board_label);
>> >> err_board_label:
>> >>-     kfree(dst->freq_supported);
>> >>+     if (src->freq_supported_num)
>> >>+             kfree(dst->freq_supported);
>> >>      return -ENOMEM;
>> >> }
>> >>
>> >>--
>> >>2.25.1
>> >

