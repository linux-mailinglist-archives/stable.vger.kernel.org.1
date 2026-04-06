Return-Path: <stable+bounces-233354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jjIIDI5n02kCiAcAu9opvQ
	(envelope-from <stable+bounces-233354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:58:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA33A21AE
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2F723004C84
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0434BA50;
	Mon,  6 Apr 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="c0xknJNm"
X-Original-To: stable@vger.kernel.org
Received: from cmx-mtlrgo001.bell.net (mta-mtl-008.bell.net [209.71.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE822E54B6
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.208.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462278; cv=none; b=f71RGJSfyHwBC1R8SZKmyzlzrZrCfWT8C+UpvnbLMi2PLitbrgwXaFZxivcIuT9jC6W+8lO5qlXfaHQ0Ydnj46RgcL3U0d0FMHeEc7wCoTQ31jooNwqyXnUWNPQgUdTovPJ2A+o7/M/+QzQiaH1EnO+gtzH3aqL4GcJ0/3N3s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462278; c=relaxed/simple;
	bh=c0N7m5z8hZVNWJq5uAs4Kn5/y5ehEpZ/+gE27TP3eAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HedOrtItavmiDWcboUcne8rJfdONTeiiiWBkGktVvqttnTQvoiSGHGUXqUd1pQkpyskFV/qix+JzTO5hzVVzlLibhExmJ6FNBvl6Vu7Sdr0lu1cKOak1EwZKQE4I1CytkdmBrllovyOX1XBNlTlP9cMgJHo/yjlVzhh5L6dTEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=c0xknJNm; arc=none smtp.client-ip=209.71.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1775462277; 
        bh=ee/ibGxRB7ZMYV1LgEYDA/tCFpV2VxAtOGiEdEyBcsk=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=c0xknJNmf3u68zTBvOBOnScKqzfrRoLNyoU4h4WvvRNY2CDwIh+2+eGRrOQXxjCelUArB7bM5NeYohYCf4GW1/loLHwMVJ7YAzc5354ofvK2BFi0o/8WPiA+JFPhAe4ACqohIMwHqB2FPRO+UXslcHi3tghj1b7ppZT2UfN/D+enKT3Pvrq8ZsiQopKlZeHCh+wjtFgmA9vi0IB/gu1PJPwFOyTRWIrmwSD1lGgRAG13FGZ/sVZnm/rhAG6Z85F82dJa9fhp2dLoHaG7KC0OOa0AYKAkfHPUWt0pVunL/1g9VnpGR5EfAIYNqvzl68+SEM89XeIO+o06XfNhlWUBhA==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: matt.fagnani@bell.net
X-RG-Rigid: 69BEEF93021C3F91
X-RazorGate-Vade: dmFkZTEwdeOu4RFMK0bgxNPhFO6olhcTTPjSXyYQ4ESBdvLEPeNsUtn3i7fQCRLygdbADflYYybHj4BpueTVDOTen5ln1JzbdbKHPhTdhhNQSLcVDkQSvwmtB/nskwz+3ltD5Q4mkjsTsd44WDJx1Jhf04HOzT6Ahy/SdkZI0bV6rpHFmy+ylGlX1Z/lGDxd60P3IDn0oOGXtbd2LRu0Um5eAc4M6dlHsFDZidudjBt0ahqdC5utZ/5K7NDOTgENJ1od7VGPqDLexbGrCoMXBY2VQfhP6dD6OAOtl99YVPkXE+61JFCnh9u7Rt5zAqM7b4+ccpVjxoUeCXYCtD260Ovj9xE9Zh9xUyJqBzI9lUKyzNqutU5h61q5RpyLOHEkjL2DJt4oOPz12sZWcUuphO+RzrqtWpyGMw7Lb4+pvFsT79hg57kJipIFSkdxxGjGKbKdZkXEk8q4EGLdoIzqmUA4DgL9AvydlmkO0iucHSlsTgLYIKxCV7hVeIGSsb/0U2YNHu4JjpgTb/f00JtrAgZQOOf6HQKWegpwNVQUzr5pv612elDG4/EKQRPgDmND7CmfaAxsrsqMINDk5op5S34PrkGxlfG/dAgolhSXJ/fiLatEaTSgTm4fJI9m6Z4N3W97Iqo7D/V+hAZOn+ch4vKeNyvFE9N9CLbSw/SAvzo5EppQyw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.10] (70.48.33.60) by cmx-mtlrgo001.bell.net (authenticated as matt.fagnani@bell.net)
        id 69BEEF93021C3F91; Mon, 6 Apr 2026 03:54:40 -0400
Message-ID: <35ed8f9a-66c2-40c3-a545-da4af629014f@bell.net>
Date: Mon, 6 Apr 2026 03:54:39 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: Warnings and errors in drm_mode_config_cleanup when booting
 6.19.10 and 7.0-rc5
To: Greg KH <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
 <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
 <2026040259-glacial-reversal-9a75@gregkh>
Content-Language: en-US
From: Matt Fagnani <matt.fagnani@bell.net>
In-Reply-To: <2026040259-glacial-reversal-9a75@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bell.net,none];
	R_DKIM_ALLOW(-0.20)[bell.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[bell.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bell.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt.fagnani@bell.net,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233354-lists,stable=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,bell.net:dkim,bell.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07BA33A21AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-02 08:12, Greg KH wrote:
> On Sat, Mar 28, 2026 at 11:52:48AM +0100, Thorsten Leemhuis wrote:
>> Matt, thx for the report.
>>
>> On 3/28/26 11:30, Matt Fagnani wrote:
>>> I could try to bisect. The commit
>>> e493c135980f90c20308d1a98f2e0d1223951e94 drm: Fix use-after-free on
>>> framebuffers and property blobs when calling drm_dev_unplug was included
>>> in 6.19.10 and changed drm_mode_config_cleanup https://git.kernel.org/
>>> pub/scm/linux/kernel/git/stable/linux.git/commit/?
>>> h=linux-6.19.y&id=e493c135980f90c20308d1a98f2e0d1223951e94
>> Did a quick search. Turns out this is mainline commit 6bee098b914176
>> ("drm: Fix use-after-free on framebuffers and property blobs when
>> calling drm_dev_unplug") -- and when searching for that (FWIW, this is
>> not widely known, but that is really helpful in case like this, as the
>> mainline commit id is way more relevant) is turns out that is in the
>> process of getting reverted:
>>
>> See https://lore.kernel.org/all/20260326082217.39941-2-dev@lankhorst.se/
>> or 45ebe43ea00d6b ("Revert "drm: Fix use-after-free on framebuffers and
>> property blobs when calling drm_dev_unplug"") [next-20260327
>> (pending-fixes)].
>>
>> Sasha and Greg: you might want to make sure to pick this up.
> When it shows up in a Linus-released kernel, can someone remind us?
>
> thanks,
>
> greg k-h

7.0-rc7 https://lwn.net/Articles/1066405/ had the patch Revert "drm: Fix 
use-after-free on framebuffers and property blobs when calling 
drm_dev_unplug" 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.0-rc7&id=45ebe43ea00d6b9f5b3e0db9c35b8ca2a96b7e70 Thanks.

Matt



