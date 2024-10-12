Return-Path: <stable+bounces-83597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2E499B680
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D7A1C210DD
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E3D84A4D;
	Sat, 12 Oct 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QVVfYXfo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED817579
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755822; cv=none; b=tKEAThFSKaM4lmg5DIi7o7fl7sHWcdrgVNQGWKpuKZy61Zq2m1FAyGIYcay5MFUDWoUvIHPtEKuKDnnc4dZMaAgNCTX9VVH2A9gcQk4VjOrBoOLKUFBk2yRNUcumR/cr6eHx51sZ8LH+Pk8p7tuGlaklUyj8SELTXJYvMkFCLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755822; c=relaxed/simple;
	bh=3/V95UUH2c0yoFKXBOsne5gPo4uvRHtx+5canAl8Hf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXCo2xavcwGFNwEzkKvJi1BYpROzvZAic5Bjs0DrdhWJhnfrZlEbdQYUstLdMWQD9Yya1/AW8gzff0EO9tx/ZlPz+gWcZI+vkQz6Pr9TPsDcEl/LWVjicP9URlIQii9+4UCRYBKoyz+HJAdjmjKGfQPPslKOLgIaKLrL8DO6/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QVVfYXfo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460464090d5so25869911cf.2
        for <stable@vger.kernel.org>; Sat, 12 Oct 2024 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728755820; x=1729360620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHItiWb5IrOjPY6NonGd8YD85E4uRbqHKk7wzTRMpY0=;
        b=QVVfYXfoAFm7gApBMqmBFCCZblh46itsVgGMwlm0nEmW2116jA3oijN6e5QgHP4eMY
         w6kAg0K5z9zW0nBMSIVLTHP5/atVTV9SajQFmK7oAIzv386WrS8cfaSLWL+8uhcH8x7A
         RrwXyhVRuDMquDzb88Kp7Kv3Ep4MCTp382W2F8MEkLqYM1FG4gZSVu3VwkGPr/3i3iYI
         rnoltBmUHnM0LnGhg2XR3UL0br1oz8zklK1KTxekHmLReU16/LYO4R1Rfxrupltkn+7g
         1VsikAJJxGo0AU5afB6n+E084BZi2QI5fzCvPywXoaaazvgCaVvngd2MTMURXp5QhuXp
         +B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728755820; x=1729360620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHItiWb5IrOjPY6NonGd8YD85E4uRbqHKk7wzTRMpY0=;
        b=IG3+QHtziWKb9Y0u78pS0t9WFycHYF70eVa6S7A+LY0K5gKRCZPIpQCpsZMV1HKmg2
         MD4PEdOT5w9wodOw/OULGzkN8RZ7N6JQH4F0z8ITC+0o6BtNY6DQfaSbavv240AypOzA
         CEDIamcSeY02pFQcCAV+Nej8Wuu8tRXucwFNAZyb/EeXm3tf8EDsOrx11veDZsgDWg91
         IwHmaeyePLsCqpgEpJ8ik2asvMZaKcglBcYlWRl13LjLD60UROk0jzq0ht5I3s0WPiLd
         tVQaIflXaq7SWSPek/RTqls6GZKIvPHDPCqascgPlv1SppHgaMlXmC4h3/lh1oGDTwYJ
         ZJzw==
X-Forwarded-Encrypted: i=1; AJvYcCWXaB5cFf1wrGOksap6gKdyQ0OBldIjW0Z6kLVL90C4ylGUIyd4brH1B7rnSeJzZq7a4L8ifrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3iN7B7XMRSeUjnDjEPqHTFGLcTHsHscnApkeBOqC5qOkLoc2
	3JmN8kxlrGm7q7F6RO2qW8bRr7BYbA9/yMVZhJEFD6QWIiSSCfy0i8e/RnNWqI4=
X-Google-Smtp-Source: AGHT+IHE+bbFbZOnG1qPJvndk0MHjt9z6Kp5I+VnW9c5Fa3W+P8GxcpQOqIq4SjY6c5SXlJG/covIA==
X-Received: by 2002:a05:6214:5b87:b0:6cb:d302:f0cf with SMTP id 6a1803df08f44-6cbeff63b0fmr112926426d6.28.1728755819725;
        Sat, 12 Oct 2024 10:56:59 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b75c9sm27548406d6.45.2024.10.12.10.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 10:56:59 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:56:42 -0400
From: Gregory Price <gourry@gourry.net>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
	ira.weiny@intel.com, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <Zwq4WsTIwj2jAWmE@PC2K9PVX.TheFacebook.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
 <a7b8a007-907a-4fda-9a35-68faed109ed3@icloud.com>
 <6709647f66d94_964f2294ae@dwillia2-xfh.jf.intel.com.notmuch>
 <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>

On Sat, Oct 12, 2024 at 07:40:13AM +0800, Zijun Hu wrote:
> On 2024/10/12 01:46, Dan Williams wrote:
> > Zijun Hu wrote:
> >> On 2024/10/11 13:34, Dan Williams wrote:
> >>> In support of investigating an initialization failure report [1],
> >>> cxl_test was updated to register mock memory-devices after the mock
> >>> root-port/bus device had been registered. That led to cxl_test crashing
> >>> with a use-after-free bug with the following signature:
> >>>
> >>>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem0:decoder7.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
> >>>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem4:decoder14.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
> >>>     cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[0] = cxl_switch_dport.0 for mem0:decoder7.0 @ 0
> >>> 1)  cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[1] = cxl_switch_dport.4 for mem4:decoder14.0 @ 1
> >>>     [..]
> >>>     cxld_unregister: cxl decoder14.0:
> >>>     cxl_region_decode_reset: cxl_region region3:
> >>>     mock_decoder_reset: cxl_port port3: decoder3.0 reset
> >>> 2)  mock_decoder_reset: cxl_port port3: decoder3.0: out of order reset, expected decoder3.1
> >>>     cxl_endpoint_decoder_release: cxl decoder14.0:
> >>>     [..]
> >>>     cxld_unregister: cxl decoder7.0:
> >>> 3)  cxl_region_decode_reset: cxl_region region3:
> >>>     Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP PTI
> >>>     [..]
> >>>     RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
> >>>     [..]
> >>>     Call Trace:
> >>>      <TASK>
> >>>      cxl_region_decode_reset+0x69/0x190 [cxl_core]
> >>>      cxl_region_detach+0xe8/0x210 [cxl_core]
> >>>      cxl_decoder_kill_region+0x27/0x40 [cxl_core]
> >>>      cxld_unregister+0x5d/0x60 [cxl_core]
> >>>
> >>> At 1) a region has been established with 2 endpoint decoders (7.0 and
> >>> 14.0). Those endpoints share a common switch-decoder in the topology
> >>> (3.0). At teardown, 2), decoder14.0 is the first to be removed and hits
> >>> the "out of order reset case" in the switch decoder. The effect though
> >>> is that region3 cleanup is aborted leaving it in-tact and
> >>> referencing decoder14.0. At 3) the second attempt to teardown region3
> >>> trips over the stale decoder14.0 object which has long since been
> >>> deleted.
> >>>
> >>> The fix here is to recognize that the CXL specification places no
> >>> mandate on in-order shutdown of switch-decoders, the driver enforces
> >>> in-order allocation, and hardware enforces in-order commit. So, rather
> >>> than fail and leave objects dangling, always remove them.
> >>>
> >>> In support of making cxl_region_decode_reset() always succeed,
> >>> cxl_region_invalidate_memregion() failures are turned into warnings.
> >>> Crashing the kernel is ok there since system integrity is at risk if
> >>> caches cannot be managed around physical address mutation events like
> >>> CXL region destruction.
> >>>
> >>> A new device_for_each_child_reverse_from() is added to cleanup
> >>> port->commit_end after all dependent decoders have been disabled. In
> >>> other words if decoders are allocated 0->1->2 and disabled 1->2->0 then
> >>> port->commit_end only decrements from 2 after 2 has been disabled, and
> >>> it decrements all the way to zero since 1 was disabled previously.
> >>>
> >>> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> >>> Cc: <stable@vger.kernel.org>
> >>> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: Davidlohr Bueso <dave@stgolabs.net>
> >>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> >>> Cc: Dave Jiang <dave.jiang@intel.com>
> >>> Cc: Alison Schofield <alison.schofield@intel.com>
> >>> Cc: Ira Weiny <ira.weiny@intel.com>
> >>> Cc: Zijun Hu <zijun_hu@icloud.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>> ---
> >>>  drivers/base/core.c          |   35 +++++++++++++++++++++++++++++
> >>>  drivers/cxl/core/hdm.c       |   50 +++++++++++++++++++++++++++++++++++-------
> >>>  drivers/cxl/core/region.c    |   48 +++++++++++-----------------------------
> >>>  drivers/cxl/cxl.h            |    3 ++-
> >>>  include/linux/device.h       |    3 +++
> >>>  tools/testing/cxl/test/cxl.c |   14 ++++--------
> >>>  6 files changed, 100 insertions(+), 53 deletions(-)
> >>>
> >>> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >>> index a4c853411a6b..e42f1ad73078 100644
> >>> --- a/drivers/base/core.c
> >>> +++ b/drivers/base/core.c
> >>> @@ -4037,6 +4037,41 @@ int device_for_each_child_reverse(struct device *parent, void *data,
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
> >>>  
> >>> +/**
> >>> + * device_for_each_child_reverse_from - device child iterator in reversed order.
> >>> + * @parent: parent struct device.
> >>> + * @from: optional starting point in child list
> >>> + * @fn: function to be called for each device.
> >>> + * @data: data for the callback.
> >>> + *
> >>> + * Iterate over @parent's child devices, starting at @from, and call @fn
> >>> + * for each, passing it @data. This helper is identical to
> >>> + * device_for_each_child_reverse() when @from is NULL.
> >>> + *
> >>> + * @fn is checked each iteration. If it returns anything other than 0,
> >>> + * iteration stop and that value is returned to the caller of
> >>> + * device_for_each_child_reverse_from();
> >>> + */
> >>> +int device_for_each_child_reverse_from(struct device *parent,
> >>> +				       struct device *from, const void *data,
> >>> +				       int (*fn)(struct device *, const void *))
> >>> +{
> >>> +	struct klist_iter i;
> >>> +	struct device *child;
> >>> +	int error = 0;
> >>> +
> >>> +	if (!parent->p)
> >>> +		return 0;
> >>> +
> >>> +	klist_iter_init_node(&parent->p->klist_children, &i,
> >>> +			     (from ? &from->p->knode_parent : NULL));
> >>> +	while ((child = prev_device(&i)) && !error)
> >>> +		error = fn(child, data);
> >>> +	klist_iter_exit(&i);
> >>> +	return error;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(device_for_each_child_reverse_from);
> >>> +
> >>
> >> it does NOT deserve, also does NOT need to introduce a new core driver
> >> API device_for_each_child_reverse_from(). existing
> >> device_for_each_child_reverse() can do what the _from() wants to do.
> >>
> >> we can use similar approach as below link shown:
> >> https://lore.kernel.org/all/20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com/
> > 
> > No, just have a simple starting point parameter. I understand that more
> > logic can be placed around device_for_each_child_reverse() to achieve
> > the same effect, but the core helpers should be removing logic from
> > consumers, not forcing them to add more.
> > 
> > If bloat is a concern, then after your const cleanups go through
> > device_for_each_child_reverse() can be rewritten in terms of
> > device_for_each_child_reverse_from() as (untested):
> > 
> 
> bloat is one aspect, the other aspect is that there are redundant
> between both driver core APIs, namely, there are a question:
> 
> why to still need device_for_each_child_reverse() if it is same as
> _from(..., NULL, ...) ?
> 

This same pattern (_reverse and _from_reverse) is present in list.h
and other iterators. Why would it be contentious here?

Reducing _reverse() to be a wrapper of _from_reverse is a nice way
of reducing the bloat/redundancy without having to update every
current user - this is a very common refactor pattern.

Refactoring without disrupting in-flight work is intrinsically valuable.

> > - *
> > - * Iterate over @parent's child devices, and call @fn for each,
> > - * passing it @data.
> > - *
> > - * We check the return of @fn each time. If it returns anything
> > - * other than 0, we break out and return that value.
> > - */
> > -int device_for_each_child_reverse(struct device *parent, void *data,
> > -				  int (*fn)(struct device *dev, void *data))
> > -{
> > -	struct klist_iter i;
> > -	struct device *child;
> > -	int error = 0;
> > -
> > -	if (!parent || !parent->p)
> > -		return 0;
> > -
> > -	klist_iter_init(&parent->p->klist_children, &i);
> > -	while ((child = prev_device(&i)) && !error)
> > -		error = fn(child, data);
> > -	klist_iter_exit(&i);
> > -	return error;
> > -}
> > -EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
> > -
> >  /**
> >   * device_for_each_child_reverse_from - device child iterator in reversed order.
> >   * @parent: parent struct device.
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 667cb6db9019..96a2c072bf5b 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -1076,11 +1076,14 @@ DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
> >  
> >  int device_for_each_child(struct device *dev, void *data,
> >  			  int (*fn)(struct device *dev, void *data));
> > -int device_for_each_child_reverse(struct device *dev, void *data,
> > -				  int (*fn)(struct device *dev, void *data));
> >  int device_for_each_child_reverse_from(struct device *parent,
> >  				       struct device *from, const void *data,
> >  				       int (*fn)(struct device *, const void *));
> > +static inline int device_for_each_child_reverse(struct device *dev, const void *data,
> > +						int (*fn)(struct device *, const void *))
> > +{
> > +	return device_for_each_child_reverse_from(dev, NULL, data, fn);
> > +}
> >  struct device *device_find_child(struct device *dev, void *data,
> >  				 int (*match)(struct device *dev, void *data));
> >  struct device *device_find_child_by_name(struct device *parent,
> 

