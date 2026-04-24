Return-Path: <stable+bounces-241044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHLUExDc62kgSQAAu9opvQ
	(envelope-from <stable+bounces-241044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:09:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCB4636A3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDD89300827E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2833343C;
	Fri, 24 Apr 2026 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWxgBIsc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6465D31E84E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064973; cv=none; b=rW8Q+lI119+8AqmFc47yzZ2yj/1/mQ6Wt9GCa7AGI9TyMTIFTMfoo3J6UfjJzgzOCSFaeVRbuMxyHU3WWfIBc9rWeKSmjLJPNBv0y59RwDj3RBQ7T8mbHMU8iMCfp1iJXQkuQxvfpmnMbaytpu9K4e0Gjdy6/0RyNTAk8am8QrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064973; c=relaxed/simple;
	bh=apy8/SINRni6fY3RGZVaKtmHg8auqTSkE/w8aibATxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Do/yxvFQTGqeGJRWQ+ZrH7TuQxFAi7xuohWKsWY6mxsi983j680dF3TWcNPuisXEC5xHcy/6fhcdiuZXzKNpRQmFK0uTeCVXMGDgSRGabZXJEzbsWv/QrsKMPXQqLeyY32rHoYGaYgX1dkuhZvtqQ5yNPSm0Q1kKDuYRs4xNqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWxgBIsc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso57721635e9.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777064971; x=1777669771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3s/reOiow6cWcetSWjs5GiKOk/PJ/Crj+r1G//Avpjc=;
        b=TWxgBIsceFT9pFzwFF+y95mju8UySqmeJgJhTKyQIEnUMDvlPr2wi13Kh1O4wVJCgQ
         ok2bbm093Ct8hgplNZH1wzT3Dba2762qPVSo9V926KRSbT8jC0e0evjiAmAxdJ4oskda
         m5GiLbnClboyJ6SzLLQIpVpu76uZlt+38mgPw1YZ7BkGsHFJiaz0B9YfKEHbMLmH8LVu
         0PEriX+mRYe72dwNxspkIxlBZ1e9gZPc/Hud14nktxlNlFV/Qat15FchNXKsARR39s0A
         W+1NpA19+iz6xMZ8fS5oAWejY22tOEyJv1jubUn8xWAck/QJ086HMpLbCQLpCunRwIxW
         hzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064971; x=1777669771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s/reOiow6cWcetSWjs5GiKOk/PJ/Crj+r1G//Avpjc=;
        b=BaoIKAqMdNnhkTUHXBaxXe7TCa5ydDegZoU0k7UYRU0650+qXZ/eaSwngcxjr3RuJL
         4Xufiwg5sj+KNZ3o32e9op0yXy16qV6x9zWA1sQ8I4ugEc0iLc6Uo1OX0GWfk8sgFFTk
         QuLB3WLnX+xVNLh9gOm/67pB/4sHlVeNse3JV43dcHh/0aJqZa1FLxghLrF1PX1KIihS
         l3wdgzfwVPlY3klCOUxrNzscqhtl2xfKI4o9Ph60VRDhuOGLtu2AwaTU1raAQzJRDBcc
         pldcYIKTXY3UZS1Q2V/c5EhIX79VKfioM9R8JsuZn/rthE7S80IdUPbQqtqlyxe2329M
         3xsQ==
X-Gm-Message-State: AOJu0YzQHhBThXk0FhltbzBVy/47oLdprfHG7RwtffeyheXoJicw26IE
	jVQmETda5l10ZAVwlXa3rillbwmvSnSVQO5t4A3FR3H+3jM/1X2gOXVWuWLYjg==
X-Gm-Gg: AeBDieu7vi4n0uvrDoXF7qFHkQ1dGOdTbpAuNQ4i/rHeDkJcONlyw1tInjEig14jkEO
	GiqKFZOGZxGfpDdtt/SzYvpuoOMK0c8+QxXkI+yNXCH1AvZH25hl5tOGGl67qWM17oICIrGWS5J
	yq1Bgs+9PiwgYsPzcH3rDc7TxFoAuNC3CXW9Le3GNWfDvc+p7ddAykhCzN2d0K1zGqJAapahWQX
	7eR7gPYBC0tXBdpewirKl4+lbOErvv7AfkqyjtfDDSKx5sv9ZR1csxx50MWZgnZzPir2+bPwAUe
	Iq7mFCzKsWfjqm/QGMe6IFkrTRcubHlSjK8KQ1w+scH7WHyRjLVb+on4+QN93KVROvZme4AM8kF
	QdJWyZM9o+vVflgPBLjQaJWj8YzChYoz6M4/qiYqXo86N1bnOuLIIIezpJ2kfgeV9p5dSJl0Q+l
	6sn665Lyh5psnuwodAA/3x2shQvCI8Uw==
X-Received: by 2002:a05:600c:1907:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-489201cdf13mr298872305e9.12.1777064970549;
        Fri, 24 Apr 2026 14:09:30 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm555788615e9.8.2026.04.24.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:09:30 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: elaidya225@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.18.y v1 0/9] mm: backport sticky VMA flags and soft-dirty fix
Date: Sat, 25 Apr 2026 00:04:41 +0300
Message-ID: <20260424210518.1054497-1-elaidya225@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1CCB4636A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241044-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

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

