Return-Path: <stable+bounces-144574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5F6AB9606
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 08:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCBA9E73DF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD78224898;
	Fri, 16 May 2025 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyrfVW3k"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E11D88AC;
	Fri, 16 May 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747377218; cv=none; b=QDu+MvvzkE9unJdwTcJdxJMjIviVFd8EIXbGe92Kw/HBc9yv9eMc0my2ylfPj79g602A+ZftmQOOour55fHyobp/IpyYqgstN/Bbly8Vdm7yCmhCc87glYcy048ZUkW+X/A36A/CsXX0Le90f2gXt7md0TNeVQDs3yfcf7sous8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747377218; c=relaxed/simple;
	bh=ITiHYvPVbIk9Cqhu0/8qKyPCQGSeXSdTjNGJyN7gjH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTAf5sSxvBCoNcNbhtqmPGdTYndvF/y0i5/Pqk/wkKsmwT6leQobepQ6qn1XiTcptALWu1oiHhNo5QLzx1UWG9JMzFPSV/7BCZf5ZtzmIiVnIi+Ops6Nqegh3YK25IHjObxootiQIsThMeWBXv0cqdpc7V/uY6l8RAid6RgrKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyrfVW3k; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54e816aeca6so2361162e87.2;
        Thu, 15 May 2025 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747377214; x=1747982014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBTw7n47tA9Za/6wjkrYsmCiKYOHmpnvJ9njSK+TKlc=;
        b=TyrfVW3kpw2t2MLaY2NqUpFrFM1gC9j4Yio7aSGz4HW3Ncsh7YpQ79U/1PCc1h7Bs0
         em8SSPUsIMMsZ5U/FEneK6MWbPOGIuBlf+cOtV/XdhTipUoq6lFI+ZNpAvMppm71VN42
         n+X6zj/7Z/VvHhfEc1zoH78wglZ+0G6bpOoL1H6znYV5Cm7mJdyeqcMpYO5zvJyHAkKY
         xdu0GOO3cnaQm2KtsKmXVWHN5i5EgP2C8hCCJjqb2Yc4X4OpVosXJKvLHut7zTQFtLSM
         5ai8Oxkft+gb1fl3ph+sFveilrusaXqCAqBuUliB0WqWQCptCbYSNZyHQmcWSkt5gWoc
         IfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747377214; x=1747982014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBTw7n47tA9Za/6wjkrYsmCiKYOHmpnvJ9njSK+TKlc=;
        b=SjzeirCs2n2u2C5j8/5l5zjAG3Yr4/2lsp2d+s1sb4bO6nOMaaDGM9W7Uly303jSDO
         XWWANuv2JNGse7JzqwK2udknytCjvGn2AftvxDp9dcTTxIwM71yZ/glccXnTISQJPkfR
         bzFzK4fB6GemzRfTYOD2aMwJERqy7w5fBhCsc8ehgb06WuZenNBXoHA4rYbnv6EPwD+f
         iqGnxYhw/HqLgo9RNUFK2VZFlQBRp4fxdTQB0J8paoWqlRWN2TGQPLBKK5AOjX3xWxXV
         AMOi1fLBTl+dM5i1M1EFP/CyYIE/vOTLd4NkCP0+e5FS8sCw60bTUGXB1nTvZbWjv1SM
         j84Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWswgoxlTBGU0U9Z7LbhipjoKfjBA4vHkD0Ysjp5YTv6EKU7BpVvz0vAnoNnUvojbCm79WVW3L@vger.kernel.org, AJvYcCVibBifrna5eTRWjs7eVQfqiCeygXPMV9+0GCasZJELK2iX34gC/mAI4qlIk/SUjLRUh4G7KKaDMavZ/Y8=@vger.kernel.org, AJvYcCX8+JgfsQhDBTEwgJQzp89vEDewzuOkKUkyajtcjZPzhjX+6l4SopYg6BYy4iEYwEiERs/jtrWWiDoL@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2FK5R98JGcolF9zf55poJ4gflxpp5TCb6HsFQCqjx8G+LjIw
	//VDQCr1DSRBDODFUcud5AeKK1lGf+CXvFCXjV7jBi3stkpmTJwgGSWS
X-Gm-Gg: ASbGnctluEClmoMAX3ZtUCMbGbZfPDTlpl3SF3YKuFOV6UsRItymfpIehlF/3Gvi/pi
	9khYKxdYJuMcpElzDj9VrT5FdyRC7dpgkm+l7ox8FzoMPi7v3LWEwSfZtUTk0l3jm4Omud9rl2j
	MXg+KMN40J3tLMJoCMvKAbfSyV+DNENg2qaaaw90nNx3Kk+OC/Oikom2DV5DYRMgLilAn0kxcHt
	Vx48zIq5dPPS2QlH7Lv36IE1HEAHwsMqjvQLvTYGFSP1+5VYiH7PQ9N9js2z8COPG4VBru0SlIi
	1215BUl6wIJ1SET8CD9oXsQ+Y6v5LtkLdNM1Rm6FNpxwoCknstn3zikjWJYDxzbwypp0gf9UwUF
	W+Ow=
X-Google-Smtp-Source: AGHT+IFXuvhTg0HwM4B7G448RH8kbjZAcl27kGgPEEicb7hYFOL5VilJkbVwHq1ibwD1yMKVeyUIrQ==
X-Received: by 2002:a05:6512:2616:b0:54d:6aa1:8f5a with SMTP id 2adb3069b0e04-550e71a732dmr438740e87.13.1747377214256;
        Thu, 15 May 2025 23:33:34 -0700 (PDT)
Received: from foxbook (adqk186.neoplus.adsl.tpnet.pl. [79.185.144.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f30e6csm281840e87.67.2025.05.15.23.33.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 May 2025 23:33:33 -0700 (PDT)
Date: Fri, 16 May 2025 08:33:28 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Roy Luo <royluo@google.com>, "mathias.nyman@intel.com"
 <mathias.nyman@intel.com>, "quic_ugoswami@quicinc.com"
 <quic_ugoswami@quicinc.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
Message-ID: <20250516083328.228813ec@foxbook>
In-Reply-To: <20250515234244.tpqp375x77jh53fl@synopsys.com>
References: <20250515185227.1507363-1-royluo@google.com>
	<20250515185227.1507363-2-royluo@google.com>
	<20250515234244.tpqp375x77jh53fl@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 23:42:50 +0000, Thinh Nguyen wrote:
> In any case, this is basically a revert of this change:
> 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state()
> helper")
> 
> Can't we just revert or fix the above patch that causes a regression?

Also note that 6ccb83d6c497 claimed to fix actual problems, so
disabling it on selected hardware could bring the old bug back:

> In some situations where xhci removal happens parallel to
> xhci_handshake, we encounter a scenario where the xhci_handshake
> can't succeed, and it polls until timeout.
> 
> If xhci_handshake runs until timeout it can on some platforms result
> in a long wait which might lead to a watchdog timeout.

But on the other hand, xhci_handshake() has long timeouts because
the handshakes themselves can take a surprisingly long time (and
sometimes still succeed), so any reliance on handshake completing
before timeout is frankly a bug in itself.

Regards,
Michal

