Return-Path: <stable+bounces-6377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D395D80DF56
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 00:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01331B20F7E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478AF56746;
	Mon, 11 Dec 2023 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Widpidh7"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1DCB
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 15:15:21 -0800 (PST)
Message-ID: <c4e5775a-3672-4b1c-8654-ae42f928d5cd@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702336519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz91hqnqSWsawiVZ9oKizuYjDR5DR+RUpW+Jn/HczQw=;
	b=Widpidh7cFKUwVF7Bv4pv9WIbWuCLvnZBJxSSr2tylxwyo+RPKvc4m1fo4gpskL2wfUOJh
	zwGGpw/2TCxAhlnZlaRrgvn2LDMRRGd1EwmCKuNmTGM7G/a5oFewdGJFrWOF3kplTCwloZ
	2MbdWyM649M5GXv3kRjlZcYJHYOLBeFAbd+T6n6X8f2Degqtwa6mjONrqDdJRMqHO6MhLG
	E9ctz+BRHCwgX0edvg4CHLdRyq1rFFU68EXFKKZ2XpAnT9GgpVA2nGsWojBAO21AQKe1zL
	qCaEHxRyBKlEclFIzmeX0AIkjg+Ct/At2vrwLrJCar1CQVPvSeRtr/wuUsUoNw==
Date: Tue, 12 Dec 2023 06:15:16 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
Content-Language: en-US
To: =?UTF-8?Q?L=C3=A9o_Lam?= <leo@leolam.fr>
Cc: stable@vger.kernel.org, johannes.berg@intel.com,
 Greg KH <gregkh@linuxfoundation.org>
References: <20231210213930.61378-1-leo@leolam.fr>
 <2023121135-unwilling-exception-0bcc@gregkh>
 <718120b0a3455e920e6b7d78619cf188651cb1b6.camel@leolam.fr>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <718120b0a3455e920e6b7d78619cf188651cb1b6.camel@leolam.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 12.12.23 05:57, Léo Lam wrote:
> On Mon, 2023-12-11 at 07:47 +0100, Greg KH wrote:
>> On Sun, Dec 10, 2023 at 09:39:30PM +0000, Léo Lam wrote:
>>> Commit 4a7e92551618f3737b305f62451353ee05662f57 ("wifi: cfg80211: fix
>>> CQM for non-range use" on 6.6.x) causes nl80211_set_cqm_rssi not to
>>> release the wdev lock in some situations.
>>>
>>> Of course, the ensuing deadlock causes userland network managers to
>>> break pretty badly, and on typical systems this also causes lockups on
>>> on suspend, poweroff and reboot. See [1], [2], [3] for example reports.
>>>
>>> The upstream commit, 7e7efdda6adb385fbdfd6f819d76bc68c923c394
>>> ("wifi: cfg80211: fix CQM for non-range use"), does not trigger this
>>> issue because the wdev lock does not exist there.
>>>
>>> Fix the deadlock by releasing the lock before returning.
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218247
>>> [2] https://bbs.archlinux.org/viewtopic.php?id=290976
>>> [3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/
>>>
>>> Fixes: 4a7e92551618 ("wifi: cfg80211: fix CQM for non-range use")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Léo Lam <leo@leolam.fr>
>>> ---
>>>   net/wireless/nl80211.c | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
> 
> Apologies for the slow reply - been dealing with some eye soreness. :(
> 
> First of all, thank you for taking the time to review this and for
> reverting the broken commit so quickly as it seems quite a few users
> were hitting this.
> 
>> So this is only for the 6.6.y tree?  If so, you should at least cc: the
>> other wireless developers involved in the original fix, right?
>>
> You're right. Sorry I forgot to cc: johannes.berg@intel.com; though just
> to clarify, there is nothing wrong with their commit per se; the issue
> comes from how it was backported without 076fc8775daf ("wifi: cfg80211:
> remove wdev mutex").
> 
>> And what commit actually fixed this issue upstream, why not take that
>> instead?
>>
> 
> As far as I understand, this was never an issue upstream because
> 076fc8775daf ("wifi: cfg80211: remove wdev mutex") was committed in
> August, *before* commit 7e7efdda6adb ("wifi: cfg80211: fix CQM for non-
> range use") added the early returns in late November. This only became
> an issue on the 6.1.x and 6.6.x trees because the CQM fix commit thxwas
> applied without first applying the "remove wdev mutex" as well.
> 
> I did consider taking 076fc8775daf (i.e. removing the wdev mutex) and
> applying it to the 6.6.x tree but that diff is much bigger than 100
> lines long and I thought it would be simpler and safer to just fix the
> buggy error handling. Especially for a newcomer who isn't very familiar
> with the development process...
> 
> 

Hi Leo,

thx for the patch. At least some users on my end can say it fixed the 
issue for them. Also Johannes checked your patch by now: 
https://lore.kernel.org/stable/DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com/

So your patch can be applied via a patch series by including Johannes 
Berg's patch as well. Addressing all error paths works too in the end ;)

-- 
Best, Philip


