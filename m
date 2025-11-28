Return-Path: <stable+bounces-197619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8DC92962
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C9DD348ED9
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17EA26B2AD;
	Fri, 28 Nov 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLluKbad"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906F23C4F4
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347692; cv=none; b=llFXlB9GaRyLpDcLqcBVk6dPlJSY+G7LrttnYjwCZrg/2K16psBxcBWuHKNCcrSKyPBE0gwBocsqMKlz/JefFdgfXUXXcIHVsUTJx3km2BTCfbYUZQgtVXl5iq7bSKj/dh8DztYFrICAJSS7LZ5IYQbQA39/jBuXfuBSey++tng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347692; c=relaxed/simple;
	bh=GXH1cWPdGus4O8oVWZv/sxdK/JlLC1p3HxJzlpZFPDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIPtG/HnjYvwr6kvd1eVIEsL22R/PnSbZ6Wy8ge8+5BWUqQ7zxt/zPiQx8Pyeh/eUifiYmxbwenqpNxL5wnWIjK/uaueZDS7IQlqkYwIYvUO2Nu0VeW/nIj+cpC841zOG6f3AwUXLKMKS4mL4DQHzUfZMn7JEjwB1kTIJaJRe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLluKbad; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bde0f62464cso1865365a12.2
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764347690; x=1764952490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFmk9hlrvzIMQ9F/XPguCU52S/7ZrA0XyoOyhl4nsuw=;
        b=TLluKbadMCGr88g/x2llq+qT5GyW6r6J8v/tBctvbh1gobzLq1j6QQdyjwJE2BsoNs
         S6d11YJdxowsdOrmkajG3n4B55JVOIi8cTC1zAQiMa3rPNkDOdvnZ+Fpgz9Gm7KN8giY
         Q940ozf2f9eIZCuF2mpBS94TNUQLbYihI5dugIPjT7gz/3z8u32bVZZBin5afeTHQs/t
         9n9dXZzgilE5gFH3Bh07n6xaI9vvK+e58ROjK4vZBRwSP6cRiL2yMMOPF3IgBaqWSY+F
         iwTMRHpZT4kID7Y3FkVU8HSlZCau4rZDtiwep0ROpNbCtxU1eEO5G5fQ7Y6HXWCnt68o
         vUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764347690; x=1764952490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PFmk9hlrvzIMQ9F/XPguCU52S/7ZrA0XyoOyhl4nsuw=;
        b=TbJhwayakQz36Xxn+Wz3v+LwlXuYbcfd0r3peWuBeeoMLXsWeLtodb7HuyfV0kCvi2
         bmGt+jhT9FeDPgWns2p6i0Lj2lhvo5m13mqaatif9Y0KXrHFFjmO0O5XS1IfAcTgAIDO
         bmMS3zFoemsoIA2aOwpUmWh7PJ60lQkmmw/6NR5Ug4Ebe0sj9wR2m9OOF0XMnIoYb2g1
         V8yb5cicrb1ruBK9La5hWSmShx1k8YOyLXIZAQodJ7Pf71NvfVFPdtCFbqm+ApoFCCBM
         ZCqUQceLn2sGf3iwuogiQIeAB/GeZwu/zAM+l1e8LxcpTozRiuutG4VEnQEhslUXSWai
         1IeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlex6QltGdzvAikSo6REux4sB5mbTis/zJ8oPYSlEeF6GgiPagamCjZijqEcek9x2+JA/LEgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwl8iNmq4e4gMe4oKVZRkRS7iHqezVyHknsPMoYwjQRIdR0BA
	V/lpBKbw+Qu1jbehj5MGsxXWevTMG876yg+SIbOE2PYUYa68jkKwgn/tyE47Kw==
X-Gm-Gg: ASbGnctENuaFG0SzRU36qM5INIT2h5uY7kAM2ahJ5by0PVwra02gQjl23sXL4VoQE55
	5XB5+xXRg5ieBvJgxksO4QR8/eR+zlIsBG4D9cnl/QbWRqGDpdrNV4IMOfPpRfEqBXvIzG/POO9
	kw+A3J+/Y5CiOmjgl04yDGQZuCM8ZvNr4vwjTWlGvxkD1LGVJGEwOkZtB5pWW+76VnzehVqE+eq
	BccoNdXUgsb+gIkfPAeGC8WDzwMboPRs5v15RcLf6sKHnMebdYuPneTGj+l9RV+epAMpME3ryIQ
	lQD2n2H6z17Kq6xs4ba+Q9TZ07NOVe8W+5PVJWIKiYzxEDwXb5POBcAyPAOF35/igLTE98ocRam
	b9jBH/j3NgQY8Da6OA06TH7l3Y53HkGXpTyVuhdR1zCpU4yp8YjxA5fPFtS1T9jlUTm0N1CS8oi
	W21l4KDj2gifdNyvChqKvfTbg=
X-Google-Smtp-Source: AGHT+IHSE4V0DVDx+1WJxYLX/1UcOOn/zoR6YvJ99VgXvbLfW9lqG/mD60tGkXaEnTc9gRyYW/IiAA==
X-Received: by 2002:a05:7300:2716:b0:2a4:3594:d545 with SMTP id 5a478bee46e88-2a719d5a9d5mr13034270eec.18.1764347690279;
        Fri, 28 Nov 2025 08:34:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm16442454eec.0.2025.11.28.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:34:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 28 Nov 2025 08:34:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max6620) Add locking to avoid TOCTOU
Message-ID: <f5a0e99d-306a-4367-8283-b5790a74dfcb@roeck-us.net>
References: <20251128124351.3778-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128124351.3778-1-hanguidong02@gmail.com>

On Fri, Nov 28, 2025 at 08:43:51PM +0800, Gui-Dong Han wrote:
> The function max6620_read checks shared data (tach and target) for zero
> before passing it to max6620_fan_tach_to_rpm, which uses it as a divisor.
> These accesses are currently lockless. If the data changes to zero
> between the check and the division, it causes a divide-by-zero error.
> 
> Explicitly acquire the update lock around these checks and calculations
> to ensure the data remains stable, preventing Time-of-Check to
> Time-of-Use (TOCTOU) race conditions.
> 
> This change also aligns the locking behavior with the hwmon_fan_alarm
> case, which already uses the update lock.
> 
> Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
> Fixes: e8ac01e5db32 ("hwmon: Add Maxim MAX6620 hardware monitoring driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
> Based on the discussion in the link, I will submit a series of patches to
> address TOCTOU issues in the hwmon subsystem by converting macros to
> functions or adjusting locking where appropriate.

This patch is not necessary. The driver registers with the hwmon subsystem
using devm_hwmon_device_register_with_info(). That means the hwmon subsystem
handles the necessary locking. On top of that, removing the existing driver
internal locking code is queued for v6.19.

Thanks,
Guenter

