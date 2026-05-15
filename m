Return-Path: <stable+bounces-247747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFNaAgsaB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:05:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA455026E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019FC3181F8A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337448033B;
	Fri, 15 May 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4k5XFV4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596E47ECFB
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848983; cv=none; b=XsgqqchM596p7OHC9JvKCf3aKOpYbmeE4wvS3e7Rz1zzmcgh7wDe7Jb8OzuM3/MU6JZo5WEhMpdrw6QMdSx8gozbCnsXSEGp6wfFuhE8LmFQK6InIEZM1SvWrQwp8Fa7+29xUZrIvSPVSUDEHth6aZ3a5G2HWgOaOjg9C+vstRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848983; c=relaxed/simple;
	bh=vT3wegExwnA8eSdb2Hi+OaapAlrPds/fxFU+mKF0Ogw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCeNGYhnpfFXr3xV8rIZQsvxh8S23jU3uoN4y6hV9+uT9vcuD883wo5S2mQ7Hw/IWKTj5l4cqRBJn5YT1cTmConewnOsemcGuZcNZUxME7UXFw67ugvoZ5mQQQWKZiDMSzQ+EQhzOM+4DjGkgET1RHrcT48Lca6/ekZc2z9OJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4k5XFV4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so82690545e9.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848980; x=1779453780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z084uCbkFx59D3UMHm4ioLPaFQOLLB0xopC+MevdRJQ=;
        b=e4k5XFV4m1mnrVzRnqcUFDtwDzWtUy40AF9CHkb9VDwhXcaSY6aJHTOYucVnZcotgD
         0a/4I/3LUHop5HXFgXHkrV8OXBiXe8SkTptEfk+ZJhay1GfLh3/Y+gypjLsiYZZOu55P
         AaGoieIPqaKJKC6wRiMwg/v7NDimwVd4GootAzal7aIVWz0ylTtn/dpuoybE0HcVfQJN
         RGgvtrojtY9lbKJ3pY12GdQ7pSBwmgsFkCyW7Ff+LM88/ndx8zhi8cya7gl1+VSBCoNp
         MAanqMIC73lij6XVK2CVCjcJQPfA7R7BNmEdcECJnJUPUmmVO3j6flLT2yYQHqupck+r
         Pwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848980; x=1779453780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z084uCbkFx59D3UMHm4ioLPaFQOLLB0xopC+MevdRJQ=;
        b=f+nbxzTGpcwdsscyNIb1xbAww1PuM60iRIg4GSTx20vvwe6qHkFgPAfXSblwEnNU98
         TqzZ8Bu4JbwAuvp02/nNoegJphedO+FQOpkeUbSqM2Z9MX8htIV7/UBeSzDRP58a9hIY
         Ha0QwbkHTaZ/74DQm4zvUgP2OOboSoUh98V8abHVGLScnyKbCPHobG/EqE85ap6zTMIi
         IxFuZ7vNrWGqjYtMcEWBRVICmYJetHIDGZ3ku0ciKjr6sAGUHTxkASCy9wLm4W/cs2SD
         UXdBOVrYwDcrwD9pDlqskg5F7Jkt92oZ9EJ0sIP3EE4V/Uq2n6a/8MzhZpG/UhE3TPA4
         /Nzw==
X-Gm-Message-State: AOJu0Yzv1xnfKBDL++YIWRBBf3TdN6myiUtMVbWDYIRK/6NwfZrwwMNf
	78CcPDVKnk2CfMaLBYmAPr0Q6XFZEReIodTRhn//1D8OktrmWzB3gFft5gNNwA==
X-Gm-Gg: Acq92OHext99fcJ30rlRVrPNEsqTAd8IxZ9Y5cE5ez50spKV1lvDLOhyGa6lDViZOWz
	x9zruP1M+LcUhG8YlQ/elPtcQdzUOU6np9kj0gbKIc3TZ5hy0S+OalaOGiPhwjwO9lyit2Yppwt
	sxkQbuTfNw0kzEB2IghjiqK4JiMTJRcrY9R+WZYEtKhrYlHhyf0rW5/02V6V9NAGiUxtMuE8/WC
	K6Y/EHnR7Y1elfWC96NzMZEGhQOQ+os2SqYFYUtA/YidAReMqBoNRNQiba8YmWTGpZQ4glvGC6R
	85j6sUP3spkxhpzeHWgoTaeRMVSBqqxfWKqRV9Fv9BwFqMak0dhCQ75heU1gaziHYAwVrUAkSLS
	yTvrjFFAi223yJ8G0BD3CqvXCe07bJQzHWaz8kzJRiwShKv93Y9kZ0in9Wqlrr9JC3ae62ScKKb
	yUJ40A2BTJK7ex2Kim9lo=
X-Received: by 2002:a05:600c:4e43:b0:48f:e230:8cad with SMTP id 5b1f17b1804b1-48fe6632135mr48885025e9.33.1778848980288;
        Fri, 15 May 2026 05:43:00 -0700 (PDT)
Received: from fedora ([156.207.183.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm100188115e9.1.2026.05.15.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:42:59 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	avagin@gmail.com,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH 6.18.y v4 0/9] mm: backport sticky VMA flags and soft-dirty fix
Date: Fri, 15 May 2026 15:42:10 +0300
Message-ID: <20260515124218.151966-2-elaidya225@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80AA455026E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247747-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This series backports the sticky VMA flags infrastructure and the
VM_SOFTDIRTY-on-merge fix to linux-6.18.y.

Motivation: CRIU incremental dump/restore can hit a missing-parent-pagemap
failure when VM_SOFTDIRTY is lost during VMA merge operations.

Patch 8 is the target fix:
  mm: propagate VM_SOFTDIRTY on merge

The preceding patches provide required dependencies on 6.18.y and are included
to preserve upstream behavior, as requested by maintainers for stable backports.

Changes since v3:
  - Reverted to sending the full 9-patch series as requested by Greg KH and Lorenzo.
  - Updated Lorenzo's email to ljs@kernel.org across all patches.
  - Added Cc: stable@vger.kernel.org # 6.18.x to all patches.
  - Added Fixes tag for soft-dirty merging in Patch 8.

Lorenzo Stoakes (9):
  mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
  mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
  mm: update vma_modify_flags() to handle residual flags, document
  mm: implement sticky VMA flags
  mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
  mm: set the VM_MAYBE_GUARD flag on guard region install
  tools/testing/vma: add VMA sticky userland tests
  mm: propagate VM_SOFTDIRTY on merge
  testing/selftests/mm: add soft-dirty merge self-test

 Documentation/filesystems/proc.rst      |   5 +-
 fs/proc/task_mmu.c                      |   1 +
 include/linux/mm.h                      | 100 +++++++++++++++++
 include/trace/events/mmflags.h          |   1 +
 mm/khugepaged.c                         |  71 +++++++-----
 mm/madvise.c                            |  24 +++--
 mm/memory.c                             |  14 +--
 mm/mlock.c                              |   2 +-
 mm/mprotect.c                           |   2 +-
 mm/mseal.c                              |   7 +-
 mm/vma.c                                |  81 +++++++-------
 mm/vma.h                                | 138 +++++++++++++++++-------
 tools/testing/selftests/mm/soft-dirty.c | 127 +++++++++++++++++++++-
 tools/testing/vma/vma.c                 |  92 ++++++++++++++--
 tools/testing/vma/vma_internal.h        |  49 +++++++++
 15 files changed, 579 insertions(+), 135 deletions(-)

-- 
2.54.0


