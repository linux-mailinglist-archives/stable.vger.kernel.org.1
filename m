Return-Path: <stable+bounces-6371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8E80DE35
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C322C1F2144B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7355793;
	Mon, 11 Dec 2023 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qxRLQV03"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25F8F
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 14:26:43 -0800 (PST)
Message-ID: <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702333601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahl3EiP7g03rhk1AaXGKb/2N9qHLeHJeUD9ZaY/KRMY=;
	b=qxRLQV03kADl3DG4UVI8QJImeGApS+eK8CuyxFqEUVXxP5xSEtj7mIEbN0HnLNBQ2mru2D
	Fk/vsg14/ZqxxXV/H4CY95lHMlwuHiWlmCUFejgNzR8jlyWjbHmIVP9xzAcADkGxI6wTI7
	JKaD02EfrYOaPjqrD0B0KnceRdVLJ2IY6NN8DHOE6WUBv9bfpf6js90bw4CaZvug4YW1N3
	sTgHxTIVLptAFqnOvW5qDJWGQaWfz90lzaaSBiFwwivvpanAxqMoHrp5J8SX1B8od6cxE/
	ReEo3sl3TCPvTYVRE3DGNg81+lUZ/DO/xybr9AT2fC7GSrXidrJ55ebo932W2w==
Date: Tue, 12 Dec 2023 05:26:37 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Content-Language: en-US
To: "Berg, Johannes" <johannes.berg@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 12.12.23 03:58, Berg, Johannes wrote:
>>> https://www.spinics.net/lists/stable/msg703040.html
> 
> FWIW, that looks fine to me. I don't know how I managed to miss that. Sorry about that ☹
> 
>> That "fix" was not cc:ed to any of the wifi developers and would need a lot of
>> review before I feel comfortable accepting it, as I said in the response to that
>> message.
> 
> Indeed, I hadn't seen it before.
> 
> But I just checked the error paths there, and the fix adjust all three of them correctly.
> 
> johannes

I have at least 7 users who have tested that fix on my end:

https://lore.kernel.org/stable/20231210213930.61378-1-leo@leolam.fr/

So it can also be called tested now:

https://forum.manjaro.org/t/153045/77
https://forum.manjaro.org/t/153045/88
https://forum.manjaro.org/t/153045/90
https://forum.manjaro.org/t/153045/92
https://forum.manjaro.org/t/153045/93
https://forum.manjaro.org/t/153045/94

-- 
Best, Philip


