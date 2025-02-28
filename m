Return-Path: <stable+bounces-119970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EEA4A001
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20CE176F05
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380711F4CA0;
	Fri, 28 Feb 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBucXGUl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAF1F4C96;
	Fri, 28 Feb 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762717; cv=none; b=FD5tlL4Ts93St/e+PG3e44nY5XlCABBljJUR6+B0wxoBEpTSLcmPoNwQmGJgu9SEMCRlpEZ3LaKk/F728hqmWQyKklssFGzSRcEmRNomtH6gufwDhzSFKRM7kIDTCWAGFVk3sGDw4vhjhWc63k8d70SgMKoyIsjglQQbY5RnsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762717; c=relaxed/simple;
	bh=34GoB2luaawFWdu1l7ZA4a8soc8d3PcRfzxudMjW4xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpWWZRyyT3Z2u/AqyvHKnE8D8r177LElsvi5kVG9lEbIhloL7oEFi7Y832XSpqGANRH8Qn+S6AF+m+TgBflvCn4DJ6K8R36CE3jRx+NmxVc/kJIniHcYaD1BVfaK2MfxFDv4431e/FfJN1J6un0EWJY/wzEIi8kUcmFFq4yKnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBucXGUl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf45d8db04so61642766b.1;
        Fri, 28 Feb 2025 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762713; x=1741367513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6ets5aVNLOO0bxti3imRnUSklZXl6EEfSVuw5+1snM=;
        b=GBucXGUleTdGN8VnrJNl1gJtDe1+82sUO6iZOZG/D+YF3BHN0+M79XDytR6bcbWJfl
         2Ecf8yMon7her8cDQd94HoHlIU6oeVN0VkiJk7OkJJ052rf5EfOMLsblPNfLs3JSkqNx
         ivpOr02hptTd9bWvb9MwIss+WDPG99dA961AVXkGARctMpc2GrJiCfoPPVsdZ6mg+gRI
         ch4s0oRNGMZ0h0XTt1GE+0YuGmQHzaORPMpI5BA196/dWKiAnIs2MWwxmJZtWm/vIDn5
         Uiel7MVhebq1uShXnKbbZL4NXVGXp3wHKw8AlmJn1/ohJaEWNRwXOv/gQ/C8HiqKNMHg
         btKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762713; x=1741367513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6ets5aVNLOO0bxti3imRnUSklZXl6EEfSVuw5+1snM=;
        b=F7YVO8sH+JUJqVIQtBl3teLhhMw3rA853FEjVN5TDNW95VrLgK2SPHHUOsSq7Z+MCI
         V/Lv9agWjn1fu3/6KIy1WdsiqGWriYeLL7bSPM7jVuDqZ0ZSf0zDQWcE3KVWNWrsTsLx
         e3xeqjRyTD5oR99T2FMsZCFLCwwKJOvH1gWov6+nqSZ27SFfRBWoL5QMTKObWwl3J7/E
         Ar9Z/AjfDdjr7ptYJSR7dWyheyJTccZYY087YaEc6Wv303jiaLw1wTZ4ag1Mw+9gYsTT
         4ijpq1qzbWe2X4YfqDPOQP6+P9OIFFaRNePdUSvPAVhAfA0xJUTXhrTDXXoJNGNWjH9m
         Y7jg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Mg0vTEkzNfDYS+bosFkRbS1IHjEtcSlimN0r9WNO27wppIMOgFbI5pUKUIS8hHhprDqvABP9vEyy@vger.kernel.org, AJvYcCUrGJQmDieXYt3IJDXVy0blsLZlVjn43xnZXBhw0x/tbt/j/4WxxKObUadB2B5wOPfXV51j/OaJ+4cHcgc=@vger.kernel.org, AJvYcCVI9FvMhT7VTcIihBEhWOQQ6n1p4k3zmB1tfK++IqaXoNVwZRgLlYX/o145SKT5s7pF1quFGnm6@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjLhKi7kjCq1Q1dNf4gh34rWg/5Fe74oTq/d8i5hmdBp7McdS
	Zh2VGSd21caxMhN7L1GBno4WUE2YjQfaCLp8gGA6DLHNLGJTga38tq4HSw==
X-Gm-Gg: ASbGncvhYhNpE95rpgAILIdUD5285nZzsXxcAglR+fFKE5w+7REwCCiP12HwGKx0m6F
	sbWBUmarbL7dfAkoGCk6KTVedyjtf8CWecmwEe+8Za9E/cez84Dnk6K6YsePJ1yUVkMbmBW5NNd
	0Vq1NkhSJsb/BsSJFWkLajVL4K9tljIBlm222GG7bS5CdlHrUuwFvtt9+G23pprNYqvtXk15W+T
	xjZHLJsagU21ve8BS/tbrbZKVY3Na+Ra0MJv5JoeqkNGyN1bV1oPt+r5v86WyhRjC2lRFUTzHlE
	tjVq/RyMZH1UtH+w7MfWX6yPDHFy8B2dsL0E0e4N
X-Google-Smtp-Source: AGHT+IHZ3OgXJcoyK5UfrZxguUKxf5uKY3BVB81jJHZQfRIoF319w4NjdEB5itkEizbZibkQjuK/Mg==
X-Received: by 2002:a17:907:60d0:b0:ab7:f245:fbc1 with SMTP id a640c23a62f3a-abf261f9dffmr409006366b.3.1740762713099;
        Fri, 28 Feb 2025 09:11:53 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c74c766sm315767266b.127.2025.02.28.09.11.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Feb 2025 09:11:52 -0800 (PST)
Date: Fri, 28 Feb 2025 18:11:46 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Kuangyi Chiang <ki.chiang65@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error
 reporting by Etron HCs
Message-ID: <20250228181146.5188fcdb@foxbook>
In-Reply-To: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
References: <20250205234205.73ca4ff8@foxbook>
	<b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
	<20250210095736.6607f098@foxbook>
	<20250211133614.5d64301f@foxbook>
	<CAHN5xi05h+4Fz2SwD=4xjU=Yq7=QuQfnnS01C=Ur3SqwTGxy9A@mail.gmail.com>
	<20250212091254.50653eee@foxbook>
	<41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 18:13:50 +0200, Mathias Nyman wrote:
> On 12.2.2025 10.12, Micha=C5=82 Pecio wrote:
> > Maybe I will seriously look into decoupling giveback and dequeue ptr
> > tracking, not only for those spurious Etron events but everywhere.
> >=20
> > Mathias is right that HW has no sensible reason to touch DMA buffers
> > after an error, I will look if the spec is very explicit about it.
> > If so, we could give back TDs after the first event and merely keep
> > enough information to recognize and silently ignore further events.
> > =20
>=20
> This issue was left hanging, I'll clean up my proposal and send it as
> a proper RFT PATCH.

I think it would be more pragmatic to have 'next_comp_code' instead of
'last_comp_code', because then you don't need this new helper function
which basically duplicates the switch statement from process_isoc_td().

And as long as Success is the only 'next_comp_code' supported, it can
be a simple boolean flag. So, basically, rename 'last_td_was_short' to
'expect_success_event', set it in process_isoc_td() and that's all.


What are your thoughts about killing error_mid_td completely and using
a similar mechanism to deal with those final events?

1. The events would be taken care of.

2. It should be OK wrt DMA, because the HC has no reason to touch data
buffers after an error. Short Packet is done this way and it works.

3. A remaining problem is that dequeue is advanced to end_trb too soon
and "tail" of the TD could be overwritten. Already a problem with Short
Packet and I think it can be solved by replacing most xhci_dequeue_td()
calls with xhci_td_cleanup() and adding to handle_tx_event():

    ep_ring->dequeue =3D ep_trb;
    ep_ring->deq_seg =3D ep_seg;


Regards,
Michal

