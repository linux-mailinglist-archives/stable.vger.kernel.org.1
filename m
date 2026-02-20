Return-Path: <stable+bounces-217607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C2QHFf0mGkaOgMAu9opvQ
	(envelope-from <stable+bounces-217607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 00:55:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF416B72C
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 00:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F49304C4BB
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150B2DB79F;
	Fri, 20 Feb 2026 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCf0RJby"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB6311C3D
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631685; cv=none; b=JFOQW7T8UrJzG2UxvFZWX2NZr4oNTyuR60nbZJOYSIfGql51/0fc9gMjtLllOUFT8TKUz60s40frjuAgoDDw21WZaF8v2qm1E8dI9dapbtdoeJCPuzUTljFKP3sCH3dOfT9Bbdv929JBDQocCoqctgtt6sKdleLM2yKxBoaJ7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631685; c=relaxed/simple;
	bh=S95391Nv2N1C7cuTrHJL9ItK4+s15TFj+YAB1tlQ2Dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u7NDJZlsooc3gIM/QG9Oxr36P/GcYxVFo5z25OSNefZiknGNtHNqZwno0VKgNE7dWd4c9u2Hp5LwxmKMtdGCCGgAYxOBUrPC3IxGz2yDDLwUVymgmaFDeH4Ol0D83+Di1gzLPCcfz6wtYRuRd9R2KXf3Q3+Uksa7WpEWZNUkFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCf0RJby; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so13784214a12.3
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 15:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771631684; x=1772236484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AsOcE+q9g9Rn3X6/odlnCkM6qqA9vgkvaxtReZc0KH0=;
        b=zCf0RJbyXzylbldGAO0LmvXUtgPFL4d6fd/3JGV+0DmqG4usNruldJzFrkMJPhszav
         qf8Mj5MVln1zlnCQitnMEg+WnMpoV5XlIWPFjYhqqJe9ctJMymAyjpPMiy+gptOn/L/m
         EEqzJnqAgpNl9VMH7d4n+ZYJ0TcI2XUP8rPdz3L3cihCZk6gyQ1CYsm77qQgUpfjtffa
         x0hmFQw1eriFwK7rBe0no6zqlw5lxKCXjPqy8XKsk/DvRJccd61E/5qoD2hrvVLGRtV8
         JkuuAC35jBGKdBdRLbAAYEXg/R5Rt5qRcorpkjm0hRW0zSyCKM7VMWzleoLT7Qpu4j+R
         LHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771631684; x=1772236484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsOcE+q9g9Rn3X6/odlnCkM6qqA9vgkvaxtReZc0KH0=;
        b=VDmg50Ky1yZtqpYNWJw8MTjBGznmBDrPxAgMfg53oizBMYCzfHiITtYPOwQS9vQe36
         6pSdOblHmkUfsDmjuWyzrUaPNnNZ+bvEv5jpuxuhh/rDcfKru5rUQS8DrYDchRobLlSP
         PpSTfSTiwuXNrene6oMSWE7U8rYEh+F7U/QaIFCi0Z/hKChxGXE7+Q3yb+2whJ51w9R8
         ix34JD8Q3BCWOyxPcpaOgWYWqrMD4+HYwZjvGCEvc4PgRjisSLLODMy7AVRFzALcOL+P
         g8hjt4HsKbT82x82DVrIICn7ilcyZclk2inI6V4PQ5tHS6ptqHQP3tt0UXwR2TMOOkeQ
         Noyg==
X-Forwarded-Encrypted: i=1; AJvYcCW9iAPF9+oVbs/NtTZT3NjQPhGAZeVn6I8PlGvyXKiwQhDGQaXoXonoTH4cU4JxIm3BFoJbfWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhq55gOaSfgZTkV6Qi7w7qGmD4HQ2S0XdZbF/k0VarT2VNmVKB
	sT7XeefRTDf4areXbwWoHbAFCXbsckDJEXEf1GjKmKGeee0lgQMSE0sP49cTVE8qEw2k7/ZAP2H
	+jdUZaZ158rng1E9thHhYz8EbIQ==
X-Received: from pgig4.prod.google.com ([2002:a63:f404:0:b0:c6e:1b27:7693])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734d:b0:38c:792:56af with SMTP id adf61e73a8af0-39545dbf3afmr1066001637.2.1771631684094;
 Fri, 20 Feb 2026 15:54:44 -0800 (PST)
Date: Fri, 20 Feb 2026 23:54:35 +0000
In-Reply-To: <cover.1771630983.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771630983.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <455483ca29a3a3042efee0cf3bbd0e2548cbeb1c.1771630983.git.ackerleytng@google.com>
Subject: [PATCH v2 1/2] KVM: selftests: Wrap madvise() to assert success
From: Ackerley Tng <ackerleytng@google.com>
To: kartikey406@gmail.com, seanjc@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: vannapurve@google.com, Liam.Howlett@oracle.com, ackerleytng@google.com, 
	akpm@linux-foundation.org, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	david@kernel.org, dev.jain@arm.com, i@maskray.me, lance.yang@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com, 
	stable@vger.kernel.org, syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217607-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,redhat.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux-foundation.org,kernel.org,linux.alibaba.com,arm.com,maskray.me,linux.dev,vger.kernel.org,kvack.org,redhat.com,gmail.com,syzkaller.appspotmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11CF416B72C
X-Rspamd-Action: no action

Extend kvm_syscalls.h to wrap madvise() to assert success. This will be
used in the next patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_syscalls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index d4e613162bba9..843c9904c46f6 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -77,5 +77,6 @@ __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
 __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
+__KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
 
 #endif /* SELFTEST_KVM_SYSCALLS_H */
-- 
2.53.0.345.g96ddfc5eaa-goog


