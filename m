Return-Path: <stable+bounces-144977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4AABCAE9
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 00:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6907189906B
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 22:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797521421E;
	Mon, 19 May 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju3T1VgD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCC1552E0;
	Mon, 19 May 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693930; cv=none; b=fdCi46trSGiBtSQ2XjD8BlfV5HVDc658e35NVroCXM/60sxsABbM/ubv2BVkTpCoDIt56EBS5ruWc/s2hEfw0dJu6RNkTmhcpJAUML3u0tgIifAOSO670PQ6WwPUSKEz1V7Y6Cop41l2sezNEhZ7Df5+HsIg+PuPFH61EGjbI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693930; c=relaxed/simple;
	bh=ypJXToy2vgtGqOOQIR3W3J1R+zAn3GN4eWGnrapbfb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xf5AAb0gJqkUrrFLwMoFgNvRKafAEE7MymFQA2x6o373nZOcaUjd/qrMLjJJhPtw1Cij4Yobf7RpcUagdc6gIr8znxhhH2QxtulD+eL39jBDnItWNBx2JqV/56EWOqKEbutTpyzQYYxGCG0swrT0IhInL66pWn/IGU1wD7IEHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju3T1VgD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so6291553e87.1;
        Mon, 19 May 2025 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747693927; x=1748298727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPgoGD4mfiKg7wSy3nd78LkGhoTM3C7+Sd8OwYTqByM=;
        b=Ju3T1VgDBiX5PiBQiH4JUzri4TVHZPr5vCM3fXojoN9wApduCIW/rl/CdNh5E9NYoG
         7n5YXYXOtHeJFE4PO1w0hVJL4kWHtMBXSbHjjmjLeQSGRxBIUAzhw7UWQbrVrLVqy2bo
         HtzOXlCaWV4lUkTlXhVOWwyHHdKv4kDM9+GDd/ERCUxFgYi+Vam1UJzS/GXVh01RPk8M
         hyzgleLAUy3m4Ff+6RRPRSu3sV/rWUnndP6B9a9G2TQ7LBKGpHeoGCUp7y1UxLtsGLGk
         36TQM3zKRp7aHMvNO/W3OswDHFPOIH0ER7W8K6AIpINI4tz9ctKBwHTP2cR7fdMnBnWa
         RL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747693927; x=1748298727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPgoGD4mfiKg7wSy3nd78LkGhoTM3C7+Sd8OwYTqByM=;
        b=DJ7I6HOIL/fTXCF7lfugQHy73kUpdKUHvqERbEokqSaE4GOW5a+M9LJQfliZZWPLyB
         AQYABW4NhEFQrdOfa40FFmLFEQOhO6lokWWqxfb6fTH2080xjvz9UfXbLjMbaYUXejhW
         ccjiDh9cq3XG9W780UB2Ndn01Ugfgyx4b7/Zl715U2ig4VbJjO8DZoc5wAY+iBUOvjmg
         Ib+ES1MGHphdVZgXpkNxCOb37AI43YVfN+qgfTw2BtAcl1ZtKdhpElEWmApUrhTjeQIc
         QajbWbNPscIoNaykiAkiMkXi0GdI2ma7Xd/IOOyb4aX4LpGE57Nms2QunhH4qFTeBG/t
         jhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYv4LPOQzjXnCMXYk2hkdWQ+KlC89liPSN8YDKPZ8psZPTOoWvy+dOvxKR/DGy28BPqT95fIDd@vger.kernel.org, AJvYcCVNX6P1j7+sN6vW1l3KmArnNVJFpUn5T8hcGI7XNfGl7ajcq9TzcTpaJCs6NNRyALPff7jwEko3NSwX@vger.kernel.org, AJvYcCX8E3fOYcEOqzlDWyY01dPjQqI2M4dkQxEiM1aT9pOP7R6MFDGvyzPGdTVjxUgCGMevzJpFGk0JgWi9wMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7zxq1xLxpXqglhNUO6pYxeOSMVto4A55wg+baiP+S13imwn5
	5GkRgPgLInx7WGWnSCtLWHeuqQiomwc+dFIjC1LEOnSIQlWs2VELcVKG
X-Gm-Gg: ASbGncuT5iZPaIeobhnWORk+yFxa6L0BXpFFm/2dlpQgunsa5cgUUS0xkwV8ej70xKS
	BaWHFWPAE4T0NovfmFfLulgyE9jcj2jjUuOq5a3rTlckomVE3w+qYhXIyU8viTz794seGnpH2Db
	X7R7SAIKTz2aoborl/N42jgrGZZkwSNk7Bot7YO1jMV2DI1ZSNOosqprPFhQO4TpZ4lFIX+rAOp
	l2DbpevY4aL8RAWcMBQcXWBSzPza2pPPIGNh33doL3HiV1G3L1wmsukGFe7VMBDiCXwFl5ihLKS
	7d4yEKW+IdbdgOavup8p1E98/jKM3cLgyUBsd/ejI4+BXJDgtV2b7dmrRHVFDG78hUA0
X-Google-Smtp-Source: AGHT+IH2nem1x0cfEiINMWoZp/EFEUq+NhlMhQkahCPgi58UyfE8meqY3ZTLVHKA6No2SKKepvX5ig==
X-Received: by 2002:a05:6512:290f:b0:549:5b54:2c68 with SMTP id 2adb3069b0e04-550e71d0cd8mr4564560e87.22.1747693926765;
        Mon, 19 May 2025 15:32:06 -0700 (PDT)
Received: from foxbook (adqk186.neoplus.adsl.tpnet.pl. [79.185.144.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f16363sm2044013e87.34.2025.05.19.15.32.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 May 2025 15:32:06 -0700 (PDT)
Date: Tue, 20 May 2025 00:32:01 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Roy Luo
 <royluo@google.com>, mathias.nyman@intel.com, quic_ugoswami@quicinc.com,
 Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "usb: xhci: Implement
 xhci_handshake_check_state() helper"
Message-ID: <20250520003201.57f12dff@foxbook>
In-Reply-To: <CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com>
References: <20250517043942.372315-1-royluo@google.com>
	<8f023425-3f9b-423c-9459-449d0835c608@linux.intel.com>
	<CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 23:43:21 +0530, Udipto Goswami wrote:
> Hi Mathias,
> 
> From what I recall, we saw this issue coming up on our QCOM mobile
> platforms but it was not consistent. It was only reported in long runs
> i believe. The most recent instance when I pushed this patch was with
> platform SM8650, it was a watchdog timeout issue where xhci_reset() ->
> xhci_handshake() polling read timeout upon xhci remove.

Was it some system-wide watchdog, i.e. unrelated tasks were locking up?

It looks similar to that command abort freeze: xhci_resume() calls
xhci_reset() under xhci->lock, and xhci_handshake() spins for a few
seconds with the spinlock held. Anything else (workers, IRQs) trying
to grab the lock will also spin and delay unrelated things.

Not sure why your commit message says "Use this helper in places where
xhci_handshake is called unlocked and has a long timeout", because you
end up calling it from two places where the lock is (incorrectly) held.
That's why adding the early bailout helped, I guess.

> Unfortunately I was not able to simulate the scenario for more
> granular testing and had validated it with long hours stress testing.

Looking at xhci_resume(), it will call xhci_reset() if the controller
has known bugs (e.g. the RESET_ON_RESUME quirk) or it fails resuming.

I guess you could simulate this case by forcing the quirk with a module
parameter and adding some extra delay to xhci_handshake(), so you are
not dependent on the hardware actually failing in any manner.

> Full call stack on core6:
> -000|readl([X19] addr = 0xFFFFFFC03CC08020)
> -001|xhci_handshake(inline)
> -001|xhci_reset([X19] xhci = 0xFFFFFF8942052250, [X20] timeout_us = 10000000)
> -002|xhci_resume([X20] xhci = 0xFFFFFF8942052250, [?] hibernated = ?)
> -003|xhci_plat_runtime_resume([locdesc] dev = ?)
> -004|pm_generic_runtime_resume([locdesc] dev = ?)
> -005|__rpm_callback([X23] cb = 0xFFFFFFE3F09307D8, [X22] dev =
> 0xFFFFFF890F619C10)
> -006|rpm_callback(inline)
> -006|rpm_resume([X19] dev = 0xFFFFFF890F619C10,
> [NSD:0xFFFFFFC041453AD4] rpmflags = 4)
> -007|__pm_runtime_resume([X20] dev = 0xFFFFFF890F619C10, [X19] rpmflags = 4)
> -008|pm_runtime_get_sync(inline)
> -008|xhci_plat_remove([X20] dev = 0xFFFFFF890F619C00)
> -009|platform_remove([X19] _dev = 0xFFFFFF890F619C10)
> -010|device_remove(inline)

