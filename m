Return-Path: <stable+bounces-95352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54439D7CD7
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 09:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644CC163272
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD91885B8;
	Mon, 25 Nov 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXZEb36T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF710185B78;
	Mon, 25 Nov 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522958; cv=none; b=iY97hve1N7Uiba54V5PMTEI8Wwct/FLJMMuqj2q8vmZgHhYWO1qOC0/omm/hCHda4DqqMdlwMnmv2jsGxjQjwFT+9uuTwvjylbykJf130MAkmGSqW1R9Ornk3Q+RVsQVgfOLqX2wlOH4S4vGXDzkHD7SYMEQP5eiWT8k7j/z8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522958; c=relaxed/simple;
	bh=FaDLf/YlT4qbJ+Y1z6mvDucV+SxvIfVsq2pI3K98FiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF1L0/aXeu/lWbsu9RO5wmEMPJ5Y2SciYSJd7X9KljRXtDx6c5zQDtnD9iP/1bvLaA637+lMhuTn8ohR3nkXy1ULxSAOrAYVyP+/DhRnGeVflcan03DZBC2krSEyyM8JFzq4DZWAaagNcgKS1IrwTT915y9xqbqJrfsCajov1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXZEb36T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C3EC4CED1;
	Mon, 25 Nov 2024 08:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732522958;
	bh=FaDLf/YlT4qbJ+Y1z6mvDucV+SxvIfVsq2pI3K98FiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXZEb36TBz1Oy36PdFu3V5iPDE+YJbEiODlp7KfXom0qH98qRReQuQukho6cCphYz
	 0JbKVfa+GyctKVjC+U5UKf5fDfYdKaZ0aPHmcCUBG8tHzswFN7/cT4GswWRBO8PEz5
	 UXlLRC0WkqLB23A7a44TUx+DRSv7fOcocmj2v8eiruFAG8q1RhYmzaHYFKdQQFsmCm
	 L0lveGE/sWq8Ak+ZRJEz5XLx66+QKCjF5Pg/KFGPU9tjQqRiNSyo/CFgmwZo02GJpi
	 PD3HuuEJ7w7JXin7XLHWVwpKY+x/Wrtxn6whbs4vBd5HbtZ9VFakv7dbX3OJdU+dMC
	 hLmp1+cgteWFQ==
Date: Mon, 25 Nov 2024 09:22:34 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: He Lugang <helugang@uniontech.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Ulrich =?utf-8?Q?M=C3=BCller?= <ulm@gentoo.org>, Jiri Kosina <jkosina@suse.com>
Subject: Re: [REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works
Message-ID: <4p2nlmktrkoeu44yctsyrpr2ofmat3e3knlwudfdcrjwkzr56n@amyl3ad44sxe>
References: <uikt4wwpw@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uikt4wwpw@gentoo.org>

On Nov 03 2024, Ulrich Müller wrote:
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
> 
> See also Gentoo bug report: https://bugs.gentoo.org/942797

He Lugang,

It's been 3 weeks since this regression was reported and we haven't
heard back from you. It's clear that the patch mentioned here is too
gready and needs tuning to only apply to the firmware which needs the
fix.

Could you quickly submit a fix that checks that the device is indeed
requiring the fix (and thus the class
MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU) and if not, keep the default class?

Cheers,
Benjamin

