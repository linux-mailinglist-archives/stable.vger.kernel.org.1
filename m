Return-Path: <stable+bounces-72955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73196ADF8
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 03:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E001C2123C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AA8479;
	Wed,  4 Sep 2024 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="WZdEwuis"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6A1EBFF0
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413772; cv=none; b=q7+/N739jZm7Ryk2kdvtv8ZlW8R3bEIER91Fkdae5CW3Jtea7uyU98M5Zx4FoQuyMOqPAzJEJfLKymBzHFsPDtOn/2GRDRSgwLyzr0RrMyi3XiMgKblkrqoZP3kV8zsgNKmPFh0owXd92g/nJPlO28sz1xbfdOX8W6DduwJ62ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413772; c=relaxed/simple;
	bh=vCoVxegwvh1xRHl64lK4GjpW/HoTxm0BccaCesNpYmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7uCteO5/U46X9cVDHcGsn59v2gfWeL1J59aOn/NTr9v1I0qSHXGd89vIpERui7haseV/oWBh2aTEGdLNv7kh8Rvy5M1mQv3cP7fgt/qzAHTR4GKT7O/kWvojVLjgII5uMxkqguF0Jdl7tvX0IhvbmVuK0pjWcEZ/ezpVp80ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=WZdEwuis; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483JXpxU006221;
	Wed, 4 Sep 2024 01:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=GFsoBJHphipjg
	3YDPcmzvBcQjOGZ5+LTJ1CO28E3OdI=; b=WZdEwuistKoFKnJoLOvukB0YoHhVg
	0+tVjFh33eiLXGxEShJgq0tyPkGrAhKl26ewOW0+FeYTSDAUxMsOIDYR+yJKvhko
	VZmfTYtRzoZ6kGe+yjhKuxpam78gifEYsTXGFzegKl709AC+0xSDQ6lnoKhf6ZJu
	dGE/Fc5QgbzwkNnqrBx7Z7Xdb5zaYb6QBay58+LMQiQi4izqeMNVfV+0p3J3+9/j
	MLXV4jPt6ABbSC3+HBxnpb92/i+ml0odWvszHnw7qAI9nv1sSTvDXCsq0N6woCBL
	/F/YVPxhtc/u0vL3EQxeTbB5Ej9uPfbFI5kWEgf+SuAqKIwf/JNPfczAA==
Received: from 04wpexch11.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 41e7w50vu3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 01:29:00 +0000 (GMT)
Received: from ML-C02GH20XMD6T.crowdstrike.sys (10.100.11.122) by
 04WPEXCH11.crowdstrike.sys (10.100.11.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:28:58 +0000
From: Connor O'Brien <connor.obrien@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <martin.kelly@crowdstrike.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Connor O'Brien <connor.obrien@crowdstrike.com>
Subject: [PATCH 1/2] bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode
Date: Tue, 3 Sep 2024 18:28:50 -0700
Message-ID: <20240904012851.58167-1-connor.obrien@crowdstrike.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH10.crowdstrike.sys (10.100.11.114) To
 04WPEXCH11.crowdstrike.sys (10.100.11.115)
X-Disclaimer: USA
X-Proofpoint-GUID: DjeD_4Js8EIJpiaRwOhBK3MAvLpqDhH4
X-Authority-Analysis: v=2.4 cv=WsB5Msfv c=1 sm=1 tr=0 ts=66d7b7dc cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=EjBHVkixTFsA:10 a=EaEq8P2WXUwA:10 a=hWMQpYRtAAAA:8 a=NEAV23lmAAAA:8 a=aPlHU-BSAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=pl6vuDidAAAA:8 a=qzKVyHLyrWJ79ptqYHEA:9 a=KCsI-UfzjElwHeZNREa_:22 a=PUeqMozfM-10x8LD7Utv:22
X-Proofpoint-ORIG-GUID: DjeD_4Js8EIJpiaRwOhBK3MAvLpqDhH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_13,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1011 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040009

From: Daniel Borkmann <daniel@iogearbox.net>

commit 8520e224f547cd070c7c8f97b1fc6d58cff7ccaa upstream.

Fix cgroup v1 interference when non-root cgroup v2 BPF programs are used.
Back in the days, commit bd1060a1d671 ("sock, cgroup: add sock->sk_cgroup")
embedded per-socket cgroup information into sock->sk_cgrp_data and in order
to save 8 bytes in struct sock made both mutually exclusive, that is, when
cgroup v1 socket tagging (e.g. net_cls/net_prio) is used, then cgroup v2
falls back to the root cgroup in sock_cgroup_ptr() (&cgrp_dfl_root.cgrp).

The assumption made was "there is no reason to mix the two and this is in line
with how legacy and v2 compatibility is handled" as stated in bd1060a1d671.
However, with Kubernetes more widely supporting cgroups v2 as well nowadays,
this assumption no longer holds, and the possibility of the v1/v2 mixed mode
with the v2 root fallback being hit becomes a real security issue.

Many of the cgroup v2 BPF programs are also used for policy enforcement, just
to pick _one_ example, that is, to programmatically deny socket related system
calls like connect(2) or bind(2). A v2 root fallback would implicitly cause
a policy bypass for the affected Pods.

In production environments, we have recently seen this case due to various
circumstances: i) a different 3rd party agent and/or ii) a container runtime
such as [0] in the user's environment configuring legacy cgroup v1 net_cls
tags, which triggered implicitly mentioned root fallback. Another case is
Kubernetes projects like kind [1] which create Kubernetes nodes in a container
and also add cgroup namespaces to the mix, meaning programs which are attached
to the cgroup v2 root of the cgroup namespace get attached to a non-root
cgroup v2 path from init namespace point of view. And the latter's root is
out of reach for agents on a kind Kubernetes node to configure. Meaning, any
entity on the node setting cgroup v1 net_cls tag will trigger the bypass
despite cgroup v2 BPF programs attached to the namespace root.

Generally, this mutual exclusiveness does not hold anymore in today's user
environments and makes cgroup v2 usage from BPF side fragile and unreliable.
This fix adds proper struct cgroup pointer for the cgroup v2 case to struct
sock_cgroup_data in order to address these issues; this implicitly also fixes
the tradeoffs being made back then with regards to races and refcount leaks
as stated in bd1060a1d671, and removes the fallback, so that cgroup v2 BPF
programs always operate as expected.

  [0] https://github.com/nestybox/sysbox/
  [1] https://kind.sigs.k8s.io/

Fixes: bd1060a1d671 ("sock, cgroup: add sock->sk_cgroup")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/bpf/20210913230759.2313-1-daniel@iogearbox.net
[resolve trivial conflicts]
Signed-off-by: Connor O'Brien <connor.obrien@crowdstrike.com>
---

Hello,

Requesting that these patches be applied to 5.10-stable. Tested to confirm that
the cgroup_v1v2 bpf selftest for this issue passes on 5.10 with the first patch
applied and fails without it. The syzkaller crash referenced in the second patch
reproduces on 5.10 after applying just the first patch, but not with both
patches applied.

Conflicts were due to unrelated changes to the surrounding context; the actual
code change remains the same as in the upstream patch.

Thanks,
Connor O'Brien

 include/linux/cgroup-defs.h  | 107 +++++++++--------------------------
 include/linux/cgroup.h       |  22 +------
 kernel/cgroup/cgroup.c       |  50 ++++------------
 net/core/netclassid_cgroup.c |   7 +--
 net/core/netprio_cgroup.c    |  10 +---
 5 files changed, 41 insertions(+), 155 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c9fafca1c30c..6c6323a01d43 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -764,107 +764,54 @@ static inline void cgroup_threadgroup_change_end(struct task_struct *tsk) {}
  * sock_cgroup_data is embedded at sock->sk_cgrp_data and contains
  * per-socket cgroup information except for memcg association.
  *
- * On legacy hierarchies, net_prio and net_cls controllers directly set
- * attributes on each sock which can then be tested by the network layer.
- * On the default hierarchy, each sock is associated with the cgroup it was
- * created in and the networking layer can match the cgroup directly.
- *
- * To avoid carrying all three cgroup related fields separately in sock,
- * sock_cgroup_data overloads (prioidx, classid) and the cgroup pointer.
- * On boot, sock_cgroup_data records the cgroup that the sock was created
- * in so that cgroup2 matches can be made; however, once either net_prio or
- * net_cls starts being used, the area is overriden to carry prioidx and/or
- * classid.  The two modes are distinguished by whether the lowest bit is
- * set.  Clear bit indicates cgroup pointer while set bit prioidx and
- * classid.
- *
- * While userland may start using net_prio or net_cls at any time, once
- * either is used, cgroup2 matching no longer works.  There is no reason to
- * mix the two and this is in line with how legacy and v2 compatibility is
- * handled.  On mode switch, cgroup references which are already being
- * pointed to by socks may be leaked.  While this can be remedied by adding
- * synchronization around sock_cgroup_data, given that the number of leaked
- * cgroups is bound and highly unlikely to be high, this seems to be the
- * better trade-off.
+ * On legacy hierarchies, net_prio and net_cls controllers directly
+ * set attributes on each sock which can then be tested by the network
+ * layer. On the default hierarchy, each sock is associated with the
+ * cgroup it was created in and the networking layer can match the
+ * cgroup directly.
  */
 struct sock_cgroup_data {
-	union {
-#ifdef __LITTLE_ENDIAN
-		struct {
-			u8	is_data : 1;
-			u8	no_refcnt : 1;
-			u8	unused : 6;
-			u8	padding;
-			u16	prioidx;
-			u32	classid;
-		} __packed;
-#else
-		struct {
-			u32	classid;
-			u16	prioidx;
-			u8	padding;
-			u8	unused : 6;
-			u8	no_refcnt : 1;
-			u8	is_data : 1;
-		} __packed;
+	struct cgroup	*cgroup; /* v2 */
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	u32		classid; /* v1 */
+#endif
+#ifdef CONFIG_CGROUP_NET_PRIO
+	u16		prioidx; /* v1 */
 #endif
-		u64		val;
-	};
 };
 
-/*
- * There's a theoretical window where the following accessors race with
- * updaters and return part of the previous pointer as the prioidx or
- * classid.  Such races are short-lived and the result isn't critical.
- */
 static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data *skcd)
 {
-	/* fallback to 1 which is always the ID of the root cgroup */
-	return (skcd->is_data & 1) ? skcd->prioidx : 1;
+#ifdef CONFIG_CGROUP_NET_PRIO
+	return READ_ONCE(skcd->prioidx);
+#else
+	return 1;
+#endif
 }
 
 static inline u32 sock_cgroup_classid(const struct sock_cgroup_data *skcd)
 {
-	/* fallback to 0 which is the unconfigured default classid */
-	return (skcd->is_data & 1) ? skcd->classid : 0;
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	return READ_ONCE(skcd->classid);
+#else
+	return 0;
+#endif
 }
 
-/*
- * If invoked concurrently, the updaters may clobber each other.  The
- * caller is responsible for synchronization.
- */
 static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
 					   u16 prioidx)
 {
-	struct sock_cgroup_data skcd_buf = {{ .val = READ_ONCE(skcd->val) }};
-
-	if (sock_cgroup_prioidx(&skcd_buf) == prioidx)
-		return;
-
-	if (!(skcd_buf.is_data & 1)) {
-		skcd_buf.val = 0;
-		skcd_buf.is_data = 1;
-	}
-
-	skcd_buf.prioidx = prioidx;
-	WRITE_ONCE(skcd->val, skcd_buf.val);	/* see sock_cgroup_ptr() */
+#ifdef CONFIG_CGROUP_NET_PRIO
+	WRITE_ONCE(skcd->prioidx, prioidx);
+#endif
 }
 
 static inline void sock_cgroup_set_classid(struct sock_cgroup_data *skcd,
 					   u32 classid)
 {
-	struct sock_cgroup_data skcd_buf = {{ .val = READ_ONCE(skcd->val) }};
-
-	if (sock_cgroup_classid(&skcd_buf) == classid)
-		return;
-
-	if (!(skcd_buf.is_data & 1)) {
-		skcd_buf.val = 0;
-		skcd_buf.is_data = 1;
-	}
-
-	skcd_buf.classid = classid;
-	WRITE_ONCE(skcd->val, skcd_buf.val);	/* see sock_cgroup_ptr() */
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	WRITE_ONCE(skcd->classid, classid);
+#endif
 }
 
 #else	/* CONFIG_SOCK_CGROUP_DATA */
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c9c430712d47..15c27a2c98e2 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -816,33 +816,13 @@ static inline void cgroup_account_cputime_field(struct task_struct *task,
  */
 #ifdef CONFIG_SOCK_CGROUP_DATA
 
-#if defined(CONFIG_CGROUP_NET_PRIO) || defined(CONFIG_CGROUP_NET_CLASSID)
-extern spinlock_t cgroup_sk_update_lock;
-#endif
-
-void cgroup_sk_alloc_disable(void);
 void cgroup_sk_alloc(struct sock_cgroup_data *skcd);
 void cgroup_sk_clone(struct sock_cgroup_data *skcd);
 void cgroup_sk_free(struct sock_cgroup_data *skcd);
 
 static inline struct cgroup *sock_cgroup_ptr(struct sock_cgroup_data *skcd)
 {
-#if defined(CONFIG_CGROUP_NET_PRIO) || defined(CONFIG_CGROUP_NET_CLASSID)
-	unsigned long v;
-
-	/*
-	 * @skcd->val is 64bit but the following is safe on 32bit too as we
-	 * just need the lower ulong to be written and read atomically.
-	 */
-	v = READ_ONCE(skcd->val);
-
-	if (v & 3)
-		return &cgrp_dfl_root.cgrp;
-
-	return (struct cgroup *)(unsigned long)v ?: &cgrp_dfl_root.cgrp;
-#else
-	return (struct cgroup *)(unsigned long)skcd->val;
-#endif
+	return skcd->cgroup;
 }
 
 #else	/* CONFIG_CGROUP_DATA */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 11400eba6124..3ec531ef50d8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6557,74 +6557,44 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
  */
 #ifdef CONFIG_SOCK_CGROUP_DATA
 
-#if defined(CONFIG_CGROUP_NET_PRIO) || defined(CONFIG_CGROUP_NET_CLASSID)
-
-DEFINE_SPINLOCK(cgroup_sk_update_lock);
-static bool cgroup_sk_alloc_disabled __read_mostly;
-
-void cgroup_sk_alloc_disable(void)
-{
-	if (cgroup_sk_alloc_disabled)
-		return;
-	pr_info("cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation\n");
-	cgroup_sk_alloc_disabled = true;
-}
-
-#else
-
-#define cgroup_sk_alloc_disabled	false
-
-#endif
-
 void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 {
-	if (cgroup_sk_alloc_disabled) {
-		skcd->no_refcnt = 1;
-		return;
-	}
-
 	/* Don't associate the sock with unrelated interrupted task's cgroup. */
 	if (in_interrupt())
 		return;
 
 	rcu_read_lock();
-
 	while (true) {
 		struct css_set *cset;
 
 		cset = task_css_set(current);
 		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
-			skcd->val = (unsigned long)cset->dfl_cgrp;
+			skcd->cgroup = cset->dfl_cgrp;
 			cgroup_bpf_get(cset->dfl_cgrp);
 			break;
 		}
 		cpu_relax();
 	}
-
 	rcu_read_unlock();
 }
 
 void cgroup_sk_clone(struct sock_cgroup_data *skcd)
 {
-	if (skcd->val) {
-		if (skcd->no_refcnt)
-			return;
-		/*
-		 * We might be cloning a socket which is left in an empty
-		 * cgroup and the cgroup might have already been rmdir'd.
-		 * Don't use cgroup_get_live().
-		 */
-		cgroup_get(sock_cgroup_ptr(skcd));
-		cgroup_bpf_get(sock_cgroup_ptr(skcd));
-	}
+	struct cgroup *cgrp = sock_cgroup_ptr(skcd);
+
+	/*
+	 * We might be cloning a socket which is left in an empty
+	 * cgroup and the cgroup might have already been rmdir'd.
+	 * Don't use cgroup_get_live().
+	 */
+	cgroup_get(cgrp);
+	cgroup_bpf_get(cgrp);
 }
 
 void cgroup_sk_free(struct sock_cgroup_data *skcd)
 {
 	struct cgroup *cgrp = sock_cgroup_ptr(skcd);
 
-	if (skcd->no_refcnt)
-		return;
 	cgroup_bpf_put(cgrp);
 	cgroup_put(cgrp);
 }
diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index 41b24cd31562..b6de5ee22391 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -72,11 +72,8 @@ static int update_classid_sock(const void *v, struct file *file, unsigned n)
 	struct update_classid_context *ctx = (void *)v;
 	struct socket *sock = sock_from_file(file, &err);
 
-	if (sock) {
-		spin_lock(&cgroup_sk_update_lock);
+	if (sock)
 		sock_cgroup_set_classid(&sock->sk->sk_cgrp_data, ctx->classid);
-		spin_unlock(&cgroup_sk_update_lock);
-	}
 	if (--ctx->batch == 0) {
 		ctx->batch = UPDATE_CLASSID_BATCH;
 		return n + 1;
@@ -122,8 +119,6 @@ static int write_classid(struct cgroup_subsys_state *css, struct cftype *cft,
 	struct css_task_iter it;
 	struct task_struct *p;
 
-	cgroup_sk_alloc_disable();
-
 	cs->classid = (u32)value;
 
 	css_task_iter_start(css, 0, &it);
diff --git a/net/core/netprio_cgroup.c b/net/core/netprio_cgroup.c
index 9bd4cab7d510..d4c71e382a13 100644
--- a/net/core/netprio_cgroup.c
+++ b/net/core/netprio_cgroup.c
@@ -207,8 +207,6 @@ static ssize_t write_priomap(struct kernfs_open_file *of,
 	if (!dev)
 		return -ENODEV;
 
-	cgroup_sk_alloc_disable();
-
 	rtnl_lock();
 
 	ret = netprio_set_prio(of_css(of), dev, prio);
@@ -222,12 +220,10 @@ static int update_netprio(const void *v, struct file *file, unsigned n)
 {
 	int err;
 	struct socket *sock = sock_from_file(file, &err);
-	if (sock) {
-		spin_lock(&cgroup_sk_update_lock);
+
+	if (sock)
 		sock_cgroup_set_prioidx(&sock->sk->sk_cgrp_data,
 					(unsigned long)v);
-		spin_unlock(&cgroup_sk_update_lock);
-	}
 	return 0;
 }
 
@@ -236,8 +232,6 @@ static void net_prio_attach(struct cgroup_taskset *tset)
 	struct task_struct *p;
 	struct cgroup_subsys_state *css;
 
-	cgroup_sk_alloc_disable();
-
 	cgroup_taskset_for_each(p, css, tset) {
 		void *v = (void *)(unsigned long)css->id;
 
-- 
2.34.1


