Return-Path: <stable+bounces-78590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D55698CB03
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 03:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61231F248A3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 01:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4031FA5;
	Wed,  2 Oct 2024 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+iMS5GP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E728F5E;
	Wed,  2 Oct 2024 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727834287; cv=none; b=Re0jsK0cQC5GZusPfDVcT/u4NcK5BvlKGVqxdE1obBO3kko7btidHJwM/Hfjj3VmFm1/Y7k/3B36jOGteRb6uz1ctVHv3Wv508pMvL7NII/0Cl6kk/ndRG5wmdf4ECuJRLfS004MSCDS+M1hU3AUd7VXtJxSxoG44544MWzOds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727834287; c=relaxed/simple;
	bh=z1XhdRijr7YKWKbdBxTScmr3m9YUmFVVhOPcvQ/R8sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr3eZuqTYIhZbTwwEfGhtatx8pm0no1zbzD9WQVsROoZLus5EEEnO7h31CP+dgTEAGsIWZyfWryCfXyGyvWFzL5srHG8orjUXGcmwaAkmZmnXbYsUJhzYzS8uiS8iT13lwoW+o1yKvcbPM6tAeIe8j83eMuifswQou/Q8NvaSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+iMS5GP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b9b35c7c3so25512275ad.3;
        Tue, 01 Oct 2024 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727834284; x=1728439084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMNrBVjF1bL7gF47dMfu/RtOoCikJdmHRhx3A5ecLfU=;
        b=S+iMS5GPb/1Rnqx6DWTrDsgtmKJpwi8Wv/3zNhPSIEjgkL3knWyjh97Z7DK2cGAh/1
         W3Zxs/RmLRPMnAO1gGA5tr12N7HW5QLNGRtDdzQMyhXDsz6I3R9h7hhxS1S9THJ2OOaX
         OEoOpfMrbsLt2lrFHf6/zFhxcuJuPt4LBlPXsnu2NotgnyLq0YIxcmnefs/5j1ydJlx9
         zcOomtGMjYQeV1C1Tk4iF4zQRTHZA8F5mrht/iHEwqwgdvTO9ZQxx7ECPgHracmE7wnl
         OgAt7WRFa2MGcTVk2W8QSKT4xjSW2K2JIHDWNUA3bwBIEvdjWLzszdLKJBDPa+OiNQ9Z
         i4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727834284; x=1728439084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMNrBVjF1bL7gF47dMfu/RtOoCikJdmHRhx3A5ecLfU=;
        b=lb+HbHT9Ha1Tl68uc9wp6jAjtft6cmwjt1G9OfRIPx+uO7UABRLaSIti+TWug+MH/6
         1+crnbYW3hFr3R32W/C+cT98khuR+K/Hzxd/nHT8mnlYD7u7SoIv7t7S1wK3VEZ+rXw+
         UI8f4tDVLXMisrNZGJW/qNItYT0KjOAToCXqT6vWtY6V8g8nzKSosI9QgM5yz+1RKemH
         AKaJlGglHoNqjDVGb3oI4oO0+gUWol+fyMDHuI+cXABFScFfrggmmwkbS0GQnXX9pWdH
         rywodZzVTCW1f5CWs8U4vndB21ZjEzrQ0buCFTNprjxRpwzToKhbHqa23HVAbcza5KdP
         ihLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+R23tMWZaIZdjxUxyaTZIpuUJ1K8EOyH5JD529bLuqCvwTkC6ikYpSZUEQZ5g4b9pZTqFrbO4@vger.kernel.org, AJvYcCWkCKz7uTG6cs6m3eaFwcPDqaLQf3duboPSc0W/gcEBlyC0rSV5fu9RRs8jSiSBqAok95Sm9uaa3KcNep0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQrJDSo1tVlvb1ZtW0Obqgrx4OMroCxjwEMO+6XPk8uuypSmp
	ph46qiVZWyBOCYu+2qYwilXELEc+WrY5Qtn+Qi1HoaqI2nyuDExz
X-Google-Smtp-Source: AGHT+IHEPTXLdFX1RXr6rSHoKJ/P6VUtNQy6DXVv+93mJMWUOlBRvZA0EwWhFAqjUm7Ei/iyqrtLvQ==
X-Received: by 2002:a17:902:d512:b0:207:16b9:808c with SMTP id d9443c01a7336-20bc59c3906mr22949365ad.1.1727834283921;
        Tue, 01 Oct 2024 18:58:03 -0700 (PDT)
Received: from localhost.localdomain ([103.135.144.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c68absm9061493a12.42.2024.10.01.18.57.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Oct 2024 18:58:03 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: ying.huang@intel.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liyangouwen1@oppo.com,
	mhocko@suse.com,
	minchan@kernel.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when swapcache_prepare fails
Date: Wed,  2 Oct 2024 09:57:54 +0800
Message-Id: <20241002015754.969-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Oct 2, 2024 at 8:43 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Tue, Oct 1, 2024 at 7:43 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Sun, Sep 29, 2024 at 3:43 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Hi, Barry,
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >
> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> >> >> > introduced an unconditional one-tick sleep when `swapcache_prepare()`
> >> >> > fails, which has led to reports of UI stuttering on latency-sensitive
> >> >> > Android devices. To address this, we can use a waitqueue to wake up
> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
> >> >> > sleeping for a full tick. While tasks may occasionally be woken by an
> >> >> > unrelated `do_swap_page()`, this method is preferable to two scenarios:
> >> >> > rapid re-entry into page faults, which can cause livelocks, and
> >> >> > multiple millisecond sleeps, which visibly degrade user experience.
> >> >>
> >> >> In general, I think that this works.  Why not extend the solution to
> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_async()
> >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avoid
> >> >
> >> > Hi Ying,
> >> > Thanks for your comments.
> >> > I feel extending the solution to __read_swap_cache_async() should be done
> >> > in a separate patch. On phones, I've never encountered any issues reported
> >> > on that path, so it might be better suited for an optimization rather than a
> >> > hotfix?
> >>
> >> Yes.  It's fine to do that in another patch as optimization.
> >
> > Ok. I'll prepare a separate patch for optimizing that path.
>
> Thanks!
>
> >>
> >> >> overhead to call wake_up() when there's no task waiting, we can use an
> >> >> atomic to count waiting tasks.
> >> >
> >> > I'm not sure it's worth adding the complexity, as wake_up() on an empty
> >> > waitqueue should have a very low cost on its own?
> >>
> >> wake_up() needs to call spin_lock_irqsave() unconditionally on a global
> >> shared lock.  On systems with many CPUs (such servers), this may cause
> >> severe lock contention.  Even the cache ping-pong may hurt performance
> >> much.
> >
> > I understand that cache synchronization was a significant issue before
> > qspinlock, but it seems to be less of a concern after its implementation.
>
> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> discussed in the following thread.
>
> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programming.kicks-ass.net/
>
> > However, using a global atomic variable would still trigger cache broadcasts,
> > correct?
>
> We can only change the atomic variable to non-zero when
> swapcache_prepare() returns non-zero, and call wake_up() when the atomic
> variable is non-zero.  Because swapcache_prepare() returns 0 most times,
> the atomic variable is 0 most times.  If we don't change the value of
> atomic variable, cache ping-pong will not be triggered.

yes. this can be implemented by adding another atomic variable.

>
> Hi, Kairui,
>
> Do you have some test cases to test parallel zram swap-in?  If so, that
> can be used to verify whether cache ping-pong is an issue and whether it
> can be fixed via a global atomic variable.
>

Yes, Kairui please run a test on your machine with lots of cores before
and after adding a global atomic variable as suggested by Ying. I am
sorry I don't have a server machine.

if it turns out you find cache ping-pong can be an issue, another
approach would be a waitqueue hash:

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..aae0e532d8b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4192,6 +4192,23 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+/*
+ * Alleviating the 'thundering herd' phenomenon using a waitqueue hash
+ * when multiple do_swap_page() operations occur simultaneously.
+ */
+#define SWAPCACHE_WAIT_TABLE_BITS 5
+#define SWAPCACHE_WAIT_TABLE_SIZE (1 << SWAPCACHE_WAIT_TABLE_BITS)
+static wait_queue_head_t swapcache_wqs[SWAPCACHE_WAIT_TABLE_SIZE];
+
+static int __init swapcache_wqs_init(void)
+{
+	for (int i = 0; i < SWAPCACHE_WAIT_TABLE_SIZE; i++)
+		init_waitqueue_head(&swapcache_wqs[i]);
+
+        return 0;
+}
+late_initcall(swapcache_wqs_init);
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4204,6 +4221,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *swapcache, *folio = NULL;
+	DECLARE_WAITQUEUE(wait, current);
+	wait_queue_head_t *swapcache_wq;
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
@@ -4297,12 +4316,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				 * undetectable as pte_same() returns true due
 				 * to entry reuse.
 				 */
+				swapcache_wq = &swapcache_wqs[hash_long(vmf->address & PMD_MASK,
+							SWAPCACHE_WAIT_TABLE_BITS)];
 				if (swapcache_prepare(entry, nr_pages)) {
 					/*
 					 * Relax a bit to prevent rapid
 					 * repeated page faults.
 					 */
+					add_wait_queue(swapcache_wq, &wait);
 					schedule_timeout_uninterruptible(1);
+					remove_wait_queue(swapcache_wq, &wait);
 					goto out_page;
 				}
 				need_clear_cache = true;
@@ -4609,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		wake_up(swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4625,8 +4650,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		wake_up(swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;
-- 
2.34.1

> --
> Best Regards,
> Huang, Ying

Thanks
Barry

