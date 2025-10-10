Return-Path: <stable+bounces-183862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A42BCC423
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0314066B6
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1CF241690;
	Fri, 10 Oct 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lCpSXtoa"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597A217723
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087213; cv=none; b=fnWvPGB+niDXkAm9ahm6eLi0FYP7YhI7Vbd3K9gE1oZXy89T+KjSmv2Sl8iOfaAetLpIOI5Hhm6rYZRuvBXeoy3YkS3XT1X4O3ycKhyJoNjzxzm2Ju8OU7tXeyieAfv8eBkwTcSKsK5AcxAh5llHvb0TrmeGsF510J1Nv3o0xN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087213; c=relaxed/simple;
	bh=IsGhKN+ISwmoiMVLqUMbSvJDHuVQmWBmnBcq6oPhEk8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=haywoe22xfjZ1bqFF38w2QMEd/JxFa8io+iSulTpOg8nwFe7tEsVBcUAZ8NHKuOKJh6lHejQ+4OpSq/pcwvpSOuFN3IXJAg36B/Ccjb7wXh5S/QO3QsnmwJBpK9iW1HqoDlTGlNA/kxnjaSol7KnrMW2ciplTibwZOFmHsgnKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lCpSXtoa; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6B00F25BEF;
	Fri, 10 Oct 2025 11:06:48 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfkyY6bSuux8; Fri, 10 Oct 2025 11:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760087207; bh=IsGhKN+ISwmoiMVLqUMbSvJDHuVQmWBmnBcq6oPhEk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lCpSXtoaz3RJPNla8lj0QnJ5eQJbkh0edD1TJy/oBGZSqE3IXiIW/AgCOYjjY2L2E
	 K0cMOGQVKd1p0eWir7wm4AIxKQ8aqDdz3gG9gxuweeNgT8dfzeofZEwNXIABQDOXSB
	 losjUGppk9rvYW2gfXA9p3D5xZidQBtYgljd1VA5zToyvRAlVtixxyzqyBRozPeFEr
	 KdM4ogcydiyy/VFVDjg0kX54iPvuxUutJ6Uxq/d1kgSFZfMir/DJS3CkancvrV0Eo6
	 0kx297XTzy4Y4XoytCWYeUXFlp6N39IsqQMtw6ZJKigchD6iDtqPDoy1RUoo5x7p4W
	 /bwgBrB2X8NZA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 Oct 2025 11:06:47 +0200
From: machion@disroot.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Subject: Re: Unplayable framerates in game but specific kernel versions work,
 maybe amdgpu problem
In-Reply-To: <fadf714ecdc2e3bd5bed0c3ee69177a1@disroot.org>
References: <c415d9e0b08bcba068b01700225bf560@disroot.org>
 <CADnq5_PX1dYF2Jd3q7ghaBjpPhNLq9EmFJtN1w6YOSfVo++7sA@mail.gmail.com>
 <69b5ebaa719355994a383fa026dc3fba@disroot.org>
 <CADnq5_PkOuAHuDjMNXABEcenaZFZgU044G=9pTu=EgMr_grXbw@mail.gmail.com>
 <fadf714ecdc2e3bd5bed0c3ee69177a1@disroot.org>
Message-ID: <748446b7fa6a53f31c69a4e40257adae@disroot.org>
X-Sender: machion@disroot.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

I have a question:

Would it be possible to make the "memory management/buffering" methodes 
switchable through a conf file (obviously amdgpu.conf)?
So that I don't have to keep an old kernel version installed just to 
play my game.

Marion


Am 2025-06-17 11:42, schrieb machion@disroot.org:
> I feared that.
> 
> It seems a crazy problem, when many people are affected and in opposite 
> ways.
> This ReBAR/UEFI thing is also new to me, but I don't have this on my 
> system either (using BIOS/MBR).
> 
> I hope, it can be fixed for all scenarios.
> 
> Marion
> 
> Am 2025-06-16 15:29, schrieb Alex Deucher:
>> On Fri, Jun 13, 2025 at 3:38 PM <machion@disroot.org> wrote:
>>> 
>>> Hi,
>>> sorry for the delay.
>>> Besides less time, I had to make myself familiar with bisecting and
>>> again kernel compiling. Last time I compiled the kernel myself was
>>> around 2010 I think.
>>> 
>>> Anyway it seems I found the bad commit. The result after bisecting 10
>>> commits is:
>>> 
>>> a53d959fe660341788cb8dbc3ac3330d90a09ecf is the first bad commit
>>> commit a53d959fe660341788cb8dbc3ac3330d90a09ecf
>>> Author: Christian König <christian.koenig@amd.com>
>>> Date:   Thu Mar 20 14:46:18 2025 +0100
>>> 
>>>      drm/amdgpu: immediately use GTT for new allocations
>>> 
>>>      commit a755906fb2b8370c43e91ba437ae1b3e228e8b02 upstream.
>>> 
>>>      Only use GTT as a fallback if we already have a backing store. 
>>> This
>>>      prevents evictions when an application constantly allocates and
>>> frees new
>>>      memory.
>>> 
>>>      Partially fixes
>>>      
>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2833985.
>>> 
>>>      Signed-off-by: Christian König <christian.koenig@amd.com>
>>>      Fixes: 216c1282dde3 ("drm/amdgpu: use GTT only as fallback for
>>> VRAM|GTT")
>>>      Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>      Cc: stable@vger.kernel.org
>>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> 
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> Unfortunately reverting that commit will reintroduce a similar
>> performance issue for lots of other uses.  See:
>> https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2827990
>> for a description of the fundemental problem.
>> 
>> Alex
>> 
>>> 
>>> Marion
>>> 
>>> 
>>> Am 2025-05-08 15:18, schrieb Alex Deucher:
>>> > On Thu, May 8, 2025 at 9:13 AM <machion@disroot.org> wrote:
>>> >>
>>> >> Hello kernel/driver developers,
>>> >>
>>> >> I hope, with my information it's possible to find a bug/problem in the
>>> >> kernel. Otherwise I am sorry, that I disturbed you.
>>> >> I only use LTS kernels, but I can narrow it down to a hand full of
>>> >> them,
>>> >> where it works.
>>> >>
>>> >> The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD
>>> >> 7790/8GB
>>> >> RAM
>>> >> I already asked the Manjaro community, but with no luck.
>>> >>
>>> >> The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021),
>>> >> uses vulkan
>>> >>
>>> >> ---
>>> >>
>>> >> I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15,
>>> >> 6.1 and 6.6 and and the game was always unplayable, because the frames
>>> >> where around 1fps (performance of PC is not the problem).
>>> >> I asked the mesa and cinnamon team for help in the past, but also with
>>> >> no luck.
>>> >> It never worked, till on 2025-03-29 when I installed 6.12.19 for the
>>> >> first time and it worked!
>>> >>
>>> >> But it only worked with 6.12.19, 6.12.20 and 6.12.21
>>> >> When I updated to 6.12.25, it was back to unplayable.
>>> >
>>> > Can you bisect to see what fixed it in 6.12.19 or what broke it in
>>> > 6.12.25?  For example if it was working in 6.12.21 and not working in
>>> > 6.12.25, you can bisect between 6.12.21 and .25.
>>> >
>>> > Alex
>>> >
>>> >>
>>> >> For testing I installed 6.14.4 with the same result. It doesn't work.
>>> >>
>>> >> I also compared file /proc/config.gz of both kernels (6.12.21 <>
>>> >> 6.14.4), but can't seem to see drastic changes to the graphical part.
>>> >>
>>> >> I presume it has something to do with amdgpu.
>>> >>
>>> >> If you need more information, I would be happy to help.
>>> >>
>>> >> Kind regards,
>>> >> Marion

