Return-Path: <stable+bounces-92002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E19C2D30
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 13:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2001C20D58
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC6155726;
	Sat,  9 Nov 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="eiuF4VH1"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F513D899;
	Sat,  9 Nov 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156147; cv=none; b=lAFxjcnvJnx7/SdJVT7xyChENxU82XksGXXn5gtZF4A2UZ+EF3/vAC/PUI8wsW9C5J6X/5mIqxGR2mE78KhntsM8OnyOpSWZ9L+2rIp2Vgusn6PU+JjHz0kuU4Zso354CBIz2pw6sR0ySMNMAezto4CYmd03oWCq8Gl1wzPcqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156147; c=relaxed/simple;
	bh=VoHbs/oGgMDe6Okkb5VlTaPby3/ftiV1xiKBHFymen8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph3x581rNC1JfbitHeg3KaQzcCbDQm4mQKh+v3cCubYaOV5l1RYB1VFpTwzDUO6YoGS0GWG+I7aYv2Tnta/s8NYi0J/HUvP4Mu+Xz8LnUZzYf9mfIBeZ2cZXsCF8WyF110ccLILlbU6fiL9fVMPwKSljoFM/TrrZpmNwdGxprTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=eiuF4VH1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=D+SrTdTv7+IX+LsrCgrUD+JvGB8+Q5Z9Xvua9pHws3Y=;
	t=1731156145; x=1731588145; b=eiuF4VH1a2JZvYBEElnNyuJW0Meudqoohd5rjfDp/P8W+8B
	RTTc7tnz8e21JuIYleOInU32k8qoIDuvfdyM5Rmc3TaOF/m+o4XUQDMfxsmNzwCXsHr7R1zKrVKNW
	aTjGNZ2kkcj6AKT6S3vnVcx2JEUmYjy2BG6LyAHrQOXtiaodDX+SC3iiUfs+UmZ4y0LrMsMo8s1A8
	vF9GkY/tQNFES3978s80kVgEOkd8thEOM86+rV+NlRrlGTBZPw5hi5kQwZY0ijwVQ7+aliBxuxPV0
	GEGG20dJsIiaxvIC3ZIOl8A0RS8Syzu0/KUV9Xndft8GolW7lzg1neGUTZQ+S1Lw==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t9knG-0002T9-0V; Sat, 09 Nov 2024 13:42:22 +0100
Message-ID: <a4b1bae4-5235-4f19-bcdb-5ed9b67449b1@leemhuis.info>
Date: Sat, 9 Nov 2024 13:42:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works
To: =?UTF-8?Q?Ulrich_M=C3=BCller?= <ulm@gentoo.org>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, He Lugang <helugang@uniontech.com>,
 Jiri Kosina <jkosina@suse.com>
References: <uikt4wwpw@gentoo.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-MW
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <uikt4wwpw@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731156145;a07a1ff0;
X-HE-SMSGID: 1t9knG-0002T9-0V

On 03.11.24 09:24, Ulrich Müller wrote:
> After upgrading from 6.6.52 to 6.6.58, tapping on the touchpad stopped
> working. The problem is still present in 6.6.59.
> 
> I see the following in dmesg output; the first line was not there
> previously:
> 
> [    2.129282] hid-multitouch 0018:27C6:01E0.0001: The byte is not expected for fixing the report descriptor. It's possible that the touchpad firmware is not suitable for applying the fix. got: 9
> [    2.137479] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI0010:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input10
> [    2.137680] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI0010:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input11
> [    2.137921] hid-multitouch 0018:27C6:01E0.0001: input,hidraw0: I2C HID v1.00 Mouse [GXTP5140:00 27C6:01E0] on i2c-GXTP5140:00
> 
> Hardware is a Lenovo ThinkPad L15 Gen 4.
> 
> The problem goes away when reverting this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-multitouch.c?id=251efae73bd46b097deec4f9986d926813aed744

Thx for the report. Is this a 6.6.y specific thing, or does it happen
with 6.12-rc6 or later as well?  And if it does: does the revert fix it
there, too?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

