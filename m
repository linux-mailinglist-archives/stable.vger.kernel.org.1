Return-Path: <stable+bounces-192185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF234C2B4E9
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596283AFBF8
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234F3019D8;
	Mon,  3 Nov 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I69Nt+ZZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A32F3C12
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169010; cv=none; b=DXD4KootfZmCLCWv3nmzvkaXNh/hYnNCqHoaXf9rZncVYRJpA+YQ08RXphxr0UKv5aJk4OhLpQhKiIZgBSrZX5kl4EX4rQ0vMm9D59U7NuNqINto6BklBJ6CppwauPjEi4rGM1NICzQQbOPw7+rlAt/nfOzVMeJEhDt03BqYUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169010; c=relaxed/simple;
	bh=zrhN/426GIFilnVCj4jC8s7WHQTdZuCf3dYpf2RYbrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl65mmogx/2TdsB22M3NYhRKUSkZDkDxYmm6HoOrikuhRHgmtZU1A9pzubzIQkrVq8hzsSZu40oPE+K67rEdi8h4Ysuu4t+iPbDEHcRuIZtRPaBMMRItwcVNMOwG54o2cDm8UvETVuMvTcfvnZD2g5fgEVoKRY9DeHgJyCVn2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I69Nt+ZZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3c2db014easo895655866b.0
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169007; x=1762773807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTiOq3s4Du2klSTxft/DNgygXTqBjyM4NTyZGqGWusY=;
        b=I69Nt+ZZiN1mB8kdAgiRvjcMenTdUvXmY/pnc/P02Jqgw5pxoidebb9JyI1WKhy0Wy
         0rfT2QPC75uexucKKTbO9H6e1DHsK4Z5c6Bp/ADNs2qYexwNsMRhDK6kymfkWOPI7nSE
         JhThI/u9wOrCh2Z02Mi7hLCiLLAbhVFDhrjsGB/QX3rKi1+FyxEDVJ38EBvjGoPkUwLj
         UVNXZLyZThKCqKf5EFZ0Y0iMn7pr6GPi8f8JYF+eDSiCVEeyEmefPLQ6DpnJSp8/TKW9
         fzFrnM3mJJIVsvgRBM8R+3HaKoRR90TNBDGCkSbC4YU7lUx0zZCX6Ez9rRG0qbA/skzf
         qhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169007; x=1762773807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTiOq3s4Du2klSTxft/DNgygXTqBjyM4NTyZGqGWusY=;
        b=EvkPnvwwLEY0gYAc3LmlR5EgRB7P4GGmvORFsFESbdwVJfj430SSe8CWut/+OWT2Hd
         5rSsIAoFNzLXTRFBN6JYG0vKDDXizS071gmRFCSve/q/ynV4/r4ynLSAfTMGkpppEmAs
         IRaQAoy1gbbbpE44IXMu1T9gZKX87xzp44nlcIDkiEnuG3J3i3TOZ9pWbyi8prsvU8bk
         LAUNdBt+5H174msU06YQ/uLaaNW7vWeJT/f4AkKt0Q1/NJ4CFAomw3Od4/FVkb+l645L
         zReSIbdUNMoOeyie2NbTa0pAMnDKWVU4EqqzfHFcRyQSyNL0VOqwAW9i7GdLL948spGY
         adWw==
X-Forwarded-Encrypted: i=1; AJvYcCV2NisUac6uO6Ey0gdxv5TmPCefRpdP1nSoj84HYYbM6uzwkH33D6EgwEYNLtjFxRjNpo5/nxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNTKb4zrFLmIBc5oWGu263Na8aHN9U+PgzAKS4EAXe5kxPSFD
	zFbBTjvxPj6ZVgQxbrd+kDOuaL9aDCk8Y4TbBaWDze3FMEbG1TuSNPv+
X-Gm-Gg: ASbGncudPOpp7O2Y2XhEx7DDEZgQVl+c+ZydJwg0Cnjdgfjfxm7TwEi+bi5tPoPhK64
	K6rjaczQ26po5fkOLmQtg6j1XfrCgg7A8fj6kr2D1m7laNDVRtjZlt6MvZ1uFVolcQ/IcKBR1yj
	s92h6cIlRk4o626TDHBIA3QT8NMrQYCgHrJCEy6OYbm1uJ/5unaBFId10nSeWsrcwdSVt9p8Woa
	D0zpw87HXeLqtkf9k3WMfgsYhboJ2bGN88gsgy4mu7z1BFLcc2pdk+/nQW0eeJpnY3SZn9iqTt7
	yhUR6aTO+CWIoFx0xoVu7r7UB3gqcddpuvLYgNnebstY2WCAX9WDkek4TMzEZs8uatirGafG657
	fFTPG616Y9PMzI8S8a8VMaHVbSsNv8tCWOYvcgCrbc5VoSrPBmkUsXCdnx99VljWnlYOPwtryqg
	l8KrHmoIc88e2GbcT/7tSHibU=
X-Google-Smtp-Source: AGHT+IHSVTw67BWDPb21rBazTbhQ1l5vnr08OXapMWF6VsDckr7xusWomPoiAMolfRR8VzInf7Rdxg==
X-Received: by 2002:a17:906:3950:b0:b70:ac48:db8d with SMTP id a640c23a62f3a-b70ac48fb80mr408438566b.28.1762169006942;
        Mon, 03 Nov 2025 03:23:26 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm358534466b.8.2025.11.03.03.23.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 03:23:26 -0800 (PST)
Date: Mon, 3 Nov 2025 12:23:22 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guangshuo Li
 <lgs201920130244@gmail.com>, Wesley Cheng <quic_wcheng@quicinc.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
Message-ID: <20251103122322.5433a7a1.michal.pecio@gmail.com>
In-Reply-To: <11d7b29d-a45f-48e9-bff5-cb94150d0bdf@intel.com>
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
	<20251103094036.2d1593bc.michal.pecio@gmail.com>
	<11d7b29d-a45f-48e9-bff5-cb94150d0bdf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 13:02:06 +0200, Mathias Nyman wrote:
> > Hi Greg and Mathias,
> > 
> > I noticed that this bug still exists in current 6.6 and 6.12 releases,
> > what would be the sensible course of action to fix it?
> >   
> 
> Not sure this qualifies for stable.
> Is this something that has really happened in real life?
> 
> The stable-kernel-rules.rst states it should "fix a real bug that bothers people"
> 
> If kcalloc_node() fails to allocate that array of pointers then something
> else is already badly messed up.

I don't know how the reported found it, but it can obviously happen when
the driver is bound to a new xHCI controller under OOM conditions.

So maybe not very often, but xHCI hotplug is a thing in Thunderbolt and
OOM happens sometimes too, so it's not exactly impossible either.

I thought it's usual to fix such bugs when they are known.
Simulated allocation failure before/after:

[ +30,414603] xhci_hcd 0000:00:10.0: xHCI Host Controller
[  +0,000012] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[  +0,000159] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  +0,000004] #PF: supervisor read access in kernel mode
[  +0,000002] #PF: error_code(0x0000) - not-present page
[  +0,000002] PGD 0 P4D 0 
[  +0,000003] Oops: 0000 [#1] PREEMPT SMP
[  +0,000004] CPU: 1 PID: 4270 Comm: insmod Not tainted 6.6.113 #11
[  +0,000003] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[  +0,000003] RIP: 0010:xhci_add_interrupter+0x25/0x130 [xhci_hcd]

[  +0,042495] xhci_hcd 0000:00:10.0: xHCI Host Controller
[  +0,000012] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[  +0,007193] xhci_hcd 0000:00:10.0: can't setup: -12
[  +0,000010] xhci_hcd 0000:00:10.0: USB bus 2 deregistered
[  +0,000080] xhci_hcd 0000:00:10.0: init 0000:00:10.0 fail, -12
[  +0,000004] xhci_hcd: probe of 0000:00:10.0 failed with error -12

