Return-Path: <stable+bounces-172762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2FB33212
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 20:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709993BE908
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE31A2398;
	Sun, 24 Aug 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYdEAZID"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93D2CCC5;
	Sun, 24 Aug 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756060264; cv=none; b=U3BZT+qsfFpK9Y84swdoXfg3RC4RyPo0zKJDxZbyEMzTYndIh95xwfrZpRftFPPJtQp8loQliZGcrAZoHxEHAKkLtg5szTlkslYqwTwjOEAjH/Jgb8kiu6t0F4B9RU/IH9GhjIZTza7oTjj5WLejcR0zZskrcayOWumkjxaPMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756060264; c=relaxed/simple;
	bh=W+ETwy5QtffVE6jxjJA45+5GGBoy8Sk4mzSosGZCkG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugPFHmrYPsv+4GbwcnHn4lOao2J0cD7IMziJ5bXzVHBmleueGroNpxwhsNsgxlt3jLRu+ZUp/nxdZuWtXmRfUT++D2+6W8zaR9jO/cOd9sa7EChyCLH/YVZtOrrHyMDmS6Eu5Jyq5gInVIoBvveFDLWbDC83mJsGVgQxKKJZMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYdEAZID; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266cd073so287232a91.0;
        Sun, 24 Aug 2025 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756060262; x=1756665062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSfLOaZ3KMbXNybbcDwUOnt1kpIXXVEtejVcb/7mXIQ=;
        b=WYdEAZID11+JTWUdNouBNtcakstS/DqQ9RvKgB3DZumdjWULItzWs6wIrs/f85/j3S
         mKZbOOWMwBTrIu41udXhDXs2iByl2zQ5IH8iywTEs5kqtMQxj0ilDJIvJF8gRi1a4l6P
         Tgc0NS7exJvk4+DsSiehrUFR64DJYKaXG8fx8+mbA31Un2vqMM2pc0PnL3Mg6h/Y2CmL
         2Sx6fhYmgzsrBzgOT6nNQoz+m+J5bMwBoT4FvX/99cGu/j7Dj3PlCFadMKlaBa1bRP96
         N5p8KhDHLcow3WumVHmlAckBNK+NxPKdsuORKExw2QGk4sevoCozlQF7fNTjpsV5g4Kx
         vMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756060262; x=1756665062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSfLOaZ3KMbXNybbcDwUOnt1kpIXXVEtejVcb/7mXIQ=;
        b=HuIP/f3BplDopQHlE160bgAufmoSmqSdyJf+wMTr8q/PieEcC3GBo8jVgMmSlIT/fi
         etIVtGFUN8BztvfDlyqWTg2L88unAulQXDeJ/MXGZiMzffvvcOIw+XWieYnZw5Aol8+z
         Fm3bq+dPdUX3rRIO1CDTbrJ0ePPq939fz8rz1LtmHssmfTx9UDGfBom6w09Y6HJtCrn2
         ioFruFYts1PL/Mw8xDRCogXevGwRjuy6k49p1JXkUcUfYipZW1OqzlKg1FtDLMt+yg0F
         TGP31HAlZpsI0Ze6czzTVFliNLwyYmq6ZYNVzpXUT1u2n/w4gB2vStTWynJupruKPXii
         vEjA==
X-Forwarded-Encrypted: i=1; AJvYcCVjUafbQ3QhUyA0/gP1LZGBbPtB90IPi02jzb4jy5T1di6AXSYuNRDwxEXkHURjFUpxOSr8w/Z8@vger.kernel.org, AJvYcCX4aA190Zt6oCj90F8t+xKxV1A4GYMY27vOcRMStuXtkrBkB+H/3fe6mcY8oih8/cib8GXG06M7YkfR5qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8X3eUsZNxVuXHDauRZXtHImCxv9XpIg7RpyEMZo6qkl245lA
	BFQWWfWNRwJh5PAtr5hCmSWIg+Id04+ZvN0Yxxi43Qy2L4o9tVxzSDF1
X-Gm-Gg: ASbGncsySvJMrXewnV0mAt9d7WgMTtkhrBeEfl2Pc6hfFazwCNB1Qng/hwNwJ0By12J
	I115WQ6PEXyoldp8JUu3oYOOA/CK3sSTT3s1PxzD1RB6sMoT56szwXEtgdpgZc4QQVjMYXHNZ73
	N8zwlgSbyzHGL6OlwN8UGpuhGzHC1dYfigzg7otruTWBKsRvFPD8apjxzGb/H8in3JpNm7BClYU
	e/UFYhN+EPsholiOFTHKAZgAKyKjCzidqUZWSW0ApBcqc9Y6j/fMndKwC17Onm2dAT/V8fBdB1r
	4qPSczlfHPLgLNwv6yn7/VuyA9xasD/esnsSME7zRJAJQhg6vEhXPHSYgQL30AuYokMOgZXN3b4
	BxTnWNUEPXzLGlpj9JFaoI3Xerxydcy7749874UvoTQhU3+D2hhiWAahGVhpUR1oAOLQso6zo
X-Google-Smtp-Source: AGHT+IFeYzk+uHKZ8TMIRbRJCuxck2G2r5ftJhcw3MUl0IBu3DqGYReR3/47A7js/25z5F4TA2NVPg==
X-Received: by 2002:a17:90b:4f8e:b0:31f:3353:471e with SMTP id 98e67ed59e1d1-32515ecb35amr7552025a91.4.1756060262304;
        Sun, 24 Aug 2025 11:31:02 -0700 (PDT)
Received: from [172.28.221.105] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8918e7sm4748573a12.6.2025.08.24.11.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 11:31:01 -0700 (PDT)
Message-ID: <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>
Date: Sun, 24 Aug 2025 11:31:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION] - BROKEN NETWORKING Re: Linux 6.16.3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz
References: <2025082354-halogen-retaliate-a8ba@gregkh>
Content-Language: en-CA
From: Kyle Sanderson <kyle.leet@gmail.com>
In-Reply-To: <2025082354-halogen-retaliate-a8ba@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/2025 7:51 AM, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.16.3 kernel.
> 
> All users of the 6.16 kernel series that use the ext4 filesystem should
> upgrade.
> 
> The updated 6.16.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thanks for maintaining these as always. For the first time in a long 
time, I booted the latest stable (6.15.x -> 6.16.3) and somehow lost my 
networking. It looks like there is a patch from Intel (reported by AMD) 
that did not make it into stable 6.16.

e67a0bc3ed4fd8ee1697cb6d937e2b294ec13b5e - ixgbe
https://lore.kernel.org/all/94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org/ 
- i40e

This asset is a quad-port embedded Intel NIC, previously eno1..4, now 
eno1np0, eno2np1, eno3np0, eno4np1.

Seems like there's a bit of a debate right now over should this get 
carried in the tree (this 1/4 state stuff is no good). Anyway, upgrading 
the kernel broke my networking, and because this is carried in 6.17-rc3 
for ixgbe it will break again. I honestly don't care if it's some 
ridiculous systemd thing or the kernel that fixes this, just that 
there's a note on how to migrate for the common man (and that there is a 
material change to how interfaces are exposed).

Kyle.

