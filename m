Return-Path: <stable+bounces-116529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9824A37B5C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 07:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1016C3A9D42
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 06:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8C17BB35;
	Mon, 17 Feb 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vn3BOK2A"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEB383A5
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773863; cv=none; b=F5w5ECTVgE62/T1R3HzC0qTQ7raoS69xjptcHxZjfjMxKwDzBxl6P3GBI3wS456Mo03mR6jv+GwZCpxAGY8CLQzp+e8L/58LP1zZO1mZdMJmliTL+1cKspg7cqMZ76BkdCml2BhGqvMQko50mB2wDK26JML1U7gnwQLDnUgy2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773863; c=relaxed/simple;
	bh=KlWfU6yVdYqXXkIRsGuYLgdSZ86bNp7r/wlf/JvN+O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXNDsZln+q8Z05B8vZFiGXYF5b2wFzNaYX1Rourr589c+1hipQLW+wauNt2cg5bmZznmFke3T2LKUEn7aoZ+GWQ2uSCpsdYNq/G7+9kaGC3D8UihXNWrDDXIyTWehmJxNaAfX8s5VQEVVrYe3z5iAth116ZQ4MVHO4gWUhbyT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vn3BOK2A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739773859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSbkq0nAzlcx3GRcxRq0rHk3/NNkNXvn8agIEIdBHzc=;
	b=Vn3BOK2A3y9iasejumNr1iKWCEwu6PTtI4D8lTuSP3lM0+Bmm5kMo88wqsQubI35rDdt5P
	HQmWILPCNo+osEAYZ3nRQ4pMHAkuTMXKp+FwFLa4fIBe/RbxbJZVJfVP276w2uCSTAu25W
	WmNO86PNShKXF5EW9e3WH0RqnTtCVcY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-NBKO0KFlNmOm1gAQIMTlnQ-1; Mon, 17 Feb 2025 01:30:58 -0500
X-MC-Unique: NBKO0KFlNmOm1gAQIMTlnQ-1
X-Mimecast-MFC-AGG-ID: NBKO0KFlNmOm1gAQIMTlnQ_1739773857
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f2f78aee1so1392421f8f.0
        for <stable@vger.kernel.org>; Sun, 16 Feb 2025 22:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739773857; x=1740378657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSbkq0nAzlcx3GRcxRq0rHk3/NNkNXvn8agIEIdBHzc=;
        b=QQfFjNQp0uEDKerkhckZasRkYpD+PQTCz3bbtr2Ht4hL6a1Am6BD1+eDPaelErR3KY
         Yu/kRW7vr2uZr0C69dN4Te3i3Jx7bZDGhH5Gw0h7OHD4mNdewyxRax4PkikTkXh2ryUx
         PvPez9Z8Dby2j7OMNYZCTCeIvhwxxqCHB5NBhsvPWmn3JdzG1Rdf/cKEYM/BzFPKcYZ4
         kssbWKC8DJroV4vlMkDPNW/y6kpofg2L/FYLN0QztRmxRgfQWojJLcELXf4gZhZ1rJTx
         34ICDM23s8CUcOKk/6mMZpAhDdDxk8hOpfgcBjuxFlB7dd84/WvO83ggtSlGKoMRUsQC
         PPkw==
X-Forwarded-Encrypted: i=1; AJvYcCWkQ1FzoYDSyrzd+IUetYLd2HUP3fkLaYHCnHibHpirLNEl7t9O9QNKWVmUF7hHDE4z6PLD5/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJEtz5kF22NHymGCTD3gExaxRU7is5QhpD67jwcy4ELWSwq3r
	Nd8msh11/ZNaE6e1Iy5zKSiMU0sZqzhCAMdRt/SfWJca45Uh7kFwfzAqR3elGNMIeIZ2CbZWvjc
	OPsRfmT89xIMnYqdJ1DV4wlPjkFvLFXibmhW1586TXoMu3itff+hONA==
X-Gm-Gg: ASbGncuG9vQyqSuHM+w8kJ9TSolzOPPaCQoxEcH+yCylRiqzZPAVKknyZPkbosHKvFZ
	IufjP6hBCP0a3YBC18hl6MOei7NDhTiQRZ8Fa0xaNQ88KvX9METT0ZM704sJCGHrBmU8hciSDXg
	bw6ZnD9tQwLI4ONaM8y9Uaa/qY7alUJt2niAf66vcJ1E14SLJgCtf1I4OHcYRe6mOczxJmhHbud
	G7Zjmji2urvxyyNqPSDCIb19FuDgz4zN8/3SgWz7wCoPAZam9sq88mFph3FbpZoP6y5Oy3ISCro
	Vkw+EqqCG6XjwZVK7787XIuw1/Fyu+7fnw==
X-Received: by 2002:a5d:64e6:0:b0:385:faf5:ebb8 with SMTP id ffacd0b85a97d-38f339dec87mr7221682f8f.7.1739773857165;
        Sun, 16 Feb 2025 22:30:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHttA9fha0k/9govYLax1zHGBuPJ4nojLhARVkvqFPQSjco5hSshV1vhLQo6S+SjSbefkXQtA==
X-Received: by 2002:a5d:64e6:0:b0:385:faf5:ebb8 with SMTP id ffacd0b85a97d-38f339dec87mr7221665f8f.7.1739773856881;
        Sun, 16 Feb 2025 22:30:56 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4335sm11548426f8f.15.2025.02.16.22.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:30:56 -0800 (PST)
Date: Mon, 17 Feb 2025 07:30:54 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Waiman Long <llong@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@vger.kernel.org>
Subject: Re: Suspend failures (was [PATCH 6.13 000/443] 6.13.3-rc1 review)
Message-ID: <Z7LXniBEa_u5atXS@jlelli-thinkpadt14gen4.remote.csb>
References: <20250213142440.609878115@linuxfoundation.org>
 <e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com>
 <2025021459-guise-graph-edb3@gregkh>
 <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
 <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
 <012c4a3a-ead8-4bba-8ec9-5d5297bbd60c@redhat.com>
 <905eb8ab-2635-e030-b671-ab045b55f24c@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <905eb8ab-2635-e030-b671-ab045b55f24c@applied-asynchrony.com>

Hi,

On 15/02/25 20:57, Holger Hoffstätte wrote:
> On 2025-02-15 02:35, Waiman Long wrote:
> <snip>
> 
> > Commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> > earlier for hotplug") is the last patch of the 3 patch series.
> > 
> >   1) commit 41d4200b7103 ("sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes")
> >   2) commit d4742f6ed7ea ("sched/deadline: Correctly account for allocated bandwidth during hotplug")
> >   3) commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > 
> > It looks like 6.13.3-rc1 has patches 2 and 3, but not patch 1. It is
> > possible that patch 3 has a dependency on patch 1. My suggestion is
> > to either take patch 1 as well or none of them.
> Now that we have 6.13.3-rc3 passing all tests I got curious and applied
> the whole series again. And voila: suspend works reliably (3 out of 3).
> Mystery solved.
> 
> So Greg, feel free to add the whole 3-part series in the next round.

Apologies for looking into this late, but thank you so much, Holger, for
the report and Waiman for catching the missing change!

Best,
Juri


