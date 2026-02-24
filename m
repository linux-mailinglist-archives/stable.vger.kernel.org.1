Return-Path: <stable+bounces-217922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF+3Av7HnWk8SAQAu9opvQ
	(envelope-from <stable+bounces-217922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:47:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57829189450
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 813B53055443
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAE3A63E5;
	Tue, 24 Feb 2026 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="J+XrR1eb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BB3A1A28
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948024; cv=none; b=Sai/gNDsgQZDNCZhDn93Ddk5FY980SM2xoSMDIQWUkfmcziHMnmdfEJY3ohDt7/FjoIgc90gRaLppCfPRN2wy93GiEEnXAJkQPGOxydPVHvInbOexDufBvs8aDPjp5PLCd22pVzwnSZ9jnjyi0Oc6mer823nsRsJRDtjdnBL/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948024; c=relaxed/simple;
	bh=FmS6mT3TQDgW/UbzukgFcXe38SLDZTmQgb7H+tbASWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZtLzaM4/fYtHNp9AYIRL4sdHHsErgaMboBQvVJtrldRWDGwaGb9+gb2SZ1e6Kj8Vquigo7l7KDKMyquWtbKUePTJB3ggnwtPinTICyIeUpnqGN+pU5K0W8IJT7BBq2wFlnC04k7qV8Es4XmL3+cbEI9IQxstYzTTJHc4dszQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=J+XrR1eb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-503347e8715so69056051cf.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1771948022; x=1772552822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhkuQepQPneHK/qUGrckkXHtp6WWRJ5IG4Yd3zisi+I=;
        b=J+XrR1ebFwnrdkN+m4jbcXlk92Y1W+UZw+mgFSpNUsaYw8PdOtAFHp22ZBwXTiJ807
         Zlq67cWNiByjZZ8RBZCy9WIfEXyxcbpfY03YXUifjjI5NnrZTwNkYK3cpKthGZTDLOSX
         zYR98ZeeyM3VJxDdvOkzHCTejDcgmt95NLFRzgookBfNTAMnia8Nh8r1oWR6gYPhXgcr
         MOoh0zlzYQ1Okzqh16sfoBfnrGd1YkN+HclS2/+Wrlhig0O6BfeqRu+h2jS5j6IcTIUu
         A0/VkWq+mpGNkNIWrfRr8MFCsRhQ+IZULo863qAb3mjVDs5SWeaByNFKgYJ4+vJxa6TH
         TUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771948022; x=1772552822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhkuQepQPneHK/qUGrckkXHtp6WWRJ5IG4Yd3zisi+I=;
        b=kY1+Tqd+ilSBvOdEuGw64fphM3XXf7dRSqrhBKPf4K/N4jmklO3GRCPICIBfuVYfeq
         s7/3JZQKlxc0N7kpSeYQ3sGqRxziLNJf31/2zZ/uih5911wUwdCmbi3QoEwbEXCY14ug
         iyAQhK6kpuB8fvXaoUmbm3bKC3yVlSUjTKHYyZzg6aNcHRuZd6J/8JUVnto6OeB4EZKW
         cF8EFfFFxMgGYvaYVvyf9EGxuSzYEdof44krzhba9g2bitrCILBNaBXX5d37kRU3jWvd
         Vyq8x4mVjrcd0AIRvrdsQwZgl7GcwhWpieiNofpB0G/xJUwtl2Txkgwr7+llUiGDKFPQ
         LO2w==
X-Forwarded-Encrypted: i=1; AJvYcCUuzIGWFLsDEMgBJrNQRqdZyUVCsGQZvlllBDfKVK14JKdfE5iTgF9yz0rQiqLxlj+8hSjYdcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvY53Dg8AtmcoRM7cBx6diai9bZotU8KJbnxyJrUZ56CpDptOU
	OAd9pVB3Ji26JyEZSXwthuORkoTyliMd4dmCtzfSrlZZZIC0SOUKJB1AAhrwYmLumA==
X-Gm-Gg: AZuq6aK1WspLRQ1RdeswJxFjcyYCEgQB/9CZn4wch3qTDC13dyNkdEtu+VRIDEbp/Wd
	cdLKeP7GzF0b+p+GZZXe8R0x4V0cG/GXdgfgfdFgk6w3uatITxSw113zb87xc1ZlxgewIWVJDZ9
	t9alBhJNRUSmLzNj7AFcSpfvuCAJGxDbHXPvGLsQYd7thOqZl8Zw0OdZS+OGxJcwB6UXgEmiISC
	5oLu4Nu5A4UgKBFwfz2YIyrE6CmSCnYv5NFqilbyGFPafJ3ww1A2bA9GHYdBj3WMP5TwBFbWwCr
	JqTtAnadCoS0/wcTT17hf9hDtsFJ+klg8YjKnqs/HAa1Cj+qIVzTA9MLf9oN8R0PHBzMDxaY3gQ
	eypUsAyx8FtZsjIRMWeqXJzq9lveFeCAKvQuRRBhjTAY6SxM9fsrZvahhOS6O6MgbJKUWAnqgjl
	sceXSz2UDY7o/aUWv5HOkT43FC
X-Received: by 2002:a05:622a:15c3:b0:501:41c1:2aef with SMTP id d75a77b69052e-5070bc6b310mr176353581cf.42.1771948022382;
        Tue, 24 Feb 2026 07:47:02 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::687c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6dd96fsm99469061cf.28.2026.02.24.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:47:01 -0800 (PST)
Date: Tue, 24 Feb 2026 10:46:59 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Jimmy Hu <hhhuuu@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Vacura <w36195@motorola.com>, Xu Yang <xu.yang_2@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	badhri@google.com
Subject: Re: [PATCH] usb: gadget: f_uvc: fix NULL pointer dereference during
 unbind race
Message-ID: <50314bb4-1539-452d-86d6-47887a9603a7@rowland.harvard.edu>
References: <20260224083955.1375032-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224083955.1375032-1-hhhuuu@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217922-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rowland.harvard.edu:mid,rowland.harvard.edu:dkim]
X-Rspamd-Queue-Id: 57829189450
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:39:55PM +0800, Jimmy Hu wrote:
> Commit b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly
> shutdown") introduced two stages of synchronization waits totaling 1500ms
> in uvc_function_unbind() to prevent several types of kernel panics.
> However, this timing-based approach is insufficient during power
> management (PM) transitions.
> 
> When the PM subsystem starts freezing user space processes, the
> wait_event_interruptible_timeout() is aborted early, which allows the
> unbind thread to proceed and nullify the gadget pointer
> (cdev->gadget = NULL):
> 
> [  814.123447][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind()
> [  814.178583][ T3173] PM: suspend entry (deep)
> [  814.192487][ T3173] Freezing user space processes
> [  814.197668][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind no clean disconnect, wait for release
> 
> When the PM subsystem resumes or aborts the suspend and tasks are
> restarted, the V4L2 release path is executed and attempts to access the
> already nullified gadget pointer, triggering a kernel panic:
> 
> [  814.292597][    C0] PM: pm_system_irq_wakeup: 479 triggered dhdpcie_host_wake
> [  814.386727][ T3173] Restarting tasks ...
> [  814.403522][ T4558] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> [  814.404021][ T4558] pc : usb_gadget_deactivate+0x14/0xf4
> [  814.404031][ T4558] lr : usb_function_deactivate+0x54/0x94
> [  814.404078][ T4558] Call trace:
> [  814.404080][ T4558]  usb_gadget_deactivate+0x14/0xf4
> [  814.404083][ T4558]  usb_function_deactivate+0x54/0x94
> [  814.404087][ T4558]  uvc_function_disconnect+0x1c/0x5c
> [  814.404092][ T4558]  uvc_v4l2_release+0x44/0xac
> [  814.404095][ T4558]  v4l2_release+0xcc/0x130
> 
> The fix introduces a 'func_unbinding' flag in struct uvc_device to protect
> critical sections:
> 1. In uvc_function_disconnect(), it prevents accessing the nullified
>    cdev->gadget pointer.
> 2. In uvc_v4l2_release(), it ensures uvcg_free_buffers() is skipped
>    if unbind is already in progress, avoiding races with concurrent
>    bind operations or use-after-free on the video queue memory.

Sorry if the answer to this question is obvious to anybody familiar with 
the driver...

The patch adds a flag that can be accessed by two different tasks 
(disconnect and release).  Is there any synchronization to prevent these 
tasks from racing and accessing the new flag concurrently?

Alan Stern

