Return-Path: <stable+bounces-58049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181DA92771D
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2BC1C2321A
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E57E9;
	Thu,  4 Jul 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8wF2OBM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A387846F
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099512; cv=none; b=JCKCm3DIHlTUJUpRdSBUVx/pmuceOI03BdElanL0miVS3jvUGjBbJ5Rqm8aK6KfCWvgxdfAvQgennlAnBMSbfM4ETytPn1/nuzrjaDc2y+jbmcL4VShhshHDSvqa8C5GnS9yVpFz2v8rqHkuCHd73XZTFK9d51OC8l6HCkWzDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099512; c=relaxed/simple;
	bh=Voll2Yc8WG6/v4LxvG2CK3/mC5XTekANdrTvNMMKUiQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pzYlF0tFY/dYVENzZj3FdhS3tKf1IsqUefgY7pVBmWz5gSpxBnNCLvPw9z4Q1JM8ydVJiuiOVLHF+dVf4UANqNdOTeIegUhkUIA6DKPeCIMIyASFgYIRnHLzdui+B6hha5alT92Eq5vTN/vdgmJjfUEYgGY6FvPGtKLOpEVtyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8wF2OBM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso1225648276.0
        for <stable@vger.kernel.org>; Thu, 04 Jul 2024 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720099510; x=1720704310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/z5eWgjSAssnhVs5ruBEIfE2gZpUKEUPXtdY5HP8ZQ=;
        b=s8wF2OBMeZPvBVS/PI738kZWEdoxBiGBKdad8Mz9nhIaEKFmI3K5BaLylQU7LNBMEk
         zWHYAtSRjhmVv7IFXhGYyE2cpRkhRaS+LYeIR0Y+fGH0dNbWP5CFx3loKr5/Nj6neKGM
         +K3DJ4Pfunx5Um32bzqwe8G0tjc7WIwautPIf62KgXOOzIsqU+8WatBr/OIqeZSUHf7q
         DbT2CbxYgeCl3V4HD7UHeh4EFaGAsBgTn9F3Hz+JYEj8ncXs5vp2K4U2u/zBwJ+f1C35
         KfXHgo4TFAqoOiqNlXCIa96QiiXXjZBdxFXMHciK+bXj5N3dWyvoFN8vtS7yTeSA72Zl
         bWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720099510; x=1720704310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/z5eWgjSAssnhVs5ruBEIfE2gZpUKEUPXtdY5HP8ZQ=;
        b=Qn7PJPV4gfjPBSfF1xOYg6NjyByV6VAw5ZjGz9FoF3GyUcc+8hNCDgm96vAUzB5lhj
         xG51yLjH1tKHX8dHbpP/v5RUP+jA/131uIz7DJ8CvZ4v18IOsg+dRqQRCM4vljGvuo1P
         KO5uVhfACKn8ho+X8BGIEJ97uxGNPXGS0QK0178M5XHKuApxkv0vcoGCW2vcmrnYtHRS
         B3XC0AdIqRZToPVGBaHKN1CRelXkE4+lQ7osw3gZJBIKseGF/qP7PJrhDlZ5WSFA8AuQ
         SV4EtA2BuoNNP8PXD1rEyAgl4BHh7qw7eT0yqjNYGi3vKu2TBIpsl7oPJftogyzPW4+H
         CiCA==
X-Forwarded-Encrypted: i=1; AJvYcCWP2Knz1UfMk6Zy4k2QJBuhuojhTlI7rCIU2srp1DIwauA15INgwRX4rHF+o9RXnMi2ZhI1Wp0sBQXmbWyiqA6SQE7u839v
X-Gm-Message-State: AOJu0YxL1TiFH6DofRKQe2NQtfy1ErNCrrqd+y4ERFXvNOPY7xo56cI6
	2SJYMhO/knTM+TquDbA5RBT8XmIDkeJJSIWGnMoeYh3g/OXYvbQljiNNkaX7T4jAwLeXoJQbvoR
	81Q==
X-Google-Smtp-Source: AGHT+IE3xCGxuoDABW3/KZUt4f7AaMn1Bp0SuK/C64OmLq4UAu763ExpBjweZKFQcIPU9hCc1uGSO1MbM30=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f773:f667:425:1c44])
 (user=surenb job=sendgmr) by 2002:a05:6902:2c07:b0:e02:e1c7:6943 with SMTP id
 3f1490d57ef6-e03c1b6806emr2887276.12.1720099510027; Thu, 04 Jul 2024 06:25:10
 -0700 (PDT)
Date: Thu,  4 Jul 2024 06:25:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704132506.1011978-1-surenb@google.com>
Subject: [PATCH v2 1/2] sched.h: always_inline alloc_tag_{save|restore} to fix
 modpost warnings
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, chris@zankel.net, jcmvbkbc@gmail.com, 
	kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com, 
	surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mark alloc_tag_{save|restore} as always_inline to fix the following
modpost warnings:

WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_save+0x1c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_restore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init.data)

The warnings happen when these functions are called from an __init
function and they don't get inlined (remain in the .text section) while
the value returned by get_current() points into .init.data section.
Assuming get_current() always returns a valid address, this situation can
happen only during init stage and accessing .init.data from .text section
during that stage should pose no issues.

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <stable@vger.kernel.org>
---

Changes since v1 [1]:
- Added the second patch to resolve follow-up warnings
- Expanded changelog description, per Andrew Morton
- CC'ed stable, per Andrew Morton
- Added Fixes tag, per Andrew Morton

[1] https://lore.kernel.org/all/20240703221520.4108464-1-surenb@google.com/

 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..a5f4b48fca18 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2192,13 +2192,13 @@ static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
+static __always_inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
 {
 	swap(current->alloc_tag, tag);
 	return tag;
 }
 
-static inline void alloc_tag_restore(struct alloc_tag *tag, struct alloc_tag *old)
+static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct alloc_tag *old)
 {
 #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
 	WARN(current->alloc_tag != tag, "current->alloc_tag was changed:\n");

base-commit: 795c58e4c7fc6163d8fb9f2baa86cfe898fa4b19
-- 
2.45.2.803.g4e1b14247a-goog


