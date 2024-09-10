Return-Path: <stable+bounces-75657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A990A9739D0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9AC283AEF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB6C19413D;
	Tue, 10 Sep 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBjNSmTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5818785A;
	Tue, 10 Sep 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978407; cv=none; b=B9QlbYbhknfzTFeDY9XelVwFSBC6zPc6lmlicox9Otvibg5D5/UkIpRr7EBpC+fyAjwRW33eu9Q2MBwFK59KU13J+HCMfp0jnjjSsMaqxlqvUPYotyqb3Fk9Bk3x2lWq4A3y7mPMAx9nZgysyRRU7bNnIp+fBHdO0C0Pd0iZx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978407; c=relaxed/simple;
	bh=4f1LNzAFL4ChXZ3LiermEw80kYtbSzTVWQ5QbSwrnm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/DS5G0HT+q7WZPmTN7LQLCZWLK8tnY3XNKBQrMvEOTXPSDzhXBwcKgqH6TN9InWPUQ0D/PA1PQBmz8GrOt+CJX7nTT7Iv59FQGk3tjxPhth128lE7vh2xvlkDxBLfA3Cg4INUyaAu8efGxm3telx+e3Egh4478e5c4t+4B9dvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBjNSmTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56D5C4CEC3;
	Tue, 10 Sep 2024 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725978407;
	bh=4f1LNzAFL4ChXZ3LiermEw80kYtbSzTVWQ5QbSwrnm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBjNSmTrJkOD5yjFrTNxPEnqUFs3P6r+xYIAiP0vVI7YtO95p9EamAwkCL2nd0NyY
	 2z370oM32koOhNaX87JO+d37YvpPcL8U8bQh0O4mqBBnODdaXyVV9ztvTWWoW26g97
	 Scynaac96jqKGZx5vGcHy05MTNhmjyqo/jS9eITc=
Date: Tue, 10 Sep 2024 10:26:45 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
	James Harmison <jharmison@redhat.com>, platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86: panasonic-laptop: Fix SINF array
 out of bounds accesses
Message-ID: <20240910-ludicrous-nimble-labradoodle-1ee9ae@lemur>
References: <20240909113227.254470-1-hdegoede@redhat.com>
 <172590448046.2114.11735502570640542626.b4-ty@linux.intel.com>
 <68b1cc24-1ef0-c247-f2c0-546e7ee96ed9@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68b1cc24-1ef0-c247-f2c0-546e7ee96ed9@linux.intel.com>

On Mon, Sep 09, 2024 at 09:40:36PM GMT, Ilpo Järvinen wrote:
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo branch only once I've pushed my
> > local branch there, which might take a while.
> > 
> > The list of commits applied:
> > [1/3] platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
> >       commit: f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4
> > [2/3] platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array
> >       commit: 33297cef3101d950cec0033a0dce0a2d2bd59999
> > [3/3] platform/x86: panasonic-laptop: Add support for programmable buttons
> >       (no commit info)
> 
> Hmpf, b4 messed this one up. Only patches 1-2 were applied and 3 should 
> go through for-next.

Hi:

This is a common gotcha and I'm hoping to make it less of a problem in the
future. The reason this happened is because you told b4 to retrieve the entire
patch series, but applied only a subset. We couldn't find a match for patch
3/3, but this often happens because maintainers make small tweaks to patch
contents, which skews b4 towards false-negatives instead of false-positives.

For the moment, the preferred way to avoid this problem is to tell b4 to
retrieve a subset of patches using `b4 am --cherry-pick 1-2` -- this way we
know that it was intended to be a subset and won't mention patch 3.

Hope this helps!

-K

