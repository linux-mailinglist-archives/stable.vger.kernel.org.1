Return-Path: <stable+bounces-69920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE695C295
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 02:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB712285171
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 00:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF4D304;
	Fri, 23 Aug 2024 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="v891LZUR"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BC171A7
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373997; cv=none; b=ipgPIA8A92S36L4TpBUR5/+nLLyMSw+ZvRlbAAigpI0aD8IS7P2pdhMOndd1ZG2/MWSiuDdaFPVjTkFdnUJ2+upL1I4Pd5o2wDJEbVLEfi6skPjBEb60vSKEi7goyjDQB3jwDZMRx9VH36rje7kXQdIeNcQiWJGPPgIjmL2OcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373997; c=relaxed/simple;
	bh=O9yoUAC9U3HTcaZO5oCRTm/Xv0FNLEQl2U7b5acSDAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwKrndja5kRQ1rYJt+8hviMUImMN+nJHSA2dbsMryjSEGWlfGiCmU6ttqqLxJ/cdwxgbxYH+aF4g56Os9rf+dQYyaoaPLWo4XLgjWN1LxAiSDFpBZWEQ9gB84mggGmfXHrxlWNCnaSuBR2qEGtU6yDHzaevbTbZY1ST+8ALKhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=v891LZUR; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724373996;
	bh=jud5zcJEFcAFMQrtEXNZK48wCk4punyShcIaYQqM4Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=v891LZUR8I1HokDTlTSbSSWG1bPOtNHrsRJEvZ57LBnbXQ7EL/klbkdKqE9WfTDuZ
	 4sTgx8TXgOVHLebqG5IjQfnJuDTfGQ/OCS104bc2u7lYu9lIIaHtkt7MEW8PA7FrM7
	 qrZxaYC4hmBKfi2Vs3nMlPGPC4NP3G4j33BRO323xLTb9Ibx+XxLNJQ3woAG1BdLpI
	 OS1Khd2gIlzn9aPB7wGqkVAXE6KD/nz905roCx5CAKDOTVINHgWkM2W5giQLMpjDvS
	 8Ut9VrP/N/gMbczWTHWG7v2wZpYAhLpLZsKRpQgXDQZDlqu+MmTy+sHkdM7pxG49ld
	 0bqWlMnBGMIFA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 25161DC0096;
	Fri, 23 Aug 2024 00:46:31 +0000 (UTC)
Message-ID: <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>
Date: Fri, 23 Aug 2024 08:46:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <ZsfRqT9d6Qp_Pva5@google.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZsfRqT9d6Qp_Pva5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h1_urtemGm9ii2t2ftknkctfK09QeLGu
X-Proofpoint-GUID: h1_urtemGm9ii2t2ftknkctfK09QeLGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_17,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=501 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408230004

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
really?
do all C compilers have such behavior ?

> There is no issue here.
> 
> Thanks.
> 


