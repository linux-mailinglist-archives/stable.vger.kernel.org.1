Return-Path: <stable+bounces-196997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF0C89581
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61C494E4779
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911C3191DF;
	Wed, 26 Nov 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmHA4CXB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0E315D32
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153722; cv=none; b=uwlqZVeDGJWTU+df6m2lknbaVCTEH5cVh/aHYFBy+TQwpwlZWPHmSC+HWXI+WSHsdI7g2hmgibRJAaED4YXyijaIv/VRQmGKGwNZRAD5ej0aiV7/7vQT+GYJXjw5DtYlID5T6UMfoMZtnlm6mvxiEy1hr95ZnBwxb3hZIzO31OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153722; c=relaxed/simple;
	bh=ZeNbKFXorJI4bmwAWJcBD4LOWE7JA9kzueTQlFWSg6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp8TOBpWpdL7tITlFF/UA5Ig8pxEBsTav4kDIjJGt68LXaHgSZi+BDkX2O7uV5AFd2MJSsKTTHeWbOsyGgfxD1jmKOesrFFMcVzPAVkE8PPE87HX6hnPxhvSLhXj6aS6XTZhcazcMGQM7M9uDgXE5+h6CxXBrWMFC8bwEdh7TNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmHA4CXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F3AC113D0;
	Wed, 26 Nov 2025 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153721;
	bh=ZeNbKFXorJI4bmwAWJcBD4LOWE7JA9kzueTQlFWSg6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dmHA4CXBlOondQYr1s3wHnFJbTwzL5Y5dFCsnYGAfYRQw4/QdERsmrgWiyu+afWe2
	 WU9V/RU64WTZ1H+iTCHhm9s58493GI5tvupt1fatfNVKkFZuGUNW9v6jY243bR9df/
	 li9Li2Jz4DCEqxcQtEFgiMNoLMQ4WGA+f8fjPkdF+L5dGGap/gK2ql11RgeFpJL0Ry
	 4D8lniQBP1lHhac0lZF/P5ewQjsiLvOJ9I4kDVZh5lSlfN0zftGqymhQxrQWgtpwqU
	 JMJ5ALQbwkt6kM4tiMr6E4r0a4I3jZyrWv2hAR/GR9UuQRRtLbtxidcFQR9BEFgu2p
	 Oxjp7WTldZhcg==
Message-ID: <6d0948f5-e739-49f3-8e23-359ddbf3da8f@kernel.org>
Date: Wed, 26 Nov 2025 11:41:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 athul.krishna.kr@protonmail.com, stable@vger.kernel.org
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com>
 <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
 <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
 <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org>
 <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
 <CAJfpegvH=5bA3B=6Mkjs_X_RtXV+=bCnGCV7Oc_-rAy38-uZ1A@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CAJfpegvH=5bA3B=6Mkjs_X_RtXV+=bCnGCV7Oc_-rAy38-uZ1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 11:19, Miklos Szeredi wrote:
> On Tue, 25 Nov 2025 at 02:10, Joanne Koong <joannelkoong@gmail.com> wrote:
> 
>> Prior to the changes added in commit 0c58a97f919c ("fuse: remove tmp
>> folio for writebacks and internal rb tree"), fuse didn't ensure that
>> data was written back for sync. The folio was marked as not under
>> writeback anymore, even if it was still under writeback.
> 
> This is the main point.  Fuse has existed for 20 years without data
> integrity guarantees.  Reverting to that behavior is *not* a
> regression, it's simply a decades old bug.   And solving that bug is
> darn hard, which is why it's not an option at this point.

Yes, and it should be clearly spelled out in the patch descriptions that 
this is a fuse-only thing, and why it is a fuse-only thing. It's not a 
"we don't have data integrity because writeback may hang", it's a "we 
don't have data integrity because fuse never supported it, so waiting 
here is simply not required".

-- 
Cheers

David

