Return-Path: <stable+bounces-69954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9E95CB0A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 12:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E22C1C218E4
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9CB1862B2;
	Fri, 23 Aug 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EZnjN9AA"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EE187337
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410394; cv=none; b=cs5vp7xVCGfK/MtDtXpfhr3c8tjoyuQu41ibOAKFvS0G4C0cj+mmNVAZy/DAFQcHfPVHL5K+i/Y0I18UgojwOHV4W3UI6u9vKE5WiKzIOCDu3s8n4P2ibk7VF96yjEt1fx39vwlnYfbw4DVUK1h/mezJlAtdY+KNqHelmakCZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410394; c=relaxed/simple;
	bh=LzNZP8D/JikrZqvd3KnfrjtecLMd+GXgTwvXKvkPa5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eipzeyD3ZDfXrOWG0zvz83JrTz2dQ8OGcG1btfTKF3zJSyeg81AuWN5ExOmDg6MNlrNAyHJhE99CwmThuPQcRFsFRY9G+K0Eh6/Jt6CmhMK5vor9LGHMl9zJGMHyRBMvIG06Jd/s1c7Ee+Nyj0/JGctbBX1AMr7bNW4ZgNPJ0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EZnjN9AA; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724410392;
	bh=4oEYTSnYB8gV+hdO+WbLXv/ub86nSIX37ilAYztk8Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=EZnjN9AAb9IIw8+PCrsypiwtDsEhiTGFZUnY585Dvp2490gM/WuvDylKcbOuzy7Mp
	 DFUKRGLe4n8jWae2QQM5QE8qoQt6zywEuGbXYGKYaJx5Ivj3g4kyB4yEXfAvEqvqwK
	 0StaEd1Hl5/nckW31JIU1+kfd93QlcMc9Q1681LMRuhfxjajkFYWjM572bh4hrGIsP
	 qoe3PT/Ls0MbWdtHTHi4rsFTy5y8wMl7xTOmP6ffgL64NlmxUryVsUSPKK/TikKScp
	 V/JKdwpT0zXjdJDzmDsWZFEgPf56wmmIgTpxIPK2W3OzCeMe/TKoTcCEFwNw3uoxJE
	 fWOHQz/B9RL1g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id E5BB7A0210;
	Fri, 23 Aug 2024 10:53:06 +0000 (UTC)
Message-ID: <48b997b0-a27a-43ca-a7cc-abbab9bb9eb5@icloud.com>
Date: Fri, 23 Aug 2024 18:52:47 +0800
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
 <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>
 <2024082318-labored-blunderer-a897@gregkh> <Zsfk-9lf1sRMgBqE@google.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Zsfk-9lf1sRMgBqE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q-d1PEaJGgMqV9MRR2s56GRT5lx-xMXC
X-Proofpoint-GUID: Q-d1PEaJGgMqV9MRR2s56GRT5lx-xMXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=565
 adultscore=0 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2408230080

On 2024/8/23 09:25, Dmitry Torokhov wrote:
> On Fri, Aug 23, 2024 at 09:14:12AM +0800, Greg Kroah-Hartman wrote:
>> On Fri, Aug 23, 2024 at 08:46:12AM +0800, Zijun Hu wrote:
>>> On 2024/8/23 08:02, Dmitry Torokhov wrote:
>>>> Hi,
>>>>
>>>> On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
>>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>
>>>>> An uninitialized variable @data.have_async may be used as analyzed
>>>>> by the following inline comments:
>>>>>
>>>>> static int __device_attach(struct device *dev, bool allow_async)
>>>>> {
>>>>> 	// if @allow_async is true.
>>>>>
>>>>> 	...
>>>>> 	struct device_attach_data data = {
>>>>> 		.dev = dev,
>>>>> 		.check_async = allow_async,
>>>>> 		.want_async = false,
>>>>> 	};
>>>>> 	// @data.have_async is not initialized.
>>>>
>>>> No, in the presence of a structure initializer fields not explicitly
>>>> initialized will be set to 0 by the compiler.
>>>>
>>> really?
>>> do all C compilers have such behavior ?
>>
>> Oh wait, if this were static, then yes, it would all be set to 0, sorry,
>> I misread this.
>>
>> This is on the stack so it needs to be zeroed out explicitly.  We should
>> set the whole thing to 0 and then set only the fields we want to
>> override to ensure it's all correct.
> 
> No we do not. ISO/IEC 9899:201x 6.7.9 Initialization:
> 
> "21 If there are fewer initializers in a brace-enclosed list than there
> are elements or members of an aggregate, or fewer characters in a string
> literal used to initialize an array of known size than there are
> elements in the array, the remainder of the aggregate shall be
> initialized implicitly the same as objects that have static storage
> duration."
> 
> That is why you can 0-initialize a structure by doing:
> 
> 	struct s s1 = { 0 };
> 
> or even
> 
> 	struct s s1 = { };
> 
For above both initialization: it appears to initialize the whole struct.
but For the initialization approach we discuss, it appears to
initialize partial struct, it is easy to mislead developers.

> Thanks.
> 


