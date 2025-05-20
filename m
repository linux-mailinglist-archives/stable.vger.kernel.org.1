Return-Path: <stable+bounces-145034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DFABD20F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08041BA1FF6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3A4265CB5;
	Tue, 20 May 2025 08:33:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10E264A9F;
	Tue, 20 May 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730007; cv=none; b=ZAH1ItUQnWGCffIEOb2rPYIZvSUGyiafhYfit4xfuqfivMqIBlJ6yC4YrAzsQsU7NwJj1SxGs2H9O9uNCzO7AbF3d/MeqdcetelB3/IXYcnBVxiXa09uobRo/9DINdvjrTb+Mg8ddiVwowmN4fC5gxjXw7d5X6Z9o+48JUCcs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730007; c=relaxed/simple;
	bh=hFVptviLLsmn8W3CbUF9WSbHP56TiBXDUOrzasHZE3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DC++VR5F7YMlARLGQ/phy5frfMpudZfEaTGkddTxzQZrbKF7n413qvOv0BkGvEqZTk/w96VNzdCYGie87EODdGDdZvKrqi1DYUz+QntBSraIUNTRaXXYnT0FbONLu7gcud7s/aslp9flR+ztGui8dG1Xi9LeDbHmD1TLiDyqK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K55jWP009765;
	Tue, 20 May 2025 08:33:09 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46phe8ty6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 May 2025 08:33:09 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 20 May 2025 01:32:52 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 20 May 2025 01:32:48 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <atenart@kernel.org>, <kareemem@amazon.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5.10.y] net: decrease cached dst counters in dst_release
Date: Tue, 20 May 2025 16:33:04 +0800
Message-ID: <20250520083304.1956521-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CS04kR7QEL0BlePVkvi7GQsX-6nPLJOp
X-Proofpoint-ORIG-GUID: CS04kR7QEL0BlePVkvi7GQsX-6nPLJOp
X-Authority-Analysis: v=2.4 cv=arGyCTZV c=1 sm=1 tr=0 ts=682c3e45 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=RSTy8_7DnOH_di7dvoIA:9
 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2OSBTYWx0ZWRfXzcuY4bz4pykn rFGcMunDeJr9gpiL5HnvqKJypbm2I51iRtFnntrt6Zr8x+JEnrqIvR1T+JF1krGb5rd8t+Lo8UU oVr6L5+CgxskG0x0+eY6W8IVZaRjuspuPjpi2Ft3SJAIa0N9r/HNpFK+kXf6S9kIY54/rWeq84w
 64LcHpXgyVEUNxH8xTGXw/TgVZLNB5+jkOMaSKjHsaCc9QvEIkLT+33Kr4I2H7KJHMGbwPrLLiy Af7EVii5Qva/oVX68pS4CHfl2ZB/8EK16rx5MmFEhz0SHnh6WLasjH+UfT08vEG0yihw8KmIOSe m3cKulyn341ml/OrXrUZ9rS39+i7JeOucBmy2Ms60n3pDkjZkZIKV5rJ+Qt93a/68/LZLNA6UYO
 16MV9Ix/+3EHVc5ivmmPkTApfZ07NY/C59VkVdTf34cYCDT7lUEsRj9iinyWGC7FFGhLh0Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200069

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit 3a0a3ff6593d670af2451ec363ccb7b18aec0c0a ]

Upstream fix ac888d58869b ("net: do not delay dst_entries_add() in
dst_release()") moved decrementing the dst count from dst_destroy to
dst_release to avoid accessing already freed data in case of netns
dismantle. However in case CONFIG_DST_CACHE is enabled and OvS+tunnels
are used, this fix is incomplete as the same issue will be seen for
cached dsts:

  Unable to handle kernel paging request at virtual address ffff5aabf6b5c000
  Call trace:
   percpu_counter_add_batch+0x3c/0x160 (P)
   dst_release+0xec/0x108
   dst_cache_destroy+0x68/0xd8
   dst_destroy+0x13c/0x168
   dst_destroy_rcu+0x1c/0xb0
   rcu_do_batch+0x18c/0x7d0
   rcu_core+0x174/0x378
   rcu_core_si+0x18/0x30

Fix this by invalidating the cache, and thus decrementing cached dst
counters, in dst_release too.

Fixes: d71785ffc7e7 ("net: add dst_cache to ovs vxlan lwtunnel")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Link: https://patch.msgid.link/20250326173634.31096-1-atenart@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Minor conflict resolved due to code context change.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 net/core/dst.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dst.c b/net/core/dst.c
index 5bb143857336..e5d2ce95a2b6 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -175,6 +175,14 @@ void dst_release(struct dst_entry *dst)
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
 		if (!newrefcnt){
+#ifdef CONFIG_DST_CACHE
+			if (dst->flags & DST_METADATA) {
+				struct metadata_dst *md_dst = (struct metadata_dst *)dst;
+
+				if (md_dst->type == METADATA_IP_TUNNEL)
+					dst_cache_reset_now(&md_dst->u.tun_info.dst_cache);
+			}
+#endif
 			dst_count_dec(dst);
 			call_rcu(&dst->rcu_head, dst_destroy_rcu);
 		}
-- 
2.34.1


