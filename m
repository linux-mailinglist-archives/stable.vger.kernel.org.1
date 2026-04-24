Return-Path: <stable+bounces-241045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH2dJAzd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6224636D7
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB89330063A1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD143368A2;
	Fri, 24 Apr 2026 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzoHvBR8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B152DD60E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065209; cv=none; b=PJRme2QDijvjqUXxd42Ss+aKXO+tDeuoxu/Sg0S9W6q/YLDVVTvM8klnWkkFpBICN+VzpkT++hkJFvH5+aEuDgcX/yhe5ulxpP/9t+79OLYhghI+v9JCV61BfxbXXZ8fLKal6mbauqBKhNB36TJxjg/qnT0RG6NpQ8Aj2WPrmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065209; c=relaxed/simple;
	bh=apy8/SINRni6fY3RGZVaKtmHg8auqTSkE/w8aibATxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvygfyXSYaKOlLVeAlQrlpnq4G4XmQRxL3eAmlDqLTt3icoKDpV2haoHgeuVy/uATtA5S6zJR/Zs4Bh8vZvkO6wS+NO5doa9W2UOcyLcYtJSTQCy2aezw77n346MzbKwslSaPeZiM2DdI/I64tr28LKxXvcefAT6SXDgFLKY/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzoHvBR8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d73352cf2so6787741f8f.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065206; x=1777670006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3s/reOiow6cWcetSWjs5GiKOk/PJ/Crj+r1G//Avpjc=;
        b=lzoHvBR8XhGGkBkITwlxmvS2AOy45GrNPOU52baO47L9DVTojIoSMlduZd3cSgZh3R
         SbqO+5aDdU4dJaqwsh9A8z7FkWrCyxtE8QvfwZB3q0+mDyWHNFMwk3/wozirlar4fBxM
         CErxDga7XPx+JnyEhdV0vheVC1ZudE28PxG9cfDd42GRr3MMMCKcJfDL3o+U2pBVKkOj
         6wlgZHzFcZ9LEZOYLK7482y9GSYiRTuspbfVcUiCIGnMhREKuL69zPTH9pypMvmG2dHv
         wyKgoPC1zEIigw11LsnSQny0ouW1FYWPDhvGVA9V9rWatAZKmf/NK1sFs/T+mlTEQ29c
         JT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065206; x=1777670006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s/reOiow6cWcetSWjs5GiKOk/PJ/Crj+r1G//Avpjc=;
        b=mcrpvRUPdg1arEbr0c4ooEsvax94cgmTDzr5p3JC8hoEIxagQbrqpTLVnMRGbFLGuk
         fDN1q1dt8kpD+D0oT8ew6Vn5AsBmX13YBDS0p8GEtIPGyRshNB+qcp4LC4R9oUL7Nqoq
         Gr/+t07/PEIQgSXORA2Qak00uSwCmBBAbqm6UIRZhMuMZLAmRD1sNM+z5AM4d1d/NBo8
         pqEDniMzfV5fkMxRHbSs2Q7HGGDHHcXxNWAZJEuznBcgejM765Ug5FVmBMzBnVEEI3Oc
         P5GIeGbf2LZVhzvTE/rAmbDfkbMGy3N/7J+9PiJ+R7XEnHS4DFjMRFKoN5dm29poKZNB
         W4PQ==
X-Gm-Message-State: AOJu0YzZP5cF7vI5mTTHMvPeXE3btoVZF/rrnICdlenKV/jYrIq5oQcD
	pZSPCtb/59lfJIGPoAEcRmFMM+tYmIbPOQjsgeNfO8eP2axA48rTv3tUCmigvWMk
X-Gm-Gg: AeBDietLeyoXPE43G9dDGUHlSgjS9Abc0CvCLbZqKP7p6m3dPaq72AwuTThk4h4OwFT
	Hy0hT2vkdpO1OCNrYypU0i3/HjmFDoE8ozzeu92M9zSRqBDddsAk8Xwiitiz0b9Q3tIoqU3JB5I
	dXH+XUxlUFOcr0xaoykTVqABW71VDHHEOmnbH3J2lsg8N1fHYf+da5itNu/4PT8lbu2hQHQ5KEL
	7O8dgbs2ZPd8t3Fjj7QGoukW0wE6fqyhWcTtLnxMuPyhJqWDpRuegfxtSpx8JhvKYJ1/UxjdQfF
	ysOFWlF/jrH1IrZYWf5g+SulW4nBRY2EMbPmUhS4MUIKNo/yOUWKqLyDbjqvSMO0LKpOLzeObKD
	JLvpw6YLVCkDY/MJqxEoJTdhyk5AUB8ldQz8Uf2uMW7OlvZaQ6GeMH21o0VcrO7GLt4dzXDjz0n
	3BaOB1mYjPOVjQXZouR8AhTM/QpOTz+Q==
X-Received: by 2002:a05:6000:2508:b0:43d:7e6f:3816 with SMTP id ffacd0b85a97d-43fe3e14ecbmr50458410f8f.40.1777065205591;
        Fri, 24 Apr 2026 14:13:25 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:25 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH 6.18.y v1 0/9] mm: backport sticky VMA flags and soft-dirty fix
Date: Sat, 25 Apr 2026 00:12:34 +0300
Message-ID: <20260424211315.1072123-1-elaidya225@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED6224636D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-241045-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series backports the sticky VMA flags infrastructure and the
VM_SOFTDIRTY-on-merge fix to linux-6.18.y.

Motivation: CRIU incremental dump/restore can hit a missing-parent-pagemap
failure when VM_SOFTDIRTY is lost during VMA merge operations.

Patch 8 is the target fix:
  mm: propagate VM_SOFTDIRTY on merge

The preceding patches provide required dependencies on 6.18.y and are included
to preserve upstream behavior.

Backport notes:
  - Non-trivial context conflicts were resolved in:
    - mm/mseal.c
    - mm/vma.c
  - Conflict resolution keeps upstream semantics; no intentional behavior
    changes beyond context adaptation for 6.18.y.

Cc: stable@vger.kernel.org



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
2.53.0

