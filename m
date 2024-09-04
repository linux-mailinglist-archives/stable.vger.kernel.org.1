Return-Path: <stable+bounces-72956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8E96ADF9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 03:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9D1285FB5
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1A6FB0;
	Wed,  4 Sep 2024 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="GsDDrd+5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4B8479
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413795; cv=none; b=ZJ4D0EwwiM3OZYQL1wJ3ywqJ+xc05cM4wnF0M0TxFqB+a6tEEo7P8F6pdAMlhtKji3pDZAmwWvpnnfuKGDRdDkyt9wlf4KCl0enhYKbdl18pVln30qFbIuG/baK4k4Aop03oodCL5t+Ac8LMcHtPBNgwyTnX6SxEdOT+dAJBZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413795; c=relaxed/simple;
	bh=zHHvZmcMv00yY0KE39YJMpHuOM78kgXNZQpVGvUZJkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xnz3WKna6T5eOXvVs1zty8Jri2A6TKuRPEHxAEPD/VlKGkMMC8M1xi63Q/T6l6sf6IHq47zJQEjSDkVAk5FE7wcnaAqQ+nQRT5rJffpAzZp9PPpt+kgusmFeaBSet0pLEg8Wykt9XxciT+neVj9cBNcuOcUxpaFwEBQN/yO9N2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=GsDDrd+5; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483JXpxV006221;
	Wed, 4 Sep 2024 01:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=NkEu+/4kUWon8voBshuqljE2zGGqia5XddDiDOdQUUA=; b=GsDD
	rd+5ORIWQTQHQoNmA8ygAOdtk4yOZcNWq+v4oRcNeIhk1RwPh80Bh5PW4dUkmrax
	//X6yVnbzvbIIJYpBEcxt8dMYgTA02FL5+v/5tDLCY6nJMMxyXzqYVjzlFxvGtzj
	7He+MI1rwlqj6kAtT+NctqZ6U3YbibDUYpYUD0mGnxBg/UY7r3PTe3mIP1pns5t8
	ZnG3pFqL5Xd2y2yzYVQ2YtCQ0kOy+Db5LGLpy7vznYJUVdBBubMN45X2oNRPZySg
	p/eTGUpMJU1BS0i47K9Hvyd57XvUCRRnwJgd/qXvdVOPeT/Cm5wQCeCEqwl0Q9Bk
	XoI4SY8xyRYcSNoIkg==
Received: from 04wpexch11.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 41e7w50vu3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 01:29:01 +0000 (GMT)
Received: from ML-C02GH20XMD6T.crowdstrike.sys (10.100.11.122) by
 04WPEXCH11.crowdstrike.sys (10.100.11.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:28:59 +0000
From: Connor O'Brien <connor.obrien@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <martin.kelly@crowdstrike.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Connor O'Brien <connor.obrien@crowdstrike.com>
Subject: [PATCH 2/2] bpf, cgroup: Assign cgroup in cgroup_sk_alloc when called from interrupt
Date: Tue, 3 Sep 2024 18:28:51 -0700
Message-ID: <20240904012851.58167-2-connor.obrien@crowdstrike.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904012851.58167-1-connor.obrien@crowdstrike.com>
References: <20240904012851.58167-1-connor.obrien@crowdstrike.com>
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
X-Proofpoint-GUID: A4TEYFVwtklPfKyfnwfR-J0V8uKlmiZK
X-Authority-Analysis: v=2.4 cv=WsB5Msfv c=1 sm=1 tr=0 ts=66d7b7dd cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=EjBHVkixTFsA:10 a=EaEq8P2WXUwA:10 a=hWMQpYRtAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8
 a=2z9DCgBl_GFp3FPknVMA:9 a=KCsI-UfzjElwHeZNREa_:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: A4TEYFVwtklPfKyfnwfR-J0V8uKlmiZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_13,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=778 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040009

From: Daniel Borkmann <daniel@iogearbox.net>

commit 78cc316e9583067884eb8bd154301dc1e9ee945c upstream.

If cgroup_sk_alloc() is called from interrupt context, then just assign the
root cgroup to skcd->cgroup. Prior to commit 8520e224f547 ("bpf, cgroups:
Fix cgroup v2 fallback on v1/v2 mixed mode") we would just return, and later
on in sock_cgroup_ptr(), we were NULL-testing the cgroup in fast-path, and
iff indeed NULL returning the root cgroup (v ?: &cgrp_dfl_root.cgrp). Rather
than re-adding the NULL-test to the fast-path we can just assign it once from
cgroup_sk_alloc() given v1/v2 handling has been simplified. The migration from
NULL test with returning &cgrp_dfl_root.cgrp to assigning &cgrp_dfl_root.cgrp
directly does /not/ change behavior for callers of sock_cgroup_ptr().

syzkaller was able to trigger a splat in the legacy netrom code base, where
the RX handler in nr_rx_frame() calls nr_make_new() which calls sk_alloc()
and therefore cgroup_sk_alloc() with in_interrupt() condition. Thus the NULL
skcd->cgroup, where it trips over on cgroup_sk_free() side given it expects
a non-NULL object. There are a few other candidates aside from netrom which
have similar pattern where in their accept-like implementation, they just call
to sk_alloc() and thus cgroup_sk_alloc() instead of sk_clone_lock() with the
corresponding cgroup_sk_clone() which then inherits the cgroup from the parent
socket. None of them are related to core protocols where BPF cgroup programs
are running from. However, in future, they should follow to implement a similar
inheritance mechanism.

Additionally, with a !CONFIG_CGROUP_NET_PRIO and !CONFIG_CGROUP_NET_CLASSID
configuration, the same issue was exposed also prior to 8520e224f547 due to
commit e876ecc67db8 ("cgroup: memcg: net: do not associate sock with unrelated
cgroup") which added the early in_interrupt() return back then.

Fixes: 8520e224f547 ("bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode")
Fixes: e876ecc67db8 ("cgroup: memcg: net: do not associate sock with unrelated cgroup")
Reported-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
Reported-by: syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
Tested-by: syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/bpf/20210927123921.21535-1-daniel@iogearbox.net
Signed-off-by: Connor O'Brien <connor.obrien@crowdstrike.com>
---
 kernel/cgroup/cgroup.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3ec531ef50d8..030eaed1f06b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6559,22 +6559,29 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
 
 void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 {
-	/* Don't associate the sock with unrelated interrupted task's cgroup. */
-	if (in_interrupt())
-		return;
+	struct cgroup *cgroup;
 
 	rcu_read_lock();
+	/* Don't associate the sock with unrelated interrupted task's cgroup. */
+	if (in_interrupt()) {
+		cgroup = &cgrp_dfl_root.cgrp;
+		cgroup_get(cgroup);
+		goto out;
+	}
+
 	while (true) {
 		struct css_set *cset;
 
 		cset = task_css_set(current);
 		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
-			skcd->cgroup = cset->dfl_cgrp;
-			cgroup_bpf_get(cset->dfl_cgrp);
+			cgroup = cset->dfl_cgrp;
 			break;
 		}
 		cpu_relax();
 	}
+out:
+	skcd->cgroup = cgroup;
+	cgroup_bpf_get(cgroup);
 	rcu_read_unlock();
 }
 
-- 
2.34.1


