Return-Path: <stable+bounces-114937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F110A31162
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 17:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965B01881456
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127521E5B87;
	Tue, 11 Feb 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R1eyWf/m"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55752AE6A;
	Tue, 11 Feb 2025 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291441; cv=none; b=MLRimuJj4Scyr6/OCvuEqAEfEqwi4vpiPQUFDk4tezX56GludNrm+ZqUYXDSTN5eoALTVa0fai9c1A/mFObq2vLN5iJCL90PiffD+FReHfnwnCANjGoLx0aPp1bnyQMhS1RvFIzr4xYpljLI1s6dMhRtFzGCxbkNpycvJNqbXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291441; c=relaxed/simple;
	bh=blWk8OYXAKWZt4nEyYBk3rcMjLdQvE088z87QuEQYcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KByZ/nJamAbjR7ax0UrELxXZ+Qa1SJxLFKnwm1ZeVlnueTCKMyeRBtN7lDpdC7dc7l9sC2Q5SjuMkOZ7ldWpQz6TV6Z6MRdwFinglbtDlwOByJEcZFdvLarqzxeJ/xO11Z6vsjvNv6E++KAx9ZPuZKR8S2/uy+9R2yTIVye33PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R1eyWf/m; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B4vo81003866;
	Tue, 11 Feb 2025 10:30:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9E82TJqdSUGHUuRV0fGif+EouUYylC7G+GekqeDR0R8=; b=
	R1eyWf/mJidquPtQn+fUtWSP7lrEQt2n4uJoNpQNsRZhGtmWstPtBXuhMNljbvga
	fIaZ53RjFxfUsrWh4opw7HW/wRz3y7gl4YPqttFYsYlc/j6pMrP3W7yUDbgAQkNJ
	Hh//P61JCytBBhNjt+t3wZUuSICPmKB7agB7yrop4b1qxxqnavChSAFZc36KpouP
	RhUfSQnK2WMFa28D2vKnGLLSuUtvK5wDduAzdIxa8mfIkAcYcY4BDBgY+ouYxWCS
	Rah6I7JWwqqpy01BShumlyWnwf9x8r/trpgJBRvrF0dMGejwjBQUnRooewcXkr4K
	wY3+W/VgHTKo8FbzW3eIig==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44p4jmw2dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 10:30:32 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 16:30:26 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 11 Feb 2025 16:30:26 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 26323820248;
	Tue, 11 Feb 2025 16:30:26 +0000 (UTC)
Message-ID: <8a785b3d-1c77-4905-832b-4f4acaec1ff3@opensource.cirrus.com>
Date: Tue, 11 Feb 2025 16:30:26 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: test_control_parse: null-terminate test
 strings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
CC: Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
 <d1c9a0f3-5bc5-4b78-abfa-d17e90c36f48@opensource.cirrus.com>
 <20250211161448-c6560879-7bc9-4fe1-a9cf-713f029c1ee7@linutronix.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250211161448-c6560879-7bc9-4fe1-a9cf-713f029c1ee7@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PNv1+eqC c=1 sm=1 tr=0 ts=67ab7b28 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=xpmXR35279-dqAzjWgoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e9r7MIn-42D0RhUNrOckl23MdUcm-rwF
X-Proofpoint-ORIG-GUID: e9r7MIn-42D0RhUNrOckl23MdUcm-rwF
X-Proofpoint-Spam-Reason: safe

On 11/02/2025 3:21 pm, Thomas Weißschuh wrote:
> On Tue, Feb 11, 2025 at 03:10:38PM +0000, Richard Fitzgerald wrote:
>> On 11/02/2025 3:00 pm, Thomas Weißschuh wrote:
>>> The char pointers in 'struct cs_dsp_mock_coeff_def' are expected to
>>> point to C strings. They need to be terminated by a null byte.
>>> However the code does not allocate that trailing null byte and only
>>> works if by chance the allocation is followed by such a null byte.
>>>
>>> Refactor the repeated string allocation logic into a new helper which
>>> makes sure the terminating null is always present.
>>> It also makes the code more readable.
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> Fixes: 83baecd92e7c ("firmware: cs_dsp: Add KUnit testing of control parsing")
>>> Cc: stable@vger.kernel.org
>>> ---
>>>    .../cirrus/test/cs_dsp_test_control_parse.c        | 51 ++++++++--------------
>>>    1 file changed, 19 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
>>> index cb90964740ea351113dac274f0366de7cedfd3d1..942ba1af5e7c1e47e8a2fbe548a7993b94f96515 100644
>>> --- a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
>>> +++ b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
>>> @@ -73,6 +73,18 @@ static const struct cs_dsp_mock_coeff_def mock_coeff_template = {
>>>    	.length_bytes = 4,
>>>    };
>>> +static char *cs_dsp_ctl_alloc_test_string(struct kunit *test, char c, size_t len)
>>> +{
>>> +	char *str;
>>> +
>>> +	str = kunit_kmalloc(test, len + 1, GFP_KERNEL);
>>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
>>> +	memset(str, c, len);
>>> +	str[len] = '\0';
>>> +
>>> +	return str;
>>> +}
>>> +
>>>    /* Algorithm info block without controls should load */
>>>    static void cs_dsp_ctl_parse_no_coeffs(struct kunit *test)
>>>    {
>>> @@ -160,12 +172,8 @@ static void cs_dsp_ctl_parse_max_v1_name(struct kunit *test)
>>>    	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
>>>    	struct cs_dsp_coeff_ctl *ctl;
>>>    	struct firmware *wmfw;
>>> -	char *name;
>>> -	name = kunit_kzalloc(test, 256, GFP_KERNEL);
>>
>> This allocates 256 bytes of zero-filled memory...
>>
>>> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, name);
>>> -	memset(name, 'A', 255);
>>
>> ... and this fills the first 255 bytes, leaving the last byte still as
>> zero. So the string is zero-terminated. I don't see a problem here.
> 
> This single instance it is indeed correct.
> In all other five it's broken.
> 
>> Just fix the other allocs to be kzalloc with the correct length?
> 
> If you prefer that, sure I can change it.
> 
> Personally I like the helper much better. One does not have to look at a
> dense block of code to see what the actual intention is.
> Assuming the location in cs_dsp_ctl_parse_max_v1_name() was fixed when
> some breakage was observed, with a helper it would have been fixed for
> all locations and not crept into upstream code.
> 
> 
> Thomas

Actually I try to avoid helpers in tests. The trouble is that the
function name _sounds_ like they do what you want, but you have to go
and look at the helper to see what it _really_ does. More helpers means
it's more difficult to review whether the test case does what it should
do. I went through this early on where I had a lot more helpers for all
that similar code in the test cases, and I found that I had test cases
that were wrong but that was difficult to see because the test procedure
was hidden across a lot of helper functions.

For these strings there are some cases where it's important for the
string to NOT have a NULL terminator in the firmware file so I'm a bit
concerned that it was intended to create a string without a terminator
and the bug is failure to handle this. But I'm really busy right now
with other things so haven't got much time to look at this, If you
and Mark want to take this patch to prevent the string overruns I'll
come back when I have time and do a follow-up patch if I think the
test framework should handle the non-terminated strings.

