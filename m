Return-Path: <stable+bounces-164468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B004B0F6B2
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E934AE0033
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FB2FA65E;
	Wed, 23 Jul 2025 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3wgCDBC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392602E92DD
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283181; cv=none; b=NHhKWEmpLt5RE4CV+cgo9pjUKlXfPYX6dNcoM/rJVZDIPOTgGddUAow8wOz4YI9lZYTYt1AEzuK5Rr5u1xd+gGj4RYQLeyrqVb+EQzZbczh+nCp9r4sWvTNrYw+DjK1uN8zyQILUCtJ4XHZYMZ3D+JBBSWqx6nCvorl2AVvPmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283181; c=relaxed/simple;
	bh=IrutvD/t3WsxBciy7jIL8z/hkUj+sQZtgmYA/RdlU5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvk451fnMH6IgRlclLyvx+DsOJu8iJMcXhyH6ZbUl6S2YjDE2dPm8+TZXfAhEei73o5fq1evvSi8iGWRmI0zJTsbT6ruhaSZd7iOcuSy44o2EgNqmg3Ewuv5rX7H25UQO99KoWsKeb4JqPHxehHYIXbwfcR4rm7IhqVp7u/dd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3wgCDBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA857C4CEE7;
	Wed, 23 Jul 2025 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283181;
	bh=IrutvD/t3WsxBciy7jIL8z/hkUj+sQZtgmYA/RdlU5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3wgCDBCx+QH20fGniZY7yKhzh+WsLJ2i7N+ulT/QlwjTrKMWjh/qSaO7jgPJwfFL
	 3bRtckHSH0EhRWqPPHpcgvzM6PzxWPyYYqZ4YE4jRN2q+lB1t5hMQ/7i4w98GHoNmq
	 T+WIs30ulwrHAgH3XMw4mArQ/9bCUWN6Qh5BXv96YijsLvFTNhc/rxe5H/Bfo1TqHx
	 zuD8wIRzfrY7OHbU5cMXZe+RYWidqRAlDxiLDQLStrjoNiJ3R5bKpcQEAIDiNj6Oji
	 BYaWC4asTpEsvhui6qxTHzSzwY0e6fReCu5moVnhI9j+LPNbP/7rjPHdu6NZp/4jIR
	 2Iu7Gjfv1CkPQ==
Date: Wed, 23 Jul 2025 11:06:17 -0400
From: Sasha Levin <sashal@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 5.15.y] powercap: intel_rapl: Do not change CLAMPING bit
 if ENABLE bit cannot be changed
Message-ID: <aID6aeUGpWGUADIz@lappy>
References: <2025070818-buddhism-wikipedia-516a@gregkh>
 <20250721001504.767161-1-sashal@kernel.org>
 <bbb2c75c-2e14-47c2-987b-aefabf298d6b@oracle.com>
 <2b62ff30e0c3a256ec18d074623967e3b317e1e3.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2b62ff30e0c3a256ec18d074623967e3b317e1e3.camel@linux.intel.com>

On Wed, Jul 23, 2025 at 06:48:08AM -0700, srinivas pandruvada wrote:
>On Wed, 2025-07-23 at 12:11 +0530, Harshit Mogalapalli wrote:
>> > +	/* Check if the ENABLE bit was actually changed */
>> > +	ret = rapl_read_data_raw(rd, PL1_ENABLE, true, &val);
>> > +	if (ret) {
>> > +		cpus_read_unlock();
>> > +		return ret;
>> > +	}
>>
>> Shouldn't this be rapl_read_data_raw(rd, PL1_ENABLE, false, &val); ?
>>
>>
>Correct. This will result in additional call to rapl_unit_xlate(), but
>since for primitive PL1_ENABLE, the unit is ARBITRARY_UNIT, this will
>not translate and return the same value.

I was thinking we need to call rapl_unit_xlate() so we won't just get
whatever the raw value is, but yes - since it's ARBITRARY_UNIT then it
won't really do much.

I guess in this case it doesn't really matter if we pass true or false
here?

-- 
Thanks,
Sasha

