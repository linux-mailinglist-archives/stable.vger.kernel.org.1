Return-Path: <stable+bounces-77892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1C9880F1
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195FB1F21ABD
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9370018A6D4;
	Fri, 27 Sep 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="b2YCtg10"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7B189505;
	Fri, 27 Sep 2024 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427547; cv=none; b=H3zoD4bYE0+/YLsiTBBrD0v+4DlsxA5q26RxxZcM1shK0kVwYiy4eUxO0ojyG57XOfmcJgIDQx2kHJ0hjAWTKZSDm8W1MilD5GZ30SG/aIK/tFZcPh+lcbVwQXFRpEiNslhj0q+8aTC+p2MLJF9XkSVhbsYrwzH3Zegaja87vmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427547; c=relaxed/simple;
	bh=TMNi1TEAkPmIaNzTLKdT90PeWm/JU0u5xNclztXdGBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0rHfud8Trm4NJJVkThCV2iEj7vbw4Jnf2kmx6jWGGFdJQxo+iv9068V2FbmRyj3Zmmwe09DDeMlstyOHrJLAvNfpNH2gpTkLyAV4V+mTR1WsnJ9oxb0HmlIOYef6hw3WGTlxQFU1esbWx6SgbFe/WiKkicK0aBwWzl3NOw2Yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=b2YCtg10; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=UEPOauNiUq9T7KfVOX/WwHhE48u8UrL4ukkVKlw7PHw=;
	t=1727427545; x=1727859545; b=b2YCtg10ixJSNeaw5QwpHpvKfU/mxkEOa4YdKHsL1VjpRMD
	vbVZeAdgpjOgsXUn3BFtsSM4q5mfj28C0Bs3xsgCmo0iQglmYLntltbettw42QWPrg4gCSEs35Up2
	b2utvObuDYZdG6VptA71C5jGri2t83nf+Wdi1/mcb1JWfvGlYvClPUJ7DlnnEqJBk1hD56lwB+RIn
	EjqV42tm44kROD445MemRkeqD68avDcGmEQ4PMZpTdQvxyENCFQglBTbp5avJ3ta7jroIteuU1KCZ
	jANWnCU6OGmNIxUzp0V2xIQN9kbIDZNaMQ32le/+ZDqcsKrvQCI3c85HVUb9zlDA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1su6oY-0004oG-By; Fri, 27 Sep 2024 10:59:02 +0200
Message-ID: <38620c47-62ea-40b6-a7b3-afee9a3238a3@leemhuis.info>
Date: Fri, 27 Sep 2024 10:59:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] frozen usb mouse pointer at boot
To: Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <3724e8e8-ab71-4f64-8ba1-c5c9a617632f@leemhuis.info>
 <2024091128-imperial-purchase-f5e7@gregkh>
 <66ef853de5f16_10a0a2946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <66f229fc4daa9_2a86294ec@dwillia2-xfh.jf.intel.com.notmuch>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <66f229fc4daa9_2a86294ec@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727427545;4d57946b;
X-HE-SMSGID: 1su6oY-0004oG-By

On 24.09.24 04:54, Dan Williams wrote:
> Dan Williams wrote:
>> Greg Kroah-Hartman wrote:
>> [..]
>>>
>>> This is odd.
>>>
>>> Does the latest 6.10.y release also show this problem?
>>>
>>> I can't duplicate this here, and it's the first I've heard of it (given
>>> that USB mice are pretty popular, I would suspect others would have hit
>>> it as well...)
>>
>> Sorry for missing this earlier. One thought is that userspace has a
>> dependency on uevent_show() flushing device probing. In other words the
>> side effect of taking the device_lock() in uevent_show() is that udev
>> might enjoy some occasions where the reading the uevent flushes probing
>> before the udev rule runs. With this change, uevent_show() no longer
>> waits for any inflight probes to complete.
>>
>> One idea to fix this problem is to create a special case sysfs attribute
>> type that takes the device_lock() before kernfs_get_active() to avoid
>> the deadlock on attribute teardown.
>>
>> I'll take a look. Thanks for forwarding the report Thorsten!
> 
> Ok, the following boots and passes the CXL unit tests, would appreciate
> if the reporter can give this a try:

Somehow I apparently became a "bugzilla-man-in-the-middle interface" yet
again... But whatever! ¯\_(ツ)_/¯

To forward the latest comment from the ticket:

"""
--- Comment #11 from brmails+k@disroot.org ---
Good news!

I think the proposed patch by Dan Williams fixes the issue.

I have tested it with v6.6.52 and v6.10.11. I haven't been able to
recreate the
issue with those modified kernels even once.

The patch can be applied to v6.11.0 and v6.10.11 out of the box. For
v6.6.52 I
had to slightly modify it as the line

#define SYSFS_GROUP_INVISIBLE   020000

doesn't exist in /include/linux/sysfs.h in v6.6.52 hence the patch
looking for
that line fails on that file.
But after adjusting the patch accordingly, the patch works fine on
v6.6.52 and
the issue is gone with the patched version of v6.6.52, just like 6.10.11.

So, I assume that the fix / patch proposed by Dan Williams works as intended
resolving the issue I had.

Thanks again for forwarding the bug report and for the quick fix!
"""

Ciao, Thorsten

