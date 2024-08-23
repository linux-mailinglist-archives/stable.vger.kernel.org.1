Return-Path: <stable+bounces-69956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15595CB1E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317821F24B06
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C2187561;
	Fri, 23 Aug 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fOedo3kI"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819231684AE
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724411045; cv=none; b=MJck0u9loFzIenS0rUeLViD1aOdj8HzN4X3UYw2LFN6WN3ENBCSGVMJD90O3trkeE5NlF9FTvA13Kc0U7GiKgzmY+vJ3cfmPf08SzN9+pA/mL7VglIoY9mXZaGPminWY+v7CFXKdh304QvpiGUjzyhRRnbfmn4XrLb/eJb5BoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724411045; c=relaxed/simple;
	bh=Boo2wVJGjx9lO7q4aYDkl35VLdSPG9t/mv0CsyBI07M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qj/ba9D5joEmONC2Mg2rYWpTUKIub+ZyM6W1MD9aGwuuLDa/0fmFBuACU0Ma/0miLPSIcvxSTuF8BlmfwsGNrtIP3vhPan0lHjREXRjL47zd0RKlnn2PKotqjzASite3Dsdealk3uopimWXFLhAPRuIHqrP00v88/QIH7xFkFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fOedo3kI; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724411044;
	bh=fq54+5+8FFNqg1RQYELgTpBUW74FFFDFPXYke2L7d2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=fOedo3kI61W3WB8ml6HBtXl2uB8ZVf8/em7kK1OfmaWkC90sKW4BY4CvkMCxu13Uq
	 W7i4dT/nTX1V20Yz983Qf+Ngk7KJbk+dxVxqJL3kD7m2cx4oH1btQ6r0gHXWrX5EhS
	 s3Dt+syb3oALFis+8QHd2t8m4ZIGDviK/+XuMTLEmt3acvio1vQ8LIyjgVzhpL3k29
	 sVu1igj3DskJIuTH5JGs00kWEMKLmbUc/NnY7wvg7AlrXDKrv0xVF+HOxm7gpDweWN
	 wJ7pHkKJs3EUZb533/+9DgWSGzoG/BQXddcDsAS2poD9VBtze/W8JrVMnuZEE2ksAD
	 +weVTQNz4Aqtw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 0C7FE8E057C;
	Fri, 23 Aug 2024 11:03:58 +0000 (UTC)
Message-ID: <15769558-010a-4935-ae0c-b4da6dfb8203@icloud.com>
Date: Fri, 23 Aug 2024 19:03:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <ZsfRqT9d6Qp_Pva5@google.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZsfRqT9d6Qp_Pva5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 52FwH2Lc1U72KpugRY6--DMPwTTSH18l
X-Proofpoint-ORIG-GUID: 52FwH2Lc1U72KpugRY6--DMPwTTSH18l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=481
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408230081

On 2024/8/23 08:02, Dmitry Torokhov wrote:
> Hi,
> 
> On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> An uninitialized variable @data.have_async may be used as analyzed
>> by the following inline comments:
>>
>> static int __device_attach(struct device *dev, bool allow_async)
>> {
>> 	// if @allow_async is true.
>>
>> 	...
>> 	struct device_attach_data data = {
>> 		.dev = dev,
>> 		.check_async = allow_async,
>> 		.want_async = false,
>> 	};
>> 	// @data.have_async is not initialized.
> 
> No, in the presence of a structure initializer fields not explicitly
> initialized will be set to 0 by the compiler.
> 
yes. you are right. compiler will implicitly initialize @data.have_async.

is it worthy to explicitly initialize @data.have_async as existing
@data.want_async as well to prevent misleading human readers since this
initialization approach appears to partial initialization ?

> There is no issue here.
> 
> Thanks.
> 


