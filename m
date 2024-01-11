Return-Path: <stable+bounces-10528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C082B38E
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15D5B21418
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542385100C;
	Thu, 11 Jan 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HW3IaXw8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D551013
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso13684a12.0
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 09:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704992454; x=1705597254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVpHmRU4t7msu8p8UIFuWi7e+gfkGhiO1WXPb0mMfbs=;
        b=HW3IaXw8BMlWitp8ap2t9490M9Xd8WL4B0G4s5i3vlaVU8gadCgnva/MgehpIhLExe
         bplbBK/oKMmLr9KDewjzT5KV4XGTV523pHARyc1nA/I1fmu2XffvupEXitEEEgiLgZiC
         v87nv7/jIEiuqHPmQYZJskxcRar8q6vCSzYNdswNORXxxNVHySEauAOpKK8XaqRiMDBz
         LeurCGdZrzseoTS8NzjKVZfdQB2pNoPsr1HkcFzMv9RenP0nuv4K3prLnyRdYxeueITl
         XfPNDOCqEIGqY4FqtCd+eD4RsBnghKrDhpzvFD0xmdW8dkqwlA7xKsBgEPY2xnadwzVb
         Om1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992454; x=1705597254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVpHmRU4t7msu8p8UIFuWi7e+gfkGhiO1WXPb0mMfbs=;
        b=MpW1i891VwC1R01fQN070fcOooVbfzUrG8J98lKwoq9jYo+j9mP2ku3HmCYLkjlKYm
         uhI+2n8EGhE7T0gsfvilDk89J+u3l9Y+eJjMKuNljV9Da3MrkTb4NtRdWTgcaqmKO6kh
         d3LANWA6xajVyEN7+1IaHsvagin1gzCst1xjZ+EtVcobsqS0bPpp7TBQp3Y88pX4VOqs
         vK7GecekaIc59Q1lCRyYGJQLBIZSCyI/GxTnAwhUqOla9EVLKVc7Dg98K63aAv5Mw77W
         9y9ElsXj5Dw5CSnmTFjaZ1tJ3Vl2Y4aKN3gJT0agaYmhKRfUYU6T/y8Gk0cLp+pY4iKy
         DAvQ==
X-Gm-Message-State: AOJu0Yx678TnN1p2WGHLtwdLp3I2jn6xAueh7clTcGi+DwfctUFthxhT
	R7+Cv3hQ53K/2AuPjUpW8iSdLZWRqjfOyyBSYx4lOxJDFdab
X-Google-Smtp-Source: AGHT+IECGVU7ifFt3/CmGLptso4Zf2qxVEwZRmCovmC2Vw55bATpEcsLBqx7fiNcGtd9gI97Ova2aMGEu0KwCiGIgrY=
X-Received: by 2002:aa7:c411:0:b0:558:b501:1d2a with SMTP id
 j17-20020aa7c411000000b00558b5011d2amr58381edq.6.1704992453633; Thu, 11 Jan
 2024 09:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181722.228783-1-jsperbeck@google.com> <2024011150-twins-humorist-e01d@gregkh>
In-Reply-To: <2024011150-twins-humorist-e01d@gregkh>
From: John Sperbeck <jsperbeck@google.com>
Date: Thu, 11 Jan 2024 09:00:40 -0800
Message-ID: <CAFNjLiVJ0OKp7kKsNTr-mCJvG+dkYis2F1fE==Fhz65eZfT+aQ@mail.gmail.com>
Subject: Re: Crash in NVME tracing on 5.10LTS
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bean Huo <beanhuo@micron.com>, Sagi Grimberg <sagi@grimberg.me>, khazhy@google.com, 
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 1:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jan 09, 2024 at 10:17:22AM -0800, John Sperbeck wrote:
> > With 5.10LTS (e.g., 5.10.206), on a machine using an NVME device, the
> > following tracing commands will trigger a crash due to a NULL pointer
> > dereference:
> >
> > KDIR=3D/sys/kernel/debug/tracing
> > echo 1 > $KDIR/tracing_on
> > echo 1 > $KDIR/events/nvme/enable
> > echo "Waiting for trace events..."
> > cat $KDIR/trace_pipe
> >
> > The backtrace looks something like this:
> >
> > Call Trace:
> >  <IRQ>
> >  ? __die_body+0x6b/0xb0
> >  ? __die+0x9e/0xb0
> >  ? no_context+0x3eb/0x460
> >  ? ttwu_do_activate+0xf0/0x120
> >  ? __bad_area_nosemaphore+0x157/0x200
> >  ? select_idle_sibling+0x2f/0x410
> >  ? bad_area_nosemaphore+0x13/0x20
> >  ? do_user_addr_fault+0x2ab/0x360
> >  ? exc_page_fault+0x69/0x180
> >  ? asm_exc_page_fault+0x1e/0x30
> >  ? trace_event_raw_event_nvme_complete_rq+0xba/0x170
> >  ? trace_event_raw_event_nvme_complete_rq+0xa3/0x170
> >  nvme_complete_rq+0x168/0x170
> >  nvme_pci_complete_rq+0x16c/0x1f0
> >  nvme_handle_cqe+0xde/0x190
> >  nvme_irq+0x78/0x100
> >  __handle_irq_event_percpu+0x77/0x1e0
> >  handle_irq_event+0x54/0xb0
> >  handle_edge_irq+0xdf/0x230
> >  asm_call_irq_on_stack+0xf/0x20
> >  </IRQ>
> >  common_interrupt+0x9e/0x150
> >  asm_common_interrupt+0x1e/0x40
> >
> > It looks to me like these two upstream commits were backported to 5.10:
> >
> > 679c54f2de67 ("nvme: use command_id instead of req->tag in trace_nvme_c=
omplete_rq()")
> > e7006de6c238 ("nvme: code command_id with a genctr for use-after-free v=
alidation")
> >
> > But they depend on this upstream commit to initialize the 'cmd' field i=
n
> > some cases:
> >
> > f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
> >
> > Does it sound like I'm on the right track?  The 5.15LTS and later seems=
 to be okay.
> >
>
> If you apply that commit, does it solve the issue for you?
>
> thanks,
>
> greg k-h

The f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
upstream commit doesn't apply cleanly to 5.10LTS.  If I adjust it to
fit, then the crash no longer occurs for me.

A revert of 706960d328f5 ("nvme: use command_id instead of req->tag in
trace_nvme_complete_rq()") from 5.10LTS also prevents the crash.

My leaning would be for a revert from 5.10LTS, but I think the
maintainers would have better insight then me.  It's also possible
that this isn't serious enough to worry about in general.  I don't
really know.

