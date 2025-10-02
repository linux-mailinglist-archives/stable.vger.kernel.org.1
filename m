Return-Path: <stable+bounces-183029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7BBB3673
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99B13A519C
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F522FFDEA;
	Thu,  2 Oct 2025 09:11:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71C2DCF43
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396263; cv=none; b=J6T0uKUT7BZ3BApEh8KTCEK8RjezeN1a4TYcpBl4bwVJfn6sOLxgfnnPC6CnzsQabVfmBEmQ/XLi+IaTIoS+JIdwfevda4o5NrEoAejyLIDkIjgBNTv2HRw4vC2bmrFJAq+TSzOejzqCsvOvIcRWSX7k/eBjAKIO3w2GmTFTC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396263; c=relaxed/simple;
	bh=0x4mni42h3u3+Yk8psdRxeM5zzr4vUX2feS9t68m2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd8IMUNJ4HUW6vDo4xakvkjYfjWcg/iNSZgFViPhK5YpQr0D6MHOlfHhLn5/Q21a3QoZ2QmR1ztPFiG4pG/2yLrzvbR95d2pm4OoTrQgKk2JqU9/at+Yrdff5tyUpLC+d500JJ7nZt0Pk6bm4WSgQuTskUc5jb8xdqI+UIuesBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so1226301a12.1
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 02:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396260; x=1760001060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRDmlXYbuy08sNt5xF8Zckv3BDEt/TW4zDdfvpxaR3k=;
        b=BSJrtfxp8sQabEccwyQJECQ78d+/xXgU3AcyX8DNfk95WoNkXt4P+eveaSb11pE8V7
         +4Eq7sF6MOKOy4/sTE49VnjkJvB22987iRQ2bEt3CBblmFPujgf3a4zGwVRtfI0Evym+
         uaBQwJSgc0KpYRAsk6Q8+kBXw0N/GCy774vUDzZNNEAkWlcLhDvswu/Tc4e6WbrZiceB
         xSX+RRvLImpGAvP8X2rxlImTm2cRvJMA3i4e+94gjyhvUwqKIxKzwZq0B1LpH6daxsTj
         4khWpMpdiu5LB14FQRROfVFcUb35BXNu6EKQqRzhaO8JEYvi1B/fjJAJwgnw/abU6pQB
         aVYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmzcvMuchKJ+1MaxcaZBrlwteLzZ6/TiJlR2fW19DaVuytzkcNgAH0jzK7gJJYck23VvXquBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZWlly4/x5HGMce8lRTWizPTshht9i2nF3Ig1iOSKZnzDVrsf
	RumA647Sgs49mxTgiRcgr8DIYQQja5Ogh05b37yXRzo952QXPZVPy8cK
X-Gm-Gg: ASbGnctcC9c4/dkdPzbKYPmVAC89Wz2fhtNGYxphI8qV0MMyePkkVyhP/YrN7s+3cCX
	eFKGAvC5Miyueoqt+EwIhU+E7Vsf+NXq61YpSl+ftqeSV0GoHbd+ffCnSuxQmVar3U4eC0NMkiQ
	pduf4Gkv25vSR9jRKl419ToDsL+TbsG60cML9ONxANkTUrria+Dhq/p1q+xrCUsxBmUTcXZVEj4
	IGhzlV9xuJXkTa7zJkuA0ZNMas7cpyQPbFtPIs+iTRK8YCNkN7iJvNcGwuogw86tdGlrMhDZkhu
	hIiZsadhjsh8ZQ9OigF9LvBOYjA4kROSTKh+DhyHtWARBvRvCBdGTTzr+orVPYCzXLcWidFlQ1j
	6EanWvW8B7k9W/BN4N3civVXwK7A1b8hgZ4Zj+g==
X-Google-Smtp-Source: AGHT+IGI0lLEvsbF1QPCvI8L4Q/FaURN2Mex33lSpcN9SL3uUzSJV82rsbQoChB7SREpyehAucnnhQ==
X-Received: by 2002:a05:6402:d08:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-63678c9f53cmr6776854a12.37.1759396259611;
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffa4dsm1428844a12.29.2025.10.02.02.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Date: Thu, 2 Oct 2025 02:10:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Message-ID: <z5thnuj2nwzuk7wp7kentekm7zx6v6fh5f6zknerdbld665guo@6uxxl7emi3be>
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
 <20251001213657.GA241794@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001213657.GA241794@bhelgaas>

On Wed, Oct 01, 2025 at 04:36:57PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 29, 2025 at 02:15:47AM -0700, Breno Leitao wrote:
> > Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> > when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> > calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> > does not rate limit, given this is fatal.
> > 
> > This prevents a kernel crash triggered by dereferencing a NULL pointer
> > in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> > AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> > which already performs this NULL check.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Thanks, Breno, I applied this to pci/aer for v6.18.  I added a little
> more detail to the commit log because the path where we hit this is a
> bit obscure.  Please take a look and see if it makes sense:

Thanks! That’s exactly what I would have written if I actually knew what
I was doing. :-)

