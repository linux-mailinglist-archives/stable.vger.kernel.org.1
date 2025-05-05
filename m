Return-Path: <stable+bounces-139661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E7AA9123
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF1F7A7C36
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8BC1FF61D;
	Mon,  5 May 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwHyN0b7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14B1FF7B0
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440951; cv=none; b=fcc1U6+j1MBUjkCKuNkHL+0AhUFg6wWmpMhc6ejGcXPeaNYGuFazlY4I/Ibw+//EXt+NayTIsaxOvaCXg5pbqeexF4JbDe+BRo5kPvhgZdFTSoh21Ogzu5ZFEXStgy58TqLBSJgWH9KpL74LgoKxyiqQyfLwTBJVmHsAKyUga5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440951; c=relaxed/simple;
	bh=lVKJxfzyZlhxJPGHPbA6XTPBlMLKkyYZEHmX+IIRK0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLwMOQmqe7id5V9Rw8UYY/peuodXSVkfAKv9c+MZzjSCVDg713voCVUl9Jo60U/CNbp8I1hcbKC2UszNM0ciTwHP2RcVNtvl0Gxi3JmTAaj9u/omgI+bJYPDV1vCIG0FVonS30FBw3IC5naZWNhn0qfK2PYNyvxZe/8PehcNY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwHyN0b7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fab81d6677so2847213a12.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746440947; x=1747045747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h9NJPEPNcCHElqCsFKkOD/zhCMdaqJ93x2wt89oLANA=;
        b=dwHyN0b7UOcKOzRofwbYJf4d9FxlVhb5deu7k20CaYzD86msqUEx+csDyDQ+Zfk29X
         VGHarFOLz189ZunTSUJX/QRW486snsDWGFBZyrg3aA/5RT+SMnVxmt+Ix0x40xGzVe3I
         qTRycdjJEi+XHbwrl9igHs5LhkRPJTtc7zuetjwzO4UkAHkUniYBjJhgFFI3I39/ATS1
         hQsMxDQp/E/moK5PYpZi2MlS4un4tMGwCl18V4CZs9mrcQePtHVlypLL2B3dClUsNJr+
         r5brlVJXjdOGrP2e4/cdKsj/X0G7Lu71iiNY5FW+3KOO8RmEUf6SjeN43Ksdyf2qYXPl
         DYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746440947; x=1747045747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9NJPEPNcCHElqCsFKkOD/zhCMdaqJ93x2wt89oLANA=;
        b=DLU0p51uSJ7XgnAoMlmFRikyRXK0ySGFW/n10hfFR7BBJoCU+ZV2jmtu7UziDdxwYw
         wRGggOwZkphTIEcHvc7r5z2ByxYE4UQVRVZIqYmjxy4/ngOhIFs8Ud8zoLp3+CjXjZXc
         ivp2SpgBGEC7SnbRRhdFWiQMHJ6gsrUM5lM9hrw+UsuLOhov+KQOMhpZcHzvxkfSy285
         xQkDaquJxvfIpGy0PLJ+xIibTg2fNcekNu+ZuntzV1DaceLnYCGCsKtrO45N885AT39g
         hlCmREYGQsKpOMOcm6+qDf6yQMJ54acJ2iTPKITRVYFyzX5naWoPEn+3J22K1282CNAG
         P8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK0XlfimduUfrPnXg9Dci5Dz5ohHq8qnXBtNd1oBZsQy7PGtLWZkFzvDZf6n2kOPzkBI3gIUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTChqsis7v0/DrIQygn1hI89oXPpaehAOqOcGo3oUDihaBhZ+8
	xtJnrBXtz1Ju5OrFBe1eRYoqzGXz79EOnD2oVBmvcMakwdGup5a9ytjCcGyURzeSZOX5ljNyELq
	sZlHdp81zKBJ2Scq7vI1oB1YO39bJHBQpLHdlxw==
X-Gm-Gg: ASbGnctOF8twwQTCNjxYzlV8JNxON7F31gaEwV5my5STJlgszKZBcMR9FsS36Jl85aD
	aqNmU1u30oMw8mtYW3F0Trk0hgCe2TxnbR5E1z0hi2bTYDvJ79+BZJsUlIYqNtwdZ9lb5nD/0tA
	SI3G6hfZllyLP4oQpt0TvlMCDlXZ6TH8b2Xac/dmwGcA0HYvnwqMM=
X-Google-Smtp-Source: AGHT+IFGLdOA0wjrKNVNr+OgSY/m0KfnXY3uoRWhdic9itp5AdsIBqgTTOv/2WI6gBetK79o3lt6ttFowKiy6rytszo=
X-Received: by 2002:a05:6402:1d4e:b0:5dc:7725:a0c7 with SMTP id
 4fb4d7f45d1cf-5fab056dde8mr5734455a12.3.1746440946940; Mon, 05 May 2025
 03:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com> <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
In-Reply-To: <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 5 May 2025 12:28:55 +0200
X-Gm-Features: ATxdqUFW1mE6ZQzU1S1KsW8u-ZfkAndPfLeziZRRMlNmnLJodq2VykFlzWKjRZQ
Message-ID: <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
Subject: Re: IPC drop down on AMD epyc 7702P
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>, Peter Zijlstra <peterz@infradead.org>, 
	"mingo@kernel.org" <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Valentin Schneider <vschneid@redhat.com>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 11:13, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> (+ more scheduler folks)
>
> tl;dr
>
> JB has a workload that hates aggressive migration on the 2nd Generation
> EPYC platform that has a small LLC domain (4C/8T) and very noticeable
> C2C latency.
>
> Based on JB's observation so far, reverting commit 16b0a7a1a0af
> ("sched/fair: Ensure tasks spreading in LLC during LB") and commit
> c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
> condition") helps the workload. Both those commits allow aggressive
> migrations for work conservation except it also increased cache
> misses which slows the workload quite a bit.

commit 16b0a7a1a0af  ("sched/fair: Ensure tasks spreading in LLC
during LB") eases the spread of task inside a LLC so It's not obvious
for me how it would increase "a lot of CPU migrations go out of CCX,
then L3 miss,". On the other hand, it will spread task in SMT and in
LLC which can prevent running at highest freq on some system but I
don't know if it's relevant for this SoC.

commit c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
condition") makes newly idle migration happen more often which can
then do migrate tasks across LLC. But then It's more about why
enabling newly idle load balance out of LLC if it is so costly.

>
> "relax_domain_level" helps but cannot be set at runtime and I couldn't
> think of any stable / debug interfaces that JB hasn't tried out
> already that can help this workload.
>
> There is a patch towards the end to set "relax_domain_level" at
> runtime but given cpusets got away with this when transitioning to
> cgroup-v2, I don't know what the sentiments are around its usage.
> Any input / feedback is greatly appreciated.
>
> On 4/28/2025 1:13 PM, Jean-Baptiste Roquefere wrote:
> > Hello Prateek,
> >
> > thank's for your reponse.
> >
> >
> >> Looking at the commit logs, it looks like these commits do solve other
> >> problems around load balancing and might not be trivial to revert
> >> without evaluating the damages.
> >
> > it's definitely not a productizable workaround !
> >
> >> The processor you are running on, the AME EPYC 7702P based on the Zen2
> >> architecture contains 4 cores / 8 threads per CCX (LLC domain) which is
> >> perhaps why reducing the thread count to below this limit is helping
> >> your workload.
> >>
> >> What we suspect is that when running the workload, the threads that
> >> regularly sleep trigger a newidle balancing which causes them to move
> >> to another CCX leading to higher number of L3 misses.
> >>
> >> To confirm this, would it be possible to run the workload with the
> >> not-yet-upstream perf sched stats [1] tool and share the result from
> >> perf sched stats diff for the data from v6.12.17 and v6.12.17 + patch
> >> to rule out any other second order effect.
> >>
> >> [1]
> >> https://lore.kernel.org/all/20250311120230.61774-1-swapnil.sapkal@amd.com/
> >
> > I had to patch tools/perf/util/session.c : static int
> > open_file_read(struct perf_data *data) due to "failed to open perf.data:
> > File exists" (looked more like a compiler issue than a tool/perf issue)
> >
> > $ ./perf sched stats diff perf.data.6.12.17 perf.data.6.12.17patched >
> > perf.diff (see perf.diff attached)
>
> Thank you for all the information Jean. I'll highlight the interesting
> bits (at least the bits that stood out to me)
>
> (left is mainline, right is mainline with the two commits mentioned by
>   JB reverted)
>
> total runtime by tasks on this processor (in jiffies)            : 123927676874,108531911002  |   -12.42% |
> total waittime by tasks on this processor (in jiffies)           :  34729211241, 27076295778  |   -22.04% |  (    28.02%,     24.95% )
> total timeslices run on this cpu                                 :       501606,      489799  |    -2.35% |
>
> Since "total runtime" is lower on the right, it means that the CPUs
> were not as well utilized with the commits reverted however the
> reduction in the "total waittime" suggests things are running faster
> and on overage there are 0.28 waiting tasks on mainline compared to
> 0.24 with the commits reverted.
>
> ---------------------------------------- <Category newidle - SMT> ----------------------------------------
> load_balance() count on cpu newly idle                           :      331664,      31153  |   -90.61% |  $        0.15,        1.55 $
> load_balance() failed to find busier group on cpu newly idle     :      300234,      28470  |   -90.52% |  $        0.16,        1.70 $
> *load_balance() success count on cpu newly idle                  :       28386,       1544  |   -94.56% |
> *avg task pulled per successful lb attempt (cpu newly idle)      :        1.00,       1.01  |     0.46% |
> ---------------------------------------- <Category newidle - MC > ----------------------------------------
> load_balance() count on cpu newly idle                           :      258017,      29345  |   -88.63% |  $        0.19,        1.65 $
> load_balance() failed to find busier group on cpu newly idle     :      131096,      16081  |   -87.73% |  $        0.37,        3.01 $
> *load_balance() success count on cpu newly idle                  :       23286,       2181  |   -90.63% |
> *avg task pulled per successful lb attempt (cpu newly idle)      :        1.03,       1.01  |    -1.23% |
> ---------------------------------------- <Category newidle - PKG> ----------------------------------------
> load_balance() count on cpu newly idle                           :      124013,      27086  |   -78.16% |  $        0.39,        1.78 $
> load_balance() failed to find busier group on cpu newly idle     :       11812,       3063  |   -74.07% |  $        4.09,       15.78 $
> *load_balance() success count on cpu newly idle                  :       13892,       4739  |   -65.89% |
> *avg task pulled per successful lb attempt (cpu newly idle)      :        1.07,       1.10  |     3.32% |
> ----------------------------------------------------------------------------------------------------------
>
> Most migrations are from newidle balancing which seems to move task
> across cores ( > 50% of time) and the LLC too (~8% of the times).
>
> >
> >> Assuming you control these deployments, would it possible to run
> >> the workload on a kernel running with "relax_domain_level=2" kernel
> >> cmdline that restricts newidle balance to only within the CCX. As a
> >> side effect, it also limits  task wakeups to the same LLC domain but
> >> I would still like to know if this makes a difference to the
> >> workload you are running.
> > On vanilla 6.12.17 it gives the IPC we expected:
>
> Thank you JB for trying out this experiment. I'm not very sure what
> the views are on "relax_domain_level" and I'm hoping the other
> scheduler folks will chime in here - Is it a debug knob? Can it
> be used in production?
>
> I know it had additional uses with cpuset in cgroup-v1 but was not
> adopted in v2 - are there any nasty historic reasons for this?
>
> >
> > +--------------------+--------------------------+-----------------------+
> > |                    | relax_domain_level unset | relax_domain_level=2  |
> > +--------------------+--------------------------+-----------------------+
> > | Threads            |  210                     | 210                  |
> > | Utilization (%)    |  65,86                   | 52,01                |
> > | CPU effective freq |  1 622,93                |  1 294,12             |
> > | IPC                |  1,14                    | 1,42                 |
> > | L2 access (pti)    |  34,36                   | 38,18                |
> > | L2 miss   (pti)    |  7,34                    | 7,78                 |
> > | L3 miss   (abs)    |  39 711 971 741          |  33 929 609 924       |
> > | Mem (GB/s)         |  70,68                   | 49,10                |
> > | Context switches   |  109 281 524             |  107 896 729          |
> > +--------------------+--------------------------+-----------------------+
> >
> > Kind regards,
> >
> > JB
>
> JB asked if there is any way to toggle "relax_domain_level" at runtime
> on mainline and I couldn't find any easy way other than using cpusets
> with cgroup-v1 which is probably harder to deploy at scale than the
> pinning strategy that JB mentioned originally.
>
> I currently cannot think of any stable interface that exists currently
> to allow sticky behavior and mitigate aggressive migration for work
> conservation - JB did try almost everything available that he
> summarized in his original report.
>
> Could something like below be a stop-gap band-aid to remedy such the
> case of workloads that don't mind temporary imbalance in favor of
> cache hotness?
>
> ---
> From: K Prateek Nayak <kprateek.nayak@amd.com>
> Subject: [RFC PATCH] sched/debug: Allow overriding "relax_domain_level" at runtime
>
> Jean-Baptiste noted that Ateme's workload experiences poor IPC on a 2nd
> Generation EPYC system and narrowed down the major culprits to commit
> 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB") and
> commit c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
> condition") both of which enable more aggressive migrations in favor of
> work conservation.
>
> The larger C2C latency on the platform coupled with a smaller L3 size of
> 4C/8T makes downside of aggressive balance very prominent. Looking at
> the perf sched stats report from JB [1], when the two commits are
> reverted, despite the "total runtime" seeing a dip of 11% showing a
> better load distribution on mainline, the "total waittime" dips by 22%
> showing despite the imbalance, the workload runs faster and this
> improvement can be co-related to the higher IPC and the reduced L3
> misses in data shared by JB. Most of the migration during load
> balancing can be attributed to newidle balance.
>
> JB confirmed that using "relax_domain_level=2" in kernel cmdline helps
> this particular workload by restricting the scope of wakeups and
> migrations during newidle balancing however "relax_domain_level" works
> on topology levels before degeneration and setting the level before
> inspecting the topology might not be trivial at boot time.
>
> Furthermore, a runtime knob that can help quickly narrow down any changes
> in workload behavior to aggressive migrations during load balancing can
> be helpful during debugs.
>
> Introduce "relax_domain_level" in sched debugfs and allow overriding the
> knob at runtime.
>
>    # cat /sys/kernel/debug/sched/relax_domain_level
>    -1
>
>    # echo Y > /sys/kernel/debug/sched/verbose
>    # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
>    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
>    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING
>    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA
>
> To restrict newidle balance to only within the LLC, "relax_domain_level"
> can be set to level 3 (SMT, CLUSTER, *MC* , PKG, NUMA)
>
>    # echo 3 > /sys/kernel/debug/sched/relax_domain_level
>    # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
>    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
>    SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING
>    SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA
>
> "relax_domain_level" forgives short term imbalances. Longer term
> imbalances will be eventually caught by the periodic load balancer and
> the system will reach a state of balance, only slightly later.
>
> Link: https://lore.kernel.org/all/996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com/ [1]
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   include/linux/sched/topology.h |  6 ++--
>   kernel/sched/debug.c           | 52 ++++++++++++++++++++++++++++++++++
>   kernel/sched/topology.c        |  2 +-
>   3 files changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 198bb5cc1774..5f59bdc1d5b1 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -65,8 +65,10 @@ struct sched_domain_attr {
>         int relax_domain_level;
>   };
>
> -#define SD_ATTR_INIT   (struct sched_domain_attr) {    \
> -       .relax_domain_level = -1,                       \
> +extern int default_relax_domain_level;
> +
> +#define SD_ATTR_INIT   (struct sched_domain_attr) {            \
> +       .relax_domain_level = default_relax_domain_level,       \
>   }
>
>   extern int sched_domain_level_max;
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 557246880a7e..cc6944b35535 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -214,6 +214,57 @@ static const struct file_operations sched_scaling_fops = {
>         .release        = single_release,
>   };
>
> +DEFINE_MUTEX(relax_domain_mutex);
> +
> +static ssize_t sched_relax_domain_write(struct file *filp,
> +                                       const char __user *ubuf,
> +                                       size_t cnt, loff_t *ppos)
> +{
> +       int relax_domain_level;
> +       char buf[16];
> +
> +       if (cnt > 15)
> +               cnt = 15;
> +
> +       if (copy_from_user(&buf, ubuf, cnt))
> +               return -EFAULT;
> +       buf[cnt] = '\0';
> +
> +       if (kstrtoint(buf, 10, &relax_domain_level))
> +               return -EINVAL;
> +
> +       if (relax_domain_level < -1 || relax_domain_level > sched_domain_level_max + 1)
> +               return -EINVAL;
> +
> +       guard(mutex)(&relax_domain_mutex);
> +
> +       if (relax_domain_level != default_relax_domain_level) {
> +               default_relax_domain_level = relax_domain_level;
> +               rebuild_sched_domains();
> +       }
> +
> +       *ppos += cnt;
> +       return cnt;
> +}
> +static int sched_relax_domain_show(struct seq_file *m, void *v)
> +{
> +       seq_printf(m, "%d\n", default_relax_domain_level);
> +       return 0;
> +}
> +
> +static int sched_relax_domain_open(struct inode *inode, struct file *filp)
> +{
> +       return single_open(filp, sched_relax_domain_show, NULL);
> +}
> +
> +static const struct file_operations sched_relax_domain_fops = {
> +       .open           = sched_relax_domain_open,
> +       .write          = sched_relax_domain_write,
> +       .read           = seq_read,
> +       .llseek         = seq_lseek,
> +       .release        = single_release,
> +};
> +
>   #endif /* SMP */
>
>   #ifdef CONFIG_PREEMPT_DYNAMIC
> @@ -516,6 +567,7 @@ static __init int sched_init_debug(void)
>         debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
>         debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
>         debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
> +       debugfs_create_file("relax_domain_level", 0644, debugfs_sched, NULL, &sched_relax_domain_fops);
>
>         sched_domains_mutex_lock();
>         update_sched_domain_debugfs();
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index a2a38e1b6f18..eb5c8a9cd904 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1513,7 +1513,7 @@ static void asym_cpu_capacity_scan(void)
>    * Non-inlined to reduce accumulated stack pressure in build_sched_domains()
>    */
>
> -static int default_relax_domain_level = -1;
> +int default_relax_domain_level = -1;
>   int sched_domain_level_max;
>
>   static int __init setup_relax_domain_level(char *str)
> --
>
> Thanks and Regards,
> Prateek
>

