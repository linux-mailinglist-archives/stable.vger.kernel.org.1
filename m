Return-Path: <stable+bounces-45498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67E8CAD40
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852F7B21E07
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DF74E26;
	Tue, 21 May 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jOncpPrX"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1478B4C;
	Tue, 21 May 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290429; cv=none; b=f/CCzzlue6cvr40BuYCayahjnLLQ8wiXuPtLh43jb0ZMDZG+L0troboK07l+2zWP6YSQwZP/3W1vUBG9Y+RVQzef2CCs1bh0zNXYgf+5kxqPLrlELP81yCNoX14EXPuiMMcPyoGk1G0QHkIODGNwMXnv6Zy+U+84mzG8sL1+mAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290429; c=relaxed/simple;
	bh=LZ+rsiOJNbuvUBqa8SfnpSBVNsHQlw64ObMmyDOFgkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAfB0uQdS7LU9mEk0bI5T+sjMJmIbpDG2epJVY/I6jzslh4AMcRoGJF0cYYbgClqwpUOU0a3KTPWTraT/MC7+6YZGAj18K1/vfiNeCOXvBujeMFOzXHmXoyaYlJFycT+e1xKNxztJd4bp2F/sVGNNAoVMUbLwo8wSt8aWviT5Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jOncpPrX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=bryoWbNN8cFi6dYEo/k2lPyQOXpLR2x/eApoa9hqlW8=;
	t=1716290427; x=1716722427; b=jOncpPrXv5FfF4S3b8Rv+jfHgEa3B6WdX3nL21bFGh5dcLe
	RLgJqvdabvfyhCHremNRTDLrpdUOyoEUHMOONGvd+0blk7QZMWLxk6nZGSqIBpRX1PEc6aDBtuYqi
	JipK+gBD+NE4yjQoFxI/7aQJZAsHnpkAPqNH7FTJQTOIJ2JDNQwYNWEgHTC4Iq4ANxdb+b8ImZ7/g
	Sbb+GWIm3WwBpnwKb/PtsWOsCOgG91rFAx6fCe+uBQlLKFeBMpL2HUb3BMl3GmWq3deHzqO0Ps6CW
	3Guw3pY6Rrrudd6j+l5YboOQzatDA3F+m/968k7vSvn5fsV2EFR/5Fg8sxnGGJAw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s9NXZ-000357-WB; Tue, 21 May 2024 13:20:22 +0200
Message-ID: <83df4e94-e1ec-42f6-8a15-6439ef4a25b7@leemhuis.info>
Date: Tue, 21 May 2024 13:20:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference at
 drm_dp_add_payload_part2
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: "lyude@redhat.com" <lyude@redhat.com>,
 "imre.deak@intel.com" <imre.deak@intel.com>,
 =?UTF-8?Q?Leon_Wei=C3=9F?= <leon.weiss@ruhr-uni-bochum.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240307062957.2323620-1-Wayne.Lin@amd.com>
 <0847dc03-c7db-47d7-998b-bda2e82ed442@amd.com>
 <41b87510-7abf-47e8-b28a-9ccc91bbd3c1@leemhuis.info>
 <177cfae4-b2b5-4e2c-9f1e-9ebe262ce48c@amd.com>
 <CO6PR12MB5489FA9307280A4442BAD51DFCE72@CO6PR12MB5489.namprd12.prod.outlook.com>
 <87wmo2hver.fsf@intel.com> <6f66e479-2f5a-477a-9705-dca4a3606760@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <6f66e479-2f5a-477a-9705-dca4a3606760@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716290427;ef363253;
X-HE-SMSGID: 1s9NXZ-000357-WB

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Hmm, from here it looks like the patch now that it was reviewed more
that a week ago is still not even in -next. Is there a reason?

I know, we are in the merge window. But at the same time this is a fix
(that already lingered on the lists for way too long before it was
reviewed) for a regression in a somewhat recent kernel, so it in Linus
own words should be "expedited"[1].

Or are we again just missing a right person for the job in the CC?
Adding Dave and Sima just in case.

Ciao, Thorsten

[1]
https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

On 12.05.24 18:11, Limonciello, Mario wrote:
> On 5/10/2024 4:24 AM, Jani Nikula wrote:
>> On Fri, 10 May 2024, "Lin, Wayne" <Wayne.Lin@amd.com> wrote:
>>>> -----Original Message-----
>>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>> Sent: Friday, May 10, 2024 3:18 AM
>>>> To: Linux regressions mailing list <regressions@lists.linux.dev>;
>>>> Wentland, Harry
>>>> <Harry.Wentland@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
>>>> Cc: lyude@redhat.com; imre.deak@intel.com; Leon Weiß
>>>> <leon.weiss@ruhr-uni-
>>>> bochum.de>; stable@vger.kernel.org; dri-devel@lists.freedesktop.org;
>>>> amd-
>>>> gfx@lists.freedesktop.org; intel-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference at
>>>> drm_dp_add_payload_part2
>>>>
>>>> On 5/9/2024 07:43, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>> On 18.04.24 21:43, Harry Wentland wrote:
>>>>>> On 2024-03-07 01:29, Wayne Lin wrote:
>>>>>>> [Why]
>>>>>>> Commit:
>>>>>>> - commit 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
>>>>>>> allocation/removement") accidently overwrite the commit
>>>>>>> - commit 54d217406afe ("drm: use mgr->dev in drm_dbg_kms in
>>>>>>> drm_dp_add_payload_part2") which cause regression.
>>>>>>>
>>>>>>> [How]
>>>>>>> Recover the original NULL fix and remove the unnecessary input
>>>>>>> parameter 'state' for drm_dp_add_payload_part2().
>>>>>>>
>>>>>>> Fixes: 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
>>>>>>> allocation/removement")
>>>>>>> Reported-by: Leon Weiß <leon.weiss@ruhr-uni-bochum.de>
>>>>>>> Link:
>>>>>>> https://lore.kernel.org/r/38c253ea42072cc825dc969ac4e6b9b600371cc8.c
>>>>>>> amel@ruhr-uni-bochum.de/
>>>>>>> Cc: lyude@redhat.com
>>>>>>> Cc: imre.deak@intel.com
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Cc: regressions@lists.linux.dev
>>>>>>> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
>>>>>>
>>>>>> I haven't been deep in MST code in a while but this all looks pretty
>>>>>> straightforward and good.
>>>>>>
>>>>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>>>>
>>>>> Hmmm, that was three weeks ago, but it seems since then nothing
>>>>> happened to fix the linked regression through this or some other
>>>>> patch. Is there a reason? The build failure report from the CI maybe?
>>>>
>>>> It touches files outside of amd but only has an ack from AMD.  I
>>>> think we
>>>> /probably/ want an ack from i915 and nouveau to take it through.
>>>
>>> Thanks, Mario!
>>>
>>> Hi Thorsten,
>>> Yeah, like what Mario said. Would also like to have ack from i915 and
>>> nouveau.
>>
>> It usually works better if you Cc the folks you want an ack from! ;)
>>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>>
> 
> Thanks! Can someone with commit permissions take this to drm-misc?
> 
> 
> 

