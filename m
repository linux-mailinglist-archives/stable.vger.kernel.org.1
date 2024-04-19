Return-Path: <stable+bounces-40255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF38AA9DD
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F52AB2291F
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D14EB44;
	Fri, 19 Apr 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0S9spQ7I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621EE3E485
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514332; cv=none; b=WqG0qUQTIm06B7OBbuXkugHTj472fK5FyaeK/9n5008WDqeA2uDadB/veWJUp/dv+Z/wyJwfUSwkdTjw+uq5eylLPbuEKQxLMh6qIEj5uj8Uz4GXJlGBr7AyXbmgYGPghBma9tDkYTlh3N+xp5SU7s8VyGgSFiyMfqMJRUJY1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514332; c=relaxed/simple;
	bh=Lrl9VyY4H6VkrMiqFp9Un3371PeHUgqIYUfRbu1KE+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nljuAiKKY0aPJTCLKg0k8TT3mpIUJf1/crkQs9d5h90+KtFaw4a72IQ6QcnVQCxP86K5UXFpq+vauK5fB/Ci914K/2I9eD9TpyFDotPYPCX4F5U1IyrMfzE/yKp7TuNpBE66aCaAwKsOJ8DBmoTKi9ZRHZw6B3oGaNxfOWIzc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0S9spQ7I; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4190a40096eso1562785e9.0
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514329; x=1714119129; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7D96C2r4Z5B53ELYjalx5RDnaC3F06tC9J2enu2MMNw=;
        b=0S9spQ7IbF1YEIceCMpI3hjF2ftd35c/H3aryzPVgeFDwq0/VAGXsYa8QRsbD2Dudo
         riG5lBf165iFbVw9M8kxKlT2adeQXBK/IBNwdmzrv+l5+/vcY6+oo5EmcF0YELrcE2hL
         lvU1bRDRSafK9U6tQnl4lJTOhaiJcE43+5P/SFtFM3v83NKHRvSgoIEryzuiD428rZtu
         JVZUC7/qq+JRrfXwBoQac8gwG637bJf2CxuZ2/GlV3wfjEGyXqjGx/nM6njPeoKVlGYd
         hwZuHQwmt+9P+QNhQY5sMhgkgmNPZENemkqPKaybLZnMnMdJ5X7ZwMeQzd3K6M5OPVeA
         ePwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514329; x=1714119129;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D96C2r4Z5B53ELYjalx5RDnaC3F06tC9J2enu2MMNw=;
        b=t9YZ+i+GiDRW1D7H4gAxN4+iG/lbXH81b4Mhplp3IpfZg+cvUpiRIQMI2S/b67UFNW
         df/koKmwyGJ21tIwzi/CFI4o0hsnMva9Nq1HPXKrNU7eO9idQhif9VxBcwBm1cutFPgP
         dZuscS75ha7hW5sIfDbcBi6eoC6z+XaPVvOGfBqQplgahvjtJgetHtyYlUobUG8TVuO5
         +EVqieru9pza4iZXKWvGPidwGOvSkVkBUrgmDAdw6ZHaFaGyUAlxy6miZXEUf1z6S9tv
         KcBqO//9eQ1HwmBK5XVVD3s4mV5820FUE20bh3t9BPSH89zV8wjCDQev6n/urGZP3vJX
         LzoA==
X-Gm-Message-State: AOJu0Yz8xiNTxAIwaojHpirvmA+kZnhKqpYVOUrxOKm7HBzJoLWc6xni
	ToMtF8ReRUWu3KXpHT4pDZy9etdJIALMr1ncvfytQivj3wZn4SVPwCWU9XUDhzggYJEbxfcPUsD
	7eNNRc1Q6P+iBr/ncPsjzOoOnJUpI1QQ97O8sROjcxn6WTsg7enGuu4R9hguiZl/mn31tjFc1ZP
	UrJZxZVO019kjnGeOOEvzjaw==
X-Google-Smtp-Source: AGHT+IFiQGoTTtlSRtoRMi6nk0Vv1HijiSZuCu3DGM4iLNQowr2aJYOroCFLQoPMKi6HS5obiTW5MkwL
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:6d8f:0:b0:34a:122d:a749 with SMTP id
 l15-20020a5d6d8f000000b0034a122da749mr11348wrs.6.1713514328841; Fri, 19 Apr
 2024 01:12:08 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:25 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=ardb@kernel.org;
 h=from:subject; bh=jmX4RP1rkHO1NRVxKxHIGtJmypHBlaU3F7T2k3SS5UI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXaNx28ZqK2t2icr39vFnZ3TPdZFYmOWk/1/j1T7Ft
 V789vM7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETMChn+u9YtPr5pv8rusJ6X
 VqbSpfP2M97sPvhZQWuGztu5p5QK8xkZuj7ucJygX2zwPU7p1oS+yTV+e78vjle29b62Y79Jgyo rFwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-44-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 19/23] x86/head/64: Add missing __head
 annotation to startup_64_load_idt()
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

[ Commit 7f6874eddd81cb2ed784642a7a4321671e158ffe upstream ]

This function is currently only used in the head code and is only called
from startup_64_setup_env(). Although it would be inlined by the
compiler, it would be better to mark it as __head too in case it doesn't.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/efcc5b5e18af880e415d884e072bf651c1fa7c34.1689130310.git.houwenlong.hwl@antgroup.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 34580e1a4cdb..78f3f6756538 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -588,7 +588,7 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void startup_64_load_idt(unsigned long physbase)
+static void __head startup_64_load_idt(unsigned long physbase)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
 	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
-- 
2.44.0.769.g3c40516874-goog


