Return-Path: <stable+bounces-267817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJccE6a8OWopwwcAu9opvQ
	(envelope-from <stable+bounces-267817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:52:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A2D6B2B5D
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:52:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZIOxnaKa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267817-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267817-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E7BE302ED7A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7437BE7E;
	Mon, 22 Jun 2026 22:52:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9436F90B
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 22:52:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782168738; cv=none; b=Fi0vcbYOMeIhKmLlXqoM3Cqd1cQp0kBLGskECmJd0Eung/3mnSuGroccelS58m/Wl6yAkrUvl4Y/U5v38i/X5tmyIHx9sp5fqYB4k73RYDhya+9cv1oi+d2p7viFxPvUCgO3Ro8yo3od8UucIArWZTYJlddz+ZH9AkewHtOT2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782168738; c=relaxed/simple;
	bh=TvAcEuk2XHt4r/QEK/A4Pajv2/5S3b1Eeu7n6KSlsWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntQxI7JSmtun9CnIQU6ejrMpIoFWkTzQWOWbE8nGjNtrZQsp0Ej/ppkwr8UpbN+MxB98rS3KLr/h3kOKZnX5S76iy0yLHD3s1HPz2adqaUEyfH0c1fccSnQ18lTLk1DtEyJ7sXwoyvYHPSDdUH4BvnHhNjGmxTUzBMZlGdh/ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIOxnaKa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F4F1F00A3A
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 22:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782168737;
	bh=sOaJBY2vYbjxJ/JpG7DCE2JRLzNVwpwwc0x2I1M0tkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZIOxnaKab5p1n/3vTLL9gXUkmX2oYBpiSSI4S1Uk7/8zrSjEy4ofyrWXKIk/7YAyq
	 EIWbcTgfeqfpaQWtp89e++0rRLLoJ0jGyKhsnjB+nA6RbCXJ2urbaNlaVOEpEksnW0
	 +NI4Tmh/r5FFEazkOrnPF0cVnldvTgPEBCCRpUex6WgBu2wzruGpvm/KQOV+dnCnNS
	 2je8b9x8rWa46d6mP7P07hk5/7kSuu2lJbxdTTY6b17r6cfiux0vCxtYj3MsoFF12U
	 oeTNV7yKN5OY2kcDbfFvqAeGWTC3dPTMtHQym47+ezpqjj0ahN4oJt7s2Gsu0SJIV3
	 6bUTMmOdJX9xA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9158fbaa4bbso562172385a.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:52:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ88hknNoOy+edclt7z47/Y+Mj+yXjl+B9q+tRndBVvXCg/2RLPSwNvL4ibh1dLEvvu7IRu3K3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+L9XP38xjmcJIqOB0TyFYmQLXu08p0QjJ5zouWl6V6f3RnjW
	hwWZbvj1bQOBz9h1pdfP6YchZqnrNPRNkuva+dUFK20wsDs5kR3debrBQgiUK1zu469wPQjxgd2
	R+LIivTF9J69e8q2Bm9RAICd857Ig0xI=
X-Received: by 2002:a05:620a:a2c5:10b0:920:be30:2d38 with SMTP id
 af79cd13be357-920be302dbamr1837599785a.9.1782168736458; Mon, 22 Jun 2026
 15:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
 <20260622073703.79258-1-qi.zheng@linux.dev>
In-Reply-To: <20260622073703.79258-1-qi.zheng@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 23 Jun 2026 06:52:04 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z34ZRu_RKkaZ7EgTWMOxptUjZ90WJyNoJrXGNjzutxnA@mail.gmail.com>
X-Gm-Features: AVVi8Ce0foZMj_P664AgKaMfmRLO4b5-1jEQyynf-QVbFLWZ4URCnbuGkwqxqQo
Message-ID: <CAGsJ_4z34ZRu_RKkaZ7EgTWMOxptUjZ90WJyNoJrXGNjzutxnA@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: fix stale batch updates after memcg reparenting
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org, 
	muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, 
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267817-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:harry@kernel.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[baohua@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73A2D6B2B5D

On Mon, Jun 22, 2026 at 3:38=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec lock.
> The reset_batch_size() later folds those deltas into walk->lruvec under
> the lruvec lock.
>
> The page table walker can run concurrently with the memcg reparenting pat=
h
> as follows:
>
> CPU0                           CPU1
> =3D=3D=3D=3D                           =3D=3D=3D=3D
>
> walk_mm
> --> walk_page_range
>     --> update_batch_size
>         --> walk->nr_pages +=3D delta
>
>                               mem_cgroup_css_offline
>                               --> memcg_reparent_objcgs
>                                   --> lock lruvec
>                                       lru_gen_reparent_memcg
>                                       --> reparent child folios to parent
>                                       unlock lruvec
>
>     lock lruvec
>     reset_batch_size
>     --> child lrugen->nr_pages +=3D delta
>
> This can trigger the following warning:
>
> WARNING: mm/vmscan.c:5867 at lru_gen_exit_memcg+0x26f/0x300
> RIP: 0010:lru_gen_exit_memcg+0x26f/0x300 mm/vmscan.c:5867

I can't find 5867; instead, I can find 5828:

VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
  sizeof(lruvec->lrugen.nr_pages)));

Is this the warning?

> Call Trace:
>   <TASK>
>   mem_cgroup_free mm/memcontrol.c:3972 [inline]
>   mem_cgroup_css_free+0x76/0xb0 mm/memcontrol.c:4241
>   css_free_rwork_fn+0x125/0x1260 kernel/cgroup/cgroup.c:5575
>   process_one_work+0xa0d/0x1c30 kernel/workqueue.c:3314
>   process_scheduled_works kernel/workqueue.c:3397 [inline]
>   worker_thread+0x645/0xe80 kernel/workqueue.c:3478
>   kthread+0x367/0x480 kernel/kthread.c:436
>   ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
>
> To fix it, add lrugen->reparented to remember the new owner of a
> reparented lruvec, and make reset_batch_size() charge pending deltas to
> that owner.
>
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a=
53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Looks reasonable to me.
Reviewed-by: Barry Song <baohua@kernel.org>

