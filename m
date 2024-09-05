Return-Path: <stable+bounces-73119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF596CBFC
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 03:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F35B23F36
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98154A1E;
	Thu,  5 Sep 2024 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="FKFy/o14"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC6747F
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498181; cv=none; b=mFQdvSbdjqT83C9Xf9gX09F2rfdf0vWAgpWMf2dd+pnoEyld/R7Xwedy1yqIdew79S+r9knj2CfXr+F90K2fuPlqWyB0PEU6ksM00fMliqrXEhq4a5+GOqeSC4DUot42Md13C7ACVAd8uCLqe4mMIG1AHLHIUHqDqcIFfyvN7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498181; c=relaxed/simple;
	bh=GykyIwLq1BnUDdl5erj5qQJG0n/oyjRymF+evXtV7oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g75CqRO3uJVJlBcYVInma+i/x/1I4PSpOYKfYvPbQtHYradTWPv8niMDS8hPBjD0+cPie08K8SkafaXtrIAxQ9tKN3xhBW+fV3ekIOupedLHhinQVxEBd4NDgsZARJvcs1aU6Ls2Cv8GjmJFocmj7vmFggjdqg2/VvWjzgYNfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=FKFy/o14; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725498180;
	bh=6Hmte6RnfrOEToAS1kUk3LKPZ+n947JNju3lGec5oho=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=FKFy/o14jYYGLMVx0PnK+yfGg62i3AEV4ZeN5WdNc8sWQ6rDfobm6Qrv2wCwD8uYI
	 Q81qVTarBT2msuVAJGQqI67vJv72jwNnGdj8snLO4LuJdQxAOuDxtUNP4uAozN8RjZ
	 TdLh9QRaIUyLNc+ScugLRz+uP2b9xE8O4CVhUWgaZhiEU2DYCk4BZ23bU63EWeVy9g
	 m68raLb96raoC5J7r5cmCmJGazO1IWb7HG7YDEyMDMiUG1Ruy7X1D5C6v6wrUuym3G
	 sWdaSMnUBBFcvq5JIjkz4TWJI4lJKz4XbCxdVLlpP/JjRzCOY2bFv8H1AyKQ8z9Fxv
	 Jpvk+WJ9N69Nw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 13315C8009E;
	Thu,  5 Sep 2024 01:02:54 +0000 (UTC)
Message-ID: <af326d48-e41e-4e4f-8555-5bf62dd6e552@icloud.com>
Date: Thu, 5 Sep 2024 09:02:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix logic for finding a free cxl decoder
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Ben Widawsky <bwidawsk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 stable@vger.kernel.org
References: <20240903-fix_cxld-v1-1-61acba7198ae@quicinc.com>
 <ZtduQeu2NNyVWTk7@aschofie-mobl2.lan>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZtduQeu2NNyVWTk7@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lYNaOzvWn1x7jVXL8M2WOO0oJq-sykJ4
X-Proofpoint-GUID: lYNaOzvWn1x7jVXL8M2WOO0oJq-sykJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_22,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409050006

On 2024/9/4 04:14, Alison Schofield wrote:
> On Tue, Sep 03, 2024 at 08:41:44PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> match_free_decoder()'s logic for finding a free cxl decoder depends on
>> a prerequisite that all child decoders are sorted by ID in ascending order
>> but the prerequisite may not be guaranteed, fix by finding a free cxl
>> decoder with minimal ID.
> 
> After reading the 'Closes' tag below I have a better understanding of
> why you may be doing this, but I don't want to have to jump to that
> Link. Can you describe here examples of when the ordered allocation
> may not be guaranteed, and the impact when that happens.
> 

thank you for code review.
let me try to do it.

> This includes a change to device_for_each_child() which I see mentioned
> in the Closes tag discussion too. Is that required for this fix?
>

yes, device_for_each_child() is better than device_find_child() to
correct logic for finding a free cxl decoder.
> It's feeling like the fix and api update are comingled. Please clarify.
> 

actually, there are two concerns as shown below:

concern A: device_find_child() modifies caller's match data.
concern B: weird logic for finding a free cxl decoder

this patch focuses on concern B, and it also solve concern A in passing.

the following exclusive patch only solves concern A.
https://lore.kernel.org/all/20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com/

either will solve concern A i care about.

> Thanks,
> Alison
> 
>>


