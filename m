Return-Path: <stable+bounces-171939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B4B2EB82
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 04:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CAB7BC3FC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFED2D47F3;
	Thu, 21 Aug 2025 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jk+B531y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DA2D3EC7
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744997; cv=none; b=OCVQPqDXVSddGzx2cou5Yvlodx1LVEq9sn4bBEkl+JCuXyK14bXmeXZIVGg1COgS31Yg0asBlnQZhXLG1S50Q1oTEPy2/xJjAl7mEhuCTfGqBVJxsTy9kp/QMfG9dcAKdu/MlaoCT7Oipij+oxkLUu041w9a68wJnVfZu9w8BQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744997; c=relaxed/simple;
	bh=XHwx3T0vj4Lv+s2Y6qqwZiObkh2r7IivbMwDx2b9V+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcL4RZoImo36EvbhRnQaabbsrG3gMqgbxmagVJ5Iigb+eJz9B8hRLYnHYSBpHlEN89XpbS9GYaFbpzGOByvH0qlfvgYQbyNmNiPiXWHkoCck9xnXChTMPiL5w5XQHRy4O/iE69rHlRbETYQY1c7r/WNmh32W9X2qE4OXjeX7Bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jk+B531y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-245f19aab74so4072885ad.0
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755744995; x=1756349795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H996zq4Ef8LWOErXtNjqGqwGdLBd8tccS6w3vtc0ofM=;
        b=jk+B531yo+tDFD0GgYH9CPrdGm4F0E8ZaMTy3+3IZduxdZqHtIgSghwYVADFBsnF4W
         B6+JxtFkdUV3FSz3FWaYdOPd8dgkSSC8ShNaMYm1RXAFMdgXe7AGtpH0DCvxI64ifNhT
         1SwXI4i5NAZ8pKkOUcKWymv6DhbR2D4txZT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755744995; x=1756349795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H996zq4Ef8LWOErXtNjqGqwGdLBd8tccS6w3vtc0ofM=;
        b=UJa8RmKlWzHOO0xRzR82G01IynEYFWyTi0MtnLp9megoITqtCp1a1fYQgPfsb6SqdW
         p1qNCKzug+HidDEIKbaSsjlJG67/LJbdtc5G95hl8DEpJq2pHirrk1GB4aMlZ1ifYArs
         reNlfSlmC7fUmM/GqRBl3wJAVRoDYSqGpDcsuxWSYKbnVL5pH3L/Y7tsRl8o+Szv7Ji6
         iwXN5nR+eDXsjDf0AxVT97OV5NiyIw/n/30HcCJNX9qct3hGyJGsq5bcpoFAZvWo2FEN
         eCyZSy9JzPA1OpVi8vp6UQoYQ7X6KS43564U7hOGDejKhY5tjBwZpRB1GZ8SuzE8q+0u
         Bp6w==
X-Forwarded-Encrypted: i=1; AJvYcCVlmi1tGSSPrB9Ibhzm5qtJG4tPh7mGu0PaCIQFSjg4ogMu8uRDvDJs4M8/kSIy5ikultu/Guk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaPR5QAm5T6NQ8+RIXInGW0LZia9ee/QSG3/Ve08UDJ8cjSxh
	0mjPkG/EFg88Gkwkrk49EKmQX+3AdnJyo0FTpHRu2PKk3gHJrAs2Oqke2STS/oVUIg==
X-Gm-Gg: ASbGncsIlziMKOmRTNptHEHon81c9onL/eBDXyhyIgoELcTZgeItzzypNI4u865D+hW
	t8ad9bFeGWDuOS5zcjDeML/fiwCpkFr5Qv3QmKVTl+PlG8lRIMRdFlEI5CY+87w8RTAzoyr0xHG
	fyfLJB8vKVRcDvP+2DCAgVp1tj9vtq/T1uoFs7rYa7E09q2Okr5uAhnxGGac+BRmitGtZDC8Qp6
	E2sBDLa/DYC7CUa02drqIG1tSvrm1G8teT3oeWi7hX9lKApE4wvLMS3vAeF0nTepLgz3Aysv7Ql
	Sunr6lKvRf+IPcE9mu0gAH/vLS+aWv/Q6+sNY08B7ELuB03NGALmnT8aNj3lycBPGTVOjevCX6P
	J0jQ8BufikdnFa06wyGvC1BxhgyT8e+RE10zum5v2rhrS3FUOXKvhleyHmN1n
X-Google-Smtp-Source: AGHT+IFfmuP/LFF7jXoz31JRLaGXSHGr8GvB67Fhz5PVKoovm91wDMvqkaL2E7H6MP4gZJtQNndaNg==
X-Received: by 2002:a17:903:3bcc:b0:240:49e8:1d3c with SMTP id d9443c01a7336-245fed7d21amr10502565ad.35.1755744995342;
        Wed, 20 Aug 2025 19:56:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2283:604f:d403:4841])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed4c7588sm40352175ad.101.2025.08.20.19.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 19:56:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:56:33 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aKaK4WS0pY0Nb2yi@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>

On Thu, Aug 21, 2025 at 08:54:52AM +0800, Ethan Zhao wrote:
> On 8/21/2025 1:26 AM, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > max_link_speed, max_link_width, current_link_speed, current_link_width,
> > secondary_bus_number, and subordinate_bus_number all access config
> > registers, but they don't check the runtime PM state. If the device is
> > in D3cold, we may see -EINVAL or even bogus values.
> My understanding, if your device is in D3cold, returning of -EINVAL is
> the right behavior.

That's not the guaranteed result though. Some hosts don't properly
return PCIBIOS_DEVICE_NOT_FOUND, for one. But also, it's racy -- because
we don't even try to hold a pm_runtime reference, the device could
possibly enter D3cold while we're in the middle of reading from it. If
you're lucky, that'll get you a completion timeout and an all-1's
result, and we'll return a garbage result.

So if we want to purposely not resume the device and retain "I can't
give you what you asked for" behavior, we'd at least need a
pm_runtime_get_noresume() or similar.

> > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > rest of the similar sysfs attributes.
> > 
> > Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Brian Norris <briannorris@google.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >   drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
> >   1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5eea14c1f7f5..160df897dc5e 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
> >   				   struct device_attribute *attr, char *buf)
> >   {
> >   	struct pci_dev *pdev = to_pci_dev(dev);
> > +	ssize_t ret;
> > +
> > +	pci_config_pm_runtime_get(pdev);
> This function would potentially change the power state of device,
> that would be a complex process, beyond the meaning of
> max_link_speed_show(), given the semantics of these functions (
> max_link_speed_show()/max_link_width_show()/current_link_speed_show()/
> ....),
> this cannot be done !

What makes this different than the 'config' attribute (i.e., "read
config register")? Why shouldn't that just return -EINVAL? I don't
really buy your reasoning -- "it's a complex process" is not a reason
not to do something. The user asked for the link speed; why not give it?
If the user wanted to know if the device was powered, they could check
the 'power_state' attribute instead.

(Side note: these attributes don't show up anywhere in Documentation/,
so it's also a bit hard to declare "best" semantics for them.)

To flip this question around a bit: if I have a system that aggressively
suspends devices when there's no recent activity, how am I supposed to
check what the link speed is? Probabilistically hammer the file while
hoping some other activity wakes the device, so I can find the small
windows of time where it's RPM_ACTIVE? Disable runtime_pm for the device
while I check?

Brian

