Return-Path: <stable+bounces-113993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D583FA29C25
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4831884E26
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888F215075;
	Wed,  5 Feb 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddpq3QPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041C1FFC4B;
	Wed,  5 Feb 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792404; cv=none; b=S4alCHiUJT9mL9pi2CfPPhSAOTS5MPloMQEHNODxeyonkdNrm37ohgcIK5ABgt+JRfjRIcVIxpMzG9zzhAbqz4qO3MRtjQ/nM4F4LzfxN/XAa4DYbYiBdsoTasGBOSd9ixt9JdRiPbXFKYMN5tvC6wqRrgBs9Ds+ANomW58QKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792404; c=relaxed/simple;
	bh=x9d9cNYBFtlNcU52LjDGoQ5l6Zp8mlPVT0eIwPFJNkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqnAXAlfKmpoRtQEU2NP33xdwtMZQnd4XeKSqKkH19NUO0tyAxst1K+LHz2/Gs/nBakGLHYgDFzthaRrc2GnHnEnd09MWEzy943TnFtWzDjG2C7zc0otc4o/i+oBLlUG6vTUupIrqn90+Io4Os8DZvinZ3H2ZD/hafIsBRDB7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddpq3QPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D637C4CED1;
	Wed,  5 Feb 2025 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738792403;
	bh=x9d9cNYBFtlNcU52LjDGoQ5l6Zp8mlPVT0eIwPFJNkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ddpq3QPoxqKqJXu4nbOoGVAshaVJZnbKEirnXkeMKhNKHOhpp9xowG3WQ3X3yey/R
	 55llMKdNRN6CX1Fl2+1wXM+P93kTa1ekSaskdQ7/KJTDPIjxQzg/0GNloe0K00SMK2
	 wiaAnv2+nRHSSrguab5790uJ5TQ7ggsKIH0UcFk5egkbQIN0FtANdXTc0jqyGVIUQ3
	 9z/g42e7anHkT/nB6bjILT/tUH/CticoDTSO9SPfaW5qfdZAqOph4RJmlcpmng+0ax
	 KORxvwKv6SMCPBYV8rSA1N+JW65mbAnJQwOJGRCt+9o6OOSyVIdLBcB2rO9RuKrS/r
	 JO1BaxUGXUoBw==
Date: Wed, 5 Feb 2025 16:53:22 -0500
From: Sasha Levin <sashal@kernel.org>
To: Namhyung Kim <namhyung@gmail.com>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paran Lee <p4ranlee@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Steinar H . Gunderson" <sesse@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Yang Li <yang.lee@linux.alibaba.com>, Ze Gao <zegao2021@gmail.com>,
	Zixian Cai <fzczx123@gmail.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Subject: Re: [PATCH AUTOSEL 6.13 06/16] tool api fs: Correctly encode errno
 for read/write open failures
Message-ID: <Z6Pd0oU4sa0OBxp3@lappy>
References: <20250126150720.961959-1-sashal@kernel.org>
 <20250126150720.961959-6-sashal@kernel.org>
 <CAP-5=fVMYQPe5qajj34P75oT17Wi_dymJy_DvhoLd7nR4yyX9w@mail.gmail.com>
 <CAM9d7chcUeg0C+MHGrqPuMMy7b8c-8RoUiXseoBnW+GY89O8jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chcUeg0C+MHGrqPuMMy7b8c-8RoUiXseoBnW+GY89O8jQ@mail.gmail.com>

On Sun, Jan 26, 2025 at 12:41:31PM -0800, Namhyung Kim wrote:
>Hello,
>
>On Sun, Jan 26, 2025 at 10:27 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Sun, Jan 26, 2025 at 7:07 AM Sasha Levin <sashal@kernel.org> wrote:
>> >
>> > From: Ian Rogers <irogers@google.com>
>> >
>> > [ Upstream commit 05be17eed774aaf56f6b1e12714325ca3a266c04 ]
>> >
>> > Switch from returning -1 to -errno so that callers can determine types
>> > of failure.
>>
>> Hi Sasha,
>>
>> This change requires changes in the perf tool. The issue is the -1
>> gets written to perf.data files in the topology, the -errno value is
>> "corrupt." Because of this, I'd suggest not backporting this change.
>
>Agreed.  Please remove this patch from the all stable series.

I'll drop it, thanks!

-- 
Thanks,
Sasha

