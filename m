Return-Path: <stable+bounces-219889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNDwICH3oGk8oQQAu9opvQ
	(envelope-from <stable+bounces-219889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:45:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B61B19AB
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354E230528A8
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7DA272803;
	Fri, 27 Feb 2026 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJy1o4QL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5828D8E8
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156701; cv=none; b=O4zfODFbSXnyGoDK42fxabt80baXUESvwFZJDMiHw6VsRw2Px3siHYzOpaWPeXRfF5QKZkISVB4xGv8YjIifw88NDhn/aloAdtlqkxf9LmWTP/V2oJnnsnGdyqwVJioq19INNrCIy2e3xgwWHG5SojiuQHqoeg46WGqqgDt/nwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156701; c=relaxed/simple;
	bh=NTY89IdzpzMF/vamWnS8uagHAc6qdvmbw2nDVuvCKx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuaxcWdAEXOGuZS5QAQbF2Izy9Z4y3Cya5d6IrPCD3SwrKERO9e17RjHTQrZEw4GacF3hq2yzRuernfCMqam/1aG++I8nIP0J6Cd8FB5BfY/Mp7bLQSvUMHNdSIPcMPE1E1SZblNBlWKSKMTi/fYBxw5q1rBA2UnYhmMG2IHXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJy1o4QL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so41695ad.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 17:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772156699; x=1772761499; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OfQIDC/J7NEbWJLcNCVG4ViZ9Wlry/rF6niI+P+JhNI=;
        b=JJy1o4QLjsIvYjdXcRswLOcXKvJD8d1mOa8zqKMCdXyySc13qwL7YPYvIkS3nvzxfX
         R4nuGNDWUCA/966Z0Yc8fbEAzIg/HdwMlwokJYB+Nx8MJ4waaNmI+6C3yawasQpA6Qv9
         Okls9xP7iHK1tnUUKF6Cbsnjnl4oZWULbvUcMJ1MTXf0zERsG+NZ3+/t34hxSR2SavYY
         Y/hkDs3jFqoR0HnaAqnfS//KifjJB+ICKrEgU0+RiU48w/R4z3b9tDCaFltdBi1XGauB
         vBndKRN6x+OouKawPR5ZoJHTZiSx2ht9lf3Jp1CDMX9tMd0tLRkyAOKP/dV8MEWajq8Y
         Bopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156699; x=1772761499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfQIDC/J7NEbWJLcNCVG4ViZ9Wlry/rF6niI+P+JhNI=;
        b=j3Dh+9EDloOwyWZ85xdJXUByQbN1IcRlIjDcWhCmu9ifBnpR35nHRvJdOQZLWwCifS
         lOV7F2n0CwUeSHkZMyD8Yly3HOXcMLIUyD3uC0wnpEvIBUhSfoSLhntBOZqFJc5XpeBp
         KZUdb8dgcX036m4VXpQUMmwAkdh+Fbh+GN8X9o4rPT+UudZJ+j33G2vzAwKoOaI5lGlZ
         EOu4FPYzg2+KDZRq2LVZBajEdUSuG35+GbjhqUUb7cH3JCDvaBhRIXlOBWMZ+67no4N0
         m8nK5my+fcTtqjXC4QCxH7ZsYFFLEkU0Lsku6MyHde56u+psKlI0SF0lShZCOziE12Qt
         Mxtg==
X-Forwarded-Encrypted: i=1; AJvYcCUOX/d3Vdk7XUaXZ8jJ7DdyBHUMqCwLmSsYMYn2J+vgAOdVqXtvqsSEt3Qv4MTfG3oWLfQJSjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5+0A/wE4zcgtUhG3A/WwT/QAzwUgjiWugWwYNTZ756VozblP
	VTD61c5PxlVkc3pgE/4KuA5qZ/NqEViCj6bbCO0US9rAuarg0VLc1i/XYa/bmlLrjA==
X-Gm-Gg: ATEYQzzACoeuWNNza3O6ZIzsC1Td0Zl22o3GFouSehLDe72nVgNSNi5LcRZmkhIevid
	FvgtkG8CJC3R+QABaEAbKNBe7vFf8oqde3loMDrvEAB6i9bMzbCwBA04Q44Y4a4IOF9wU0CDQ7O
	Wp4g5HtodFAWemS6/VwrOFlKiGv1PEXkLfaEQ60y/MZASzyYOWm9QheAnJiVkEIlFsMYnmXyD3t
	RQJ1NGS6fmQmxo5B6323Px8k4A/Gu1ZkGCK2slsXJACqPQgJARYqcc4YU8nUUeIc0JQNNfVCY8a
	QfIotfShvjnPGQj2hl66hWHMSDHISm6Jmk8L76rT1DWwK1Nqll4wRQYBgoXKf5CUnvIRVfHGSUf
	hIEY3a69boeSc2ibygFsp3j+9PcE+Rf1/zjYLopDUWy7C2Wg9dMKuMNemtuLj4kGXsB8WWTKQ8v
	gBaxiVAiKEnkPK37VBVVM48SH9jxLMZg6URga0EdLvXyuJz9neOtWCABA/0TR4sw==
X-Received: by 2002:a17:902:dad0:b0:2a7:9532:1a2b with SMTP id d9443c01a7336-2adf77c6b5fmr4035125ad.20.1772156698800;
        Thu, 26 Feb 2026 17:44:58 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm4658070b3a.21.2026.02.26.17.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 17:44:58 -0800 (PST)
Date: Fri, 27 Feb 2026 01:44:54 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, "Guo, Jinhui" <guojinhui.liam@bytedance.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"will@kernel.org" <will@kernel.org>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Message-ID: <2ydt4k7saucrkg6pxedfozdg5dsrkfhx5bpqkrdgwrob2dsi4j@tc63xjaw6ltt>
References: <BN9PR11MB5276FCF5D751DE7432A32BBB8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260210233912.GA93504@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210233912.GA93504@bhelgaas>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219889-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,bytedance.com:email]
X-Rspamd-Queue-Id: E14B61B19AB
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 05:39:12PM -0600, Bjorn Helgaas wrote:
>[+cc Alex, beginning of thread:
>https://lore.kernel.org/all/20251211035946.2071-1-guojinhui.liam@bytedance.com/]
>
>On Wed, Dec 24, 2025 at 03:08:49AM +0000, Tian, Kevin wrote:
>> +Bjorn for guidance.
>
>Sorry for the late response.
>
>> quick context - previously intel-iommu driver fixed a lockup issue in surprise
>> removal, by checking pci_dev_is_disconnected(). But Jinhui still observed the
>> lockup issue in a setup where no interrupt is raised to pci core upon surprise
>> removal (so pci_dev_is_disconnected() is false), hence suggesting to replace
>> the check with pci_device_is_present() instead.
>
>I think checking pci_dev_is_disconnected() or pci_device_is_present()
>in drivers is usually bad practice because it's always racy, as you've
>already pointed out.
>
>I don't think it's possible to avoid Invalidate Completion Timeouts in
>general, so I think the real solution is to figure out how to
>gracefully handle them without running into the lockup detection.
>
>I assume the lockup is the loop in qi_submit_sync() where we wait for
>QI_DONE with interrupts disabled.  Maybe we need something like
>watchdog_hardlockup_touch_cpu() there, along with a timeout in that
>loop?

Looking at the AMD IOMMU driver, it has 100ms timeout in wait_on_sem()
that basically waits for the completion until the timeout occurs. Is
this the expected behaviour as per specification, or should the IOMMU
wait for the Invalidation Completion Timeout?

Reading the specs (notes of PCIe r7.0, sec 10.1.1, Figure 10-4), it
seems the device is allowed to send translated TLPs, targetting the
address regions being invalidated, until the Invalidation Completion
Timeout (which could be 1-2 minutes as Bjorn shared below).

>
>The PCIe r7.0, sec 10.3.1, implementation note suggests the timeout
>might be in the 1-2 minute range, which is pretty extreme, but if we
>can at least handle timeouts gracefully, we can think about ways to
>make them less likely, e.g., by coordinating with FLR and VFIO detach
>(maybe the sort of thing Alex alluded to at
>https://lore.kernel.org/all/20251223153534.0968cc15.alex@shazbot.org).
>
>> Bjorn, is it a common practice to fix it directly/only in drivers or should the
>> pci core be notified e.g. simulating a late removal event? By searching the
>> code looks it's the former, but better confirm with you before picking this
>> fix...
>
>I don't know exactly what it would look like to simulate a late
>removal event, but it sounds like some kind of complicated
>infrastructure that would still be only a 90% solution, which I
>wouldn't recommend.
>
>> > From: Baolu Lu <baolu.lu@linux.intel.com>
>> > Sent: Tuesday, December 23, 2025 12:06 PM
>> >
>> > On 12/22/25 19:19, Jinhui Guo wrote:
>> > > On Thu, Dec 18, 2025 08:04:20AM +0000, Tian, Kevin wrote:
>> > >>> From: Jinhui Guo<guojinhui.liam@bytedance.com>
>> > >>> Sent: Thursday, December 11, 2025 12:00 PM
>> > >>>
>> > >>> Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
>> > >>> request when device is disconnected") relies on
>> > >>> pci_dev_is_disconnected() to skip ATS invalidation for
>> > >>> safely-removed devices, but it does not cover link-down caused
>> > >>> by faults, which can still hard-lock the system.
>> > >> According to the commit msg it actually tries to fix the hard lockup
>> > >> with surprise removal. For safe removal the device is not removed
>> > >> before invalidation is done:
>> > >>
>> > >> "
>> > >>      For safe removal, device wouldn't be removed until the whole software
>> > >>      handling process is done, it wouldn't trigger the hard lock up issue
>> > >>      caused by too long ATS Invalidation timeout wait.
>> > >> "
>> > >>
>> > >> Can you help articulate the problem especially about the part
>> > >> 'link-down caused by faults"? What are those faults? How are
>> > >> they different from the said surprise removal in the commit
>> > >> msg to not set pci_dev_is_disconnected()?
>> > >>
>> > > Hi, kevin, sorry for the delayed reply.
>> > >
>> > > A normal or surprise removal of a PCIe device on a hot-plug port normally
>> > > triggers an interrupt from the PCIe switch.
>> > >
>> > > We have, however, observed cases where no interrupt is generated when
>> > the
>> > > device suddenly loses its link; the behaviour is identical to setting the
>> > > Link Disable bit in the switch’s Link Control register (offset 10h). Exactly
>> > > what goes wrong in the LTSSM between the PCIe switch and the endpoint
>> > remains
>> > > unknown.
>> >
>> > In this scenario, the hardware has effectively vanished, yet the device
>> > driver remains bound and the IOMMU resources haven't been released. I’m
>> > just curious if this stale state could trigger issues in other places
>> > before the kernel fully realizes the device is gone? I’m not objecting
>> > to the fix. I'm just interested in whether this 'zombie' state creates
>> > risks elsewhere.
>> >

