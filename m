Return-Path: <stable+bounces-167071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B082FB21768
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB571A24EB3
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A42E2DCB;
	Mon, 11 Aug 2025 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWeluUKP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F02E5431;
	Mon, 11 Aug 2025 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947707; cv=none; b=Z1qAl1ciPCoHum8ttvzddf0fWE06T9seqw0oSFFAz5eaqapHm3bq7qpaWQgZI61ddcOZsij5TGxPKk7BTPfGw2NUHROhe66YIbgexOdAlLksHoHo880lvBZ/jyuJCppKTas+q3KuEhTLTZbtv1wMVEJ7F0Y5y+F5eQj/E78ffXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947707; c=relaxed/simple;
	bh=mpk27qrn0f9RHS7XKFScEMTU8qgUMeWZcJ6TqKsDXAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LutXb2H6HDgDBv80LjSma8Rc/B/CwbVQqOyQ2oh3pfeJFbo55SMaH9N6M7OmZj8u9HCGnAVYZrp1bW7A6AgpFU+60v15qQYp8v9C9pUZe6pRUF+ZQ/6eihYl6SA0tl23eofPFm7Q8nYXQrrEMkKHCqgcGLvFgeBi/glaIMk534g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWeluUKP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b8a0f36fcso5174453e87.1;
        Mon, 11 Aug 2025 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754947704; x=1755552504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpjIpzAPB0v7NxDZwwT0mjO9aLWv5i/E2Osu7tXQZqE=;
        b=TWeluUKP8yku/5f0YcFA76/18p8aTYwxUceWYPjU8lG6GvcXOkb2CBnOSganU9hLLQ
         wQsErbdXK/0tUeP9k6dLFvNShmqqcn7AZRy0NjsOhuEoIEazt7Lr8WnXg/pmompDNTQl
         ZplfGKOhj/gJH4pijD3jZkwFnl0TmOjmQ2A+k/fChpImWIlDqLuLeScefr+2fDTduR3R
         GFfzzmtBpaAroFB0DoU0UetJ1i3JoLaEFzBb80cbe8pHsOcbN2g+72JzUssQyUuwqOqA
         j5AwkN3Gpw8VJjJ4DS3S1nVkeyhsHnU5edm+Yiy9JlRQy5KNUFYJ0DQYnADhVtp/56oH
         OISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947704; x=1755552504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpjIpzAPB0v7NxDZwwT0mjO9aLWv5i/E2Osu7tXQZqE=;
        b=hSClbcTzjDcTL/Rp6BrbjFp7zM0x4jjtSwpewIys7bOm04ufBc4rwO2yl/o8Nph3VT
         hg5dU7itcPVHZakfy4a1oKXGDQILCKSrmeA/FBWwUXeMTzu8Y01osK7a3DgKKlw2AHTR
         APluOJKRB4QEZGJ4O3cJ2/pOpdxQVeLgFp92WzlTVXsWr/uSsODU42fWTaCq1o+6NCBF
         Rac9GBitgO1EqzJOHrLj+L2FbtNbs4ClSLpIox92sHVKXbfUCO/b5Ui9q4YnvIZhcxN9
         7tV7ZUcyR7LPvAgz3n10TC/tESBVsA1UTFEmFM5wVa/GU//qFqJNXA4e+7752GGxTsC8
         ddzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIkAIQakjZW4FtTZvF/W4FJvxGDCcxhDMl7vl6YupDZz0RiBvJXrqjA8WvYIUwcNhjSkFBAQcqD1w=@vger.kernel.org, AJvYcCWVwnfvTpztMlwdeLtT9oyVpePHZ9VOsm5vfBRKe1rjKoAokGO4Q0zunANTC6wHYYmKbvTwmgcB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5RHZTeliJgE4Q7KABupiEuT2zJFnVOlepXMSQPyoqrrwvTmo
	ln9d9ZnzVT3VfxfXToCgte1otyLwOuhHH+zM0WV5BvF76w5UH2Nu61lX
X-Gm-Gg: ASbGncvl2vRR6TsydNORmMQVZ9ZzY1T+LaNQOwyA3MPXaTVHTm2nBp/zWcdgEPWL24G
	l0S6Z4BG7nzSba/oLKWvbLSVNC/nL/ya5P0ijFG89nzZsr8Wzrh0Diqvg9SBDjT8dKCZHbAy8aG
	79uRFBbRliqe2yTjdkOfhmNRcIt74XAortNf866tzIei0tSsuSW341p0GUYp4LKEym9FZ+4difA
	/KzWzT/A6x4tAN8ahr9X6qJJf5rZWE53/Oxz6qtVZqeyEnXgVaj/YxxxZPRGFSV1haY/VDEMCkk
	XmO6+ErTdJTrBbLhIZaKLuUNIGfW8PoEccZIpCO8LR8cZHjVdScNIJDHdn1fCjKEF5BJHQU+4De
	94VmWs5qoAd0qqwPqiFfsGfXDOSGmU0QdcRc=
X-Google-Smtp-Source: AGHT+IGk+VTPIrnjQuog4v7TbkCyB00WQoWvYsPlYTExmUr1HajhxEL9dzSdsIBYJf8YaraRPtuZYw==
X-Received: by 2002:a05:6512:ea8:b0:55c:d617:a132 with SMTP id 2adb3069b0e04-55cd75b25f6mr383568e87.6.1754947703662;
        Mon, 11 Aug 2025 14:28:23 -0700 (PDT)
Received: from foxbook (bfd208.neoplus.adsl.tpnet.pl. [83.28.41.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cce15c650sm1083440e87.103.2025.08.11.14.28.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Aug 2025 14:28:23 -0700 (PDT)
Date: Mon, 11 Aug 2025 23:28:15 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu, stable@vger.kernel.org, =?UTF-8?B?xYF1a2Fzeg==?=
 Bartosik <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
Message-ID: <20250811232815.393c7bb9@foxbook>
In-Reply-To: <fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
	<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 08:16:06 +0200, Jiri Slaby wrote:
> This was reported to break the USB on one box:
> > [Wed Aug  6 16:51:33 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> > [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> > [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> > [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> > [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> > [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
> > [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> > [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: Device not responding to setup address.
> > [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: Device not responding to setup address.
> > [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: device not accepting address 12, error -71
> > [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: WARN: invalid context state for evaluate context command.
> > [Wed Aug  6 16:51:36 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
> > [Wed Aug  6 16:51:36 2025] [     C10] xhci_hcd 0000:0e:00.0: ERROR unknown event type 2
> > [Wed Aug  6 16:51:36 2025] [ T355745] usb 1-2: Device not responding to setup address.
> > [Wed Aug  6 16:51:37 2025] [     C10] xhci_hcd 0000:0e:00.0: ERROR unknown event type 2
> > [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: Abort failed to stop command ring: -110
> > [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: xHCI host controller not responding, assume dead
> > [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: HC died; cleaning up
> > [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-1: USB disconnect, device number 13
> > [Wed Aug  6 16:52:50 2025] [ T355745] xhci_hcd 0000:0e:00.0: Timeout while waiting for setup device command
> > [Wed Aug  6 16:52:50 2025] [ T362645] usb 2-3: USB disconnect, device number 2
> > [Wed Aug  6 16:52:50 2025] [ T362839] cdc_acm 1-5:1.5: acm_port_activate - usb_submit_urb(ctrl irq) failed
> > [Wed Aug  6 16:52:50 2025] [ T355745] usb 1-2: device not accepting address 12, error -62
> > [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-2: USB disconnect, device number 12
> > [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-3: USB disconnect, device number 4
> > [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-3.1: USB disconnect, device number 6
> > [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-4: USB disconnect, device number 16
> > [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-5: USB disconnect, device number 15
> > [Wed Aug  6 16:52:50 2025] [ T359046] usb 1-7: USB disconnect, device number 8  

Is the problem that this USB device fails to work, or that it takes
down the whole bus while failing to work as usual?

The latter issue looks like some ASMedia xHCI controller being unhappy
about something. What does 'lspci' say about this 0e:00.0?

So far I failed to repro this on v6.16.0 with a few of my ASMedias and
a dummy device which never responds to any packet.

Can you mount debugfs and get these two files after the HC goes dead?

/sys/kernel/debug/usb/xhci/0000:0e:00.0/command-ring/trbs 
/sys/kernel/debug/usb/xhci/0000:0e:00.0/event-ring/trbs

Regards,
Michal

