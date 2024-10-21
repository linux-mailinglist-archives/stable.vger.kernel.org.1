Return-Path: <stable+bounces-87605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7F9A70AA
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A253A284912
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793011EB9EE;
	Mon, 21 Oct 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3TOF//x"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C75FEE4
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530611; cv=none; b=Zx8PB66D6ORdy4Yn4tKas7RjTFDT/W2psQhrRzBxbQPNf9HkYo+J/N3+jYRC/G3muLE0W1O3ZiUfxauGXDZzIYMJCvfWAOphyYk90js/0geC9bn7WJNLT+yV+4KYWwbZfdeC/53lFdJQKqCD3BXRJ+0J9p8gHqcXT1j1yPsa5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530611; c=relaxed/simple;
	bh=0Ky3ry4ktAXzMeSeT0I7OGPp/mgeOZjYi1TiOp84HlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+CncHapqq0uhq2E+HDqDpiGinEQuX0fOWSgvuC7zqReHNdgM0/cEJbiuO5+NAFIH5VvNXiceMthV56+wPl/BDb+68HwHjdznHutKmdtiTgeLwdQ3CFWiW8gBbpXsYCKOXGdPZa8P+rapMpfYEcL/BtNeZZfUwQu5Jy+uIhguD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3TOF//x; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so56668607b3.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729530608; x=1730135408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyrIf92icdv4C2H2apolpF3+XQ094SRto0t5Nmu1wWk=;
        b=J3TOF//xzEcPYtJwo/PjbP4MsR5F5YUV8kzY8+hYrJm7hIA5l40orxO2sgi2gsNL2r
         LpPyiVWsAm8hSVMVLOf4JwrIPV1+nUgXDzIt5KEfrRZpibNY69U7Xiwv6PYFfycEFNkk
         77iRA1PrWJIABNUgMNBj1BX3agJ0zp08gz3u55wOyDlzOj5UIf7R59tR6umSKNXu/fW6
         8KrNbU4O+K3b4Ov5f01UJrSj1j7yh3N4y/grkI0z8+1PKcE4dFymxsnJeDskMpcLFZTD
         pKsAFvCffMePXpU1UKKoDbLsZoWuAsbntyP061QBczDoXrEc3i1ZFDyv/AKTFfM1/3TW
         PU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530608; x=1730135408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyrIf92icdv4C2H2apolpF3+XQ094SRto0t5Nmu1wWk=;
        b=aHrSTwY9i0dvx5sppTJ2Qj/OvIY/6cC8JZlP4ZRWeiE3BODtxddxH0WpFQiIJThtsu
         M+GYTCNfc8f/HwCnFDlKLcLW2USQab5BJnqMU3aTYD3ZOEyVgxrnOQwq8GwD/R3Oemjt
         G13S2uLkfq/BQypPPg6crqVZ5HH/zj2+nsy8FTnaZGWkXGUNxwZTv6ob+0DKYXrTX4cM
         dBmeHjSNNX0m6AHFuOyWMlDEZK01Nk2On+TU8tjvOJSgXDAszZfyM4whHU4BSIYzVl1F
         d8JRpYhxBwSDmY++Bi8Tc4SwiT77ixkc5n0ddbo2qEqPz+jqwkl29NP1AQYTFJlGFBRE
         It3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXml+FJZThO2T2ZENV+2+kEZl29TIvRGp4xSWlcgOIjPSIYfe7JkxlgX0dAEUluF5bCXOCe3g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwLanSPydtxePq0OggW1Bj2ETcxHcitWZnvetm/4LokN1bjxX
	av2hSmHT6tLOX3ki0lSu6Pp/+i4Y5MMVTeRjnCLux/MrbGiLg71BXhLGIMmCE+VtwW6zcEROy34
	pfA==
X-Google-Smtp-Source: AGHT+IH4ff05WX++Qh7Giyaz3E0EwBe0lKlsLONpmg8aOIOXjzTlun11Cl2tFDQ8IAnXNo6FMDRe62BnuSo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cfa8:1167:32cd:5d81])
 (user=surenb job=sendgmr) by 2002:a05:690c:368d:b0:6d9:d865:46c7 with SMTP id
 00721157ae682-6e7d4812d70mr30257b3.2.1729530608363; Mon, 21 Oct 2024 10:10:08
 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:10:03 -0700
In-Reply-To: <20241021171003.2907935-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021171003.2907935-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021171003.2907935-2-surenb@google.com>
Subject: [PATCH 6.11.y 2/2] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
From: Suren Baghdasaryan <surenb@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, surenb@google.com, 
	stable@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Florian Westphal <fw@strlen.de>

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
---
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
2.47.0.105.g07ac214952-goog


