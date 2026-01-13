Return-Path: <stable+bounces-208269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A9D194B5
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 15:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF53306435D
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D06F392B64;
	Tue, 13 Jan 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="I0duCVe7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FD349B19;
	Tue, 13 Jan 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312996; cv=none; b=ae/BAG4ewXaSjk0wNpqXa9cNHTjRNnJQXEz8WUWQuh8c0swrW3JWGcgPjEJcGgFrcdWCZodW94n6pdGfl9wR6OmPrUKQjl+qwE24JEVN3CZdnJgSfwt73sDYiYycVnawv5vXe3c7JAs3/zDSWeiM1FIzHevq6VbdJ6O5h8ctLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312996; c=relaxed/simple;
	bh=Mlv8Q3oR7V/OLiVqdmnQP9ckhLwj7sgcxdD2uTXOCiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekr37ScD1uig5XqPlMCERZCdTSC0yMoU4yPkuCtkFqhpRjmG4Dd8JC74SshoT8XPECh3SqekXFKlpOBb3mEV01+lzN5A4sek9IuY6K0e3gKz5WLkrTNUmf0yTJtxes5yDiDRBWFix7UzeeIW3W5EoboDJe+kBR5Y7a0q/8OpYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=I0duCVe7; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60DC4dtS1330592;
	Tue, 13 Jan 2026 06:02:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fQ7j1PpGTasQAblfO8V1KwLqMUsTQm5W+M3/6xbpbQs=; b=I0duCVe7seY9
	Edk/KTttYI7pSWoYZeM0jlkHIh1rNXqTqRlrmWA5DDtmw+cyr+js5kd+YW+lAEi+
	wyWRsOgyVP7cZXyJ521koGYuvcfbOlqxcIKZ/mtPc1La+qU1EzA1tQDAqWqzY1fy
	WXCVvVWbyhyD6yC5Onr8rK50uhcSnEM3U83BWw94xMqoHGUVKqZkDa2Ls/4vxdnQ
	EcO3t9e3x/msw1qWNheVYhMSk2QU6IHI+SwzmJuYGC6UgBOudhskL9S7uolAqZ5u
	S/3xQ5eaAE1alCHjyZaDTLYG9Kpa+I+venuH2H0GgLg27XuEwq24P8K5o9mZhEwO
	pn4EceYpjw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4bnnr4rsm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 06:02:54 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 14:02:51 +0000
From: Chris Mason <clm@meta.com>
To: Breno Leitao <leitao@debian.org>
CC: Chris Mason <clm@meta.com>, Alexander Potapenko <glider@google.com>,
        "Marco Elver" <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mm/kfence: add reboot notifier to disable KFENCE on shutdown
Date: Tue, 13 Jan 2026 06:02:27 -0800
Message-ID: <20260113140234.677117-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127-kfence-v2-1-daeccb5ef9aa@debian.org>
References:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -zdoFufYx-ri54AmF2W0YNzuIqDQSvvM
X-Authority-Analysis: v=2.4 cv=Zs/g6t7G c=1 sm=1 tr=0 ts=6966508e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=xNf9USuDAAAA:8
 a=7sR78lRsTtdWeVkM5_EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExNyBTYWx0ZWRfX/SH2AzbaA7MB
 fQ7SM27TcoFfggUzHtqIj9YhlO1KEvX/6zhNr8J15aiISa2bEPfqhMxaGMCXMRk7HSSy2FeKxgG
 ibIbIpNHOjRb942E+A/vtvrrW00uQh/2JJikK5QORViYber7Xv8570VWucIgV+Md40nWkQ69a/h
 ceE9JyquvWsfNEG0ymemR3nJfJdFJBhdrqkXF+G4N4dEF3wCYQe9ChjlA5DEOg/VBgeqsjnHq9+
 fDMjeZ5zQVSoy9peZ/++qafLhPPJoHlPHTq/hJ0FOwRdkNTQolGhAI5ikEhdq/6EtAbq6PscK5v
 U8+EjxbMMiTCIYMGLNF4UFv19e8DLo/fL3Mi2lZ+aEcSiIj70a/thIH9S26H8vTe2EGUs5jZ5uX
 tgvHiHwvc/8cojlBjhfmCefn7NaWbU4n/GkF4BpbvDEnVF+bsNROvOPUAnaRQjlW+R9I+QaCBm/
 M6FkDwYwMQY3kxIZ3GA==
X-Proofpoint-ORIG-GUID: -zdoFufYx-ri54AmF2W0YNzuIqDQSvvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01

On Thu, 27 Nov 2025 06:51:54 -0800 Breno Leitao <leitao@debian.org> wrote:

> During system shutdown, KFENCE can cause IPI synchronization issues if
> it remains active through the reboot process. To prevent this, register
> a reboot notifier that disables KFENCE and cancels any pending timer
> work early in the shutdown sequence.
>

Hi Breno,

I'm running v6.19 MM commits through the patch review automation and this
one was flagged.  Is this deadlock possible?

Automated review output:

> @@ -820,6 +821,25 @@ static struct notifier_block kfence_check_canary_notifier = {
>  static struct delayed_work kfence_timer;
>
>  #ifdef CONFIG_KFENCE_STATIC_KEYS
> +static int kfence_reboot_callback(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	/*
> +	 * Disable kfence to avoid static keys IPI synchronization during
> +	 * late shutdown/kexec
> +	 */
> +	WRITE_ONCE(kfence_enabled, false);
> +	/* Cancel any pending timer work */
> +	cancel_delayed_work_sync(&kfence_timer);
                   ^^^^^^^^^^^^^^^

Can cancel_delayed_work_sync() deadlock here?

If toggle_allocation_gate() is currently executing and blocked inside
wait_event_idle() (waiting for kfence_allocation_gate > 0), then
cancel_delayed_work_sync() will block forever waiting for the work to
complete.

The wait_event_idle() condition depends only on allocations occurring
to increment kfence_allocation_gate - setting kfence_enabled to false
does not wake up this wait. During shutdown when allocations may have
stopped, the work item could remain blocked indefinitely, causing the
reboot notifier to hang.

The call chain is:
  kfence_reboot_callback()
    -> cancel_delayed_work_sync(&kfence_timer)
       -> __flush_work()
          -> wait_for_completion(&barr.done)
             // waits forever because...

  toggle_allocation_gate() [currently running]
    -> wait_event_idle(allocation_wait, kfence_allocation_gate > 0)
       // never wakes up if no allocations happen

Would it be safer to use cancel_delayed_work() (non-sync) here, or add
a mechanism to wake up the wait_event_idle() when kfence_enabled becomes
false?



