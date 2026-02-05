Return-Path: <stable+bounces-214484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJBWM7WuhGk14QMAu9opvQ
	(envelope-from <stable+bounces-214484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:52:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E1F4440
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054FC302D969
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32934F27B;
	Thu,  5 Feb 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPPgp+Db"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA33212B2F
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303061; cv=none; b=qIsBAKkwpbMttmUkSU7TmR2nPPJWZ7u8mxnZ3nEMXq0+XNxM1rO5WQAhOpzMbUQJrcCRv9Tq9Nu9C8MJYsksFamc/qP/AcjXm/p/+ZW6UolupI0nKHcBvqtlTk3hi56VfNLFWlQ84RdZ6qQ3ZPCt6VK9YMKGeLq3mNUel8Nek8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303061; c=relaxed/simple;
	bh=YVgxEMUekUiwSH1AJnQti1nrs2UQrYUrvGEBctUtEHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l1Wl++nbdmmwLbm6WzJYWpYGim9q4OMVI3egQWsek1lUEEAYkdi5DS9ZLgtHgZIqDs/Ope6PTB31iLTXJxBCY2Bep6u1glGcTs0qf7KoYt2a18A3JJBJTUktBCzZ5ozIWuOqhqY96S6JP3hOvrUc09gVDl2PGpXE3MaYmcicS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPPgp+Db; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so18286345e9.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 06:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770303059; x=1770907859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvp9ADJW+h5hQnGxgLtc+vFKCRET1FtUQ5XB5iZCpDw=;
        b=qPPgp+DbURDEFVm6I8QQrWAIR4WHmD5oh1KOtLJIV88YsOBb/nf68eu6p9hJx/KbTd
         WGtxU87SRWz3DXd7KYEGDTB6R2l4xODH+x7VT0S175xb3UX/Q2fc4s0mun/bk67FAn+6
         hmI3CU1+sQTo6jZ8M/CMVitoCMzBiSGbdP+Ntc74PbEnL8vU7z3i7oPuAywRYrHg1ihl
         kTGL1f24zRfVB7KQ37gmAzGfxktt5sgf2Qdj92ZsRJPeEQh0egl4226yl9wk00CAonM4
         zZk+EajYW1qmQHG0UC4zfh2oooTomqcfIKYEGw7P2gjBFFT9wMrNzlF3O+XbFyrESQqN
         QHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303059; x=1770907859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvp9ADJW+h5hQnGxgLtc+vFKCRET1FtUQ5XB5iZCpDw=;
        b=ZePSd+BY84HGHRhKd8wjeqVGXheNNbLmTtgEsqG6M4hhZwL06fDEpSdJ7/EQwKfXHX
         +F3T+5Gnx/9PwcLyVBsAzWnUbWdMKPcgo3iRee4dln4+oBIdrENECoQDUmMzMUzrmIkX
         bh5ewqMWoKJOpSVIGYG5xC0gzgKkUkMVvd8JjF3XUgKZtE3bd5JyyUzWZYSyNCJqA+lR
         bdj/c7ON/gwWdhUc87RY5QgE1A03pYRkPPzsHP0MFL0oEy+W4mgQcRTapeD1Wj05xwZl
         XjV9EzNbkdBv5tRlS/sHac/l3grq0mLGQtTAPsNzQ8gCriMlsCz60EwtC3Dle9mvMAnr
         2q3w==
X-Gm-Message-State: AOJu0Yz0/qL1BxrjNsqADntlkbTUym5bcSfNj/yw7F6iMMiu49s/+Kl8
	WwS7CN1EQA2wkL92S5MK23CDJJ4QbG0oHRbBNdpuNiE/atuOJs8J6v26ac/P0Hw/+2Fw7S+Whbf
	CHafAeIbjkeshva8BEFJSzIJsVPLrONbzwqzAM12Cq9NqLx8vI7f7zxdMFmfNCnEBe1w0X1tF2D
	0NXJUbIPLIneIC+F6V0OdlrNh7bYAwcPw=
X-Received: from wmbg27.prod.google.com ([2002:a05:600c:a41b:b0:480:692a:4431])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6212:b0:479:1348:c614
 with SMTP id 5b1f17b1804b1-4830e9707bbmr86569595e9.26.1770303059112; Thu, 05
 Feb 2026 06:50:59 -0800 (PST)
Date: Thu,  5 Feb 2026 15:50:55 +0100
In-Reply-To: <2026020339-trickery-vegan-e9c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026020339-trickery-vegan-e9c3@gregkh>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205145055.3333340-1-pimyn@google.com>
Subject: [PATCH 5.15.y v3] mm/kfence: randomize the freelist on initialization
From: Pimyn Girgis <pimyn@google.com>
To: stable@vger.kernel.org
Cc: Pimyn Girgis <pimyn@google.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214484-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1F4E1F4440
X-Rspamd-Action: no action

Randomize the KFENCE freelist during pool initialization to make
allocation patterns less predictable.  This is achieved by shuffling the
order in which metadata objects are added to the freelist using
get_random_u32_below().

Additionally, ensure the error path correctly calculates the address range
to be reset if initialization fails, as the address increment logic has
been moved to a separate loop.

Link: https://lkml.kernel.org/r/20260120161510.3289089-1-pimyn@google.com
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Pimyn Girgis <pimyn@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 870ff19251bf3910dda7a7245da826924045fedd)
Signed-off-by: Pimyn Girgis <pimyn@google.com>
---
v2: handle addr calculation for error path  within appropriate loop
---
 mm/kfence/core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c49bc76b3a38..e1a555eeec45 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -520,7 +520,7 @@ static bool __init kfence_init_pool(void)
 {
 	unsigned long addr = (unsigned long)__kfence_pool;
 	struct page *pages;
-	int i;
+	int i, rand;
 	char *p;
 
 	if (!__kfence_pool)
@@ -576,13 +576,30 @@ static bool __init kfence_init_pool(void)
 		INIT_LIST_HEAD(&meta->list);
 		raw_spin_lock_init(&meta->lock);
 		meta->state = KFENCE_OBJECT_UNUSED;
-		meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
-		list_add_tail(&meta->list, &kfence_freelist);
+		/* Use addr to randomize the freelist. */
+		meta->addr = i;
 
 		/* Protect the right redzone. */
-		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
+		if (unlikely(!kfence_protect(addr + 2 * i * PAGE_SIZE + PAGE_SIZE))) {
+			addr += 2 * i * PAGE_SIZE;
 			goto err;
+		}
+	}
+
+	for (i = CONFIG_KFENCE_NUM_OBJECTS; i > 0; i--) {
+		rand = get_random_u32() % i;
+		swap(kfence_metadata[i - 1].addr, kfence_metadata[rand].addr);
+	}
 
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		struct kfence_metadata *meta_1 = &kfence_metadata[i];
+		struct kfence_metadata *meta_2 = &kfence_metadata[meta_1->addr];
+
+		list_add_tail(&meta_2->list, &kfence_freelist);
+	}
+
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		kfence_metadata[i].addr = addr;
 		addr += 2 * PAGE_SIZE;
 	}
 
-- 
2.53.0.rc2.204.g2597b5adb4-goog


