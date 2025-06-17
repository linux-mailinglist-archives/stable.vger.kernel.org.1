Return-Path: <stable+bounces-152763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7B4ADC6D0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 11:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778C21648A9
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2EB292B4E;
	Tue, 17 Jun 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BBArIcmN"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144321B91F
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153327; cv=none; b=WA2wGatFm3BBMLArYb3vkLZh0KEe4XA2EC45Modu/Eje4uPimhDfZN3ZSWWFrr2yhT7Tzzjdb+ua3S7ShgCrLeHL4/kxZnQNE450DLIwWyQ/bc4VBBinF1GHu30FWyU73GLEVz/0TrdS7QSsRb/ccTn9hmZmVvmlexHSi0srfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153327; c=relaxed/simple;
	bh=kEVr5LRDJXI5+NMKIDFQUd9VmCGFm55tC/Y7nPANTt8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AfTPO8cg6sJOBCdFLDoRQ3yKgJzq7MqvbI2bGx2OMMcOojxRmVO5a8rJ9WUK0Q0IalpuX/ogWQ7Ox8cw+gPnGF42Zqm3l+Wp5ansqk6mywSXu+pLGY9lzBzFoUNafk3euFT/3TFF62mMnBWZ0bHlh3U6OW/BMcJMQT/s+xRv35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BBArIcmN; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7B0E425F98;
	Tue, 17 Jun 2025 11:42:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLfz8DzFOpKU; Tue, 17 Jun 2025 11:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750153323; bh=kEVr5LRDJXI5+NMKIDFQUd9VmCGFm55tC/Y7nPANTt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BBArIcmNxHIoKXxCgCBxozEjIHCMN0lxBNp8rZFkzi4cfUkTmHUYZA+btASY+rxE0
	 Zk42MC5u/x40Y32dkU6MEq9405EV1UR2DhNI8mtSCelB1EOtsnKjYkm+qNFPmtjFup
	 Xnb5iAjftrdy6AcGBVVFQaBW0EP1mU4N9lYhMgc7iOxlUrgDgbvXY2D1MUOe5jtyfo
	 2L7b475uhTOlyAtprlcIMMw06ieRPzrRUOxzGS+MqMwcs3KmWSW4fyv+GhBaLcMd1e
	 JOaJEZDqCoT9jxAsG2/W76gPiEMQZcfwYF6W+0HLBSMiUJSVT084pZYKoMKAD6hHlg
	 aqi5zH64yEj4Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Jun 2025 11:42:03 +0200
From: machion@disroot.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Subject: Re: Unplayable framerates in game but specific kernel versions work,
 maybe amdgpu problem
In-Reply-To: <CADnq5_PkOuAHuDjMNXABEcenaZFZgU044G=9pTu=EgMr_grXbw@mail.gmail.com>
References: <c415d9e0b08bcba068b01700225bf560@disroot.org>
 <CADnq5_PX1dYF2Jd3q7ghaBjpPhNLq9EmFJtN1w6YOSfVo++7sA@mail.gmail.com>
 <69b5ebaa719355994a383fa026dc3fba@disroot.org>
 <CADnq5_PkOuAHuDjMNXABEcenaZFZgU044G=9pTu=EgMr_grXbw@mail.gmail.com>
Message-ID: <fadf714ecdc2e3bd5bed0c3ee69177a1@disroot.org>
X-Sender: machion@disroot.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

I feared that.

It seems a crazy problem, when many people are affected and in opposite 
ways.
This ReBAR/UEFI thing is also new to me, but I don't have this on my 
system either (using BIOS/MBR).

I hope, it can be fixed for all scenarios.

Marion

Am 2025-06-16 15:29, schrieb Alex Deucher:
> On Fri, Jun 13, 2025 at 3:38 PM <machion@disroot.org> wrote:
>> 
>> Hi,
>> sorry for the delay.
>> Besides less time, I had to make myself familiar with bisecting and
>> again kernel compiling. Last time I compiled the kernel myself was
>> around 2010 I think.
>> 
>> Anyway it seems I found the bad commit. The result after bisecting 10
>> commits is:
>> 
>> a53d959fe660341788cb8dbc3ac3330d90a09ecf is the first bad commit
>> commit a53d959fe660341788cb8dbc3ac3330d90a09ecf
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Thu Mar 20 14:46:18 2025 +0100
>> 
>>      drm/amdgpu: immediately use GTT for new allocations
>> 
>>      commit a755906fb2b8370c43e91ba437ae1b3e228e8b02 upstream.
>> 
>>      Only use GTT as a fallback if we already have a backing store. 
>> This
>>      prevents evictions when an application constantly allocates and
>> frees new
>>      memory.
>> 
>>      Partially fixes
>>      
>> https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2833985.
>> 
>>      Signed-off-by: Christian König <christian.koenig@amd.com>
>>      Fixes: 216c1282dde3 ("drm/amdgpu: use GTT only as fallback for
>> VRAM|GTT")
>>      Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>      Cc: stable@vger.kernel.org
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> 
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Unfortunately reverting that commit will reintroduce a similar
> performance issue for lots of other uses.  See:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2827990
> for a description of the fundemental problem.
> 
> Alex
> 
>> 
>> Marion
>> 
>> 
>> Am 2025-05-08 15:18, schrieb Alex Deucher:
>> > On Thu, May 8, 2025 at 9:13 AM <machion@disroot.org> wrote:
>> >>
>> >> Hello kernel/driver developers,
>> >>
>> >> I hope, with my information it's possible to find a bug/problem in the
>> >> kernel. Otherwise I am sorry, that I disturbed you.
>> >> I only use LTS kernels, but I can narrow it down to a hand full of
>> >> them,
>> >> where it works.
>> >>
>> >> The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD
>> >> 7790/8GB
>> >> RAM
>> >> I already asked the Manjaro community, but with no luck.
>> >>
>> >> The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021),
>> >> uses vulkan
>> >>
>> >> ---
>> >>
>> >> I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15,
>> >> 6.1 and 6.6 and and the game was always unplayable, because the frames
>> >> where around 1fps (performance of PC is not the problem).
>> >> I asked the mesa and cinnamon team for help in the past, but also with
>> >> no luck.
>> >> It never worked, till on 2025-03-29 when I installed 6.12.19 for the
>> >> first time and it worked!
>> >>
>> >> But it only worked with 6.12.19, 6.12.20 and 6.12.21
>> >> When I updated to 6.12.25, it was back to unplayable.
>> >
>> > Can you bisect to see what fixed it in 6.12.19 or what broke it in
>> > 6.12.25?  For example if it was working in 6.12.21 and not working in
>> > 6.12.25, you can bisect between 6.12.21 and .25.
>> >
>> > Alex
>> >
>> >>
>> >> For testing I installed 6.14.4 with the same result. It doesn't work.
>> >>
>> >> I also compared file /proc/config.gz of both kernels (6.12.21 <>
>> >> 6.14.4), but can't seem to see drastic changes to the graphical part.
>> >>
>> >> I presume it has something to do with amdgpu.
>> >>
>> >> If you need more information, I would be happy to help.
>> >>
>> >> Kind regards,
>> >> Marion

