Return-Path: <stable+bounces-114229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C0A2BFEC
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74F07A44FC
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A01DC9AD;
	Fri,  7 Feb 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMu4QSSn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB132C8B;
	Fri,  7 Feb 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921893; cv=none; b=SFvtTXMagPpXp/TNIXHUgZjM9oDxcNnTTbct6uCU7Joj5g1WWadXTg6Yrzknh1hRzMUI3cm4C/TULioJROPhlf0TGrDM/2bBdb9TSxT6DJWvJr89mKA8RbbzzMpz7GNKlGzvTrfmKEdFM+oCpKiB/w7A1dtfizY1mpi7MFWuKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921893; c=relaxed/simple;
	bh=V0fGlyJvT7Hjqw9WjWsPJ90tE7K5PrHUAzyAOBVXL5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYSjzk32df/BdV6boBp1FBhkadbs3Y8qYVDbDYORbUo2tOboG4PXJ8wKtV4jlKtUHcCIAvsJ6Jpgd/jcEFXO17Mbuq8tKqIkdzm5bDGu8iOjmvn899BuvM599JD5oBh0swnqNiyOpoO/skSOySQju3vUv3X+XZhuSp66wdv5WOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMu4QSSn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso334378566b.3;
        Fri, 07 Feb 2025 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738921889; x=1739526689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wGGRZ6eVMPwwcLMRyBcLXweN9TMQ9rUUz4JCLjz+hk=;
        b=DMu4QSSnnHtoOoSUDBBjkG82jjo3xMrAc/0BaoHgAUTwM6hnN3wtxlZvR3WzCWzk5v
         sYS5sOzUcj47pmuP5h6C5ATKghyUeM0EWu6I/CAbYgjGkSm0dK+jJjtU0/nTcYPGz6YC
         uVU/bwPhqQUWlbvpCp7wg3JwGQ1yPieoAx94lCB8KJ3iN461HHIPim6AVh4DDcEZtf7/
         Pa/VQgjy9N3eAXgL9gdhVmY48ITADgqeMOfxeHJQTbxyeWiMEF7zpIa+7PjST+ReA3Mb
         xg9EL22FvLAF6z19UvrRTAyLCIACVLNl7YH7bUp2L/w+9axtdTXTSi86vZ/lQLTsJOAP
         kRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738921889; x=1739526689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wGGRZ6eVMPwwcLMRyBcLXweN9TMQ9rUUz4JCLjz+hk=;
        b=RDpdO+BDyXcw1DuyjTug1uG+6Y2NIsdSvUC2uXHo7OiUOtVzwwH+jf2pvNDNykzI2Z
         v3fPdQ7oFUoLVEcSTZnveb6MjZcG/qBdPVGASlq2O6V93SUaWss1w0jTXaI7/RwUqkCl
         xJKxjqB75AZQ8KY+a0MJBvNtSwhvKVDNGJPCoyC3wb2ButvZPqUauzx1BJN4P+C+4fwq
         xbDQwIxVYbwy6sfBVRCfYT1VIslK5LY0j6nz9mwthxhmuk0/lJOAluM4v/mkNxQ/4N/E
         Tnb7JpFquZJtLtulElD6/EIQK162hn+LnRsvGQS3v+GDrfWirk8bkXjiaE3DCr+VRTh7
         N2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmcHBAIHFn4C/KZ2QlJ26sAv2DpNu6vjvOPK49waqO80/0GnhVJYjck37TnAuSPaqaioO5Incc@vger.kernel.org, AJvYcCWZQyAV+Z8Jp7xcvLDKiX9HFJQNQCpnijPRGvZvOBQrw9qF9uCIRslviMMdT4tBDdvo6UK6qySVCCsv@vger.kernel.org, AJvYcCXorLEfPEtccMM0yhUjhmxBfEQACX5Te7h0YVsA7+4nBuRcEuosIGry2ihoP5aBxKRek1bO1Z967+gFkYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTM4sJVL2nPyCcXnE7DK3ju2J1MUcHiu/phoKNIJegF59EHKS
	4MhyYsfbFMIMOYIihjyw2YFF3Y4Uj0pYe/SZYwZ6t7CtUzfkeBJl
X-Gm-Gg: ASbGnctvrjHKIjPZ8F+B0nOCf6yQ1sZLnC0Xw10VttwVavPu2IlgaBycakLxVFFwemj
	XhIdrISjxa7ozpKFO8p4O1wy/bue5Tmvqw1ADJju3sMbvhfZMhd1OSXO+O4sokuNmi1B9Px2I55
	1I8ou+gIrTd8tswDZaEJFyp/cswpSdqPdPzBh4JvOLC+RmMVLi6MbIwVFv/czlLrcF7EBY+gWDy
	5DBiV/9+EQCjxA0RKsOmhMt3nJMicM22afBAFlQ5NbBeDKP0FXELTQMS9oHeCZ3309xdVyZxK1z
	KJD0cHCNCAtbq3hQkfOxbNC2nJ8OIBf4
X-Google-Smtp-Source: AGHT+IHEnuoK0DdZh7BAPuOp6Egge7rYikDzdldH2vQ4C47iwFhkjEKAai76Y6xOWAXjq0vLUwU5WQ==
X-Received: by 2002:a17:907:803:b0:ab2:ea29:a2 with SMTP id a640c23a62f3a-ab789c2fa71mr264209766b.48.1738921888906;
        Fri, 07 Feb 2025 01:51:28 -0800 (PST)
Received: from foxbook (adtt137.neoplus.adsl.tpnet.pl. [79.185.231.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab791ee091esm20140566b.144.2025.02.07.01.51.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Feb 2025 01:51:28 -0800 (PST)
Date: Fri, 7 Feb 2025 10:51:24 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
Message-ID: <20250207105124.3cb2e6ae@foxbook>
In-Reply-To: <CAHN5xi1HoTHx5bye6v24eRWzuKLXcyp6zc4wVpYDyHcR4yu99A@mail.gmail.com>
References: <20250205053750.28251-2-ki.chiang65@gmail.com>
	<20250205224511.00e52a44@foxbook>
	<CAHN5xi1HoTHx5bye6v24eRWzuKLXcyp6zc4wVpYDyHcR4yu99A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 14:59:25 +0800, Kuangyi Chiang wrote:
> >  
> > >       case COMP_STOPPED:
> > > +             /* Think of it as the final event if TD had an error */
> > > +             if (td->error_mid_td)
> > > +                     td->error_mid_td = false;
> > >               sum_trbs_for_length = true;
> > >               break;  
> >
> > What was the reason for this part?  
>
> To prevent the driver from printing the following debug message twice:
>
> "Error mid isoc TD, wait for final completion event"
>
> This can happen if the driver queues a Stop Endpoint command after
> mid isoc TD error occurred, see my debug messages below:

I see. Not sure if it's a big problem, dynamic debug is disabled by
default and anyone using it needs to read the code anyway to understand
what those messages mean. And when you read the code it becomes obvious
why the message can show up twice (or even more, in fact).

I would even say that it is helpful, because it shows that control flow
passes exactly as expected when the Stopped event is handled. And it's
nothing new, this debug code always worked like that on all HCs.

Regards,
Michal  

