Return-Path: <stable+bounces-183486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9888BBEFA4
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 20:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82D984F1960
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E42D7DC1;
	Mon,  6 Oct 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PujDmGmS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC25246BC5
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775563; cv=none; b=JdO+1d+BVM9ucs3/kiNBS8JoOwDWW0kgzuulgkFlALnXMLJOc4EDLeBJNr+p92tPLq6JpPD1rP5Kshts4Ehwr0QYGvW4r6Fk7E+Gu4ZpW7NeU7Vr/3f5xHSYHR0wYURsTHPShXFYxoiC8g25xnYXeneYYw5WIYjtlbtW54blvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775563; c=relaxed/simple;
	bh=Dj6m4vh4I+aSGB7esG1Hx/YYkGrqbAo4J1raPd5acaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAAkv58KzcmNP19spfaB2Mqc0z0D3oYktRRtjj2WcfrfhQ3/Ujm56Kb4++Jko4G6/FkvpZjxpqcpJRX5Gd4hphscNMn6bwELRTkglOnZYfhJ8oEp0YGGs9HaGRowRp9Id5VXeZxpu9lC0oYzkRYUP3FLo0TJ83GLY5/vb9A6Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PujDmGmS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698384978dso37952755ad.0
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759775561; x=1760380361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwSuYHyPWLnd4B0J2NLg4Ynddq4RJZuyBAc+JpL56Y0=;
        b=PujDmGmSuclp/MSAl7Ki7Ge2233hL8EypmdA+14CW5MM6nNOSsqeebkCSafiFVoVVr
         ANxVwvxEH/JfPgFzT4W8KOUCtVzVQlIDpM7LdWCSJO1Bk3gFsThmrIy4jHrhQe4HpFzZ
         95gfPN844C3T4D2sbVqAsh6DRbIHZXw7pgYng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775561; x=1760380361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwSuYHyPWLnd4B0J2NLg4Ynddq4RJZuyBAc+JpL56Y0=;
        b=kdif55tpr7cVdfAE5BieOdEUPC4vL49ptFi9UVQmqLE5wo/qIYPQHhxUnfr4I4LNcD
         Yyf+u5dAtwkId4UMgFLIm+iMADKR6cvZYrHol/D17g1RII23Gw/l38Rlc0nRJmqfKvNC
         mZWVlOIE0y/Qws+SdDWQ+KbSU1BJDY0ndHjDGTDb5l9EpetMWV5Nv4uMhiSxy8JBEYDo
         AUrQWaE+AUGINkTev+DuN2VgQ5cM3E0ESCqTBASHqv5MnY1rnt3puRsSc0x/0xDQZVrw
         al7BHBBWwSepUbGIgCNIJKLlEXvXrFvWVOjuwnwRw5C9L8N3AQdP4y0F2YFjUxvM6+lA
         CsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+qZgGC1vXDWQPgnXuOJ/bEc1bl9A7knpD4ROv6wB6kLf/QP5CwVzTk+Lb6EdFDUe7Kx9BrsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeymgbhGYWt7+haKxBwrdUR+Huw8dodlGMlZJbu1qxxGZm9TZU
	l/h/slmZ8CuJ3MQj8o2TJe5rxSUlNUIQGgiAGcoWXrU6KC+FPKgxQp0s2KlidzzTAQ==
X-Gm-Gg: ASbGncu6xIidd+OZyE1QfCrtDUdVtV8Ag5IPHzh+GwBrjWJ4+SeXTa+GTToFTcqbo2E
	F/gaBOwPtJVXDVozYTwEKTfZUgc0z9Qn6lLVd97ZyswxW92Pu2+haZilNVWhVPenGphznyxQ1eY
	pFQDNiEcw2Vo46Yji77X6cJKeHRE2X45roeipFTA+S2XTkRnRZqjOBWm6cacuDUctuxLmkcsiAm
	BlYFN2c10Qjqe8asEG+SpNNY5C6gSzexxgF3F/m+1kRsLCVf5OG7hIMkP8U8tTUHhy8RKLEGotk
	OM0TgYxofbwqrSC1O1dvC+5gpfYKHw9KWvn9EKPjeuS3rAIpirkpDfKOvD3tywp2WkWnWkGmVfc
	3DafWVyJctjyZyFaVJSdVeLr51Q1c3Jy4ZzTFtuV3tt18XXbxqDCFQ6CVeSXWXWJiTlZ/wN07Tw
	Myz9yxiYGc3ZuQ/Vh0mwk=
X-Google-Smtp-Source: AGHT+IHyUh9+Wdk2VWGp0HemaJgNqqUfeJ8XAjYRPDqgSqGja/q3alk2W+weivII4Y0JLs+WqyHOXQ==
X-Received: by 2002:a17:903:3c65:b0:269:8072:5be7 with SMTP id d9443c01a7336-28e9a6654c0mr169220315ad.56.1759775560991;
        Mon, 06 Oct 2025 11:32:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:299e:f3e3:eadb:de86])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1108c5sm140090835ad.16.2025.10.06.11.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:32:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:32:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <aOQLRhot8-MtXeE3@google.com>
References: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
 <20251006135222.GD2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006135222.GD2912318@black.igk.intel.com>

Hi Mika,

On Mon, Oct 06, 2025 at 03:52:22PM +0200, Mika Westerberg wrote:
> On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > When transitioning to D3cold, __pci_set_power_state() will first
> > transition a device to D3hot. If the device was already in D3hot, this
> > will add excess work:
> > (a) read/modify/write PMCSR; and
> > (b) excess delay (pci_dev_d3_sleep()).
> 
> How come the device is already in D3hot when __pci_set_power_state() is
> called? IIRC PCI core will transition the device to low power state so that
> it passes there the deepest possible state, and at that point the device is
> still in D0. Then __pci_set_power_state() puts it into D3hot and then turns
> if the power resource -> D3cold.
> 
> What I'm missing here?

Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
when preparing for runtime or system suspend, so by the time they hit
pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
may still pick a lower state (D3cold).

HTH,
Brian

