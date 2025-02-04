Return-Path: <stable+bounces-112135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A0A26F90
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CC41672B5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BC020AF96;
	Tue,  4 Feb 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtrnBmPh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026520A5F1;
	Tue,  4 Feb 2025 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666275; cv=none; b=VIyOVo1GTSVX8trNYH0teusjzTZlGpNABW/gBbBdA/qvjcB31Md7coZT19mh3rMK9sLuRhWw9Cgj5ybx/ohCvhy4SCIlP75w5Jy2MgiE441lIGHWfvyNZlMWKYeTB+lsjTip1fV1OU2ufFZTILUnOC/mGs3xetNtvN185dvQHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666275; c=relaxed/simple;
	bh=V4oM7rM5pSrLSpmMMyf2Pvg1lDo9G8RlsSCvl2A4b7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOGloH9HTiNNPTN1USRA8SiTU2VMxTwqIzfzuVu8QEcDh6AbhmRxccpszPxdUzTrkoCeQQE5HJdPEUu7Fp5aekVz9FZk01XAUgqZxjqVboRaiXrDN41BnS/MFGcU7Qt8CiABnj30qoPb2DfpL+9P995v2chC6hvGqXfyGbjVrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtrnBmPh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab6f636d821so827167066b.1;
        Tue, 04 Feb 2025 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738666271; x=1739271071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fif907mKSJfSWbZ3mwowrZwwnt2cHeEenumwlaPa7NQ=;
        b=mtrnBmPhMGrReCvaMP2wF9qw0Dwm8D8Du/HEn9rsntqKt7Syub21hcI41yZHzVZuoz
         IjgBEtmvokJhQDwclCsit9U3A1tHAncJ5cFolW+Aj6OYBQiiPjHIy3vMHj/3Y15eP02H
         ORr0AkLE/SO+XaKRh1YQ4O/3qF6gZ/1klg8tGtRbB47Nj+bt5Rk1hKGEhmLk+fGVzEMH
         Z9stp7KaWC+RrPS3hIr6iliF+XVhkkY8CtYGiOJq2N4f2UCh75My1DgdJtZV/HJbNAV8
         cmC/gSnTFBwwx2cUARa6/JxpTAdG9bq93EbXt1M6daoLn9hbbsudeHJu9X+5JWgyaGwc
         am6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738666271; x=1739271071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fif907mKSJfSWbZ3mwowrZwwnt2cHeEenumwlaPa7NQ=;
        b=wN/QNsW0mHgBUYGB32QD7wbNC7XHxoPxZO9l45bGyL7unr73sZV9NmecxMl9zZW0T0
         iMGtYnsOoeJJxHvvs25kyx7UixmIGZlu9FgcCwLZCt8WH5sYdgdodWtBigNTF2EPmMfF
         SPfk5OHoKgudpSR8Z3QNcI+UBwA5fVbZ9XKY9SUKIpEnFyFbJAiI7ZEw6uXVAEemy8Co
         orgG9BHsGHzzQfSx7r1U0Vg+OKy17I40GfLANFbfUB2L837K/uPdnYbYCuyDJnjbGVGo
         MaPYqlxK16LB3cch1GpBflwj6D0ZYelQ44tcOQ1W9hleS9VB/bGvNN+XUqJ/7y/WZ782
         oAzg==
X-Forwarded-Encrypted: i=1; AJvYcCUsB97zJrMlv4c2npaxjizVfFI5zkvvyfCjs8tqHXuIIVdccSH81RSvtMqSyUbtMyNKWFImesBIkw3U@vger.kernel.org, AJvYcCV/VkMJhDZvUh1EszQmWcQVDx6xKxqRDqWVh7wo4ziboUJSboB9YwGSl9KqsFlnc3NTv/QlL1Cg@vger.kernel.org, AJvYcCWo1e9vBaRXVI8Ya5/HxfXAsU0282LaQHk5jrUBTWnMqIlId85v1aUtvNgsst3jTfX+dsFxQyd5yuVfqaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZVBMjYTjJ+/Wx1kDMtNRbMGkpNOde3BXQHc5AHy5AK21Cd63
	wQL6+/7CJ7HF+uBNSNc8xv743AYvc/jVd0XsJ1+yh1G2tPmEhhzh
X-Gm-Gg: ASbGnctNdyPTMbOlyzVugAhKtPxQ6oJIJqafCYf29HkmxFDR+GJTsJu3BDnTz3F+GO/
	hqKVU2GEXOVw2wP/aCOw8HHQjd8g6/xGouzEmnUwbSPWvBIDP3OM+DwzjMtEaKjDVavxt86Wrx+
	zVG6SiB4SGh6D/7lZZvOchUULauEH/MFJshRS/ueBuWMMJGAlOXUVLQjKilB0bHxaolhTPWajM7
	WCbToYO0xwTT/p57VY/78OaRyTB+Ge1Tl2Qc2oakShd+qxiaL9vbCnPsrFI0cyGUo+ZT57eSYwD
	n1tpI4La1BFDQmY=
X-Google-Smtp-Source: AGHT+IHTqB6ElySIjtk/hHW6LOBX5Ks/YEIaP3vKsiXi+J8odxw44+b4UPQFzGLNPNlgn+Jl71IKBA==
X-Received: by 2002:a17:907:7ea4:b0:aae:869f:c4ad with SMTP id a640c23a62f3a-ab6cfc87b2bmr3024719066b.7.1738666271266;
        Tue, 04 Feb 2025 02:51:11 -0800 (PST)
Received: from eichest-laptop ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a8012sm891359566b.22.2025.02.04.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:51:10 -0800 (PST)
Date: Tue, 4 Feb 2025 11:51:09 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, francesco.dolcini@toradex.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
Message-ID: <Z6HxHXrmeEuTzE-c@eichest-laptop>
References: <20250203105840.17539-1-eichest@gmail.com>
 <aa0c06f6-f997-4bcf-a5a3-6b17f6355fca@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0c06f6-f997-4bcf-a5a3-6b17f6355fca@rowland.harvard.edu>

On Mon, Feb 03, 2025 at 11:02:37AM -0500, Alan Stern wrote:
> On Mon, Feb 03, 2025 at 11:58:24AM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > When usb_control_msg is used in the get_bMaxPacketSize0 function, the
> > USB pipe does not include the endpoint device number. This can cause
> > failures when a usb hub port is reinitialized after encountering a bad
> > cable connection. As a result, the system logs the following error
> > messages:
> > usb usb2-port1: cannot reset (err = -32)
> > usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
> > usb usb2-port1: attempt power cycle
> > usb 2-1: new high-speed USB device number 5 using ci_hdrc
> > usb 2-1: device descriptor read/8, error -71
> > 
> > The problem began after commit 85d07c556216 ("USB: core: Unite old
> > scheme and new scheme descriptor reads"). There
> > usb_get_device_descriptor was replaced with get_bMaxPacketSize0. Unlike
> > usb_get_device_descriptor, the get_bMaxPacketSize0 function uses the
> > macro usb_rcvaddr0pipe, which does not include the endpoint device
> > number. usb_get_device_descriptor, on the other hand, used the macro
> > usb_rcvctrlpipe, which includes the endpoint device number.
> > 
> > By modifying the get_bMaxPacketSize0 function to use usb_rcvctrlpipe
> > instead of usb_rcvaddr0pipe, the issue can be resolved. This change will
> > ensure that the endpoint device number is included in the USB pipe,
> > preventing reinitialization failures. If the endpoint has not set the
> > device number yet, it will still work because the device number is 0 in
> > udev.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 85d07c556216 ("USB: core: Unite old scheme and new scheme descriptor reads")
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> > Before commit  85d07c556216 ("USB: core: Unite old scheme and new scheme
> > descriptor reads") usb_rcvaddr0pipe was used in hub_port_init. With this
> > proposed change, usb_rcvctrlpipe will be used which includes devnum for
> > the pipe. I'm not sure if this might have some side effects. However, my
> > understanding is that devnum is set to the right value (might also be 0
> > if not initialised) before get_bMaxPacketSize0 is called. Therefore,
> > this should work but please let me know if I'm wrong on this.
> 
> I believe you are correct.  This is a pretty glaring mistake; I'm 
> surprised that it hasn't show up before now.  Thanks for fixing it.
> 
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> In fact, it looks like usb_sndaddr0pipe is used in only one place and it 
> can similarly be replaced by usb_sndctrlpipe, if you want to make that 
> change as well (although this usage is not actually a mistake).

Thanks a lot for the feedback. I was also thinking, if this macro is
required. I will wait a few more days to see if no one else has any
objection and if not I will send an additional patch to also replace
usb_sndaddr0pipe with usb_sndctrlpipe.

Regards,
Stefan

