Return-Path: <stable+bounces-126784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B8A71E0D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F83B28AB
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4024F5A5;
	Wed, 26 Mar 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV/XYyP3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28A24EF97;
	Wed, 26 Mar 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012527; cv=none; b=WANsyt3vQViOf9iCfmIvoC/KBPA1SMdlyzoJPn15zTnJnGeHwzePgWnmIQbk5jLI9Pfa6FuPSp39/t8FMLyH05hEEfbRvDmpTI6bW3wzeQVQvIKpOleGIH3/Bk1vj/mSdWSqxXqXvBgAUmAht8YRbyNkURZz7xjixfJz1nWQo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012527; c=relaxed/simple;
	bh=6mLDKvGM1mGH3tA7f9jvwsDAJY9XbgV3Ql/pnbhvIAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rm7BdsMwuD1CDu9y9xoS99v65vZjzi2J/JnQRujw/v9oCfluWkXLJgJSKgete9YI0TTkoDzlMiAWG4fg974UL2ACk/Uk1IzPbY7m6E6FNktIplXbg2T4Fd0wSe0skpUTqRRfY6zsSgLufpZdaZSkkyjmjdD2DK8l2HKLeKNClc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV/XYyP3; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4775ce8a4b0so2389851cf.1;
        Wed, 26 Mar 2025 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743012524; x=1743617324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Aol4s/GyhsDfj9Ax/+3S97UHILyRN8WTp6xA7nHsuco=;
        b=mV/XYyP3W8XSBmlgrP4QxvKxPaCTfp90NAn9fv49s6vif+gRKuIJHbfOznS06VfjKu
         6HXKZD/ljNynTMvLxTLV40lXWk5TQ+oJCL1oI/ArcR2q7EOVEAnjGKl37c0prfOWXYqA
         AG3RYUnXGIgQcPzoY5BHfjSejmXuoYUr4oRH/9sloNu6w8rLkI4lzUKJi2vRWjZCno5n
         UiRKF0TlEwpSR7MKodau7jkqzMipA3CqxSr2Shqf55+pNoK9Xyge9Cuhmjzt2ZB7Mz8v
         2Q8WlB9kUY2n6hGWl0G8AUOSBouu7S+VY1RIUNzLkwoPwxRdi/6zIn2owno96zjjuFyo
         OCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743012524; x=1743617324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aol4s/GyhsDfj9Ax/+3S97UHILyRN8WTp6xA7nHsuco=;
        b=iXHp2vJ1Ii9w7ulsAzlR0+HqR4i6Cth/vZac/Ob0/WtYs+/vyBpb2f4LZAzc+NKOsI
         LeucF05/IrgccXU7yEj8nTdSEF1/63P3LZAKYNTYz3Le+FTRJVrtLUStoSWZUBfyp5l2
         liAzvDbu6OaFK0VXAOMttcsLXHLgMe6q2QleYbbRdvbZGGPbUld/K+yw3LkRM1ZYDyQr
         grlxZbfmTP7miIxl8icjvXg0ALprq5kjV/e6ErAKzCDnAudP5QEVHu7GRM3gNUG4tbdn
         VEBTIIe+qGpi4AahMf07/RAdW75tTEZK3ygW2OTN0PZxsuMraG+xOOqgz0d7uQZoC6uK
         i5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVgwVV+GSPOQ8LK2xmLHyPBNP01/n7GtYgUCqeolwqgdZDtdEAwO2cMLIgs13ZxbOBkdnPZZQ/L@vger.kernel.org, AJvYcCWzyj7iSum5EqoItRTSAOZmYBqRzRCZH8+7CEc/14KGJRla2x+SmiuQ3cIt8nMcU93bfsU1c6Q/MMtgroQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7z4gXsQ/pJ2ETS4goAtrKIl7T8pLYbKX65eIEWjD/+P930E9a
	7qVTUfUJk06amhGzPUY8FPF0m+8uIIjpc7lfzZNRv32tv9VSbgxv
X-Gm-Gg: ASbGnctV8IZkNnPlllK++B2LXlGJ1Q39DD+h426FFKBobLtR2qbq2+ZW5b7xB/g7x7t
	luJQvBsBQjB986T7jFwqJg2WZ02mXuGDv5gzZE14gQO9A3snOrpeqBUst4t2cb3kbkByXfcbJOr
	mc9bettvTKUTdxPc3wUFG/8yBBoTh7Bj6Zy/+PEgcSFV3cz6lmot5klFtwc8ul3GCqvXbTgCG2S
	PRnvaL5MlXDGdZvYdFWcrsnAyn31DJ2OZUPt5xD+qiv0I9r12CB8k6TVJshrSsmDLnUDjdyXgFt
	e8txhc+/B+nw0459HtK9JwLOnEqK4T9b3SMdibf+pkUEQhsLTwvBXYujIOWkCho7xNDSN/7aiMo
	OtnG7Pt6rGA5U2AE2lPAmyYoKO8gOSycFpwA=
X-Google-Smtp-Source: AGHT+IGQWY6oGXechStf8Ff1eNrAo42/G1GgJhoFwPQaN2dqpd7tbJQsyW5WH5wvgSS+feE4itE+Fg==
X-Received: by 2002:a05:622a:2489:b0:476:8e88:6632 with SMTP id d75a77b69052e-4776e12b519mr9366391cf.29.1743012524247;
        Wed, 26 Mar 2025 11:08:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d191ea6sm76300381cf.45.2025.03.26.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:08:43 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5E7CA1200043;
	Wed, 26 Mar 2025 14:08:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 26 Mar 2025 14:08:43 -0400
X-ME-Sender: <xms:q0LkZ6mYHIz-j6sdPij8B6AR_cmGyqKxsQZs5UQacs1RjdlabrE2Vg>
    <xme:q0LkZx3yFuvJ5aHhmH_pH1qb_dZBxPpdH3PVU-UDr9fsYXz1SlUhp5ZQ0LT8w4SPp
    upQsvxvPPxnSo978w>
X-ME-Received: <xmr:q0LkZ4p8ZwbOI0lycmE_BMlsn5AxGzQtZI-Gr7wtWAUvqZh8XrSb5SYSV5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefgteffhfehjeegtdduieffudetfeehgfegudej
    udfhieefgfeigfevueduleduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihi
    lhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprh
    gtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:q0LkZ-luD3QAMLrjuHd8JCGy1PRh78N_Ntvq7nLEV1wPyH2sfRv3Yw>
    <xmx:q0LkZ41TR9E50ebn5bFiT5A0HBr2dk9rI1NXciMKNUFSxTADwBDS2w>
    <xmx:q0LkZ1vdUf3zBNeujR_CiGxeT2fRpyZv5GpSYLTjX9wPevfDiq4nTg>
    <xmx:q0LkZ0WTPNV0Temz5Z_jfc4Gamz8CtcIPwNNDuN1z_n5dIyCeK12aw>
    <xmx:q0LkZz1_Z9m7PJfdk9zwkiyYAj9V74y4OPD3OFGRgOctvdiHxIsLTM5K>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 14:08:42 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] locking: lockdep: Decrease nr_unused_locks if lock unused in zap_class()
Date: Wed, 26 Mar 2025 11:08:30 -0700
Message-ID: <20250326180831.510348-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when a lock class is allocated, nr_unused_locks will be
increased by 1, until it gets used: nr_unused_locks will be decreased by
1 in mark_lock(). However, one scenario is missed: a lock class may be
zapped without even being used once. This could result into a situation
that nr_unused_locks != 0 but no unused lock class is active in the
system, and when `cat /proc/lockdep_stats`, a WARN_ON() will
be triggered in a CONFIG_DEBUG_LOCKDEP=y kernel:

[...] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
[...] WARNING: CPU: 41 PID: 1121 at kernel/locking/lockdep_proc.c:283 lockdep_stats_show+0xba9/0xbd0

And as a result, lockdep will be disabled after this.

Therefore, nr_unused_locks needs to be accounted correctly at
zap_class() time.

Cc: stable@vger.kernel.org
Signee-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b15757e63626..686546d52337 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6264,6 +6264,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
+		/* class allocated but not used, -1 in nr_unused_locks */
+		if (class->usage_mask == 0)
+			debug_atomic_dec(nr_unused_locks);
 		nr_lock_classes--;
 		__clear_bit(class - lock_classes, lock_classes_in_use);
 		if (class - lock_classes == max_lock_class_idx)
-- 
2.47.1


