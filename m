Return-Path: <stable+bounces-81472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D80993581
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8B5283D07
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAFE1DDA3F;
	Mon,  7 Oct 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6fk2/2O"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DB1D1E8A
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323885; cv=none; b=f5hlOd1lt8ci7wcnl6rhBvVJSzngUIgZ32aqJZ12uz37ZpcE2puPtf6w8ZMtfVlXu5r5TAITvFZNT02LJnQ1pZayT2or/Dq/7JTJjnqY1zv/QN9F62HJtfPzo1RhvcYodmAB2IM28si80i7wpq2O4nnnYPW1Eh8PdrMygPaA89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323885; c=relaxed/simple;
	bh=7qEbszZF/6uz4olBcPIoH8Z8WBEMND94l0kFwN9XzVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI5aDfSdfzVVVhjvrerbk/Pb/M6ZX/BjWoo4t25RX78MGaBqF/8vql9uWJHFci46KDniu51iWBB0OU4sC+BfOd7AaYTl+ItNiBAwB1/4yFL+2Q8lYoADwACeCt0reR7PPt37m0YYOpQYvQ4aMxovzGqVzmwjOeHokO7CsMsArlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6fk2/2O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728323882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2L2zyB/T+xM4ltldRyc60484upZDesec/e06CJOhSo=;
	b=P6fk2/2Ov1MFAdjjCKqXk3S9a8L8lssPGuev6e/xekEVAYRZwgW76jOFO84hUsOGBnhMwe
	T6ha4Tji6OoIUln+I02R96yCJ6ruythQBgbeboNo4AHeZmOTtjDwv7Ye16PaRv0CVpi4/6
	kUFBYWCWqInDe8sFWDVeRfWt41joasQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-fm5E3UIwMg-xlxTdyvrU4g-1; Mon,
 07 Oct 2024 13:58:01 -0400
X-MC-Unique: fm5E3UIwMg-xlxTdyvrU4g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5003E19560AE;
	Mon,  7 Oct 2024 17:57:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.80])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 59D21300019E;
	Mon,  7 Oct 2024 17:57:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  7 Oct 2024 19:57:45 +0200 (CEST)
Date: Mon, 7 Oct 2024 19:57:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: gregkh@linuxfoundation.org
Cc: mhiramat@kernel.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] uprobes: fix kernel info leak via
 "[uprobes]" vma" failed to apply to 6.11-stable tree
Message-ID: <20241007175741.GB1333@redhat.com>
References: <2024100757-gambling-blurry-b71e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <2024100757-gambling-blurry-b71e@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

On 10/07, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 6.11-stable tree.

Please see the attached patch. For v6.11 and the previous versions.

Oleg.

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-uprobes-fix-kernel-info-leak-via-uprobes-vma.patch"

From 112e436ce71b8630f50b6ac17db52999255cd3fe Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Mon, 7 Oct 2024 19:46:01 +0200
Subject: [PATCH -stable] uprobes: fix kernel info leak via "[uprobes]" vma

commit 34820304cc2cd1804ee1f8f3504ec77813d29c8e upstream.

xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
into userspace. On some architectures (x86) this memory is readable even
without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ,
although this doesn't really matter, debugger can read this memory anyway.

Link: https://lore.kernel.org/all/20240929162047.GA12611@redhat.com/

Reported-by: Will Deacon <will@kernel.org>
Fixes: d4b3b6384f98 ("uprobes/core: Allocate XOL slots for uprobes use")
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 50d7949be2b1..1650c05c9dc7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1500,7 +1500,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->xol_mapping.name = "[uprobes]";
 	area->xol_mapping.pages = area->pages;
-	area->pages[0] = alloc_page(GFP_HIGHUSER);
+	area->pages[0] = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->pages[0])
 		goto free_bitmap;
 	area->pages[1] = NULL;
-- 
2.25.1.362.g51ebf55


--OXfL5xGRrasGEqWY--


