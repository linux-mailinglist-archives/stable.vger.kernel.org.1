Return-Path: <stable+bounces-196921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7CC85F2B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 17:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D7F3B4859
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578423A566;
	Tue, 25 Nov 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m8pqydK0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B3235045
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087638; cv=none; b=P7y0i6WzF2Bahlu7CarDeCctfh93iaeRhbV3T8PuD+rkzg2dBDJDgiazI1YU+uMokqtXo+daB51KhZK3mEUyb+EgA+dIxPNQtz7Zid+h2NLX05FcWuebTFkcWaK5GmqXqoPdSs85DtGr9l1ky+y3zShC+2V3wlaQS2IN979GP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087638; c=relaxed/simple;
	bh=eJ/IMjGulEI8QmjGtE/6iZTat616jmFMM5GjWfzZprc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSfT7EdpaobOJ5fiPSWOhwWJqs9bipHa19KioVcCp5KX7+7S9dkS/BXBVYf12wcz2KeTDUGKfli0yzcSJoLnJVH9m/FAIc8OXQJKcYNhEAPtvI/XGuGqWmijJ9T/dR7IUMF7vJvhaV27flZD1GEmRxlI0Vy2hkE2JUwlzb3fMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m8pqydK0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso3111503a12.0
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 08:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764087636; x=1764692436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ1eFsM5Tf65QYOWpuLGzqCys5d89vyL8hwXtzNFx0s=;
        b=m8pqydK0/1LM6RTMUJvo+Lm3LHPrxyJXdiNi3oFhWUuWyOlgAAnHbngCi1KaFd9Qcv
         QyzDY9yCXkm6dRagxrM8eAkx5/kaVPhSIpYdAkO9Uw/Pi3uo7I7Me1h/HGkXaTGGp2z6
         byf69FIKY5rw7CVMKl5Kze6fR4g5A+tcMHXIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087636; x=1764692436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ1eFsM5Tf65QYOWpuLGzqCys5d89vyL8hwXtzNFx0s=;
        b=fVkeIZ6wK2nuWkK+LQPFx7HdWVRj+H3pXxa/CB/nfMdDiBdeK0BOUTiFew3fWWqs7P
         N0aJ52oR5ZyZj9N/uLGwMUhPlFUzbpDeghk6WNEq0WCJ36QUsC8cdEgiFmDp5XVbQUM0
         goYuN8jMiTPBiswuvElOW+vL8Pa09MLXtPyqwQXSm2EvXmvRdWe6q+qKdanN7yUqtfEk
         wAH2J3WISSF5gz4C3I7CrKoF3lPx0RhCT1esDJFi/v6R9T4iS8anFgiUeQGfdSjis8GH
         gN/XpDlc2qQOZKRzrkv/vHBjEu5cmDlaO2Uy4tHkWwt/zlU8jHFiZJXXrx21RaYfw/AL
         YzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCaQ/mnJTTWnhObFyUvoXsfgxEKkjdubSY7BFeL9jY/JPR/bdaOzbapMg0EX1cz3FpnC4HeyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygR2WK4GEOqTaU7vANLHMDqL13RX6b1bX42e9P+XTRIUoKPAwJ
	w+324CtdE4OWLSeciP2QFXoz+ZU89Qn28TboYnfLjo/D9fkwsqf4Qh0pWnqJ9Xkp+w==
X-Gm-Gg: ASbGncsH91SR8ugjiRke5h6eZMlU7Yscvck5TX/4xTlYaGU5/1rmn6fH/1gy55czNzR
	kQEM6PB9JE544t9i8Uuv1CTzV4n77Tz4ae5MZ/lE5Aat+4CprrctnrJwb9QXJCdZHXHGoQTXPnZ
	/SnKDIMJItNP7W/G1NrPRzMrpFqrlCZDHS8BzsyxijTM7zGaTC4kNrGIQLAcIgJPLzBP9tvRsZ5
	rTCkKNY7yDezLt6sNs4KZQC8KaocGOn97TZNLBLys8dx814wYusAXcSzBLsF+vHHYb8KunThjEx
	/SwmUi6WToBv1lX572WvZpMkwPY7J5qQ3TQ1RvvnLaFkdql4eKG6CTJGxG3fQ64ajLB7kiwa0Mo
	VVlvWLQJ7r5U/vQgFM2Zxrf9T6GCa5ldM5OAfCSQzRPVbLlFzBJX6p5025ozE3GjFZ1JlbhBQs/
	UaZCpvlysVO1GShVcIEWgDsvGA/Zlc80VaxMF+LNXS0A2ARRDkXA==
X-Google-Smtp-Source: AGHT+IHbxub078qD6r8lEEf/qWg01tDyiVQO7hyfzM7kwN7R7kHugcJNQAoH42YI5h55+GaIaK5kUQ==
X-Received: by 2002:a05:693c:600f:b0:2a4:7352:dab1 with SMTP id 5a478bee46e88-2a71a127485mr10175866eec.36.1764087635917;
        Tue, 25 Nov 2025 08:20:35 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:62e0:9ddd:dee9:122b])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a93c5562b2sm13362986eec.3.2025.11.25.08.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:20:35 -0800 (PST)
Date: Tue, 25 Nov 2025 08:20:34 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <aSXXUmfy77ZAiShd@google.com>
References: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>

On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> When transitioning to D3cold, __pci_set_power_state() will first
> transition a device to D3hot. If the device was already in D3hot, this
> will add excess work:
> (a) read/modify/write PMCSR; and
> (b) excess delay (pci_dev_d3_sleep()).
> 
> For (b), we already performed the necessary delay on the previous D3hot
> entry; this was extra noticeable when evaluating runtime PM transition
> latency.
> 
> Check whether we're already in the target state before continuing.
> 
> Note that __pci_set_power_state() already does this same check for other
> state transitions, but D3cold is special because __pci_set_power_state()
> converts it to D3hot for the purposes of PMCSR.
> 
> This seems to be an oversight in commit 0aacdc957401 ("PCI/PM: Clean up
> pci_set_low_power_state()").
> 
> Fixes: 0aacdc957401 ("PCI/PM: Clean up pci_set_low_power_state()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

I'd like to know the status of this patch, with the merge window
approaching. It sounds like people agreed it fixes a confirmed
regression. I also don't think the request to remove all power state
management from all drivers was a reasonable one.

Brian

