Return-Path: <stable+bounces-211720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCtNHyA5eGmmowEAu9opvQ
	(envelope-from <stable+bounces-211720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 05:03:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAFB8FC84
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 05:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBDC430095C4
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CB3176E1;
	Tue, 27 Jan 2026 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZG27tbn5"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72431619E
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486620; cv=none; b=t5HxdiRui/uGsEJ7wsJIUXbTlv1LNKo2TfnkDQ94Yktof/FIGhdYb8nKvzKtoV/4BzENP0ZRRUftcZgDZDkjFHbX6wJHvFBP/QVZ3dyYu0N0tdIMD1g5OfZbth+iU3weGiNFJ+sTBXcn3OIJXT9Uf//AtrUcFJhtnrHZHfcRMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486620; c=relaxed/simple;
	bh=Ib6Yd57WdBghu+vF445shZTD+HMlH1YLFnCKkQnTwqQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=rispCojEWLHZHzylLPZNWDzQ1octCYH97nYNVpzxBC4IC1G4Q7UsRcj6d/6ZU8rEvGKrFv7K881AzyOkmT3swnRVRP1Ge9Z+zBBuZUYBSsyuZDeYKYgW1T0qKXHVSQL0fqGSLwDvWswEoosNSr/eZgafFnCaYUnkEAo0DWoTMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZG27tbn5; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1769486614;
	bh=LFYAv93BuRb7R5NNr7VuLJ+tLbwiFCdVzcXngavjxkg=;
	h=From:To:Cc:Subject:Date;
	b=ZG27tbn57DDgQ+GgfIEO1b7p2XiaBm7Yl27tpk6BUAJGeEMhgdUXvMFwYjXGPNG1z
	 exdjxuZFEVWPHIxXW1fetCOROiToFBrjPn/riKo7ACMkPYQskAi0pOCAvptL6SCpr/
	 JA39Fcb89GuQBhUxgVSzIXcYgqy+jw77McvBxS6M=
Received: from ubuntu24.. ([2409:8a00:dd3:9760:874a:c122:32cf:6f61])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id DB33244; Tue, 27 Jan 2026 12:03:27 +0800
X-QQ-mid: xmsmtpt1769486607t3v419dv0
Message-ID: <tencent_9C6AFE3E9A2583AC3971A061001BDA681309@qq.com>
X-QQ-XMAILINFO: NEu9ADsh1Y9sEtpUJdRHiSeZtV+XKdj4hrJJa7QVCo7p6V8TDQM5Lur689JY8q
	 PG9PrVISBlYREzyGJdpInyY+w3QlwvzOcACakE5NEcjjjZSEtamxesdmZjXr01O3kpuiSJtY59st
	 prJ+6rBYYQ2OZVtQIJmDzwAjV3GdVZLmyJmw5HapTWBtKmP7bDyXVQ/JEKtDN05/2CwYzaFCAcsX
	 USIu2naGs2cL47XL2YGt/jSkMJa1uZ214JfxSmCU8bWI67O8Zgup8bL8Oh6SRCjBd0Ju6yQ/WuqX
	 vt3spxEPEB4Mgwqif6jVNUHt8UpOMyWQYqoFoaV3VRk90VPqROvGYWrr2QHv6/zOPrdOtbteAH7B
	 V5U+puqhLB7XRjLj/YfVypA+v43Yo/DfyjjlDrweT7QBdbnzXciqXfgkGvPAQ7tplHtAc3KfKVD4
	 Wj1iJluqJl76xiQuu2hLImsUj/ZiTFM25Vq7QstckYM1/L2epGPjLMn8Zt8shEoTzjwtqdd/LwuE
	 NozvhLQDF4emQTsynCFI8O0s6s/kWoBiAqCKW3Dg8zaKhxuFIW9H4eNHto8VsbDaFERYntetvTAT
	 /A6Jcz9laPvB3NlDRhYRs3V9dnDbV7FoOu3lqtnG22mIBy+EntZeWDRCEz33SSTNQNPPXdvVbCsV
	 1UttDkUUdq6ZRP9muy45JRQJ7q6UGdbZ1n9arXN/KGSjVEYosBQdzCyT/EbDUmOqUsm1qlRvEdFD
	 ZLcXNDy6GSFC+zD0t9r1EYZMrXnAjm4f5ZYc+b3xWHL8bAg/hXfYXCGfPM1yQlZlryrJce6dnYP0
	 gSXILoPAlxJk97P8ZtSyggCEZr2oLVQayOJmxd2MX0fMvJn0IOXqRIKKxuya7YJHOx7DcIlbqEAM
	 mnXPh9qAueCuygmveVYbWNgyNz4ifXER+wgUMO9mnyzgmEUWMykPvcOoe7mTm0pUsH7BCCeXl21r
	 OBFCLw9e4LYccp0Wzr0do2xVI8LopLq013MO5giKoePrFMksxxalFULCgNLe0LxrVXdS0mCj/mJk
	 uBqMy1nfSknvcC/ak5AOdfHqmXb701Qm4LfxiAd8CCuN+DH7oceKw2864QHL8LoEYC0s5Bbj4xz8
	 5aD2kg3RZz/zpeH1HXl8Fv/AU2vNXgc1a0z7qDpN11S2Mw+ZBPAOj5Q2Yd3p3E54dCU8XGmK+fou
	 u3klQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()
Date: Tue, 27 Jan 2026 04:03:26 +0000
X-OQ-MSGID: <20260127040326.5133-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,kernel.dk,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:mid]
X-Rspamd-Queue-Id: 9AAFB8FC84
X-Rspamd-Action: no action

From: Waiman Long <longman@redhat.com>

[ Upstream commit 3d2af77e31ade05ff7ccc3658c3635ec1bea0979 ]

When blkg_alloc() is called to allocate a blkcg_gq structure
with the associated blkg_iostat_set's, there are 2 fields within
blkg_iostat_set that requires proper initialization - blkg & sync.
The former field was introduced by commit 3b8cc6298724 ("blk-cgroup:
Optimize blkcg_rstat_flush()") while the later one was introduced by
commit f73316482977 ("blk-cgroup: reimplement basic IO stats using
cgroup rstat").

Unfortunately those fields in the blkg_iostat_set's are not properly
re-initialized when they are cleared in v1's blkcg_reset_stats(). This
can lead to a kernel panic due to NULL pointer access of the blkg
pointer. The missing initialization of sync is less problematic and
can be a problem in a debug kernel due to missing lockdep initialization.

Fix these problems by re-initializing them after memory clearing.

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230606180724.2455066-1-longman@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Remove this line: bis -> blkg = blkg for blkg was introduced by commit
  3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()") since v6.2. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 block/blk-cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e372a3fc264e..61fdff5406b5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -491,8 +491,12 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			struct blkg_iostat_set *bis =
 				per_cpu_ptr(blkg->iostat_cpu, cpu);
 			memset(bis, 0, sizeof(*bis));
+
+			/* Re-initialize the cleared blkg_iostat_set */
+			u64_stats_init(&bis->sync);
 		}
 		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
+		u64_stats_init(&blkg->iostat.sync);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
-- 
2.43.0


