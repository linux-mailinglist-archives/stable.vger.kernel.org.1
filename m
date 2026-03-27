Return-Path: <stable+bounces-230711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF9nNZLQxmkCPAUAu9opvQ
	(envelope-from <stable+bounces-230711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:46:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3A3491EC
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD6283029632
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A672D838E;
	Fri, 27 Mar 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rPzo9fin"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AE26E709
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637174; cv=none; b=M2rhsPHDyZdDH0NIFFIia8BrVIUPQK/kfi0sbA77a4EiOvbOL+4+Mag2nGqGjIElOskyct7iySOh8ryYT4+lVSIdp6UA3+MMEaqPr7jqL/O7TidUIfgXM0rqhXB721CGzSRk5Y4qX2KaADeS7ZJm1j2h62f5p2dro/weA7i3FZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637174; c=relaxed/simple;
	bh=FxGFWtPB/Wa8nrg43ruQmSyCzn7U9NtJDFZ15sUGTC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL4L1lLGTiKXg7guvYQVECeem7atHWrepZNVGtI/Sx6KV6exnyGuS6WAX/hwCDrkSIaj+1y96+KTMyFFE5zCptuBDwbIzp1AgVBjwlXPbfOaXMPhj/04Zsm9uf+L60Xdke2UgSol9QyhuD2hOH63BpFrS2PtArJE8d+dJrYH6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rPzo9fin; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb5c9ba82bso442686085a.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774637172; x=1775241972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAj2+JxeyzxCHPSTp7NdDKje1P1OmazWp5C7XTFQEIg=;
        b=rPzo9finVExw3BblzyZqQ4lScvOYt1807Lh/7ci5BAm9rQTuLhxqKa/z1RaVePpLMt
         YDlNIzMzKnLR/cT+H4wTnuKRHrSrr8BO/SG13suhKyPAP5EdVFpplDJQsqBUYf1OtGKq
         u4O54le7dUVsNGu/YfczL1GU6nug1WtBHgre8zxMOeS3jbKgVdNZCePmJO/U4rKWdcp7
         sWG2mBDfpFJejU94rw8XC3OyQToI3xH5Yraqd1mFxBvHVzt1Rb1cU4Hs050VPJE+tpaT
         p2Ey3MMLWRsvlDXhsRoL4L2RksHEJNAG1zfjsh2bD8tD8ufgyz1We+ilvnsa+V6933wW
         pY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774637172; x=1775241972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAj2+JxeyzxCHPSTp7NdDKje1P1OmazWp5C7XTFQEIg=;
        b=ONPPeILYMxdNodI173UKJXWE4psPjcaWx1FyWyCY5HJyIfpkr08WeRQyTWcowT8Wbx
         Vmpywc9uMEYtF3BmlWspzrcBQZvfBGgwl9Q5J+hEbvg1egBIy3/iBvabn3qqpD+l9NN9
         tQzrphOfSGZMZrxBz4xpxvuaiZ3+s54bmvfXjQ0/eMTpEGDIon1OJFroxzIwfmpCI/kJ
         0aF9mG0ZL6Bg9seolNTyZnqPLmwmirAXMRgHG8EcC3bJKMVwtMH7DEL7pGJSngwkMY6n
         jFVxjlJ0ORwsXoI76WqvssdkJs7LychEjXa5qivgBUnx6FPE1JnivRia2CGpoa6Mp+ad
         sDvw==
X-Forwarded-Encrypted: i=1; AJvYcCUpoyXcRtX+lxLqoqT4hg/xRz4ncUeF0CroigFGW+/GgmLgfG53hWaWwoHjrPR9EcPkstUZJcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRvDflLkS3SSimlHYZ2AMLhh/mPOYVUF7j8R/fVfPNAnvQ60F
	Nf/9T50f40o9hwDrleYw4nVWNE280890diAFpMT7s32zAJdvzM8sxchKN02uilkIIg==
X-Gm-Gg: ATEYQzwlprJJK/PyFPRjWnVt0NOQkHcFjpcPgr+iMAE0u+VfpU2sdor4wnFlRyjZ1WL
	P3TWU+ZlIgMk6VrSeEDWD/cy7uuvTChUVujRYgv8FK2dcNP3ogxCO6HwR74u0F9KkNcO2Zna5D+
	QFk+D8eY4bEJVYdFyKks99W/+zPHRiayPtipraibJUlc3p7mqNg7HoR+k5LFSEBe6op0EwkwPuh
	Tk7Ms0t3ZrzgaulwD++k0QtuByQHOGYrvNikOYzy1i2FbKXfbbsnrXGODVNRXBwr9hGoM9EEFCK
	20WBWIk6IrS4HcX0Sjj7D3MajQNlAoO27yCvqZ7amaN8j42ggdXp5qW86MwF6fVaMP6Ee+vdlaU
	+mRtKPOjpOFGIrQraao4iZv6PPyOF/CZ/kWC7xqmuU9fEmnCf+dDhMn9JRlNj9Nzn4qpaScwXOl
	Gj2Wh7ySwblURQ8C0MyjAOeQwY
X-Received: by 2002:a05:620a:2944:b0:8cf:d37d:99e1 with SMTP id af79cd13be357-8d01c63a043mr441700785a.32.1774637171947;
        Fri, 27 Mar 2026 11:46:11 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::5a82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3ca491sm563371285a.14.2026.03.27.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:46:11 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:46:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
Message-ID: <852cd509-4ce1-4b22-ab1f-b9b9bbf6a52e@rowland.harvard.edu>
References: <2026032152-getting-carmaker-29d5@gregkh>
 <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
 <2026032114-unlocked-unmoving-091b@gregkh>
 <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
 <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
 <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
 <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
 <bfd4e1f5-7bc5-448d-aa33-1a977bf00733@rowland.harvard.edu>
 <CAD=FV=WeeBoQAoPgNq+5ocZas+mOn1RuNto3k57ag4ODo2vOLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WeeBoQAoPgNq+5ocZas+mOn1RuNto3k57ag4ODo2vOLw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230711-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rowland.harvard.edu:dkim,rowland.harvard.edu:mid]
X-Rspamd-Queue-Id: 4CF3A3491EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 02:49:33PM -0700, Doug Anderson wrote:
> > > Right. ...and I think that's what my proposed "ready_to_probe" does.
> > > It really does seem like quite a safe change. It _just_ prevents the
> > > driver load path from initiating a probe too early.
> >
> > Any such consideration should apply to all the probe paths, not just
> > driver loading.  (Also, if it's too early to probe the device, perhaps
> > the return code should be -EAGAIN instead of 0.)
> 
> In my proposed solution, I was returning 0 from __driver_attach(). The
> only place that's called from is driver_attach(), which calls it with
> bus_for_each_dev(). I don't think returning -EAGAIN is a good idea
> there since it stops bus_for_each_dev(). In general __driver_attach()
> always returns 0.
> 
> In general, the goal of my new proposed patch is to add the device to
> the subsystem's "klist_devices" exactly where we do it today for
> maximum compatibility. This means that if any code was relying on
> being able to find the device, they can still find it. The _only_
> exception is that I don't want to be able to find the device in
> driver_attach(). So my proposed solution just hides the device in that
> one case.

But why just in that one case?  That's what I don't understand.  If it's 
not okay to bind at this time on the driver-load path, why is it okay to 
bind on other pathways (such as bus.c:bind_store())?

> I believe this should be fine. Specifically, driver_attach() could
> have been called (in another thread) immediately before
> bus_add_device() and everything would have been fine. driver_attach()
> wouldn't have found the device (because it wasn't linked in) but the
> probe would still happen.

That's not in question.

> > I don't know the answer to this.  That is, I don't know if there are any
> > notification handlers depending on the device showing up in the bus's
> > list.  The safest thing to do is issue the notification after adding the
> > device to the list -- which may mean after probing has potentially
> > started.  Is there any reason why that would be a problem?  I'm not
> > aware of any.
> 
> I'm not completely sure I follow what you're suggesting here...

I'm saying that the BUS_NOTIFY_ADD_DEVICE message probably should go out 
after the device has been linked into the bus's list, as it does now.

> I still believe adding a flag that just hides the device from
> driver_attach() is a safe and correct approach. In general I don't
> want to fragment the discussoin, but I think it might be useful to
> send a v2 that shows what that looks like. Any objections?

I just would like an answer to the question above.

Alan Stern

