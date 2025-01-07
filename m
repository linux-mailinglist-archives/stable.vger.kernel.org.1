Return-Path: <stable+bounces-107880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B2A048DB
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084F33A1E48
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4917B50A;
	Tue,  7 Jan 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Pa81vCG2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948F18EAB
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273035; cv=none; b=TPusFpgn+ODqKqbuKbfDZJWUMisleiE+YI/PMGS+9Oa9IbIqk77Vb4s5ehuFwVsQFCE9yVyanfuO6lh9lx1SLmwkLuNJEWHkuGq+9d+oSNQcYfwYxRi6ipEWiaVd/mRKJQ+LIF3Xcei7jGGgksStGa8/QfFDF6Pa8Hu0SWsAKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273035; c=relaxed/simple;
	bh=n209vyrwfof/czNWqUi5+WoI4HjQmf7GymybCUDGKpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgeU2z4NkFGKmsNQUI0dVWEeDUo7fhl1nd+cWAcrYk5WluaMLR20v4FIXuenroCurrVZXkpfxCWbnGhb4rXaOFRWPMLWDoXvp5uPK++8tWN75aVj5juKkKHYEEaPNLNTVkMjhluBZQbPfU6uGYOsT1iSMauHk5vYVQ5MCEa+IsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Pa81vCG2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d896be3992so94252056d6.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1736273031; x=1736877831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LrVAuQ1nuUS81n75WNC20SAbQtETSilLabjNMZGXh/0=;
        b=Pa81vCG2xrAwgR2oZMpzMxcph3Io2n0ETeGf7/Rhh7PCXccQdAgsGNRU5LkCh/LI8d
         p+nCOBpVnNXCQyAoUp2+buYadcTgI2B8JCVTlc3SbH5dmg8PMyu8KDBErYMekJs3jRtB
         Hz8BrEdOJq9LW7QtdkVH9UtQvB/3Oi5NV/GOOpwMwfkh8aTCIoDHrcVLC+NJgCxZdMfh
         Xi1CXHi7ULbflR+zLS6VTbn6Ltlr5V/7p8SFE0BtQcHEguSmLiEdjT7EtlprsF2OTEVP
         WPHpYhCIAnzsmHUEOIA7j2Z+/tlx52CTJIud57nBp+NI84TRxTjm4n9nDF5DK+vXLUBO
         O0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273031; x=1736877831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrVAuQ1nuUS81n75WNC20SAbQtETSilLabjNMZGXh/0=;
        b=oMyRKYhlk8yKBm6Q8FBPgUXfPVvipeEiagkGZgS1kSicUxBThgqmwz1aoXzdQR+u6H
         9ad1txL+QcIaq5XZbpXz5B0+LUHfwoVDoyQyKmSkrhp2feUfDYlQybfNBziXIaCfKCRR
         bPD1ssL9b1YYoX3qow0MSQffmpA5zOIuNJA/f6RDSVXxRcvzQwwN/CWbJhwJij8V8Nq0
         CE33Btf8tIBOiIgJIFFYD4D+425OagTdAyhmrUalKSEp3GCebMqP1hvrP4KV4p7IKfwo
         DpvM5TnyDMGqdL+Gj2XCTThiaBq0K6Rn+faW6AXqQfB219HOOHZx3OHAn/QBeYNsUpKb
         SomA==
X-Forwarded-Encrypted: i=1; AJvYcCVJBfdRBh4g+D3KcTGr1pOm4RXabYeo9N5ME6bC1FGMZt/QrD8m5NEo1/ZILJRHmfj8aKFzIU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydUupShQHL2Iv4IP33/uewoEI0iK2AGtqNVkUSeLuVj77TTzyf
	aIn/BcJtT6N/4/8echu/ZT2w9462LR9QB+qJ71wFAywR861nZvmEt0zlM4MXwqs=
X-Gm-Gg: ASbGncvlB546nbd4hKqP5vIcz86GkZM71GQtcHuzfhhyHu9lXfE1Szapt3sLOwQDxPF
	iEOaEwIam6AzGJYOStWC4zVhuLqNkonELXTrisW4ocVcBURRqh9+VEvskIzT92n3TftTibX/+BT
	ybBUAsUUejONb6Tn0iW0WBTCHEzT2n+TWE/nRcdfrpaYkkcP2Be3mFnsB6SwjD1eboRcd13ttpg
	cKMZeJF0y3eTTaiKfZ8mlVPujhwBWhY3zl9odaW2qg9SLv2ZD7hLkI=
X-Google-Smtp-Source: AGHT+IFl6p5h/awCPmTzw3RMPwNk4yXHopfv2hrojOPvo9EJXutNSG9yLbx8hfMAHYDNC/0n4jjd6A==
X-Received: by 2002:a05:6214:48f:b0:6cb:e648:863e with SMTP id 6a1803df08f44-6dd233a6f14mr1042589666d6.43.1736273030789;
        Tue, 07 Jan 2025 10:03:50 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5adbsm182844296d6.115.2025.01.07.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:03:49 -0800 (PST)
Date: Tue, 7 Jan 2025 13:03:45 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>,
	Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU
 hotunplug
Message-ID: <20250107180345.GD37530@cmpxchg.org>
References: <20250107074724.1756696-1-yosryahmed@google.com>
 <20250107074724.1756696-2-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107074724.1756696-2-yosryahmed@google.com>

On Tue, Jan 07, 2025 at 07:47:24AM +0000, Yosry Ahmed wrote:
> In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
> current CPU at the beginning of the operation is retrieved and used
> throughout.  However, since neither preemption nor migration are disabled,
> it is possible that the operation continues on a different CPU.
> 
> If the original CPU is hotunplugged while the acomp_ctx is still in use,
> we run into a UAF bug as the resources attached to the acomp_ctx are freed
> during hotunplug in zswap_cpu_comp_dead().
> 
> The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to use
> crypto_acomp API for hardware acceleration") when the switch to the
> crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> retrieved using get_cpu_ptr() which disables preemption and makes sure the
> CPU cannot go away from under us.  Preemption cannot be disabled with the
> crypto_acomp API as a sleepable context is needed.
> 
> Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> per-acomp_ctx") increased the UAF surface area by making the per-CPU
> buffers dynamic, adding yet another resource that can be freed from under
> zswap compression/decompression by CPU hotunplug.
> 
> There are a few ways to fix this:
> (a) Add a refcount for acomp_ctx.
> (b) Disable migration while using the per-CPU acomp_ctx.
> (c) Use SRCU to wait for other CPUs using the acomp_ctx of the CPU being
> hotunplugged. Normal RCU cannot be used as a sleepable context is
> required.
> 
> Implement (c) since it's simpler than (a), and (b) involves using
> migrate_disable() which is apparently undesired (see huge comment in
> include/linux/preempt.h).
> 
> Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> ---
>  mm/zswap.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb236..add1406d693b8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -864,12 +864,22 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>  	return ret;
>  }
>  
> +DEFINE_STATIC_SRCU(acomp_srcu);
> +
>  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
>  	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
>  
>  	if (!IS_ERR_OR_NULL(acomp_ctx)) {
> +		/*
> +		 * Even though the acomp_ctx should not be currently in use on
> +		 * @cpu, it may still be used by compress/decompress operations
> +		 * that started on @cpu and migrated to a different CPU. Wait
> +		 * for such usages to complete, any news usages would be a bug.
> +		 */
> +		synchronize_srcu(&acomp_srcu);

The docs suggest you can't solve it like that :(

Documentation/RCU/Design/Requirements/Requirements.rst:

  Also unlike other RCU flavors, synchronize_srcu() may **not** be
  invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
  periods make use of timers and the possibility of timers being
  temporarily “stranded” on the outgoing CPU. This stranding of timers
  means that timers posted to the outgoing CPU will not fire until
  late in the CPU-hotplug process. The problem is that if a notifier
  is waiting on an SRCU grace period, that grace period is waiting on
  a timer, and that timer is stranded on the outgoing CPU, then the
  notifier will never be awakened, in other words, deadlock has
  occurred. This same situation of course also prohibits
  srcu_barrier() from being invoked from CPU-hotplug notifiers.


