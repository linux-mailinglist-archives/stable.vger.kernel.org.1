Return-Path: <stable+bounces-167058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F72B21550
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 21:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E9B1A22440
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB2149C51;
	Mon, 11 Aug 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="A6I1Yb0P"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102772D8393
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940288; cv=none; b=LEHXUaTyllTrTn+CQIgTfyhroyaY5P2ZlEMGr5l7f7gUytw4J1SowKcgVpvSM3uSZcHsZqqQrquE0EYXN7X2ZZ2+gg4y3oH2ZBuNad01spbh+lI/85xrwWR2ZX3Zyp0oqjmxyf9w2HVHJU6z+3ouFcdphKPxiywqwG+MLw9PgFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940288; c=relaxed/simple;
	bh=puiPMvRLC0fsCgBP3I9XxgD+HqX4Ja3xWQpNrCXy5lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfxFxveqmKY5s8WvJTMUrD2kSSxJ760IifPU/zt0Aq/Nk3VnfmL8dfUk8t2/jojmFXYNbmM6gbIn9KeMQNnZ0vCDTaDQgDAvuzDpJVEASBBUqmo+x2MuEaPjRC7rl7xT0H16HpdmP+C7opWnweCAUjqrW6dEOi471o3QGCFb2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=A6I1Yb0P; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70740598a9dso43527136d6.0
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1754940286; x=1755545086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QUZTA6GtaA7czamtY3xPr8PgEMTZeItGL8BIt7Y0OZY=;
        b=A6I1Yb0Pa1HhuV8UxmL3P10fGSibiEgkmYjEVAQ7d4MBABhskclsc7o6Kuq3xH5QkI
         s/Wsa6wUJliqubXpYP5zK7nxZGqudVdb7WudmZZKu7uR2pB/YPGdwoPSzjnCxej4AcEk
         WBerTvwBl3DAXsfIX9+XBkotIqBlEtpxKNQn0ParZQI+nYeaqtyvVPAfeNjA9FKmkm3x
         8W37aFksodEBRkfclnPnETRmF7M43afZC9nQ5/9GQGsaIThOf5AmISQ0SMYePk6iZXq/
         x4On5zduuwBP8pGHdgif8vG/UidTyOuZY+CdL2qDQFvflwIYZ+F+54q2VsJ0h8js9/vn
         Ftdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940286; x=1755545086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUZTA6GtaA7czamtY3xPr8PgEMTZeItGL8BIt7Y0OZY=;
        b=rqJDh8cp0mSIxV4PJdl7kVQS/QCKV8rv4gIKQVQSe23lhIwcL8LmBUgW9qa+EH68dY
         kmnXQpOXnzz4KEi147YQGRFPYi2KvoYWMkwb/jtpkrLnO7U3pdQlRCsZnhwMBZNe+B7l
         k2gQNWD6VQY9c9NrqHNQx51lf+JMDIq+Atrn29y3V1/oXi/Ca7a8C0T4+ZLCPBIMglKQ
         QDj7+U/CgAwWWHsRokNBG2AEjeKa6FtFPg9F2CUSqz0mT/Bqt2yCDmLMtR21NYhgcOQU
         pBFXaGuSluD/oIZ66jJJpUpg6qVPJFkQ38bCgK3q2aelokOwx9A6jtbTW07pocwNaT/a
         LIyg==
X-Forwarded-Encrypted: i=1; AJvYcCXFE39ayU8A4E0Eo3U+VY+/FnNiJ3b2iHHPVksj8E/hv1UCOBMRDHYGUntLzDev940k8Vj7NlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHtJxFwhMcFm5Y87M5s4ATznNaTlyoyZbQH97Cqmumv0rrZgR
	5cSbD0x5bWdTQSoJPMuvJeWybQBkU/oQ0v7MyDAd9V4+Lu7JaBGILVFoyl9IqeUHjQ==
X-Gm-Gg: ASbGncs+BlJJ+XWzWv4ocbir4D0iZ48+Rtv9NJgymJVdYmBHVqi/e9VCL2Sf+20kwmu
	h2Od0+chAuvuAvzEeVDQ3RWK5GrqVtHmC2QxsGahzgZn0pERoZp5q4AMLzoChd3NYLH46d9DZFd
	C8DpuE/G82HcWXMo2gsQPqCFS/7TjL0LhdhVDLKPcZxcZNDW1Ud7yA12gnbpA1R5DKzZwwnD8XB
	vnxMNiF6VNX+iH9XWWX2D3mD5JP7ZH26ZYjxXNmw1OtSd+A7FnzrvT+wwX90uUOTq50k3kLxJbf
	B6snibaFN0AgcdVnmTKWjzs8zwO7HVaaeJ8SSSYZlL8Qpk7xfW5ELUomltQAx1fcjjk9Cc9eZX4
	ZPeQGh4Y37/kkvw+Cf0y/C+pegvA4UuK7+CRaLuSY5lx3jmT+MlnEgg+Ud7yZKjIcdA==
X-Google-Smtp-Source: AGHT+IFt/3YKTBCSbCpS49sRmaeAcew9QCxCqdPIrUP1a6uOv4+01cnhkX80mFQqiyFrAfNyAT7OZg==
X-Received: by 2002:ad4:5fce:0:b0:6ff:1665:44ef with SMTP id 6a1803df08f44-7099a260910mr177522336d6.22.1754940283507;
        Mon, 11 Aug 2025 12:24:43 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm160795546d6.84.2025.08.11.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:24:42 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:24:40 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
Message-ID: <f442fe21-64bf-4669-8def-e1bf9259a6b8@rowland.harvard.edu>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
 <fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
 <1c1b5552-0b43-49fb-98f0-8d2477709160@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c1b5552-0b43-49fb-98f0-8d2477709160@kernel.org>

On Mon, Aug 11, 2025 at 01:06:03PM +0200, Jiri Slaby wrote:
> On 11. 08. 25, 8:16, Jiri Slaby wrote:
> > > @@ -5850,8 +5851,11 @@ static void port_event(struct usb_hub *hub,
> > > int port1)
> > >           } else if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
> > >                   || udev->state == USB_STATE_NOTATTACHED) {
> > >               dev_dbg(&port_dev->dev, "do warm reset, port only\n");
> > > -            if (hub_port_reset(hub, port1, NULL,
> > > -                    HUB_BH_RESET_TIME, true) < 0)
> > > +            err = hub_port_reset(hub, port1, NULL,
> > > +                         HUB_BH_RESET_TIME, true);
> > > +            if (!udev && err == -ENOTCONN)
> > > +                connect_change = 0;
> > > +            else if (err < 0)
> > >                   hub_port_disable(hub, port1, 1);
> 
> FTR this is now tracked downstream as:
> https://bugzilla.suse.com/show_bug.cgi?id=1247895
> 
> > This was reported to break the USB on one box:
> > > [Wed Aug  6 16:51:33 2025] [ T355745] usb 1-2: reset full-speed USB
> > > device number 12 using xhci_hcd
> > > [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor
> > > read/64, error -71
> > > [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor
> > > read/64, error -71

What shows up in the kernel log (with usbcore dynamic debugging enabled) 
if the commit is present and if the commit is reverted?

Alan Stern

