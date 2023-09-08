Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B43797FD5
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 02:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjIHArY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 20:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjIHArX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 20:47:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F141BCD
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 17:47:19 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34f3264a283so6776135ab.1
        for <stable@vger.kernel.org>; Thu, 07 Sep 2023 17:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694134038; x=1694738838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6+Cb3bRZZ47LN9y3HtMWq4ggj2G/LWgJo6DkgIzUlc=;
        b=PUQ19EHM7jYs4sDUiuy+ltS4H/eKCTkfDHvlc0Wrh0nxnRtCYWjUOa4MFYgWS7asas
         4OrfPv2Bo9Pw0jRNXeFwoZQutP4gLRCCK3Czv1n5RtAbCKneoP3JcckU1CgvkKXE7c7+
         8of9mrwzz2JXg6Yr9xYd4iyiQP7BcZbVZDs0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694134038; x=1694738838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6+Cb3bRZZ47LN9y3HtMWq4ggj2G/LWgJo6DkgIzUlc=;
        b=WlYHCsMu4kM0PTb26mknK7ozPtvdmUlg4ik/wFAe2yctSuX11T4guyAVs+YP+mokWu
         a5cnI8Y4PfTyWdEhjkMDmDyh1uzmVhhIlk16Ondg+1fdr4zFEuKz5JqFQ5BwlaCUti6W
         jCqj7CuLPRQqkocchNgfoXQ338bPY1M+6VjRchPK1jWpLVWhcwsfR+FvKiLI2M9CthT0
         iDqDqQRtVt0EdN3ot246a5Bq2jUl1MyQZhxUDnsakTvBAftQhIKgvCTD2WSZUXMtia5f
         gnWMmMoASEFR9SUqUCAynYM2YGYfhNR5njR0QUKi0FZP+QvXGvmrvvcJSmz/+F+t3AjX
         L6yA==
X-Gm-Message-State: AOJu0YwPo+s8h4vOXq67KMiB7M8jHBbKq1VnSxWqV6gR7z6RwcrKucFU
        HNGDkowIKcInB2sweSJHO+jzUg==
X-Google-Smtp-Source: AGHT+IFlR/Sv04z3ajcLWxvVrekQpqo/YeMso2oRkKwCsmdeMdYUZgv6PkHDs2VEqkf0Y0xCQWfyfw==
X-Received: by 2002:a05:6e02:1ba4:b0:34f:1e9c:45d9 with SMTP id n4-20020a056e021ba400b0034f1e9c45d9mr1238857ili.12.1694134038520;
        Thu, 07 Sep 2023 17:47:18 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id z14-20020a92cd0e000000b0034a921bc93asm158378iln.1.2023.09.07.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 17:47:18 -0700 (PDT)
Date:   Fri, 8 Sep 2023 00:47:17 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        stable@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <20230908004717.GC4088026@google.com>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <49ff5505-5a4a-1ad5-8552-6e79a91ee8c9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ff5505-5a4a-1ad5-8552-6e79a91ee8c9@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 07, 2023 at 08:53:14AM +0200, Vlastimil Babka wrote:
> Hi,
> 
> On 9/4/23 20:08, Joel Fernandes (Google) wrote:
> > It is unsafe to dump vmalloc area information when trying to do so from
> > some contexts. Add a safer trylock version of the same function to do a
> > best-effort VMA finding and use it from vmalloc_dump_obj().
> 
> I was a bit confused by the subject which suggests a new function is added,
> but it seems open-coded in its only caller. I assume it's due to evolution
> of the series. Something like:
> 
> mm/vmalloc: use trylock for vmap_area_lock in vmalloc_dump_obj()
> 
> ?
> 
> I also notice it's trying hard to copy everything from "vm" to temporary
> variables before unlocking, presumably to prevent use-after-free, so should
> that be also mentioned in the changelog?

Apologies for the less-than-ideal changelog. Andrew would you mind replacing
the merged patch with the below one instead? It just contains non-functional
changes to change log and an additional code comment/print. Thanks!

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3.1] mm/vmalloc: Add a safer inlined version of find_vm_area() for
 debug

It is unsafe to dump vmalloc area information when trying to do so from
some contexts such as PREEMPT_RT or from an IRQ handler that interrupted
a vmap_area_lock-held region. Add a safer and inlined trylock version of
find_vm_area() to do a best-effort VMA finding and use it from
vmalloc_dump_obj().

While the vmap_area_lock is held, copy interesting attributes from the
vm_struct before unlocking.

[applied test robot feedback on unused function fix.]
[applied Uladzislau feedback on locking.]
[applied Vlastimil and Lorenzo feedback on changelog, comment and print
improvements]

Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
Cc: stable@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/vmalloc.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..990a0d5efba8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4274,14 +4274,40 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
-	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+	const void *caller;
+	struct vm_struct *vm;
+	struct vmap_area *va;
+	unsigned long addr;
+	unsigned int nr_pages;
+
+	/*
+	 * Use trylock as we don't want to contend since this is debug code and
+	 * we might run this code in contexts like PREEMPT_RT where spinlock
+	 * contention may result in sleeping, or from an IRQ handler which
+	 * might interrupt a vmap_area_lock-held critical section.
+	 */
+	if (!spin_trylock(&vmap_area_lock)) {
+		pr_cont(" [couldn't acquire vmap_area_lock]\n");
+		return false;
+	}
+	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
+	if (!va) {
+		spin_unlock(&vmap_area_lock);
+		return false;
+	}
 
-	vm = find_vm_area(objp);
-	if (!vm)
+	vm = va->vm;
+	if (!vm) {
+		spin_unlock(&vmap_area_lock);
 		return false;
+	}
+	addr = (unsigned long)vm->addr;
+	caller = vm->caller;
+	nr_pages = vm->nr_pages;
+	spin_unlock(&vmap_area_lock);
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
+		nr_pages, addr, caller);
 	return true;
 }
 #endif
-- 
2.42.0.283.g2d96d420d3-goog

