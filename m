Return-Path: <stable+bounces-204483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8ACEED54
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A0C300E023
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E242254B18;
	Fri,  2 Jan 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="tBPW7OO/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11497247295
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366836; cv=none; b=hp8igtmV8LWpmfyvg8k3+P/0MQ5mlC7tIEQYgMLq/NbzzJ0Ee047qdrmXf6Ov+7U9LBSWdmVR4C9pz59FmkyjpLyOApH3HBOP2kJI7zr0YLuq3Ui6VtE5UOlXcbLpWbnAiKdeZkiO+adX3WSKzeO6AmHrGbalePTRFGeTjXmC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366836; c=relaxed/simple;
	bh=k3VtBBb6OF0Z2Ui69RBGkK+33zvq/U0BpsN4SQmZ6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ13ZEtZ3d7H19Xj4YvNtF/7QB3JTvOxXbC9Txk77H2zCcZcoVAeXH9Upn3WWpaFJPNVZKlI5O/KX5lr3aTPttciEpkSGA13VCnKot7SYOam/HhclJWAs65dHIMzvK0kC+1cUS8J/mQEL2rFew3XT1WSlBBVDdfPVUw/oVaQDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=tBPW7OO/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda057f3c0so139272131cf.2
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1767366834; x=1767971634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKRrOSohpgOIyc76MbizVc926qdGseLbYCMIQ6kB9to=;
        b=tBPW7OO/bc42kWHJhavcU/LTORiIJrqGeC1NM3JI2AUXuFVVvglmZAD6fZcze7p/Bb
         ODPTGkWFHcNaWNK41lzSPOhFkvmVdghcJDWBfT2E+V7ffJtljwG9UaSiG2HXoQUYv07t
         xn6bb1Js73QnQIHaAZVJb5aKdH/qmONbV+RAA0ziQQLeMgrDfCBW7efJspr9gBVhTfKi
         jphFJYxIUWlaC6zVPpliV38Vu33opzE9OqM5dxIB/egD9PzMQNUDJUbFoOJEqSTGNbTn
         P8NZs61EGpGwKM7fcxhjexd5T0MyKBsI2FRUWIlhW6tZDNuh0xjfo1ShRW1v6QD4bzrP
         9Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767366834; x=1767971634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKRrOSohpgOIyc76MbizVc926qdGseLbYCMIQ6kB9to=;
        b=hmhGX2s+OP5hMiKmBJcp/Tqq4kM12wuk9u66Uh3mEbpaPBo5SB13JY7YoX6Uv20ahI
         GV5pmI53Lzo8pF9XzD36GmFRe41w4pi138JUZbVlXgDGQMPaO7vibQGIDXfKtSfYQm9T
         wp2dBXtNx3CRTCdVJBufoeIS8bBAvNXCGWHRO7V8kCicrUiOFS4WDlB+9KFYlVjyaO0P
         9FUGgoO+JzapLGNhsG8rlkKxTkIYXzSpw+XuYUB0kJqLJ6i9phHmsHF39mTHZ4z2W4rw
         2KW7VNxqhY9T8YsKokBTBe6sM/nGYy0q9ZNEKr/qSxhmci9Wdv92wU9LZKz60V+wAUv0
         CZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpCAM/y55LTG89GgTs4ZuFXSmLrewyWLT5OGyXZOni9tWIDu7iQws2Ny9+WmDuHVdRek1ZLE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrl433euU75WcInguCbbMMYdfEJ9KwnNaPXHtkVulSMj2A+dy
	wGeqkJZEDUsl2ZtYZ0ky1p7EOyV0LaHUTLfXbyNhh9CrPFhGTwneiiNRzxkhk0dcVg==
X-Gm-Gg: AY/fxX5gw6b0OVw2D/LCVRXt3pog6H+pwnNPL5p/5K4tTBida9Kp9f0DjCamRCEVmsF
	+FWb4e9olVpaYdRbqCkE8ADMfTLrNrPeP73Ihuyp0rab85oisB4iVgj7C6RxA6LIaFE4ME/Ax/1
	uejsgJJVNE13KnDdzjs282g7m2kzisXsyf4Ehp7E9LC/+5z42XWsHPSST2HQT7+40/EMViONU9d
	NfnnCzSbfHBIjhop2VP4wghQ/sCYDO/qu0j32o+et0mTZ8UfqNKPb+mkGCJ1EnNqdOrDpP5OVFh
	a803REq66Wgcn8hojR3u4BUqdoIiv11x4WTGcL3U/xSocvnJ7zmqwLGQLnnyvG1dDy40I7aGT8w
	btTpaMVGXkE3VrV8pbtZM3Qd2BYgHz1LKRki4ZpKtGtlMNZBinWPzoBQ3Kaigq5g5mXoz34wk5G
	2OV82GnmGphMEW
X-Google-Smtp-Source: AGHT+IFiJdnVXmubr0ZXgWZIp6IV1ka1R38pWa45OLmGF5b/Jmt6hv2wey1K3GFnP+DN0+NjKJzq2A==
X-Received: by 2002:ac8:5dce:0:b0:4ee:17b0:6261 with SMTP id d75a77b69052e-4f4abcf1559mr651560161cf.29.1767366833772;
        Fri, 02 Jan 2026 07:13:53 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::16e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62fa56sm316864931cf.17.2026.01.02.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:13:53 -0800 (PST)
Date: Fri, 2 Jan 2026 10:13:50 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Diederik de Haas <diederik@cknow-tech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@loongson.cn>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengwen Xiao <atzlinux@sina.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
Message-ID: <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
 <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
 <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
 <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>

On Fri, Jan 02, 2026 at 10:36:35AM +0800, Huacai Chen wrote:
> On Wed, Dec 31, 2025 at 11:21 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Dec 31, 2025 at 05:38:05PM +0800, Huacai Chen wrote:
> > > From your long explanation I think the order is still important. "New
> > > connection" may be harmless for USB keyboard/mouse, but really
> > > unacceptable for USB storage.
> > >
> > > If we revert 05c92da0c524 and 9beeee6584b9, the real problem doesn't
> > > disappear. Then we go back to pre-2008 to rely on distributions
> > > providing a correct modprobe.conf?
> >
> > The warning message in 9beeee6584b9 was written a long time ago; back
> > then I didn't realize that the real dependency was between the -pci
> > drivers rather than the -hcd ones (and I wasn't aware of softdeps).  The
> > soft dependency in 05c92da0c524 is between the -pci drivers, so it is
> > correct.
> >
> > To put it another way, on PCI-based systems it is not a problem if the
> > modules are loaded in this order: uhci-hcd, ohci-hcd, ehci-hcd,
> > ehci-pci, ohci-pci, uhci-pci.  Even though the warning message would be
> > logged, the message would be wrong.
> Correct me if I'm wrong.
> 
> I found XHCI is compatible with USB1.0/2.0 devices,

Yes.

>  but EHCI isn't
> compatible with USB1.0. Instead, EHCI usually has an OHCI together,
> this is not only in the PCI case.

It's more complicated than that.

For quite a long time now, most systems using EHCI have not included a 
companion OHCI or UHCI controller.  Instead they include a built-in 
USB-2.0 hub; the hub is wired directly into the EHCI controller and the 
external ports are connected to the hub.  USB-2.0 hubs include 
transaction translators that relay packets between high-speed and low- 
or full-speed connections, so they can talk to both USB-1 and USB-2 
devices.  Hence no companion controller is needed.

I don't remember when Intel starting selling chipsets like this, but it 
was probably around 2000 or earlier.  (Some non-Intel-based systems 
included a transaction translator directly in the root hub, so they 
didn't even need to have an additional USB-2.0 hub.)

Before that, systems did include companion controllers along with an 
EHCI controller.  I don't know of any non-PCI systems that did this, but 
of course some may exist.  However, the EHCI-1.0 specification says this 
in section 4.2 "Port Routing and Control" (p. 54):

	The USB 2.0 host controller must be implemented as a 
	multi-function PCI device if the implementation
	includes companion controllers.

> So I guess OHCI/UHCI have an EHCI dependency in order to avoid "new
> connection", not only in the PCI case.

Do you know of any non-PCI systems that do this?

Alan Stern

