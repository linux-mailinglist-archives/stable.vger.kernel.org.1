Return-Path: <stable+bounces-200533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD9FCB1EAE
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 05:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89BBE3007C88
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3E30E0D8;
	Wed, 10 Dec 2025 04:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3LtonPF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E7200110
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765341659; cv=none; b=amfHtUDIat23/OgxypQ58LctW0/DjdfTpsB8aZk0nKFW6SZh0htmyTiUsUfKu5wwXcT8firg/nma0nogR2xb3r10tr8EPGEGY6HVqcdE2kaMy00ritpiXiXrPrOfDPDQ64A4305jLtbD8AnWQfVWhmzFKecvV0R5GPhl9rTbbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765341659; c=relaxed/simple;
	bh=UEb+Um//Pm0bjMP+ZKyco+iZ//oYpZeuCk3k7Wl9Llw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9OGIWNu8nVdS867mkecoqzpKwCVq39HWR4RhKpbU4zmwwCzazyrBv+MGJ45RH8xFdwJUgu202ThDh6t/Xagh4+qUWcAN7BB64wZj8JTHEfF1fp/5SLYaoaGjycQ8eHsI52vgDhATCexZlEGoYt8wTvtJG3JrkCtvNXk6MrZGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3LtonPF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so1315625a12.0
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 20:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765341657; x=1765946457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uby50kMfOF3sIrvqM4zL9wyiF7T878kqTyY1aG3DrgQ=;
        b=c3LtonPFZn4VpfAw3TSZKfGR3LVIX9gb6u/AKW1yCPq0aeqQzRSQBJKxxUzkvrISJ/
         eF95UmjBlXH3j+R3O06srkbDBaVsCH2bvJM46y4/3K2AhIoCyGYl2+jxTYOdCs60HNmx
         oI+lCXbUWNSGIyCcKWEFCU00gAGWxX7+VzEQPudpDdFXCbe1V2wYdVDS8vT4Ed31kpSZ
         coBjh86F4r20+C5s1zgD2NVI122uHIzpUQNiL3e7rT7hs3zV9BH9XePLGhV4iwtX8aiN
         WxiVyXtqM01HT6/0GUvpqJiZW9C6Mnx2+CIpdQPPw6bNSvsPYqbkZ5/dAc11u0a67ipp
         bKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765341657; x=1765946457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uby50kMfOF3sIrvqM4zL9wyiF7T878kqTyY1aG3DrgQ=;
        b=vxnkoMBll5Fw/8HoQv6Kkr5Ya/jb7ew8lIVYrZDG6NI2Xw0HqEmXwbRj6RV7tySgbF
         0jmuYjCE11R7FNggtK8iuAZCtyNldt+7jlJlhxUJCW8kpWSQ1veD7/3rJp/p7PYSHIas
         uv9O4TLyT8ers2wlEpITIvkVEshRNJOrZlhylq1eDIP8wWv8gA7WMINGWBxzMjD0TZ5p
         Ee8WCr8WDh+IFjzYszgIuyKGv3GGmtuMGckXuPVqbO/13K/bV7uOYftnFQwiPDSRB3KI
         X0B6FbTSA4mT9cLGvinDLxV+oJGCpYp1LUqYRoIjH2i4nrlgsaAuGaARfg3tVUuewTEq
         spfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBwToZfKbxB2SYElNjiK4bDC1rYddKAtwbQTEcX/za/5p4AkzRJ+kZLnnNQIPNiDevEqZmHuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOOk2zwZjnFvM5JGHhOw23np6Y85o7lDgs7O8A8q33xw0jB8r
	2pe+/IGiFgRda0sKWElYhA7FzVv9lisqyPzArlbz1BasOSInmWAN3s6m
X-Gm-Gg: ASbGncswuJXUe6pP81QHaLL3d3XJ1XDCqDTpk/DtgPCPLXT6AYpB18AOOzqCbl3HGg6
	XuhfZUpBxHhQ7dYAniTfxuNBjIh71gY7lhDKMCRuirGisg8MYMez4ZyO6WJ3t+io5OGijM+l/yp
	qnrDyCasj4rPPAs/Psxu9/E50TjV0D5aycl+Q1ZvangE14vvn27+A2Q5Jg29RhubeHYqk6rftxC
	7M/BSs9c9XICaYe9lE4sst6Xf8SfxRdS4vqjRM/H5HgMSXu2/cm7w9xkk4e5oIhq81VFol4NKCR
	CtKqav8cwj2/M0T34t1puYkmxtAh6JfAdW21u8BDqmaKxrQJv2OKC4ksd9SQ0KuDSeQRfTPssk/
	9AuRTOqSINO8LsSukPXLWIlUTViLxTTpqGORZmSjQwu6VhZG0/9LKycbQ/fk4D8ej3H5w86xh2G
	a4EcvdsA9dnwbWVy3R194iTpegNwCZK+xCLSuUAp2MKrunchv1El1Z
X-Google-Smtp-Source: AGHT+IENwAUsJ/s7bl0LcpXSQ+18il49/uHtdiDPbHYi/5wurUfmmxGJ90zEdCrpp2ByAgRva1UfOQ==
X-Received: by 2002:a05:7023:b0b:b0:11c:b397:2657 with SMTP id a92af1059eb24-11f2969792bmr895812c88.22.1765341657338;
        Tue, 09 Dec 2025 20:40:57 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:205a:5a0a:c468:f44f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm81337463c88.6.2025.12.09.20.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 20:40:56 -0800 (PST)
Date: Tue, 9 Dec 2025 20:40:54 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Minseong Kim <ii4gsp@gmail.com>, Mike Rapoport <rppt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] input: synaptics_i2c - cancel delayed work before
 freeing device
Message-ID: <xeski4dr32zbxvupofis5azlq2s6fwtnuya7f3kjfz5t7c2wnq@jbvlajechlrd>
References: <20251210032027.11700-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210032027.11700-1-ii4gsp@gmail.com>

Hi Minseong,

On Wed, Dec 10, 2025 at 12:20:27PM +0900, Minseong Kim wrote:
> synaptics_i2c_irq() schedules touch->dwork via mod_delayed_work().
> The delayed work performs I2C transactions and may still be running
> (or get queued) when the device is removed.
> 
> synaptics_i2c_remove() currently frees 'touch' without canceling
> touch->dwork. If removal happens while the work is pending/running,
> the work handler may dereference freed memory, leading to a potential
> use-after-free.
> 
> Cancel the delayed work synchronously before unregistering/freeing
> the device.
> 
> Fixes: eef3e4cab72e Input: add driver for Synaptics I2C touchpad
> Reported-by: Minseong Kim <ii4gsp@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> ---
>  drivers/input/mouse/synaptics_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index a0d707e47d93..fe30bf9aea3a 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -593,6 +593,8 @@ static void synaptics_i2c_remove(struct i2c_client *client)
>  	if (!polling_req)
>  		free_irq(client->irq, touch);
>  
> +	cancel_delayed_work_sync(&touch->dwork);
> +

The call to cancel_delayed_work_sync() happens in the close() handler
for the device. I see that in resume we restart the polling without
checking if the device is opened, so if we want to fix it we should add
the checks there.

However support for the PXA board using in the device with this touch
controller (eXeda) was removed a while ago. Mike, you're one of the
authors, any objections to simply removing the driver? 

Thanks.

-- 
Dmitry

