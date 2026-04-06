Return-Path: <stable+bounces-233452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN2zMBct1GnLrwcAu9opvQ
	(envelope-from <stable+bounces-233452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:00:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FBF3A7B78
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB623302CD1A
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22535F163;
	Mon,  6 Apr 2026 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="c6X2nHVb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD3285CA2
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775512848; cv=pass; b=kqkZ9mDe+0rZMyFJ1+KaadgLgEGeEviPB8aO3xf3rj97G2E9bb1fYdkSVaAzTskojP6ejTpkmhJx1MSbTbL+4sIX6nGpGbJt/3vU397rE0dGb8K2Fc40cT1Im9MYDYCvpsnqUSlzCtkJN2SQOMY0iRtgFQMhjaaEkG+a0Jhyt7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775512848; c=relaxed/simple;
	bh=AhRF60yZ5wlYEHmbfH7z43ugDhTw4ErR0cp+/TsXLy4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e8n1J+P+IcauuGplHT2q3th9IjOrARrzvPXtl8vM7LwVHT7RigiA3lpXzcaGqg3J8D4QH81raC7HmfPt1iI4GK2IDCjPhe0MzXG77E5LQhWNZ56kQj9Ofr9nNaVu/Oi+FbTBqUEVDo19giXFJ/Jvrp9m+HcdQd9dnVasspLba5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=c6X2nHVb; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79db5e18ac6so48882247b3.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 15:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775512846; cv=none;
        d=google.com; s=arc-20240605;
        b=Vxud4dPRfrmpRlcEOOJcWKfraMWu1kAIBCuYcfK2cWElfGH5K0MYsX/EQc/UjVd3p8
         6/rO/Y8et+AJc72Xtp8iyc4mHtjnvqp0bghQhr/98t+Hd9DrR+LBf5n7UuaU0NT+NMCF
         f2B76fUG/k1jjHQ5SVM0QwHx0uz0yiLBnjmA7QjFKholfP/r8UjzzIUj3yTpJKp180+u
         kyegPD2QEik8Av/Rbg5ylMmDBJtTVJOVAOhKz3lb40wHs98SSnhfGWvufVRhsUKPNZrH
         /PcnaWDQsOZJMAz1SEd6uvqmXycwxIVGknms+xGv/dtq7Pa+zk9g4i17RazR+/zTkzm3
         wmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IrXmhlnDFDN3/y/XfnM5ZPPgKttgJY7jZg+IfQOG2j0=;
        fh=LvaCOmeD1hdk8T+DKDKW58FsOHjZxYGP9768Xtj2nsE=;
        b=Osl+0760SEIXeVwRJe/qzMCzKZc+u82O9reqiAsshoWXQMHEAjQQM+TAFtC7YAda7O
         9cmRZutm1Q7/s50sK0WpARJrFM63N/Pa8tIwunxB6PjOfd/lN89gcs/r24PlAoCJMiLg
         M/WjJuBN8RTZRDRGA1hw8Yub97JYrswaNv7QEusInW6S7GRXNXw6kDmh3NhinJXH65kg
         BvQizPSTMtDHt+ok0VoW9ZTKi+nyhWiomT4inHFFXwlzdeZx1TdekvklqD5/ikwhihzl
         6N53StpggH66pwMIsvyQE55GBqlTmXnkWRMhx/gcI+KMpEtER6bL2SZBcFJGaoIeohzI
         HFkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775512846; x=1776117646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrXmhlnDFDN3/y/XfnM5ZPPgKttgJY7jZg+IfQOG2j0=;
        b=c6X2nHVb/R0ZocumPqumAGdVuSECg1Qc374+PH5Z0sjnPDQZKwNuHTTdWFNZOuwhwI
         YK4O3Wi9lShXzDqRcGPdNLi9XogXoWIEDJUJV9J5QwnBPRFXRjjDKxUOm4kZpSDE+2V1
         l7zvpuHnRLuwuwbprEiuI6tbZmEx+uCyTp2x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775512846; x=1776117646;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrXmhlnDFDN3/y/XfnM5ZPPgKttgJY7jZg+IfQOG2j0=;
        b=pOZtJOFiJW25jN6S5qkQnFCxPLqX8FcaLD8STUXzavYzp2O7oLx8huIH+WJUSUc38P
         f2BoAB2QH/mIwi6IrJ3iCGNdZpLK/gNpw/SfpMiiKbLFml3ICchUrrK9NELpLqkTnx/H
         2xBcChNLz7ZN46pQeWSvdVjidyS8beQwZtxg7QyZgTDaC5xL8ktG/6+R3On2kx0Tycb9
         fwiw7MPCNhNRsNhaNcAiWqeNdNsrjQ6z7fF6kHzwQrh4KEYGWFnZsJgkLf62VNX7wm1d
         hdwGHhLgfLMYPnIN80t0l3Sys8Nj4mxSabwTJBCl8tNkZJU9gbpxBBA2XH+392Y59XJn
         ZEig==
X-Forwarded-Encrypted: i=1; AJvYcCWr4iANEDaklYarKJybycFiwIzGe5dqLg2akJmM7sObAvgx2oBSInw++jguYJpEmZnxNjW2CFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyscCrGdJ8vYiyTPtkTgtDJGEjkTT7VK8M0UhZ8J8wUPPNcf30B
	24o0gmJYkKBlYfkaeYcfZI8sZN/78+XuN9pu3fl7D2i+Ok6yRS0/4MfxLt6MW2XJg+NKML7vdL9
	vwhZfK3t9t7WHRKClAhR+LV5cmzohAMxeBMN6G5mcCQ==
X-Gm-Gg: AeBDiet1J6iz4kOlTsOP9PmfwL/AKrgm4if4SEQNR3FHzGMBALwmsvucvKbU+tfqnkU
	wFMUIFaqvw4VcFdUZIZ0pBl6Q5z2K5ShpTxOFmlrmD3q/oX4FYiz5/SunD6+wUP44eSMgLXIhP2
	edHPm8zSKTpQbca/8vpmtDi96M4JbIYnwu8wy+7VTl7xkhZ/fO+cb2xszaKwwkuGlBUyZMXK/Zb
	9IlbooMoAGYGMtAleLoRtb1nnl1uBHUkDIYKlRdFogjb+CFwV7M14/jOgdbTBeQ6BHj+aKrCf3V
	arlQHmzsg+AnAQMSroAJUwFuOzlxxXnGPnbBn32kciAkqwvMT5DV36GTFCLvEqhV34eyuh73yDN
	8QK5RS3IeUYwoeo4wf1AM0nUTnGt1vpQJnbQoQKR+zYTCrdv90VLRr+SeFxlJCnOhHTMOIpqfCg
	==
X-Received: by 2002:a05:690c:9c0a:b0:79a:b409:b5e0 with SMTP id
 00721157ae682-7a3b8501632mr145564957b3.0.1775512846515; Mon, 06 Apr 2026
 15:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 15:00:36 -0700
X-Gm-Features: AQROBzDj1uhH1bQgWEj0c8LOPX5fqDnQKRUjEk5oKgfET8whs1RVLalE8TLXmm4
Message-ID: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>
Subject: [PATCH] Fixes a race in iopt_unmap_iova_range
To: jgg@ziepe.ca
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, Sina Hassani <sina@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-233452-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[openai.com:+]
X-Rspamd-Queue-Id: 42FBF3A7B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
body when getting to the more expensive unmap operations. This is fine on
its own except the loop condition is based on the first area that matches
the unmap address range. If a concurrent call to map picks an area that was
unmapped in the previous iterations, this loop will try to mistakenly unmap
them.

How to reproduce: I was able to reproduce this by having one userspace
thread mapping buffers and passing them to another thread that maps
them. The problem easily shows up as ebusy errors if you use single page
mappings.

The fix: A simple fix that I implemented here is to advance the start
pointer after we unmap an area. That way we are only looking at the
IOVA range that is mapped and hence guaranteed to not have any overlaps
in each iteration.

Test: I tested this against the repro mentioned above and it works fine.

Cc: stable@vger.kernel.org
Signed-off-by: Sina Hassani <sina@openai.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..965fa23df103 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -812,6 +812,7 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                iopt_put_pages(pages);

                unmapped_bytes += area_last - area_first + 1;
+               start = area_last + 1;

                down_write(&iopt->iova_rwsem);
        }
--
2.43.0

