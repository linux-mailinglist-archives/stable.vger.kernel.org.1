Return-Path: <stable+bounces-91695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C89BF403
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC751F22C73
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBB206509;
	Wed,  6 Nov 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkOziWLX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080F206E97
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912979; cv=none; b=rctnROkSfF42rxcVdOyA80abcX2VdzBp7sQnKqEtqRsmgnI1XypTNCbm3n/ZCygTa/FO390ueBGsTsCBAG+odyY7Oqd0NYfZXunE6hYalXmerO+m05WTbxi+iVqYW+mf2Y9OI+aqnchvsXB6rkUHVikXPfe1fiLhf/N8YtUn0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912979; c=relaxed/simple;
	bh=xA46enblRv87qqgY+6DG4GGjINcLxdFJ2E81K3yFp1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZI0Fz7oGXhh8VVtfg7/X6eG5JD8VbLwy8KvfhDdIBOGUoBSBxyxeoha+mzof7DGp3hF1EQbwydrK87Ul6Wn7Gbc+szlQQpdZIV9KdUJjrFzLhQtfBhtauAxQ05paQis7GyPe/B6Yc13FqY0EzoKIBJimHhy/2DgxfKLip48clrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkOziWLX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3c638cc27so133858547b3.0
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730912977; x=1731517777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu/tCa/EAr7v3VimsEZAuyq+f/De3I1ag0mzO42VO34=;
        b=IkOziWLXJhZMWtwv9ZdgyH7CRj59CftJNqGV3CwHIpn6/i3y8a5321UvIkpf+Paf7W
         lD8P+dD36LbktpW2M45dtl5tZAGDifR0MXsdE0crLYNIzhIdQVJMKz2mfDEj/Zw3ujQ2
         iK+xT0672vB72/hfcCIa8ftR9jj5qwO6geV1aDrZsVNAu2IBMrgVn0G9T82L8l+PeBw3
         f6xIfvYN3ziiySCKBxrLwyU850TrYMAJbkMPabNk1K7fsJ/TKvLQ2LZycbcacscRyu/T
         57m/xEz1GmTqTTh5MKRPQk67n2SCQAPLBeldqNgIgRUcfo36HkD93HwrQ9yKrthAWI5Q
         LSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912977; x=1731517777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu/tCa/EAr7v3VimsEZAuyq+f/De3I1ag0mzO42VO34=;
        b=b9G6ogD9h05m0DoV5NtYeMKPrXceuge6wRRnNbkG5lUjAxyUbuMHgagNBVCskpwYTk
         LG09CJXu7pT/HClHy7K1TRTt1sv0GQgzJsw8No3rYbs5jmZTPXH/f1omjQY+YOcnYSUO
         KdyQD/h+G4pgY94v1i0VHTqCzqO2ZVFRbBe8Cv/DjYT6P+Byb2u4khpszZmhdjQ8zL1a
         ZjJWFfTlOqtNzzM9WNFuiaoRM1/7KgZBxiQgZaUZUQcK43thcbWC9HAdLIH1JXTK35+4
         IkgCgTpN5tCT1gQiZYijdiAswElg7cHZpcd2dQFFG1rzuG6Hsa7lhtIzP8DqYGqHOCOF
         W+oA==
X-Forwarded-Encrypted: i=1; AJvYcCX1lxqyWV+xiWoikM61E99789RNMnfNDMOhqsfhIOK9VZdu1iRqIRS1prr6K7ojzzZ6YCOqAw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrNfZsNMTW3KeNn+H37lIndy9b7tGuus+Kb38TBSKskybCanB
	8KubvsS76nmGghlNOsuL0ATD7HYt+MyK/3cA5HZh7T5j/lBLtWc3H08D1/pragKKFWIFASLiHyL
	MpA==
X-Google-Smtp-Source: AGHT+IEY4RXzcMsI17paV2X954YMaF2/EsO1zNFX2pQquk3V89jRarHNwbd5OKr7TLIt7VnEo7QyiX0TO5s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:b9c:a9f1:f265:18b4])
 (user=surenb job=sendgmr) by 2002:a05:690c:3688:b0:6db:c6ac:62a0 with SMTP id
 00721157ae682-6e9d8bced01mr12256367b3.5.1730912976654; Wed, 06 Nov 2024
 09:09:36 -0800 (PST)
Date: Wed,  6 Nov 2024 09:09:27 -0800
In-Reply-To: <20241106170927.130996-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106170927.130996-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106170927.130996-2-surenb@google.com>
Subject: [PATCH v2 6.11.y 2/2] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
From: Suren Baghdasaryan <surenb@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, surenb@google.com, 
	stable@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Florian Westphal <fw@strlen.de>

commit dc783ba4b9df3fb3e76e968b2cbeb9960069263c upstream.

Ben Greear reports following splat:
 ------------[ cut here ]------------
 net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
 WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
 Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
...
 Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
 RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
  codetag_unload_module+0x19b/0x2a0
  ? codetag_load_module+0x80/0x80

nf_nat module exit calls kfree_rcu on those addresses, but the free
operation is likely still pending by the time alloc_tag checks for leaks.

Wait for outstanding kfree_rcu operations to complete before checking
resolves this warning.

Reproducer:
unshare -n iptables-nft -t nat -A PREROUTING -p tcp
grep nf_nat /proc/allocinfo # will list 4 allocations
rmmod nft_chain_nat
rmmod nf_nat                # will WARN.

Link: https://lkml.kernel.org/r/20241007205236.11847-1-fw@strlen.de
Fixes: a473573964e5 ("lib: code tagging module support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reported-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/netdev/bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com/
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]:
- Added SOB, per Greg KH

[1] https://lore.kernel.org/all/20241021171003.2907935-2-surenb@google.com/

 lib/codetag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/codetag.c b/lib/codetag.c
index afa8a2d4f317..d1fbbb7c2ec3 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -228,6 +228,9 @@ bool codetag_unload_module(struct module *mod)
 	if (!mod)
 		return true;
 
+	/* await any module's kfree_rcu() operations to complete */
+	kvfree_rcu_barrier();
+
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {
 		struct codetag_module *found = NULL;
-- 
2.47.0.199.ga7371fff76-goog


