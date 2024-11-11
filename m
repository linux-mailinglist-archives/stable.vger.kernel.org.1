Return-Path: <stable+bounces-92083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7739C3BCE
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD861C21B0F
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466C16F8EB;
	Mon, 11 Nov 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="D5tmSarG"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDA15C15F;
	Mon, 11 Nov 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320593; cv=none; b=kjC+xrvAXLnZfnfZNk6a5RkiGsInMnlFBSyVU30muQCdXNA+S/pe8XJWOzETpSPYUmhAkl95g/oALdFa68pEeS4M1B2qY985nA6X28EYRgsMwp2I25qZGuHZqbcjIxG7YQtCUhDj7pY9Yk1pppa7Syje0ye86KDOZMOxPlS/6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320593; c=relaxed/simple;
	bh=gG+nv2WSch8Ph96EDmDGJg3NwB4uzQfgre5yOuFMKXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyCsbs44IJhoEFJO8bdC1SWJghxCL/AWzqfczMgub5Voe5CTcNi0ek8j6097c5BHXbc8TR1vZqUZeaNgcJvyfgGRL8j/1yIZSxHfMnXcZRHz6eEgJLGsVgmX8hOqPZuu8gi6dVdTyK3YaD3lmjp5HV9YFO2UFz3Jd4GCER3mJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=D5tmSarG; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=o0Cd9Ag/qmRaG68s18dQ0QUIybsRfVp/I4NcYavvpoU=; t=1731320591;
	x=1731752591; b=D5tmSarGGLvW5PFmsJ4rTZI2SJnwPeHvntrsRjodXCJv9ErsFVamp9O+Npy3y
	kOEnUhTiDrCVgglANzq9iyli4N/7SmLcJXlMclUHOEPzIKz+JqetUXnTBUPdD27lTvuEkPNHeNZ2h
	ydve7G0jihWirV4MaJAkrEGHrFdhX1ZabUnQL1ufESUnkautevmJ53Rli3R7vX/YJNjA7G3y3LD2m
	Mtaky+xJD2ecU82d/45XOXMafYDX4Ce6cLyyKMuvICF5hq0e7xVtAg1riw+P1TiythUINpJgxmSyt
	SmU1WI9L7UiS9mUqHEilGlAmpt2/wnSu8kRdQq/i9bJWN5Brzw==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tARZa-0004NF-8i; Mon, 11 Nov 2024 11:23:06 +0100
Message-ID: <29cc9650-0273-41ae-b6be-8fd965cd0204@leemhuis.info>
Date: Mon, 11 Nov 2024 11:23:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works
To: He Lugang <helugang@uniontech.com>
Cc: stable@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Jiri Kosina <jkosina@suse.com>, =?UTF-8?Q?Ulrich_M=C3=BCller?=
 <ulm@gentoo.org>
References: <uikt4wwpw@gentoo.org>
 <a4b1bae4-5235-4f19-bcdb-5ed9b67449b1@leemhuis.info> <ucyj4h2z7@gentoo.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-MW
In-Reply-To: <ucyj4h2z7@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731320591;85dcfa58;
X-HE-SMSGID: 1tARZa-0004NF-8i

On 09.11.24 15:54, Ulrich Müller wrote:
>>>>>> On Sat, 09 Nov 2024, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> On 03.11.24 09:24, Ulrich Müller wrote:
>>> After upgrading from 6.6.52 to 6.6.58, tapping on the touchpad stopped
>>> working. The problem is still present in 6.6.59.
>>>
>>> I see the following in dmesg output; the first line was not there
>>> previously:
>>>
>>> [    2.129282] hid-multitouch 0018:27C6:01E0.0001: The byte is not expected for fixing the report descriptor. It's possible that the touchpad firmware is not suitable for applying the fix. got: 9
>>> [    2.137479] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI0010:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input10
>>> [    2.137680] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI0010:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input11
>>> [    2.137921] hid-multitouch 0018:27C6:01E0.0001: input,hidraw0: I2C HID v1.00 Mouse [GXTP5140:00 27C6:01E0] on i2c-GXTP5140:00
>>>
>>> Hardware is a Lenovo ThinkPad L15 Gen 4.
>>>
>>> The problem goes away when reverting this commit:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-multitouch.c?id=251efae73bd46b097deec4f9986d926813aed744
> 
>> Thx for the report. Is this a 6.6.y specific thing, or does it happen
>> with 6.12-rc6 or later as well?  And if it does: does the revert fix it
>> there, too?
> 
> It still happens with 6.12-rc6, and the revert fixes it.

He Lugang, in case you missed it: the culprit (251efae73bd46b ("HID:
multitouch: Add support for lenovo Y9000P Touchpad") [v6.12-rc1]) is a
commit of yours. At it was already backported to various stable series,
so it would be good to fix this rather sooner than later.

Ciao, Thorsten



