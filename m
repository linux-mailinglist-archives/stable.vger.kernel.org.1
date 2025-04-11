Return-Path: <stable+bounces-132281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C114A862F1
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A517A8F7E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A5215F56;
	Fri, 11 Apr 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="HzIctw+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047991401C
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387948; cv=none; b=NoEKcWEFBgzKuBY3BVrlQA66dPwkWKnSF/KwsuC98TLJ01fImXt6NPX5xfqUgACqAzag4RhjV/gmV9IadJyZDgqsR9RJBVKe8qTYNJjn8QTdnhqqPV8BUybpLLDV/p045oPDFvHQTWuw1ZRKpW+cM6WwfLQrf2uzJLd5KgJ3Ckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387948; c=relaxed/simple;
	bh=XrjCyKxMEk3ylaa2KhbRVDazCCNS8LHTZmXKR8x/gyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JwY5dVdwB0eUT50WN14JOhByxxwheVIW1wMbVV2Yvyn/0twZrZlPeyEzWWpk4ZF5itSJNNi4B8JHENew+s0TKgg4VcABoC8Oiyx71i0H2g7aJMpal44bHWQ185N4qjI1gQpK1g3nmi0FIP5/WWBWAokBsUsbPR8X0SeONGEtDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=HzIctw+e; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1744387947; x=1775923947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wpnUfcVrwv56vz4ATzCIKBkMSceSV1xaAPbgZYIzgsg=;
  b=HzIctw+e8eERDwW7BqZuAEaQFJdgzyK/nt+pg6dD1mmqBe09a9N1uPMX
   Cq03+KGjGJKTTXGAm8NQkAmOH2Q6hfuGOb75IJVJzBZPG2LyY+A+CsqQy
   4C7pJRc6RRm5u3OHcNWyhens6AnSzQeCKJtcws81K3rDbAs0NvSWDVWdM
   I=;
X-IronPort-AV: E=Sophos;i="6.15,205,1739836800"; 
   d="scan'208";a="9653479"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:12:18 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:44910]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.201:2525] with esmtp (Farcaster)
 id 54d0ed31-003c-45b9-8b77-7e59611a5583; Fri, 11 Apr 2025 16:12:17 +0000 (UTC)
X-Farcaster-Flow-ID: 54d0ed31-003c-45b9-8b77-7e59611a5583
Received: from EX19D023EUB003.ant.amazon.com (10.252.51.5) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 16:12:17 +0000
Received: from dev-dsk-dssauerw-1b-2c5f429c.eu-west-1.amazon.com
 (10.13.238.31) by EX19D023EUB003.ant.amazon.com (10.252.51.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14; Fri, 11 Apr 2025 16:12:14 +0000
From: David Sauerwein <dssauerw@amazon.de>
To: <stable@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>,
	<syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Sasha Levin <sashal@kernel.org>, David Sauerwein
	<dssauerw@amazon.de>
Subject: [PATCH 6.1.y] bpf: avoid holding freeze_mutex during mmap operation
Date: Fri, 11 Apr 2025 16:11:48 +0000
Message-ID: <20250411161148.10861-1-dssauerw@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
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
index 7a4004f09bae..27fdf1b2fc46 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -813,7 +813,7 @@ static const struct vm_operations_struct bpf_map_default_vmops = {
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
-	int err;
+	int err = 0;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
 	    map_value_has_timer(map) || map_value_has_kptrs(map))
@@ -838,7 +838,12 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
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
@@ -849,13 +854,11 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
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


