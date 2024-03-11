Return-Path: <stable+bounces-27408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D946F878A0E
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 22:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1003B1C20EB8
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C056B79;
	Mon, 11 Mar 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qt8xAWtV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD656B63
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192630; cv=none; b=L/YFfsbMx/Pb50eXfd/6gNVM2T4HjhM9H7+Zt8+zGvnFOqUj2PTnxaQbD7qvyWUrcfja6R5fr8wwU8fO1stzyX6dDv/78+jGm1vTqj2HedBDqzW/uFCM+iRDUlISStyXO7ais6/or+KjR93587UI7JQzdARqPiGRcdUGFrqjPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192630; c=relaxed/simple;
	bh=Dfk4ovR29+VM2K+8Ky3cH4P5tDJyC5cHjp8bG8giKPo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jY3OZ6e5QAeAh7dkmgpgSTxlM1Bs/EPuGKOaHHJtI6EDhdnfazwHFkO5Fp7tstqGNiAX9WB3oFCffxlGd/tL+1i7BovZEEh4lnzU1KCxo1LPeOijIMf1g10amqKBQaIF5v+GlbJqmD81e3CSW8VdIX4nBlcL5wzWlaCUvyI48dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qt8xAWtV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so5614530276.1
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710192628; x=1710797428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YvmpJ8ct33PRrafpbaVo1kzce/fkn32WN7BYeSu41lk=;
        b=qt8xAWtVFzr4qR1++/z4BrJVQdqsY/0WcQqzmfAGrUE8QD31fNPDXDnKq7X7KtD2E8
         +CjBIl72Uq9uJqMqBBr89GhGObdApTc5j7cd3U+VgPYAn4Tt1vdRFdD/PuB8O8Qj5cRM
         5M+iC8Dp2nuAQT4/37kRJmT73wvJr7NBvlSofJ7z0SHIg1LrScPoOshpMz5qd9GFFdZB
         zzZ99l/cGSXV96wUkKmah2UdmNFt+OAoyroPiaOkV1AD6hQ60gqNrXJCiI6Pr7H43ohB
         /+wFE4jFNDW72OwaC4L7Y9SZNGUXY+TUkgOEAbXwjzQhH02VeL4CPKeJwlS07GQDrug0
         czDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192628; x=1710797428;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvmpJ8ct33PRrafpbaVo1kzce/fkn32WN7BYeSu41lk=;
        b=n79u+A8xK4+edRqeuWTHZs4/tkWDWzeYu7JMm5RS8YWjY33fnOqsybZDZoYQac2I+l
         Op+bp78pNwWMfB+lO7zIYrpzR2nNS15xRXDhTPV7MvKVuzMRPCwZnkW3WgEhpBqruii6
         2JXySetwt95GDMreVx5yBGRepPlUfUqkzrMNUwPQvnMA7PsyNuGyN4oFomUQxZYDOcTp
         Ybd6IaYmqjAH42AAExlNa4Z/HEmyjGi9ooJtvkbdXwh9dR/IFQDEJttr6LbAicYc6SKi
         ttMs62F+gRZuF/1Agy0SRgXTcHi+4yfbVK2jVEwAhdol2JyEFWLUbUn9WkzF7oTYsXoh
         a54g==
X-Gm-Message-State: AOJu0YxRUaH0paJng+ZVdfhGHrqHr9szNRkTub4ZqI8tiKj7FKCc2hsU
	BG+6VrgJTrm9q3s2ZeVuexM7y1TKoIn0T6dEonPGa3W1oUd7Wg3MPbWTH3vwLBzREHiuaA/RR2M
	4qzdIP/Jn4Do+xW3OA0XOfzGeeKderue8vMo3n/NmOI79bOtc12IoziQGBTHkjC/o/Mys7TcVHi
	k3MukhG64z4uflH9OfatLX+rMrrB4QsqWQjh6ZJ/S5ozky1n+xzM70S5DSvQ==
X-Google-Smtp-Source: AGHT+IGf9pfY6DmJ6xaAqYigZwjChvdQhkVF7miHCYl1Ck6sdKrGMZzd1F+fRagZ4ewyq81aPliPnO2OEwXnx1HvOw==
X-Received: from rkolchmeyer.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:7f04])
 (user=rkolchmeyer job=sendgmr) by 2002:a05:6902:1889:b0:dcb:abcc:62be with
 SMTP id cj9-20020a056902188900b00dcbabcc62bemr2019992ybb.6.1710192628124;
 Mon, 11 Mar 2024 14:30:28 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:30:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <cover.1710187165.git.rkolchmeyer@google.com>
Subject: [PATCH v5.15 0/2] v5.15 backports for CVE-2023-52447
From: Robert Kolchmeyer <rkolchmeyer@google.com>
To: stable@vger.kernel.org
Cc: Robert Kolchmeyer <rkolchmeyer@google.com>, Hou Tao <houtao1@huawei.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

This patch series includes backports for the changes that fix CVE-2023-52447.

Commit e6c86c513f44 ("rcu-tasks: Provide rcu_trace_implies_rcu_gp()")
applied cleanly.

Commit 876673364161 ("bpf: Defer the free of inner map when necessary")
had one significant conflict, which was due to missing commit
8d5a8011b35d ("bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.").
The conflict was because of the switch to queue_work() from schedule_work() in
__bpf_map_put(). From what I can tell, the switch to queue_work() from
schedule_work() isn't relevant in the context of this bug, so I resolved the
conflict by keeping schedule_work() and not including 8d5a8011b35d
("bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.").

I also noticed that commit a6fb03a9c9c8
("bpf: add percpu stats for bpf_map elements insertions/deletions") is tagged as
a stable dependency of commit 876673364161. However, I don't see the functions
and fields added in that patch used at all in commit 876673364161. This patch
was backported to linux-6.1.y, but a `git grep` seems to show that
`bpf_map_init_elem_count` is never referenced in linux-6.1.y. It seems to me
that this patch is not actually a dependency of commit 876673364161, so I didn't
include it in this backport.

I ran the selftests added in commit 1624918be84a
("selftests/bpf: Add test cases for inner map"), and they passed with no KASAN
warnings. However, I did not manage to find a kernel on which these tests did
generate a KASAN warning, so the test result may not be very meaningful. Apart
from that, my typical build+boot test passed.


Hou Tao (1):
  bpf: Defer the free of inner map when necessary

Paul E. McKenney (1):
  rcu-tasks: Provide rcu_trace_implies_rcu_gp()

 include/linux/bpf.h      |  7 ++++++-
 include/linux/rcupdate.h | 12 ++++++++++++
 kernel/bpf/map_in_map.c  | 11 ++++++++---
 kernel/bpf/syscall.c     | 26 ++++++++++++++++++++++++--
 kernel/rcu/tasks.h       |  2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


