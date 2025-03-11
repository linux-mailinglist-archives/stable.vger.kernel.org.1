Return-Path: <stable+bounces-123854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB4A5C7B0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD443165986
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361925FA31;
	Tue, 11 Mar 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwlcDbzn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6A25FA1D
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707152; cv=none; b=AMuPVSMYopjcoZmlWQinRR/NHx+SP5mnoIsnSmT4ipOyeEER9v0OOLmWSfOz9jLXEJZjoT23hM+Ug+iMsAEy7jE8QMpxe+bD1Hwm/3Lt1oAN+GDAZoW6M4T7+ZxxVy0CDuiIO9LHMOMCX242lCgqGBPzffWiZULagQ8yELhUgd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707152; c=relaxed/simple;
	bh=cGR7yW+ul2CirNwt05XAkvBMRVJPmchILZoVSdAQWE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a3TM2YPnQLZlNSdj5l3fvDvjVkLP8cd2gjRrp2S88UYbxKAIJGegPsNJvxdEurQJpOJaul3XHN+9j7RKvgaxU90x8QsOeFGUpUvpWmYbTzcst01JlUk9p+wtulYdz0/1UkjBX75JAAor7dGLKzPNnjQTmOhG7kek1sSBu+y7AIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwlcDbzn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741707148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z/4Zhen8otZUUIGUirLVRCURFAkEQAh1g/kYBjTL128=;
	b=QwlcDbznTboMEMAtNn4w6pDPNK8/goRXL6teh99+o4W8bBtCoDCw7FWbJeJJxDiFZANbrf
	/GftojZw2oItJnK64cYnm2zcQSk8r2v/4lqVBFNGkrgu/dZ98xHWjvyigoVyej7DA81JQM
	+tWiD2bCTMlfa86hVuKcoLbXZz+RQrc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-nF9YwQwFMoOTsVEgzfjhrA-1; Tue, 11 Mar 2025 11:32:27 -0400
X-MC-Unique: nF9YwQwFMoOTsVEgzfjhrA-1
X-Mimecast-MFC-AGG-ID: nF9YwQwFMoOTsVEgzfjhrA_1741707146
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912b54611dso3432914f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 08:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707146; x=1742311946;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/4Zhen8otZUUIGUirLVRCURFAkEQAh1g/kYBjTL128=;
        b=rP1PdOaVf+KVhffAwCQ1YTSqUlDOCXyyy4Rz0QIMXqh2TdLfxZFMLrHHPv6wgzWaPh
         SsvQbU35THF/E53cTiJuCY9FIP5pd1b6pj2c1byWtEyMwWsXcIIkG34DHI9LsgWQKTvK
         mGiru5ZpolQ6y/AH5TEc9VimzqbajsyUly5HRztaQq7OpzIXbqmUwF+kI+6CPJNbJ057
         2ZgMGE/RzeccgSSuPicCW5zvYMUPz7y68TXzIwjCo5bvxXYRvjhZZ6WSZtV4zNnyFtn5
         RQgLiTC/cpBNXSbyAkdH26T/08r/EkPyUyuBcbci93UBspFtPCN2sM0BOCXzLqMLTGnw
         X0pQ==
X-Gm-Message-State: AOJu0YyBnzalGUQanxBBXTBDYgIwzD2/TM0bftE18HGgUypr09bUqmfq
	6GT8SCc80pfpSVHS2ixXJUBkDqpzp36Y7PayfekZB5QKgM1emD00FX3zk2lN4DFkJ5tF1PdRCvn
	/x5H2jkmHvWsi8AYOiAz+5xzEqOx7x26GApjJCJD7eCRK7IRi7rQqAA==
X-Gm-Gg: ASbGncsB5rS3nrBF5ccx1cJo4q+18GlX4NJ3G0DtUf3lVX/WicnLzQZVHUBaKuxS+Jm
	+Qwom8S34iYNNUh18VafV3Tj6GpE6DGmAMTq+0GCGpuB4jD/wN0swG5UFBDrUBoHi5kvnNw/qjt
	QHU8aNI0+ITPeuKgyqXQTQ3oD3du4Q7rwudviwuvMpsCJgMs6CX1dT8rvYOqLY9PUPGARlcryD9
	tTLSZGHCwTrxOjEL+L2tKDGOBfWcOBfpc9LWRo0ur+ZY/4sJdjssqZ3fp2zTDRqSDKrwNuA+8nr
	Fwa+Tqq7qODSgkTlWWJcJup0GcYCtvmxcFYvpEUMDN9+oYzUBBRD1IGRwpMiz2EQrbfyc7oDWDC
	M
X-Received: by 2002:a5d:5f8f:0:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-39132d2ac23mr14041026f8f.5.1741707146158;
        Tue, 11 Mar 2025 08:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5idbTwPC29cIZuVqWeIsBnJdPqrG40K1D1QZSJ7ax4/92Y7jODHouGk43yk3oUBObhGOXHw==
X-Received: by 2002:a5d:5f8f:0:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-39132d2ac23mr14040985f8f.5.1741707145716;
        Tue, 11 Mar 2025 08:32:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba66esm18681629f8f.18.2025.03.11.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:32:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 srivatsa@csail.mit.edu, K Prateek Nayak <kprateek.nayak@amd.com>, Michael
 Kelley <mhklinux@outlook.com>, Naman Jain <namjain@linux.microsoft.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v5] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <20250310052509.1416-1-namjain@linux.microsoft.com>
References: <20250310052509.1416-1-namjain@linux.microsoft.com>
Date: Tue, 11 Mar 2025 16:32:24 +0100
Message-ID: <xhsmh34fjr3av.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:55, Naman Jain wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>
> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> around 8 seconds cumulatively for all the iterations. It is an expensive
> operation which does the sanity of non-NUMA topology masks.
>
> CPU topology is not something which changes very frequently hence make
> this check optional for the systems where the topology is trusted and
> need faster bootup.
>
> Restrict this to sched_verbose kernel cmdline option so that this penalty
> can be avoided for the systems who want to avoid it.
>
> Cc: stable@vger.kernel.org
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changes since v4:
> https://lore.kernel.org/all/20250306055354.52915-1-namjain@linux.microsoft.com/
>       - Rephrased print statement and moved it to sched_domain_debug.
>         (addressing Valentin's comments)
> Changes since v3:
> https://lore.kernel.org/all/20250203114738.3109-1-namjain@linux.microsoft.com/
>       - Minor typo correction in comment
>       - Added Tested-by tag from Prateek for x86
> Changes since v2:
> https://lore.kernel.org/all/1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com/
>       - Use sched_debug() instead of using sched_debug_verbose
>         variable directly (addressing Prateek's comment)
>
> Changes since v1:
> https://lore.kernel.org/all/1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com/
>       - Use kernel cmdline param instead of compile time flag.
>
> Adding a link to the other patch which is under review.
> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
> Above patch tries to optimize the topology sanity check, whereas this
> patch makes it optional. We believe both patches can coexist, as even
> with optimization, there will still be some performance overhead for
> this check.
>
> ---
>  kernel/sched/topology.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..d7254c47af45 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -132,8 +132,11 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>  {
>       int level = 0;
>
> -	if (!sched_debug_verbose)
> +	if (!sched_debug_verbose) {
> +		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
> +			     __func__);
>               return;
> +	}
>

Nit: I've been told not to break warnings over multiple lines so they can
be grep'ed, but given this has the "sched_domain_debug:" prefix I think we
could get away with the below.

Regardless:
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d7254c47af455..b4dc7c7d2c41c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -133,7 +133,8 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 	int level = 0;
 
 	if (!sched_debug_verbose) {
-		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
+		pr_info_once("%s: Scheduler topology debugging disabled, "
+			     "add 'sched_verbose' to the cmdline to enable it\n",
 			     __func__);
 		return;
 	}


