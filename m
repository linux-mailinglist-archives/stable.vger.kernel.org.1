Return-Path: <stable+bounces-132282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF1A862F3
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C8F19E7114
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9F218E92;
	Fri, 11 Apr 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="j/5jORBu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E73FB31
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387989; cv=none; b=ORzVFVe4irk8TnRIC89QummOZ+XMcAI3V7DUq62kAxG5vtbmzaA7gi0qDPMvCryJ29BjbGVMpSr4t/pMbjCRXd2tAQFIN/Gt5XgzM8MdXm39PqBQkERfYztQo1C7KHk2/U7LkKuwjGmOQaW50bfgUp+DDBrJngYfRJKcjNIcrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387989; c=relaxed/simple;
	bh=+gC8z4UJH97veYMwYoeY6/J/Ngqg8owzIO9SB83FbDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oap2Fjd96PkEfWHVHAnVseBPliybzZ+TFxQsB9R0CkXMUw+SY/V3gvjRpD4QqnGC7lPqH9GN5HoYKbHHgVYQioZYs66kho5PUu/ce4DaRAzf7MN6LW4TfYgilntYyhyujYDrPT5T1XElEhCW+aG+spDqJiFTaJxhMZzxv88A2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=j/5jORBu; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1744387987; x=1775923987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gwKqEszbc3Oly+UOxGiWGbS8Kdgnmp2rhyfRw4D0chU=;
  b=j/5jORBui7mO6mGHveteQlCh10cJjtlKUdZdz4+Ry4vrGdqnxYeTKots
   7MzteEHocuje1LMSDTZtBWq9GYsoAEPmWu21UGtLectcMIwl6uKMIfTL5
   MxjxYZdupUk3zy2mculbNbqsfJy2+8ZEpZdyU/cc+wMTkV3/HgMgSOR5P
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,205,1739836800"; 
   d="scan'208";a="479645128"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:13:03 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:62486]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.69:2525] with esmtp (Farcaster)
 id 9933ce2f-d718-4071-ac84-1dffe4ba212e; Fri, 11 Apr 2025 16:13:02 +0000 (UTC)
X-Farcaster-Flow-ID: 9933ce2f-d718-4071-ac84-1dffe4ba212e
Received: from EX19D023EUB003.ant.amazon.com (10.252.51.5) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 16:13:01 +0000
Received: from dev-dsk-dssauerw-1b-2c5f429c.eu-west-1.amazon.com
 (10.13.238.31) by EX19D023EUB003.ant.amazon.com (10.252.51.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14; Fri, 11 Apr 2025 16:12:58 +0000
From: David Sauerwein <dssauerw@amazon.de>
To: <stable@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>,
	<syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Sasha Levin <sashal@kernel.org>, David Sauerwein
	<dssauerw@amazon.de>
Subject: [PATCH 5.15.y] bpf: avoid holding freeze_mutex during mmap operation
Date: Fri, 11 Apr 2025 16:12:53 +0000
Message-ID: <20250411161253.11836-1-dssauerw@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D023EUB003.ant.amazon.com (10.252.51.5)

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit bc27c52eea189e8f7492d40739b7746d67b65beb ]

We use map->freeze_mutex to prevent races between map_freeze() and
memory mapping BPF map contents with writable permissions. The way we
naively do this means we'll hold freeze_mutex for entire duration of all
the mm and VMA manipulations, which is completely unnecessary. This can
potentially also lead to deadlocks, as reported by syzbot in [0].

So, instead, hold freeze_mutex only during writeability checks, bump
(proactively) "write active" count for the map, unlock the mutex and
proceed with mmap logic. And only if something went wrong during mmap
logic, then undo that "write active" counter increment.

  [0] https://lore.kernel.org/bpf/678dcbc9.050a0220.303755.0066.GAE@google.com/

Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250129012246.1515826-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: David Sauerwein <dssauerw@amazon.de>
---
 kernel/bpf/syscall.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7fce461eae10..6f309248f13f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -654,7 +654,7 @@ static const struct vm_operations_struct bpf_map_default_vmops = {
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
-	int err;
+	int err = 0;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
 	    map_value_has_timer(map))
@@ -679,7 +679,12 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 			err = -EACCES;
 			goto out;
 		}
+		bpf_map_write_active_inc(map);
 	}
+out:
+	mutex_unlock(&map->freeze_mutex);
+	if (err)
+		return err;
 
 	/* set default open/close callbacks */
 	vma->vm_ops = &bpf_map_default_vmops;
@@ -690,13 +695,11 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 		vma->vm_flags &= ~VM_MAYWRITE;
 
 	err = map->ops->map_mmap(map, vma);
-	if (err)
-		goto out;
+	if (err) {
+		if (vma->vm_flags & VM_WRITE)
+			bpf_map_write_active_dec(map);
+	}
 
-	if (vma->vm_flags & VM_MAYWRITE)
-		bpf_map_write_active_inc(map);
-out:
-	mutex_unlock(&map->freeze_mutex);
 	return err;
 }
 
-- 
2.47.1


