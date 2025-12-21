Return-Path: <stable+bounces-203172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C8CD4744
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 00:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1CF304280E
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 23:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D13285CA8;
	Sun, 21 Dec 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkc6uLGG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810C280A5C
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360201; cv=none; b=NdJ6hS8qPBTxyDMFsL++AnY6Lidl3AKVAehF4IBCPv1svWVDXHGK3bcoUVSjFnoPS5ynkzr6GdaF3rXX8ZK4H+O+fN5cQ4S0ZJxn21+QWRhIXS7oGp8bDeXZl689dOEHnyFNpYygjm3MtgEmLA/uA4ZBdJEXQpPn4c67kCax9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360201; c=relaxed/simple;
	bh=I7bpZx/fGX6q1NB4SWNPZld6CoQtIHxY+wfjKHVWqtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QriviSRLRMNjNsvwfybABZfAmrYaMP9817TKIBHgYEWrAMFzJH92yflt5zUKhb8+Jx0lEQelZqpuwdX6wsYXiSklpoebL132cdfDnhGtJAmlCBXz9BeO8h4vYL6Kk6LvQ1PEBAP+IC5FX62DCy+XSyymClf0eQvR7KnSslrRULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkc6uLGG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso9377333a91.0
        for <stable@vger.kernel.org>; Sun, 21 Dec 2025 15:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766360198; x=1766964998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/ZL/U7sLuVrIZUvVuD6ozi7k6Z6Ly5Yuo8mcDrUYr4=;
        b=lkc6uLGG1L5AHh2vYVq7MnAv7d9djYfHoBgquUQ77WwnFCUAWbH7JWSURcEHUUPkdq
         DfFBHGf0z9xR/QPa5LLb5KfXnqpb6Fl44d/GQGwbc+wnROnhjNL8R0thKXOq6VV8qPm7
         gH80sYvixqcMizmoOd0kV9PScxzGW1w7P3zZIoFX/tQ6DEjmtVjyfNRDOoDOzGR8ZmmU
         j5SvrWtgdLT19s1ehkKf6y76Noe5aHlbZGXQGNH+hmMbJj/yUebyjFyoOxYwU0FsvTzO
         udsOs7oVT/yu8IkkomzXrEZ5EvqRbCiOqLCt7zgIilHijxKuvt4X1zHsN4XOj1lsrmyY
         nxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766360199; x=1766964999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/ZL/U7sLuVrIZUvVuD6ozi7k6Z6Ly5Yuo8mcDrUYr4=;
        b=IgyHkaj2W4RPZOy13plNlgXmgh3cvCU+inYdtRtb2YptGlIAllIscP7SLaO+Z331b2
         tN/5gVArgMY++Px21l2urgUAyoj/id+Qm1/G/8oECvkKllCMACN4iUdjk6QtxCIvl7px
         qb5VlSxnaU9XeFDc+2+wd/Pi81RrO2vAAtkHBgKGWF/8nsqDcwxxV+JKuFgCeWAF+j+n
         uWEi54PuSFtfeWy5JNhgnAa0IpsulLRkW3F4Kfzxyua6lLc5sFMgY9yk26Hkegx1xwFS
         5BfoATReauPqOPTBgJKr3zHOtuHiEi/J8O4G7KFsG94HNKo0nhoipiD50E2jyUC3NJ6l
         43eA==
X-Forwarded-Encrypted: i=1; AJvYcCXGXyPwC+Eq++ePAesEr7nQ4yJA7Dd6vjaMcveqYzzclKTpucEH5lEejlHLutyde5jyD2sIBhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFhZNIQ8AjtOBFDXmenaG+Ixc2HwkMzapVUj/v9NdWaK4TouZ
	fi8yY7u/KUKwg5cDGbqniUAfYBlWWrxItQB8Dt2ra5BcICzATRLhYJ9YGkpLsXeV/l8dMP87p+B
	agmhbwbWd+uTIoA==
X-Google-Smtp-Source: AGHT+IFNZ+7Qz1Q6P/PmGGIYsIi2zzA+vh1m/QOlksmFymCij8EksYbFVSEHCVudpiyuUX8ENcyEAn/pbCN7kQ==
X-Received: from dlkk2.prod.google.com ([2002:a05:7022:6082:b0:121:7c06:d4b5])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:248c:b0:11b:3742:1257 with SMTP id a92af1059eb24-121722f63fdmr13386671c88.34.1766360198470;
 Sun, 21 Dec 2025 15:36:38 -0800 (PST)
Date: Sun, 21 Dec 2025 23:36:33 +0000
In-Reply-To: <20251220061022.2726028-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251220061022.2726028-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251221233635.3761887-1-bingjiao@google.com>
Subject: [PATCH v2 0/2] fix demotion targets checks in reclaim/demotion
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	akpm@linux-foundation.org, gourry@gourry.net, longman@redhat.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, cgroups@vger.kernel.org, Bing Jiao <bingjiao@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses two issues in demote_folio_list()
and can_demote() in reclaim/demotion.

Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
introduces the cpuset.mems_effective check and applies it to
can_demote(). However:

  1. It does not apply this check in demote_folio_list(), which leads
     to situations where pages are demoted to nodes that are
     explicitly excluded from the task's cpuset.mems.

  2. It checks only the nodes in the immediate next demotion hierarchy
     and does not check all allowed demotion targets in can_demote().
     This can cause pages to never be demoted if the nodes in the next
     demotion hierarchy are not set in mems_effective.

To address these bugs, implement a new function
mem_cgroup_filter_mems_allowed() to filter out nodes that are not
set in mems_effective, and update demote_folio_list() and can_demote()
accordingly.

Reproduct Bug 1:
  Assume a system with 4 nodes, where nodes 0-1 are top-tier and
  nodes 2-3 are far-tier memory. All nodes have equal capacity.

  Test script to reproduct:
    echo 1 > /sys/kernel/mm/numa/demotion_enabled
    mkdir /sys/fs/cgroup/test
    echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
    echo "0-2" > /sys/fs/cgroup/test/cpuset.mems
    echo $$ > /sys/fs/cgroup/test/cgroup.procs
    swapoff -a
    # Expectation: Should respect node 0-2 limit.
    # Observation: Node 3 shows significant allocation (MemFree drops)
    stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1

Reproduct Bug 2:
  Assume a system with 6 nodes, where nodes 0-2 are top-tier,
  node 3 is far-tier node, and nodes 4-5 are the farthest-tier nodes.
  All nodes have equal capacity.

  Test script:
    echo 1 > /sys/kernel/mm/numa/demotion_enabled
    mkdir /sys/fs/cgroup/test
    echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
    echo "0-2,4-5" > /sys/fs/cgroup/test/cpuset.mems
    echo $$ > /sys/fs/cgroup/test/cgroup.procs
    swapoff -a
    # Expectation: Pages are demoted to Nodes 4-5
    # Observation: No pages are demoted before oom.
    stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1,2

Bing Jiao (2):
  mm/vmscan: respect mems_effective in demote_folio_list()
  mm/vmscan: check all allowed targets in can_demote()

 include/linux/cpuset.h     |  6 +++---
 include/linux/memcontrol.h |  6 +++---
 kernel/cgroup/cpuset.c     | 12 +++++-------
 mm/memcontrol.c            |  5 +++--
 mm/vmscan.c                | 27 ++++++++++++++++++---------
 5 files changed, 32 insertions(+), 24 deletions(-)

--
2.52.0.351.gbe84eed79e-goog


