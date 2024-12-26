Return-Path: <stable+bounces-106125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3FB9FC9CD
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 09:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ADE16244C
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD516D9C2;
	Thu, 26 Dec 2024 08:35:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AADA14375D
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735202128; cv=none; b=NXca9fyAM2OmDAgTlYZj0PscyLpZxHpP8Z3AjJflFX093Co4DGd4/qegrMOwOgYPibz07lW3+tg525anThWNieJf3BthXlKfi3TPtwgtKYiYiAR9TRyg92FJQgNR0d4I0MmhKldNH22N/L0mqPRDb31i11Cmuz//IChck9DTgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735202128; c=relaxed/simple;
	bh=Vz5QBgM3tDCdY/gBCQ5OzGzxb1PDAkObRXCJ1QiW6zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYhhCmIdvP4p20c5tu3YdTNZcrBSHdw4C9X09DZ/fhGRV/IqtpWeJnWhgigdvCEsy+IlhRM2TyLMI+o48Z4/ZS8KIXapPa/zrVxjrLssFhu9m3RCRIV4KGDAY65Bj/zhzhSq4pSl6Q0p/rwPrtxzWQdGrWWtbejtzKa7BZ/ywPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com; spf=fail smtp.mailfrom=163.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=163.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQ7jdR7005499;
	Thu, 26 Dec 2024 00:35:23 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43nx2pbwxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Dec 2024 00:35:22 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 26 Dec 2024 00:35:22 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 26 Dec 2024 00:35:21 -0800
From: Wenshan Lan <jetlan9@163.com>
To: <stable@vger.kernel.org>
CC: <jetlan9@163.com>
Subject: [PATCH 5.4.y] epoll: Add synchronous wakeup support for ep_poll_callback
Date: Thu, 26 Dec 2024 16:35:53 +0800
Message-ID: <20241226083553.1283297-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024122326-viscous-dreaded-d15d@gregkh>
References: <2024122326-viscous-dreaded-d15d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hoblnoJUn1d1PiPYdfN09j1slU8cTNZl
X-Authority-Analysis: v=2.4 cv=LtNoymdc c=1 sm=1 tr=0 ts=676d154a cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=RZcAm9yDv7YA:10 a=x7bEGLp0ZPQA:10 a=gpQc1nVavVoA:10 a=VwQbUJbxAAAA:8 a=icsG72s9AAAA:8 a=1XWaLZrsAAAA:8
 a=Byx-y9mGAAAA:8 a=Ii9SKyjff1enLIXkx5UA:9 a=T89tl0cgrjxRNoSN2Dv0:22
X-Proofpoint-GUID: hoblnoJUn1d1PiPYdfN09j1slU8cTNZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-26_03,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1034
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=742
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412260075

From: Xuewen Yan <xuewen.yan@unisoc.com>

Now, the epoll only use wake_up() interface to wake up task.
However, sometimes, there are epoll users which want to use
the synchronous wakeup flag to hint the scheduler, such as
Android binder driver.
So add a wake_up_sync() define, and use the wake_up_sync()
when the sync is true in ep_poll_callback().

Co-developed-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Link: https://lore.kernel.org/r/20240426080548.8203-1-xuewen.yan@unisoc.com
Tested-by: Brian Geffon <bgeffon@google.com>
Reviewed-by: Brian Geffon <bgeffon@google.com>
Reported-by: Benoit Lize <lizeb@google.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit 900bbaae67e980945dec74d36f8afe0de7556d5a)
[ Redefine wake_up_sync(x) as __wake_up_sync(x, TASK_NORMAL, 1) to
  make it work on 5.4.y ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 fs/eventpoll.c       | 5 ++++-
 include/linux/wait.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c0e94183186..569bfff280e4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1273,7 +1273,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
-		wake_up(&ep->wq);
+		if (sync)
+			wake_up_sync(&ep->wq);
+		else
+			wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 03bff85e365f..5b65f720261a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -213,6 +213,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL, 1)
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
-- 
2.43.0


