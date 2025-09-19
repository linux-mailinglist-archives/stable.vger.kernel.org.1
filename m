Return-Path: <stable+bounces-180616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E52B88866
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904E51C27EB2
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995A2F6162;
	Fri, 19 Sep 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVPmUjVX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3E2F1FE3
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273184; cv=none; b=NLe3I/27q0rKYW95FabGboobvkIfo3cKaR8MBHDmOPrORaeVnpK2qg95GjhaCJD7ej52UToEOQdR97VShpuyl3Pn29IeOf/cqQ7b5ViTlxkUSEixIQOoMcis6F9h3aZPb4iYh4GW1kVj8uKsPSKlsic0ovljdlvtdSTwXZ8EzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273184; c=relaxed/simple;
	bh=QweTAqxNpSrDrK2q0/RR+kdBUV2hZvkvOnc1TJn8Yck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP2J82Rkj0tO8lDehiJYvtzT3DAXlcaShoaozrGnQRSxv8qv92eai9TxAWVL6wyc3lc/421PHBt2Aoy7w+yjQAtSQuBGNZ0+nZTAg+zG+st7AthcfQwHKsd9ionNm/8nIBIym1UqHeGFjuVp8FSbFqAJ5IB+NQcLVEc/3odDmWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVPmUjVX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-796fe71deecso11310266d6.1
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758273182; x=1758877982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K70gfC2VGaXawlZrrSZ8hp0QF5eghAVmIXEzCCUkbN4=;
        b=hVPmUjVX8qD57Te8PtzQaXb7pzBCYUxYaT3AmPJBcIgvd1tDfMhYhZjEmMPWZiaLEN
         91vtiIAhkGHfCFl0gV/2yFN/y23ek1ZjvYmsOIyib5wa461d8v6B7hIqdeRfNVMo+P23
         yxeOnXtX2tf8EZY0MD3PPX1Fo8bSzHpE3FwLYB2xMWZtE6Lsxd/TDK0Gl89WBIgxs9Sn
         TWhY9zUmpV9cLSWB0mto1XtmyatUBIhboUcks0AaUhdIOCUI1tz5xI85IfAy0Gz+BN2J
         7Emn7lx0c/fJHle5K9pQ8qnVkIrtQt/NLGZt4/Xw71tCkOLxetOZ7jxRC9sWaFRlwp+g
         /68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273182; x=1758877982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K70gfC2VGaXawlZrrSZ8hp0QF5eghAVmIXEzCCUkbN4=;
        b=OyEpbnyHMv1TZnzFp4vWq1RitOAW53wi1rY5WSok6HKMQETt5xGd2/VCQCRqik90lJ
         EiOPv1egWMq6vx2Qp242vSd3fLCJi22cKORrcKooikI5d5a0i5+hdpNSpBSRls4gjDhE
         /TyalBZst+I8UKkNLYsqLDFoBtlw8iZJ9kK6qmTF0Ze7AR36xUMjRrc5+XBIMzfQ02I3
         TtXZ0f/bp7xWFuVcUKYAQVyQeQr9LXvtKcuwTkpf5DbypMYB27x34CLRutLu/TbI/pvT
         SXK0DrSR+hd4lygjSngm9uDjOlwHbApOMcLoYSqw33D7mweS/D56eLHG8SkvSMVywPB1
         MaVg==
X-Forwarded-Encrypted: i=1; AJvYcCVNLbt1ChQW8yIeGfSSjMsuuoxrebD78uoZxNfGmSizYc27nnYCvXse+73+vzYzFOONMO1rQc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0Jzfo3NcYlpfBSKGPowp2oMNE2UUL1RCRUFr6ChXqEulH0pp
	Ncvxz+o8Kg7ZIisHdE/MoZOYhM+vN3Af/+eLcTzkfTQWXHnqvFwBMJ7G
X-Gm-Gg: ASbGncss02pOqtzzVZ969OfhlArsPyYkEZo4iypNK9bUikDFc2uQXneXk+dXocqzcRT
	cknq4h0UijEZ/zmtloJ2hEnK+HxO/rrtb+u8//9Ex2W4qc8wHHYTF14zZxQ33Q/D3CSL+sgo7n/
	zZ0w+AnSweYDiW1oMLXmD1MVfigdGVn+5W3eyTWa800vz3hW1wgS6c+f8dtUlSsOX3Nsc2PM9My
	0wPUVLfQklHb4+Dpi3ubg7SRIybaBuCuyjmRrpK+ECzM/Vhxhyjwc5LzqDfah4IzQ32Uy0C34EJ
	TttwViu+2NrT5gRpwUvSWkecy8cazxBxQdlE9NojHXzqQ6xlNIZy7VXKiCcYJxCHUi2R02kGwdM
	TnVigY3Feg+rAhRJsZe9VSX0bxPUoWl6JrkWE2m9eMYn53AppI73Hl2NB1gPuxHoroop3K/eZ84
	EsOzPrabfZRqD4
X-Google-Smtp-Source: AGHT+IENO3y1I+WdQckOF9/GGnaAMQ+ul1aKo9ejx3/ulS4DRfGqgjIdtHE0clXgDs5HZit1Tjxilw==
X-Received: by 2002:a05:6214:29e1:b0:794:6621:6d18 with SMTP id 6a1803df08f44-7991d549c82mr24827026d6.51.1758273182126;
        Fri, 19 Sep 2025 02:13:02 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793474ac8dasm26073756d6.30.2025.09.19.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:13:01 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3316AF40066;
	Fri, 19 Sep 2025 05:13:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 19 Sep 2025 05:13:01 -0400
X-ME-Sender: <xms:nR7NaOLBS26uIfK4Ed8QhVmcyJM3gZFCCmMxb0z1MgGIwt1en81uKw>
    <xme:nR7NaKY1xYyL1iVWtry5iATJBEL0a2_379ADVTfH2YfVvX59wAGqm9e1g-J8iuH_U
    Pn08rBAjNBSBvXn_A>
X-ME-Received: <xmr:nR7NaCTvg4nWwxnNKkQxz-BJwtsomwcfFw9VAZrDGjc5w-EfgdnsvhAH9lhB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesnhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprhhushhtqd
    hfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:nR7NaCg7YxtMhcv3IoTX_-zd2libnCl4OXYA6_Ds91efm7xQkeJ6dg>
    <xmx:nR7NaOvv6BU7R_WT2VqJsWX595xDh83Ci6pQZbGQbfzj11JVQeOKOA>
    <xmx:nR7NaEyipy6jYjepz_2klsuBBZrRw02um3fbtquJ_DrzSOtrbVE2Sw>
    <xmx:nR7NaMOpas1iBqJn84ZsG6cmaZLeBWsxafdFUkhVYYwd113Ng0MaVw>
    <xmx:nR7NaO25cC3oRhaNC4wAbHcV2E0rfR4zsyDoWN09ForWCLQKj3Y3A9JB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 05:13:00 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Peter Zijlstra" <peterz@nfradead.org>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	"Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	stable@vger.kernel.org,
	Adrian Freihofer <adrian.freihofer@siemens.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 1/4] locking/spinlock/debug: Fix data-race in do_raw_write_lock
Date: Fri, 19 Sep 2025 11:12:38 +0200
Message-ID: <20250919091241.32138-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919091241.32138-1-boqun.feng@gmail.com>
References: <20250919091241.32138-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

KCSAN reports:

BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock

write (marked) to 0xffff800009cf504c of 4 bytes by task 1102 on cpu 1:
 do_raw_write_lock+0x120/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

read to 0xffff800009cf504c of 4 bytes by task 1103 on cpu 0:
 do_raw_write_lock+0x88/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

value changed: 0xffffffff -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1103 Comm: kworker/u4:1 6.1.111

Commit 1a365e822372 ("locking/spinlock/debug: Fix various data races") has
adressed most of these races, but seems to be not consistent/not complete.

From do_raw_write_lock() only debug_write_lock_after() part has been
converted to WRITE_ONCE(), but not debug_write_lock_before() part.
Do it now.

Cc: stable@vger.kernel.org
Fixes: 1a365e822372 ("locking/spinlock/debug: Fix various data races")
Reported-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---

Notes:
    SubmissionLink: https://lore.kernel.org/all/20250826102731.52507-1-alexander.sverdlin@siemens.com/

 kernel/locking/spinlock_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2e41db..2338b3adfb55 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
-	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
 
-- 
2.51.0


