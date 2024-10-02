Return-Path: <stable+bounces-80567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6869098DE99
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32211283773
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4F1D0DDF;
	Wed,  2 Oct 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g/mvt3Hm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CE1D0BAA
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882040; cv=none; b=EYPTjUecbfua/05ys88g1JgLQ3ZsClm199n4FrLeDYdr1e/c1rE21eoiYnePVHjUXmPF4lBiG+4LEPRKBztabtdLAtIXo3THo25qvbT04HGaBePr6aGvxw68EnQmBBUWxOu5PCwe5vHuZ/TjZqEpRJ/HRvz3GH3AcA5Ngp8QsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882040; c=relaxed/simple;
	bh=PNT5XTYbXIckXtjTicd4b850Ss6OcRw5Rkifql/ppL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mut7hDm+bZaPoStySVIB4ZbF+YPGdTTw5UqgpuS6jmhSZj2RX8gMQJNs7ii6Pop+4wkj5vkgO40NPdyuqmUuQbI5QNSP44M8TVD319r8ICOApM5uUAWD6eK1MMLlWr/S2sYduFGtqgwy3hsQxrzu95Y3G+uEojDakpqF8JIs5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g/mvt3Hm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd9Su016924;
	Wed, 2 Oct 2024 15:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Y
	ExqN19FIQsyzplezy0+BuI/uo4k89VEoqJwjv6q3t4=; b=g/mvt3HmoKUsIK658
	YqkHn8J/VRc6aGKxfhyZMCY4x2ZP1qYuasqa/h+okjlse3yZ4RCFMdB0BGmYWt4D
	PO2A5hO1kYMPH9zFpd09JI/GPrrV1v8JQqpiUFjbIw9wAqo4QfWinBFZ8+8WbhfR
	AB+IFN1YppNw178Tp55e1r1ierhjfyJluitxlBgC5EEez+F+Hq/IrLmCRKqPwBCV
	D+cZOrlFh90MF4D5D1Bb+oTS+J9C5Q0SO55Kkjg/pQokX3cY1sb6U9yDmgcAsqkl
	rLSLQKvn3FP+BPTrQMNrTe933RYXKHfHEExy3smXKiGGRv2WHeabVh7JoQXiQrcA
	dcdUg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt1n5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:13:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492F6pad028478;
	Wed, 2 Oct 2024 15:13:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8897avs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:13:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492FCqrb028673;
	Wed, 2 Oct 2024 15:13:46 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x88979xb-5;
	Wed, 02 Oct 2024 15:13:46 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Simon Horman <horms@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 15/15] net: stmmac: move the EST lock to struct stmmac_priv
Date: Wed,  2 Oct 2024 17:12:36 +0200
Message-Id: <20241002151236.11787-5-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002151236.11787-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002151236.11787-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020111
X-Proofpoint-GUID: 7PeWNHEj-PJbmdHoayBnpK2LI6Wl81ht
X-Proofpoint-ORIG-GUID: 7PeWNHEj-PJbmdHoayBnpK2LI6Wl81ht

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 36ac9e7f2e5786bd37c5cd91132e1f39c29b8197 ]

Reinitialize the whole EST structure would also reset the mutex
lock which is embedded in the EST structure, and then trigger
the following warning. To address this, move the lock to struct
stmmac_priv. We also need to reacquire the mutex lock when doing
this initialization.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
 Modules linked in:
 CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
 Hardware name: NXP i.MX8MPlus EVK board (DT)
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __mutex_lock+0xd84/0x1068
 lr : __mutex_lock+0xd84/0x1068
 sp : ffffffc0864e3570
 x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
 x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
 x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
 x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
 x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
 x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
 x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
 x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
 x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
 x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  __mutex_lock+0xd84/0x1068
  mutex_lock_nested+0x28/0x34
  tc_setup_taprio+0x118/0x68c
  stmmac_setup_tc+0x50/0xf0
  taprio_change+0x868/0xc9c

Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20240513014346.1718740-2-xiaolei.wang@windriver.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 36ac9e7f2e5786bd37c5cd91132e1f39c29b8197)
[Harshit: CVE-2024-38594; resolved conflicts due to missing commit:
 5ca63ffdb94b ("net: stmmac: Report taprio offload status") in 6.6.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
 include/linux/stmmac.h                         |  1 -
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b8c93b881a653..85a55f459af01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -248,6 +248,8 @@ struct stmmac_priv {
 	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
 	struct stmmac_safety_stats sstats;
 	struct plat_stmmacenet_data *plat;
+	/* Protect est parameters */
+	struct mutex est_lock;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3d7825cb30bb1..a04bb2e42c4ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -70,11 +70,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	/* If EST is enabled, disabled it before adjust ptp time. */
 	if (priv->plat->est && priv->plat->est->enable) {
 		est_rst = true;
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
@@ -87,7 +87,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		ktime_t current_time_ns, basetime;
 		u64 cycle_time;
 
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
 		time.tv_nsec = priv->plat->est->btr_reserve[0];
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->plat->est->enable = true;
 		ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 					   priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 77245f856dd0e..a11bb042db27e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -983,17 +983,19 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		if (!plat->est)
 			return -ENOMEM;
 
-		mutex_init(&priv->plat->est->lock);
+		mutex_init(&priv->est_lock);
 	} else {
+		mutex_lock(&priv->est_lock);
 		memset(plat->est, 0, sizeof(*plat->est));
+		mutex_unlock(&priv->est_lock);
 	}
 
 	size = qopt->num_entries;
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	priv->plat->est->gcl_size = size;
 	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
@@ -1024,7 +1026,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 	current_time_ns = timespec64_to_ktime(current_time);
@@ -1043,7 +1045,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	priv->plat->est->ctr[1] = (u32)ctr;
 
 	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
 
@@ -1054,7 +1056,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1071,11 +1073,11 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 disable:
 	if (priv->plat->est) {
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	priv->plat->fpe_cfg->enable = false;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 5acb77968902d..42ff5a4de8ee7 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -117,7 +117,6 @@ struct stmmac_axi {
 
 #define EST_GCL		1024
 struct stmmac_est {
-	struct mutex lock;
 	int enable;
 	u32 btr_reserve[2];
 	u32 btr_offset[2];
-- 
2.34.1


