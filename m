Return-Path: <stable+bounces-152405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F6AD4FD9
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D186C3A47E4
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192E8264A73;
	Wed, 11 Jun 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHut6TOG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/ikOoNB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C8235044;
	Wed, 11 Jun 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634235; cv=none; b=Z4t2AXsMMW9U6ufBqTSt8qmOOSTqI+aL4y78fcKkYBC5GSJdDASjLq/yn2+patyAH4du7V526kPu4k7kNRmN6JEkAVCs4kIbdK/XqiA6NJ5Z13rBiIZD/qHHnHgThX0tRdldtV1OvDhYqlyO6tF0pke8aq9Qp+FYe5hXAD9Rn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634235; c=relaxed/simple;
	bh=mFJrK1GSbumlSY17hCJ4tifRjTsfnnZ9l5K9gpPLQuI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dHOihogSs/MyYIkvAYbQEwdEtnjyX02AshdJ72fzHM83kyo/ZPPZvR8OvkD5yfUKsW9ge4Kq1KHcq4OAYre3sUGVIC4wfx5vU7/vyTzB+UwBkU1a7aTHh0T6sPRMW7uovqiq+i5wAHOgAQnPup5B3UJRqHjgf9lgIj2nY6g2J08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHut6TOG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/ikOoNB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:30:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6g8XTjYvRj/QYmzX8VBEJaIWUi9qt+BWCUfgqhptTw=;
	b=CHut6TOGbJXC+Sv0MxIdmKg3c19Q5njkQZ+auXydlH/9jf6wFV76I0bdUbPddTtmD8Ziye
	LiI5bl2IWoJAFr+8pZxFeJ8wodL3O8ZRlON7YwzqL52wv46uhj4RDiRHb3Ik7Bcnfr4qJh
	ZhRqluEHDeEKdC8W3Wf8IG32Z8td47PrAXjRYbJmyZCEomkFIMlJS4sZjWrwa9x26MJFsY
	0/8kAtHSCemgf1qU5tsLSi0CYB9UK8jlH073aGjR/LqlZw20eTLz3T7+35GSbK/Wo06Cy2
	3P33KVjDgG9ljX7v6tf1/hwCxemz1c4F/I9zU/ichkC8DATqtW42tOrM8iM9Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6g8XTjYvRj/QYmzX8VBEJaIWUi9qt+BWCUfgqhptTw=;
	b=2/ikOoNBaW5wrIMxWCLKuMNW26JYcAjQHxmwCxC8LUVSK6rqFMy/wi514WbNrjm7uwYXtL
	BJLqh2Z+kLu8MvDw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: don't collapse pages without PSE set
Cc: Juergen Gross <jgross@suse.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250528123557.12847-3-jgross@suse.com>
References: <20250528123557.12847-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963423169.406.17577535195665090252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1dbf30fdb5e57fb2c39f17f35f2b544d5de34397
Gitweb:        https://git.kernel.org/tip/1dbf30fdb5e57fb2c39f17f35f2b544d5de34397
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 03 Jun 2025 14:14:41 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 11:20:51 +02:00

x86/mm/pat: don't collapse pages without PSE set

Collapsing pages to a leaf PMD or PUD should be done only if
X86_FEATURE_PSE is available, which is not the case when running e.g.
as a Xen PV guest.

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250528123557.12847-3-jgross@suse.com
---
 arch/x86/mm/pat/set_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 46edc11..8834c76 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1257,6 +1257,9 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 	pgprot_t pgprot;
 	int i = 0;
 
+	if (!cpu_feature_enabled(X86_FEATURE_PSE))
+		return 0;
+
 	addr &= PMD_MASK;
 	pte = pte_offset_kernel(pmd, addr);
 	first = *pte;

