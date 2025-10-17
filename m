Return-Path: <stable+bounces-186242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA988BE6AB5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 08:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9267B354623
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC830CD9F;
	Fri, 17 Oct 2025 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="a5o1/U7m"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192CB30F529;
	Fri, 17 Oct 2025 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682524; cv=none; b=TX+hkRF826XI/jH+C7amjbCFGfnHDfJ5mB1a1ncIAb8W8HIbGdf8zwr8cd8Tm6XCXTc98jD+g2cFD3TABdWNNEQD2WlFg8cNujS75YT1BYap/MwYu2zwM2A+I+Hp1+NwaQZf/Y0EYbOZkCgcNLQmTip7Ups7QyV2sTIWgMjvi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682524; c=relaxed/simple;
	bh=5q8sjs9dcsbZK0iWASKvemxXFRLIMsHSBbtjDlZFGDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UC4KVtZNc7Y4HFLpp95ecpaenUWtLvf68Q+4t8/dSMvaC2GJ0bxXiskfvN7dU7P9j4/akXBpZr3AeBBcK33+8QAaOtz0jDO8NGaN2Y/2N/f96egKhFiPbEV55k2MCe3hwA8fR1Y4GmKgaFz6BqPN0ko0kG9KWk3QzIMWfYKwghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=a5o1/U7m; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EariMdmxqMUoT2CmPJ9Fw37Rbcsk5MNlNnkFbFt8+Hg=;
	b=a5o1/U7mqaMy8Ypr05HmPHeSWzMjrzj3E2/1qGDmHHeGo34F0oGY2cyJaq/FkBDnZKL4O8eHN
	/Nfbwn1hoAXly9Eq7c99PYANeDqWRvJiE+1Z7xfdblSY3PDuPEpEuUKn7amT97ravHb2Do/Xvn+
	W7IX+5wpIU5Bf2xU+wsS8LI=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cnvyH0FQYz1T4G8;
	Fri, 17 Oct 2025 14:27:51 +0800 (CST)
Received: from kwepemk200016.china.huawei.com (unknown [7.202.194.82])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F94D180464;
	Fri, 17 Oct 2025 14:28:38 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemk200016.china.huawei.com
 (7.202.194.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 14:28:37 +0800
From: Yi Yang <yiyang13@huawei.com>
To: Alexey Dobriyan <adobriyan@sw.ru>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH stable] notifiers: Add oops check in blocking_notifier_call_chain()
Date: Fri, 17 Oct 2025 06:17:40 +0000
Message-ID: <20251017061740.59843-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200016.china.huawei.com (7.202.194.82)

In hrtimer_interrupt(), interrupts are disabled when acquiring a spinlock,
which subsequently triggers an oops. During the oops call chain,
blocking_notifier_call_chain() invokes _cond_resched, ultimately leading
to a hard lockup.

Call Stack:
hrtimer_interrupt//raw_spin_lock_irqsave
__hrtimer_run_queues
page_fault
do_page_fault
bad_area_nosemaphore
no_context
oops_end
bust_spinlocks
unblank_screen
do_unblank_screen
fbcon_blank
fb_notifier_call_chain
blocking_notifier_call_chain
down_read
_cond_resched

If the system is in an oops state, use down_read_trylock instead of a
blocking lock acquisition. If the trylock fails, skip executing the
notifier callbacks to avoid potential deadlocks or unsafe operations
during the oops handling process.

Cc: stable@vger.kernel.org      # 6.6
Fixes: fe9d4f576324 ("Add kernel/notifier.c")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 kernel/notifier.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index b3ce28f39eb6..ebff2315fac2 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -384,9 +384,18 @@ int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 	 * is, we re-check the list after having taken the lock anyway:
 	 */
 	if (rcu_access_pointer(nh->head)) {
-		down_read(&nh->rwsem);
-		ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
-		up_read(&nh->rwsem);
+		if (!oops_in_progress) {
+			down_read(&nh->rwsem);
+			ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
+			up_read(&nh->rwsem);
+		} else {
+			if (down_read_trylock(&nh->rwsem)) {
+				ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
+				up_read(&nh->rwsem);
+			} else {
+				ret = NOTIFY_BAD;
+			}
+		}
 	}
 	return ret;
 }
-- 
2.25.1


