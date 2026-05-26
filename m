Return-Path: <stable+bounces-254336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHzACoiYFWqNWgcAu9opvQ
	(envelope-from <stable+bounces-254336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:56:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2715D5E08
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1720306EA72
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AAC24DD15;
	Tue, 26 May 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsDazvTR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EA232367;
	Tue, 26 May 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799862; cv=none; b=rswIihJQjjKgq80zGphluJhmWwmgcWV3M/oIyhBKfrdgoeN7Cud5xmWjEfuiBdwxaqXtLG65wcUQ1gdH0/z5CEaA2pbVYzSu817FsL/ysBv1stvp0WktlmLl+ucNK9qtbko/HBJ38cKdGQJFLOZvaYmvGa3pbCftf4WPeNo3Al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799862; c=relaxed/simple;
	bh=soxXrmHMnfTd2mMlJwwP37yhv5mgMFQOAtqmyi4tGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1cTMO6ZtsfOTnLKnnrJdJR1ppw6ZZpyHB4zY1GgR5nHXdf7XzvBCSf6ATYjE5Zod9aWXYuRqZTtd0nckeKob8BYPXUisRVopSwjfYYehZ14bjjbx05qEEXitdFu87uczIh32ow1bqlMDxdzgN8snqhIuqakRbmDXLeHZL9oXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsDazvTR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667D11F00A3C;
	Tue, 26 May 2026 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779799860;
	bh=bteBqFYiwq3J6OuPkzqH8VWWC7H63MmZiDe/6GM4mCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OsDazvTRCqIezJKqXfh8OOKQB1X2daHZmZ45puukpTDNAAa4h2d68mcd1v7oAsw8I
	 MZ4KKRpNxXIgxjh0jblCDvZ2+6jxwbyYf3V59oGWmdB4rY61G9qHgAJQpCJrV0vQJk
	 h9CljaZISKs2pvdqgaSUjb90cD7nro4md0MGNbMtpmQT19WpWsGlJjeZOzUaSTu23K
	 KJdoIDobh0UiM/xCW0LO1dCP5OMGzZle4e/Gr0q0YVtfL52Cf+puvNceX1sFgRabAC
	 v54+J/ynVhiK/A+BVaqxSOE6Zq0M4LLd3og9dPz1Q+bwc9SmYM9Cj4a0iZ+2sKXx7P
	 OZ8f2SNyYsLvg==
Date: Tue, 26 May 2026 08:50:59 -0400
From: Sasha Levin <sashal@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: w15303746062 <w15303746062@163.com>, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, tzimmermann@suse.de, mripard@kernel.org,
	louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to
 fix ABBA deadlock
Message-ID: <ahWXMzJ3OWea3eyX@laps>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
 <20260525131610.608273-1-w15303746062@163.com>
 <20260525231000.agent5-0001@kernel.org>
 <51ff85d2.9c25.19e642e591c.Coremail.w15303746062@163.com>
 <99f74d53-0060-4fed-b83e-955071883651@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <99f74d53-0060-4fed-b83e-955071883651@linux.intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[163.com,vger.kernel.org,linuxfoundation.org,suse.de,kernel.org,bootlin.com,lists.freedesktop.org,stu.xidian.edu.cn];
	TAGGED_FROM(0.00)[bounces-254336-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9A2715D5E08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 02:48:55PM +0200, Maarten Lankhorst wrote:
>Hello,
>
>Den 2026-05-26 kl. 14:06, skrev w15303746062:
>>
>> Hi Sasha,
>>
>>> Looking at the five commits:
>>>
>>>  - 1/5 (74afeb812850) is the one that actually fixes the ABBA
>>>    deadlock you observed under Syzkaller; it adds the generic vblank
>>>    timer that replaces the open-coded vkms hrtimer path.
>>>
>>>  - 2/5 (d54dbb5963bd) adds new CRTC helpers for "simple use cases".
>>>    No Fixes:/Cc:stable, no described bug.
>>>
>>>  - 3/5 (02e2681ffe1a) is a refactor that converts vkms to the new
>>>    helpers. No Fixes:/Cc:stable, no described bug.
>>>
>>>  - 4/5 (79ae8510b5b8) is a v7.1-rc1 timeout bump that depends on 1/5.
>>>    It is not yet in any released stable, so applying it to 6.18.y
>>>    would put it on an LTS before any LTS contains it.
>>>
>>>  - 5/5 (3946d3ba9934) is a doc fix for 1/5.
>>>
>>> Per stable-kernel-rules, what I need to queue is the minimum set that
>>> fixes the bug. Could you explain, per patch, why 2/5..5/5 are required
>>> to make 1/5 work / are required to actually fix the deadlock? If only
>>> 1/5 is needed, please resend just that one with your Signed-off-by
>>> added (the carried patches today only have Thomas's S-o-b, which
>>> breaks the chain of custody on a stable submission).
>>
>> Thanks for the quick review and for pointing out the missing Signed-off-by. I apologize for that omission; it was my mistake during the cherry-pick process.
>>
>> Regarding the dependency chain, I would like to clarify why commit 1/5 alone cannot fix the issue:
>>
>> Commits 1/5 and 2/5 introduce the new generic vblank timer infrastructure to the DRM core but do *not* touch the vkms driver at all.
>> Commit 3/5 (02e2681ffe1a) is the actual fix that modifies `drivers/gpu/drm/vkms/vkms_crtc.c`. It removes the buggy open-coded hrtimer that causes the ABBA deadlock and switches vkms to use the new infrastructure introduced in 1/5 and 2/5.
>>
>> Therefore, 1/5, 2/5, and 3/5 form an indivisible set. Applying only 1/5 would leave the deadlock in vkms completely unpatched.
>>
>> As for 4/5 and 5/5 (the timeout bump and doc fix), Maarten Lankhorst (DRM maintainer) explicitly recommended pulling in this exact 5-commit list as the proper upstream fix for this specific vkms issue (see the mailing list link in this thread).
>>
>> However, if you feel 4/5 and 5/5 introduce unnecessary risk for the 6.18.y stable tree, I can absolutely drop them and only submit 1/5, 2/5, and 3/5.
>>
>> I am preparing a v2 patch series now with my Signed-off-by added to the chain of custody. Could you let me know if you prefer the full 5-patch series as recommended by DRM maintainers, or just the minimal 3-patch series?
>>
>> Best regards,
>> Mingyu
>
>5/5 might strictly speaking not be needed as it's a documentation fix and I have no idea of the policy about those.
>
>The reporter made a bug report of an ABBA deadlock that was fixed in upstream by the first 4 patches, perhaps it's good to those attach here to this discussion.

I have no objection to taking all 5 if you're okay with it.

-- 
Thanks,
Sasha

