Return-Path: <stable+bounces-10627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014BA82CAD7
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5E71F22034
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC36A38;
	Sat, 13 Jan 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iU4X9vm9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5C7FF
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 09:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D471C433F1;
	Sat, 13 Jan 2024 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705138478;
	bh=abM8MftUK4btKJFINGz6Dcuc+KVKchGDYzGhsNNEImg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iU4X9vm96z4ELSPtd4uCwjVOhjlxV/Vtq7rudDOwB7nfyIth2NSF3D2P9zjV82O4Q
	 GhZZYrlR4/pFfTbBZ0GXs/MBGfdHCoCHnBo2USHhlrodqAN2E4/UGdOoB31WQMKSld
	 AaVZn1m7leDrcmMlPLQPhEcE8NtEv3gtmBqhbroA=
Date: Sat, 13 Jan 2024 10:34:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: John Sperbeck <jsperbeck@google.com>, Bean Huo <beanhuo@micron.com>,
	Sagi Grimberg <sagi@grimberg.me>, khazhy@google.com,
	stable@vger.kernel.org
Subject: Re: Crash in NVME tracing on 5.10LTS
Message-ID: <2024011314-debtless-clunky-ea56@gregkh>
References: <20240109181722.228783-1-jsperbeck@google.com>
 <2024011150-twins-humorist-e01d@gregkh>
 <CAFNjLiVJ0OKp7kKsNTr-mCJvG+dkYis2F1fE==Fhz65eZfT+aQ@mail.gmail.com>
 <eec063eb-853a-40ac-b0f6-ce14da5b3c6a@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec063eb-853a-40ac-b0f6-ce14da5b3c6a@kernel.dk>

On Thu, Jan 11, 2024 at 12:38:03PM -0700, Jens Axboe wrote:
> On 1/11/24 10:00 AM, John Sperbeck wrote:
> > On Thu, Jan 11, 2024 at 1:46?AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Tue, Jan 09, 2024 at 10:17:22AM -0800, John Sperbeck wrote:
> >>> With 5.10LTS (e.g., 5.10.206), on a machine using an NVME device, the
> >>> following tracing commands will trigger a crash due to a NULL pointer
> >>> dereference:
> >>>
> >>> KDIR=/sys/kernel/debug/tracing
> >>> echo 1 > $KDIR/tracing_on
> >>> echo 1 > $KDIR/events/nvme/enable
> >>> echo "Waiting for trace events..."
> >>> cat $KDIR/trace_pipe
> >>>
> >>> The backtrace looks something like this:
> >>>
> >>> Call Trace:
> >>>  <IRQ>
> >>>  ? __die_body+0x6b/0xb0
> >>>  ? __die+0x9e/0xb0
> >>>  ? no_context+0x3eb/0x460
> >>>  ? ttwu_do_activate+0xf0/0x120
> >>>  ? __bad_area_nosemaphore+0x157/0x200
> >>>  ? select_idle_sibling+0x2f/0x410
> >>>  ? bad_area_nosemaphore+0x13/0x20
> >>>  ? do_user_addr_fault+0x2ab/0x360
> >>>  ? exc_page_fault+0x69/0x180
> >>>  ? asm_exc_page_fault+0x1e/0x30
> >>>  ? trace_event_raw_event_nvme_complete_rq+0xba/0x170
> >>>  ? trace_event_raw_event_nvme_complete_rq+0xa3/0x170
> >>>  nvme_complete_rq+0x168/0x170
> >>>  nvme_pci_complete_rq+0x16c/0x1f0
> >>>  nvme_handle_cqe+0xde/0x190
> >>>  nvme_irq+0x78/0x100
> >>>  __handle_irq_event_percpu+0x77/0x1e0
> >>>  handle_irq_event+0x54/0xb0
> >>>  handle_edge_irq+0xdf/0x230
> >>>  asm_call_irq_on_stack+0xf/0x20
> >>>  </IRQ>
> >>>  common_interrupt+0x9e/0x150
> >>>  asm_common_interrupt+0x1e/0x40
> >>>
> >>> It looks to me like these two upstream commits were backported to 5.10:
> >>>
> >>> 679c54f2de67 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")
> >>> e7006de6c238 ("nvme: code command_id with a genctr for use-after-free validation")
> >>>
> >>> But they depend on this upstream commit to initialize the 'cmd' field in
> >>> some cases:
> >>>
> >>> f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
> >>>
> >>> Does it sound like I'm on the right track?  The 5.15LTS and later seems to be okay.
> >>>
> >>
> >> If you apply that commit, does it solve the issue for you?
> >>
> >> thanks,
> >>
> >> greg k-h
> > 
> > The f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
> > upstream commit doesn't apply cleanly to 5.10LTS.  If I adjust it to
> > fit, then the crash no longer occurs for me.
> > 
> > A revert of 706960d328f5 ("nvme: use command_id instead of req->tag in
> > trace_nvme_complete_rq()") from 5.10LTS also prevents the crash.
> > 
> > My leaning would be for a revert from 5.10LTS, but I think the
> > maintainers would have better insight then me.  It's also possible
> > that this isn't serious enough to worry about in general.  I don't
> > really know.
> 
> Either solution is fine with me, doesn't really matter. I was wondering
> how this ended up in stable, and it looks like it was one of those
> auto-selections... Those seem particularly dangerous the further back
> you go.

Now reverted, thanks.  But note, that commit does say it fixes an issue
this far back, which is why it was applied.

greg k-h

