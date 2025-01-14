Return-Path: <stable+bounces-108560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE3A0FDC3
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 02:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B723A648E
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 01:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D501EF01;
	Tue, 14 Jan 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOObl2M2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EAC1C01;
	Tue, 14 Jan 2025 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816576; cv=none; b=npzzhzcKbKcctuxwy5Sjv9k41FuCkR0UQ6S0O99rlDikkkzB/e8F2dFBn288JtWcNU3L+A+BZzUSdZPqzT4ynNdrfnKdxHJEW63F8ciyMSFkVSHw0exE83hq0vcK4oBRXk+Lgz3xjsvsLXSe+wIVxJBrnnApNXDjjlprPS5fE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816576; c=relaxed/simple;
	bh=XLM02PE2Fo9T7DlIDeZYTzqRA++0Yl19cUxJTYXRN3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG2I3pzV8sOWkErN6KxQ4LGBVRoLWPBCPzwKzsb8aPrNiAwL/DUYjFUxJr659IyXKQ6W1juqgjl0bHYtopA1s6Sn3pGDsFab2hJc0JQhpviu98C184O1jtwEjccmNmj41K4ggQUGYM5/gN+TUZ4nRKwFFMHzC6DvjUUtLQ4hlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOObl2M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A46C4CED6;
	Tue, 14 Jan 2025 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736816575;
	bh=XLM02PE2Fo9T7DlIDeZYTzqRA++0Yl19cUxJTYXRN3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOObl2M29C2d3skioVHBbUZ5ajcVaWxHswQmFEJW/ZjAIGWW8FHyXzrcXU36Gka8L
	 an/1XJsV6V+TY9mMBkxEZLkqZORIaDj+Yz0CahMBrviqhk0y8YRwkNmnB1NvCMr8EI
	 c0YiHCR+Ysjg6DgpkGY7nYOtP9fe0VdSvJ9RcsyydeWaHL5s5vImEUDDJCv3yLc+0k
	 2fZUO0jjT+plgu7qC1IfpKEUDIcJnBoBnx5aaoxP4L8jwQo3FsG262HA0orVcy4W+g
	 /x9NUb4bJxlHYYAKXmyUPRuXKmLwnGUTD2njbK+Q/B/1ihTo7NhYyW67YCWOV9EV13
	 VWlkYTK62lpZw==
Date: Mon, 13 Jan 2025 20:02:53 -0500
From: Sasha Levin <sashal@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "mm: zswap: fix race between [de]compression and CPU
 hotunplug" has been added to the 6.12-stable tree
Message-ID: <Z4W3vTZgz7pXHyI1@lappy>
References: <20250113140408.1739713-1-sashal@kernel.org>
 <CAJD7tkYY=aUDzDDpPHW6qiPxJxAD7mM-Lrs9GZGyamSEJX8CyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYY=aUDzDDpPHW6qiPxJxAD7mM-Lrs9GZGyamSEJX8CyA@mail.gmail.com>

On Mon, Jan 13, 2025 at 07:59:47AM -0800, Yosry Ahmed wrote:
>On Mon, Jan 13, 2025 at 6:04 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     mm: zswap: fix race between [de]compression and CPU hotunplug
>>
>> to the 6.12-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      mm-zswap-fix-race-between-de-compression-and-cpu-hot.patch
>> and it can be found in the queue-6.12 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Please drop this patch from v6.12 (and all stable trees) as it has a
>bug, as I pointed out in [1] (was that the correct place to surface
>this?).
>
>Andrew's latest PR contains a revert of this patch (and alternative fix) [2].
>
>Thanks!

Will do, thanks!

-- 
Thanks,
Sasha

