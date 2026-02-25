Return-Path: <stable+bounces-219653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMMAN6Qbn2kzZAQAu9opvQ
	(envelope-from <stable+bounces-219653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:56:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338D19A125
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0D9331F41B6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E73D7D77;
	Wed, 25 Feb 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="B8Kn1HHZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F63D7D71
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033916; cv=none; b=n9zCY0AaifJSDmKeR46FxkGJILjxqG1qJNeMKH1Yzc5gWnd7BdvgYrljTmPFiVosONJEBlt0Ms2z8cFVRSwQZzghKaQAuXwE6YTSqyk3hBGb185x1gIW1w4JikP7TfyI9JQ9BuUXo5L1DVowmtxtLO63o+ZDYw0ax05p0W93Y/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033916; c=relaxed/simple;
	bh=YhjBQew5gzB4pLmLGvlQ5a4ijHNLQAUTvykDlvnWBSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf0qWsOyw6Jd8tS7R7BQRDr+3d96u9jZQRzv8zak1shM8SUn3ceBqz6GPHTqLZyyZnkSLuDWlzARAts8r4W5Fs4Nua6DwiQRzKAvnp3bXnW2VQrS1HGCv7YMB1hkO4LwPYtmOCb95xH5GwphsrHQ0Bo4KPbt8TWaAOkJ0xqVYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=B8Kn1HHZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c711959442so94834385a.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1772033914; x=1772638714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l5HNgHHBMKtxWITqTdRd2/TKdA9TSeuNJbOQlnmGijo=;
        b=B8Kn1HHZVIW5hb7q7q/iq9QdWlzLQxKGgbgRKVVA2dcsiWXsU8J5zRxg7akZAjZQ+K
         EjbwZiE7vXVxBJIWExJTQmLW4NkkpXNsm6SzdByTN8j0oFCT1Cvd8hcIKivmyg2agVv3
         t4yME9/k9VvBYTNFrVVkeXxNlFWPSR0vucvZUD/Jg2K7sPkR9+5ioteGAkiw6Muv5wqN
         UpR9GY1dIYY+zO6BUiKK4azCpbqXvY7gjXAwwXU69x0wacorBYAqEA0e3ymJvLpsBctn
         7WXUaDeyMlPV+BarLarHSFk6r8H+lXXxX33A77qmxrcmr1ok9sIA6A5lGxO57oGv6XLZ
         0vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033914; x=1772638714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5HNgHHBMKtxWITqTdRd2/TKdA9TSeuNJbOQlnmGijo=;
        b=MqN1zeVyUC2jEaWjMA01/XuEUFr+jMjrrHQMbJJJdGdreMO6VFotLvsmOVvk6S/8H9
         Vv5n0nkfY+0JrXVTfyE/Hugjco+/RleAkSZhIGLDKs6y5CuEXd7SdOkqpMMomaLJuhbO
         D+WkCfwc4AKBEswqBEvaXyfodbFxMb303me8KRpOeJogqCEgeB9ZWWTOE9xcUn7hGoaN
         engX6a3p9OOi4WdHG7k5UExK1gD6pbb7yyAvruijzhsNDs4l1m8kWtiU7E2QkStXrSkA
         Uv+EpszAuazW3ht8UWy7jk9zC2Tm0q81Y0b+rar1p81yUj0FiohyJ2mil91jAYAQsrw8
         Zdhw==
X-Forwarded-Encrypted: i=1; AJvYcCUVRtSvaOqZJ21KGGCPmw+hHWG8WhDs99raMyRcwI9Q4fJmDvE8B31xmZtuYjdbcEdGsR8SkhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbF3E4LuDceAJMJ/xh2nf3Wt0pPd4xT7JMkT9xM3Jw0N28HwC
	CTEz9LF6W3YlAMBIYHQdUKNCFXrsl55egeojS7wHjz8nAiiHdEt4255B1YISAae81w==
X-Gm-Gg: ATEYQzxf511MGyxBTE6JM/uNY75VJPxMqcZD0l99+B2/B4g2trNwroPkXd2YCUylgjD
	mpld2Ld1rk0QUbgFOreFg2kXEJ7O9d6Biav/xWr2jaIIY3IFYxe/TTYIxt6FOaAN5gXiwARping
	ULcm8C9Ei2HE5dWF+hiUt7SP8kY64VsSgLnULpBG2fxgK5rLtGG7fDc8DPhdVl+d8IapiCYBhe+
	cimd8RrrrcG+9dkF+Q0k81Wi2vJQreW/EOXTZcXIO2uHet0U2eQfHb3uVObSrgiQjN/kr3MXeLW
	tBiN6lqwHUoN7Y3y8s3GDguiC5IyKUXVMM++MgmNj96dRMJfBKeuPn8cS1ThiVjWLdx/B9vadOX
	z4kJR49f4lL/r4qZ2D48HrMq/u0J5ww/0DGzrihAoKIwMPoqpkCXQKfHnVR+rEiTEJ8NBVyfqfj
	Fj6pjRFpbUb+L6Rfrl3vOwyWQCVK//DlO4PZhS9a0c4SPSMEGYmd2W
X-Received: by 2002:a05:620a:280a:b0:8c6:a587:377f with SMTP id af79cd13be357-8cbb20e412emr467750985a.36.1772033913962;
        Wed, 25 Feb 2026 07:38:33 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d101ceesm1312661285a.34.2026.02.25.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:38:33 -0800 (PST)
Date: Wed, 25 Feb 2026 10:38:31 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Vacura <w36195@motorola.com>, Xu Yang <xu.yang_2@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	badhri@google.com
Subject: Re: [PATCH] usb: gadget: f_uvc: fix NULL pointer dereference during
 unbind race
Message-ID: <5d79b7a5-7856-456a-9b9f-48f55feefe4f@rowland.harvard.edu>
References: <20260224083955.1375032-1-hhhuuu@google.com>
 <50314bb4-1539-452d-86d6-47887a9603a7@rowland.harvard.edu>
 <CAJh=zj+qoLr40+sSMksRi5AG36GkO_kDk=axvPoEU76Md-NeCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJh=zj+qoLr40+sSMksRi5AG36GkO_kDk=axvPoEU76Md-NeCg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219653-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rowland.harvard.edu:mid,rowland.harvard.edu:dkim,harvard.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5338D19A125
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:31:54AM +0800, Jimmy Hu (xWF) wrote:
> On Tue, Feb 24, 2026 at 11:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Feb 24, 2026 at 04:39:55PM +0800, Jimmy Hu wrote:
> > > Commit b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly
> > > shutdown") introduced two stages of synchronization waits totaling 1500ms
> > > in uvc_function_unbind() to prevent several types of kernel panics.
> > > However, this timing-based approach is insufficient during power
> > > management (PM) transitions.
> > >
> > > When the PM subsystem starts freezing user space processes, the
> > > wait_event_interruptible_timeout() is aborted early, which allows the
> > > unbind thread to proceed and nullify the gadget pointer
> > > (cdev->gadget = NULL):
> > >
> > > [  814.123447][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind()
> > > [  814.178583][ T3173] PM: suspend entry (deep)
> > > [  814.192487][ T3173] Freezing user space processes
> > > [  814.197668][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind no clean disconnect, wait for release
> > >
> > > When the PM subsystem resumes or aborts the suspend and tasks are
> > > restarted, the V4L2 release path is executed and attempts to access the
> > > already nullified gadget pointer, triggering a kernel panic:
> > >
> > > [  814.292597][    C0] PM: pm_system_irq_wakeup: 479 triggered dhdpcie_host_wake
> > > [  814.386727][ T3173] Restarting tasks ...
> > > [  814.403522][ T4558] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> > > [  814.404021][ T4558] pc : usb_gadget_deactivate+0x14/0xf4
> > > [  814.404031][ T4558] lr : usb_function_deactivate+0x54/0x94
> > > [  814.404078][ T4558] Call trace:
> > > [  814.404080][ T4558]  usb_gadget_deactivate+0x14/0xf4
> > > [  814.404083][ T4558]  usb_function_deactivate+0x54/0x94
> > > [  814.404087][ T4558]  uvc_function_disconnect+0x1c/0x5c
> > > [  814.404092][ T4558]  uvc_v4l2_release+0x44/0xac
> > > [  814.404095][ T4558]  v4l2_release+0xcc/0x130
> > >
> > > The fix introduces a 'func_unbinding' flag in struct uvc_device to protect
> > > critical sections:
> > > 1. In uvc_function_disconnect(), it prevents accessing the nullified
> > >    cdev->gadget pointer.
> > > 2. In uvc_v4l2_release(), it ensures uvcg_free_buffers() is skipped
> > >    if unbind is already in progress, avoiding races with concurrent
> > >    bind operations or use-after-free on the video queue memory.
> >
> > Sorry if the answer to this question is obvious to anybody familiar with
> > the driver...
> >
> > The patch adds a flag that can be accessed by two different tasks
> > (disconnect and release).  Is there any synchronization to prevent these
> > tasks from racing and accessing the new flag concurrently?
> >
> > Alan Stern
> 
> Hi Alan,
> 
> Thanks for pointing that out. You're right, the boolean flag lacks
> proper synchronization for concurrent access.
> I will submit a V2 patch using atomic bit operations to ensure memory
> visibility and atomicity across tasks. The changes will include:
> * Replacing 'bool func_unbinding' with 'unsigned long flags' in struct
> uvc_device.
> * Using clear_bit() in uvc_function_bind() to reset the state.
> * Using set_bit() in uvc_function_unbind() to mark the unbinding phase.
> * Using test_bit() in uvc_function_disconnect() and uvc_v4l2_disable()
> for safe checks.
> 
> Does this approach look reasonable to you?

No, because data races are more complicated than just concurrent 
non-atomic accesses.  There's also the issue of ordering.  Here's what I 
mean...

You want to change the bind routine to do something like:

	cdev->gadget = ...
	set_bit(&uvc->flags, 0);	// Driver is bound

and unbind to do something like:

	clear_bit(&uvc->flags, 0);	// Driver is unbound
	cdev->gadget = NULL;

You'll also change disconnect and disable like this:

	if (test_bit(&uvc->flags, 0)) {
		... use cdev->gadget ...
	}

The problem is that modern CPUs can execute instructions out of order 
and can speculate loads.  When the CPU runs the bind routine, there's 
nothing to prevent it from doing the set_bit() before assigning 
cdev->gadget.  Similarly, when the CPU runs the unbind routine, there's 
nothing to prevent it from setting cdev->gadget to NULL before doing the 
clear_bit().

More subtly, when the CPU runs the disconnect or disable routines, 
there's nothing to prevent it from speculatively reading cdev->gadget 
(and getting a NULL result) before doing the test_bit() (and getting 1).

To prevent these problems, you would need to use memory barriers.  For 
example, you could put smb_wmb() between the two statements in bind and 
unbind, and smp_rmb() in disconnect and disable before cdev->gadget 
gets used.  (For a lot more information about these memory barriers and 
other ordering issues, see 
tools/memory-model/Documentation/explanation.txt.)

A simpler approach, if it won't cause any problems, is to ensure 
synchronization by protecting all these different pieces of code with a 
mutex.  Then they would never execute concurrently.

Alan Stern

