Return-Path: <stable+bounces-72764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADE39694DB
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 09:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37020285147
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 07:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8101DAC49;
	Tue,  3 Sep 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="STnHriJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136CD1D6194;
	Tue,  3 Sep 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347397; cv=none; b=dONOaUd+/kte/Hk2v9pO/yTEKJ7+7dln7hy5Td7wGnaZetTHkdIMJCpTXOkE88dHJu5I7fV3vrz4z0gpK883yChu8/CpnUP34hdweVdX5NfJvaPCdwM3/YNQLwsuM4MZR+2ByzYuS602BOWWRtgRa6fYcPv3Ub22YhBvI2HJ4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347397; c=relaxed/simple;
	bh=YEgWiHXBuskcPndGXIwLrLW9HeAxJb4B1CgKB0BFHno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4WIYJIJPWXP0r115jiQ8C43c+FEtaomJdPIGb1APuJDjA11oLw+upqaWN/JAxdIG8cd0xplGFsS+RBb8dC5Nkq0VHnVdlqoTwAvjgYq8La3rSXbuceCn/4j5/L0LHJusTI4xzXyYBbs+5ZwyfqOaQeGGYnr5EWD2VbTJ9kD2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=STnHriJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A8DC4CEC6;
	Tue,  3 Sep 2024 07:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725347396;
	bh=YEgWiHXBuskcPndGXIwLrLW9HeAxJb4B1CgKB0BFHno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STnHriJmfSwk3zd7FKQ9ObfXGV0wHnu1Gp9iLdbedkLQ5S8WiZ4sS1Y4nvq7uIZn4
	 2zf+kekIOdX8CdCQBcB/NO0NudqAqV428ExhJH16hX6+3uYSe9logxDogC9l2kwMtO
	 EufZDOag7qHsBS9ih9W17bidAngDY9oRbWashrD4=
Date: Tue, 3 Sep 2024 09:09:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	Dmitry Vyukov <dvyukov@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com,
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com,
	stable@vger.kernel.org, andrey.konovalov@linux.dev
Subject: Re: [PATCH] usb: gadget: dummy_hcd: execute hrtimer callback in
 softirq context
Message-ID: <2024090332-whomever-careless-5b7d@gregkh>
References: <20240729022316.92219-1-andrey.konovalov@linux.dev>
 <CA+fCnZc7qVTmH2neiCn3T44+C-CCyxfCKNc0FP3F9Cu0oKtBRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZc7qVTmH2neiCn3T44+C-CCyxfCKNc0FP3F9Cu0oKtBRQ@mail.gmail.com>

On Tue, Aug 27, 2024 at 02:02:00AM +0200, Andrey Konovalov wrote:
> On Mon, Jul 29, 2024 at 4:23 AM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Commit a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer
> > scheduler") switched dummy_hcd to use hrtimer and made the timer's
> > callback be executed in the hardirq context.
> >
> > With that change, __usb_hcd_giveback_urb now gets executed in the hardirq
> > context, which causes problems for KCOV and KMSAN.
> >
> > One problem is that KCOV now is unable to collect coverage from
> > the USB code that gets executed from the dummy_hcd's timer callback,
> > as KCOV cannot collect coverage in the hardirq context.
> >
> > Another problem is that the dummy_hcd hrtimer might get triggered in the
> > middle of a softirq with KCOV remote coverage collection enabled, and that
> > causes a WARNING in KCOV, as reported by syzbot. (I sent a separate patch
> > to shut down this WARNING, but that doesn't fix the other two issues.)
> >
> > Finally, KMSAN appears to ignore tracking memory copying operations
> > that happen in the hardirq context, which causes false positive
> > kernel-infoleaks, as reported by syzbot.
> >
> > Change the hrtimer in dummy_hcd to execute the callback in the softirq
> > context.
> >
> > Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=2388cdaeb6b10f0c13ac
> > Reported-by: syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=17ca2339e34a1d863aad
> > Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> Hi Greg,
> 
> Could you pick up either this or Marcello's patch
> (https://lkml.org/lkml/2024/6/26/969)? In case they got lost.

Both are lost now, (and please use lore.kernel.org, not lkml.org), can
you resend the one that you wish to see accepted?

thanks,

greg k-h

