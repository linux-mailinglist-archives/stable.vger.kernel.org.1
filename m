Return-Path: <stable+bounces-9031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898D82096E
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 02:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371D11C217E6
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A49659;
	Sun, 31 Dec 2023 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tyVxh/mr"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A9639
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <8a43a969-bb8f-4ff2-9344-a221f46c51e5@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1703983950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiMUSVNJt8AtmWVVScSVBlWaCPZP7VRr0Nz5f9Uu0A8=;
	b=tyVxh/mr/j9tsYalch9eTzseeDi53loog0SUAriJwVYOJcYzX9u/F13AIiPaLzb98VygV3
	Oj61HqWyV1MICgrGbAMHrDPWxuVblMOFUNqDyS7SEtkVwDU8LANpWqjyuwx4nH1RC102fS
	nL3Bp3AVYCHIIJalfwOHXPYzwQqvzugJEp+e3WPp3/Rxf+n1jdvbgt4+k+VLE3mbUbmYTu
	QWHWp5MJzqUHTO4zPmwnTaqTvUUKGw8qKNKBC+mFiIAjSG4WadMMCBZpHNkTTRJEK7VnWm
	+4hRG8kmGWHlPF8YPWhQD0kSGOCCjTYdHnAxGC1QSpzpd4kgwm+lJUZid0MScA==
Date: Sun, 31 Dec 2023 07:52:24 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 =?UTF-8?Q?L=C3=A9o_Lam?= <leo@leolam.fr>
References: <20231216054715.7729-2-leo@leolam.fr>
 <20231216054715.7729-4-leo@leolam.fr> <2023123005-annuity-numbly-e6d8@gregkh>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <2023123005-annuity-numbly-e6d8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 30.12.23 18:43, Greg KH wrote:
> On Sat, Dec 16, 2023 at 05:47:17AM +0000, Léo Lam wrote:
>> Commit 008afb9f3d57 ("wifi: cfg80211: fix CQM for non-range use"
>> backported to 6.6.x) causes nl80211_set_cqm_rssi not to release the
>> wdev lock in some of the error paths.
>>
>> Of course, the ensuing deadlock causes userland network managers to
>> break pretty badly, and on typical systems this also causes lockups on
>> on suspend, poweroff and reboot. See [1], [2], [3] for example reports.
>>
>> The upstream commit 7e7efdda6adb ("wifi: cfg80211: fix CQM for non-range
>> use"), committed in November 2023, is completely fine because there was
>> another commit in August 2023 that removed the wdev lock:
>> see commit 076fc8775daf ("wifi: cfg80211: remove wdev mutex").
>>
>> The reason things broke in 6.6.5 is that commit 4338058f6009 was applied
>> without also applying 076fc8775daf.
>>
>> Commit 076fc8775daf ("wifi: cfg80211: remove wdev mutex") is a rather
>> large commit; adjusting the error handling (which is what this commit does)
>> yields a much simpler patch and was tested to work properly.
>>
>> Fix the deadlock by releasing the lock before returning.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218247
>> [2] https://bbs.archlinux.org/viewtopic.php?id=290976
>> [3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/
>>
>> Link: https://lore.kernel.org/stable/e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org/
>> Fixes: 008afb9f3d57 ("wifi: cfg80211: fix CQM for non-range use")
>> Tested-by: Léo Lam <leo@leolam.fr>
>> Tested-by: Philip Müller <philm@manjaro.org>
>> Cc: stable@vger.kernel.org
>> Cc: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Léo Lam <leo@leolam.fr>
>> ---
>>   net/wireless/nl80211.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> Both now queued up, thanks.
> 
> greg k-h

Hi Greg,

seems only for 6.1.x series. Still don't see it for 6.6.x ...
-- 
Best, Philip


