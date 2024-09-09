Return-Path: <stable+bounces-74034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966C971CB3
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF051F23A05
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA41BAECA;
	Mon,  9 Sep 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="E6A9u6bp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E121BAEC0;
	Mon,  9 Sep 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892514; cv=none; b=UnbgI9crd8hB4xyjxAeVHBtEeI2NmH4iTHr6vK0VrK86Lh1Uye2Ylgq7eIuhoKR6w444lyj5d71DDb12efV1AKC/TeLvnyKgMWH+znhfwEx+u225sGCkMrUsEGf4o5sctaISmuHvOBS+G97FIbhnAJhyJvRYyi449611NgvXUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892514; c=relaxed/simple;
	bh=C7bXknGyFxyMitrh31Cr/MolSopclgYoGfO3FYZG1hw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZl1t1g8Wc9Y58t81P5/uSSizFmJb0NsCOzXtNnIJ5QvxjCCIzD61jIB56DcTetye+KUszXLbb26L5SLXXLxm597SuYmKOIZj/Ant8ncKm7gUwQGov/+WPdwJkDrh5kmhQN1Sb6C2M2rPqfvYgxnkGz25qLQxx8R67MBgE3HPLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=E6A9u6bp; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4895uBUC005605;
	Mon, 9 Sep 2024 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=T2HTchzqKQv0cV3UAK
	mPXN4bhD8dnPssptBbdVsRfM0=; b=E6A9u6bpbdKagTlFrP/TR7JNkNBv4pGKUb
	cl+FhT2GJhmeWwTestkjQeJxUZL2BJedjwBX6vsWmKydKhkmLUC64ILDaXc+J2c+
	KkK02nHkB01TlzkndKERix3xqVcvbQnL8X73xkWDIgRQyaoAv0OCNxlIuMzLmX92
	29xte2ewKtCwwkuSJsGEPyWuLryQ1clBrSpC/LNEdDj5VvAFhGe6jtg75uqJ8V3r
	Y5LDSMVmmqEOuEOfs/NJNhx5z2+KPXIinywyBcN12JGjTa7z6KGVFWjXmWiPj8/H
	+62wpDTmBp1wBZ+Xb91+CZvKqd0YJhYU+7QrbpGmW4aQsWCgkZWQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 41gm7x1qaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:34:52 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 15:34:50 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 9 Sep 2024 15:34:49 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id DAC1F820249;
	Mon,  9 Sep 2024 14:34:49 +0000 (UTC)
Date: Mon, 9 Sep 2024 15:34:48 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: "Liao, Bard" <bard.liao@intel.com>,
        "Liao, Bard"
	<yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R"
	<sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
Message-ID: <Zt8HiDW0gs6hXDPY@opensource.cirrus.com>
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <ZqngD56bXkx6vGma@matsya>
 <b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com>
 <f5110f23-6d73-45b5-87a3-380bb70b9ac8@linaro.org>
 <SJ2PR11MB84242BC3EAED16BEE6B46F85FF932@SJ2PR11MB8424.namprd11.prod.outlook.com>
 <acec443c-f9ab-4c1d-b1ab-b8620dfef77f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acec443c-f9ab-4c1d-b1ab-b8620dfef77f@linaro.org>
X-Proofpoint-GUID: McJ1BWxhzIXMwKxx7Iw_lx2naU0oC6P7
X-Proofpoint-ORIG-GUID: McJ1BWxhzIXMwKxx7Iw_lx2naU0oC6P7
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 04, 2024 at 01:43:50PM +0200, Krzysztof Kozlowski wrote:
> On 03/09/2024 17:17, Liao, Bard wrote:
> 
> >>>
> >>> then dpn_prop[0].num = 1 and dpn_prop[1].num = 3. And we need to go
> >>>
> >>> throuth dpn_prop[0] and dpn_prop[1] instead of dpn_prop[1] and
> >> dpn_prop[3].
> >>>
> >>
> >> What are the source or sink ports in your case? Maybe you just generate
> >> wrong mask?
> > 
> > I checked my mask is 0xa when I do aplay and it matches the sink_ports of
> > the rt722 codec.
> > 
> >>
> >> It's not only my patch which uses for_each_set_bit(). sysfs_slave_dpn
> >> does the same.
> > 
> > What sysfs_slave_dpn does is 
> >         i = 0;                          
> >         for_each_set_bit(bit, &mask, 32) {
> >                 if (bit == N) {
> >                         return sprintf(buf, format_string,
> >                                        dpn[i].field);
> >                 }
> >                 i++;
> >         }                         
> > It uses a variable "i" to represent the array index of dpn[i].
> > But, it is for_each_set_bit(i, &mask, 32) in your patch and the variable "i"
> > which represents each bit of the mask is used as the index of dpn_prop[i].
> > 
> > Again, the point is that the bits of mask is not the index of the dpn_prop[]
> > array.
> 
> Yes, you are right. I think I cannot achieve my initial goal of using
> same dpn array with different indices. My patch should be reverted, I
> believe.
> 
> I'll send a revert, sorry for the mess.
> 

Hi, apologies for being late to the party (was on holiday), but yeah
this is breaking things for me as well and is clearly wrong.
Agree probably best to revert.

Thanks,
Charles

