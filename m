Return-Path: <stable+bounces-101127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A7F9EEA74
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F125028117A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35218217670;
	Thu, 12 Dec 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqmleTIG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC521765E;
	Thu, 12 Dec 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016455; cv=none; b=ikbbs6jYXYqjkzzeyUmsgKzK2fVzzUVOuW/pvrPNH4O0MqN3ix6bxAtAlEzff6qc5UrpvOEC7i02B1CThNq0gjEfZXwAA0JKyt8stVFK6kFLaQmpluISaWXHf/YWCj0+WuzKSHsSmPseK7flYQ4FZGWXeyT0lanT3smtozn7i0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016455; c=relaxed/simple;
	bh=qErvlU+RXXLiBDaly4SizXvz9rCPR6ZsOvCraZZCMxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpzd13lQpdMgtUTTL4eWZgdu6wLpqJpY14qoxscj1aSt9+scfauGjf3VMzZnodweCI80CLyGn/BXawfmBnLaNoyRbMC3xM8KsKRMIGicdPhqoEwD5kBszTuq/ULFdrZQdse0wV+gldbb6Bc2t8uHOjxuDDCO0mjU9g6T68e4x6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqmleTIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D287C4CED0;
	Thu, 12 Dec 2024 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016454;
	bh=qErvlU+RXXLiBDaly4SizXvz9rCPR6ZsOvCraZZCMxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqmleTIGY0ZqBGyBDAx0B8h/dbL4zsv07x1GyzAKA6YoqOL3+N1ArOWNQTMRJPg/b
	 RFNiT+Ys4JKysrnyFVjCh7K6YC6J6LKv8JZFpsS8Joca32MOqchMoE+zjz9GiCiZo3
	 zO94qJRtDOq53rqT2EJw3PApZwyaIN0c0x2reLYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Sperbeck <jsperbeck@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 204/466] mm: memcg: declare do_memsw_account inline
Date: Thu, 12 Dec 2024 15:56:13 +0100
Message-ID: <20241212144314.850136025@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Sperbeck <jsperbeck@google.com>

commit 89dd878282881306c38f7e354e7614fca98cb9a6 upstream.

In commit 66d60c428b23 ("mm: memcg: move legacy memcg event code into
memcontrol-v1.c"), the static do_memsw_account() function was moved from a
.c file to a .h file.  Unfortunately, the traditional inline keyword
wasn't added.  If a file (e.g., a unit test) includes the .h file, but
doesn't refer to do_memsw_account(), it will get a warning like:

mm/memcontrol-v1.h:41:13: warning: unused function 'do_memsw_account' [-Wunused-function]
   41 | static bool do_memsw_account(void)
      |             ^~~~~~~~~~~~~~~~

Link: https://lkml.kernel.org/r/20241128203959.726527-1-jsperbeck@google.com
Fixes: 66d60c428b23 ("mm: memcg: move legacy memcg event code into memcontrol-v1.c")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol-v1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 0e3b82951d91..144d71b65907 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -38,7 +38,7 @@ void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
 /* Whether legacy memory+swap accounting is active */
-static bool do_memsw_account(void)
+static inline bool do_memsw_account(void)
 {
 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
 }
-- 
2.47.1




