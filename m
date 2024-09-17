Return-Path: <stable+bounces-76551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB297AC0C
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E51B2219D
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8C149E16;
	Tue, 17 Sep 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="F1Wrp+w1"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4B44C77
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558120; cv=none; b=IbCaMnH95qy2GZbrP7VTC0Qfa5GIvDFNrbdNO+O9MrTsihKeKn7HVA/Oq1Jf3lFjf1l/0Ad4duhOQvHelaS0YShkzBKgqP2/Y69qgcsZfAQG3PvYnQoUg+s2J7PZWcBMIzN6MOz+HdJ8I/U5H+aj344logiI71zwjLTzuPvhBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558120; c=relaxed/simple;
	bh=EWGoryWPN3XTa5xPjDODSu5gYnovg9x/84Wb8baTxJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AsyPzN28dj8UAhPypJ2glK5hF8JnuCyoW3SIAOz9EOohxRy5oM/J9Ci8CPRc27ptw3B/Vl3Xd7MQcUbvUrBxyi5wzKMAqUZmA2EZyVzGkzzHlPaGVIgOqg1di22gVkrrYDSvYnr0aqXaA9Vlljy1kCtgM6kPYoBv7iWm0/SLq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=F1Wrp+w1; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726558117;
	bh=Vcx7WPhSegV9rB0wW863Hv71god9yUWJCSu6hxqP9VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=F1Wrp+w17f3PBRPTIKc6ZoHbUZpmHP1s0Mq331e6WUdu/dPnG9YG7HCPPJtkxPTJ/
	 BU1QvV7ILcDXaxMBvz2FK9WKzP4veUeKzK1GloueZcKAAi4yvRMu7j0EFnzWsBu3e8
	 GPmFLNRt7NXneKWHRDObLTWPkP7BJcRKlylCqLtkvn6EXiqw7ovz4ReAwgzusK0lP+
	 J4QpHUF2YP48u4jJputPaBeqCSMtm4fdvtBSl5UIA0+8Q1OEzpJRWoqOcMLJTh3i18
	 BsoGZqkEzLQhnljtlUVBBrfge5attU8Jf4ZNvkNT693fU6NpfTs8kygF4YD2+GFujI
	 4SCQg1GH0AvPA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 1030F2010202;
	Tue, 17 Sep 2024 07:28:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Sep 2024 15:28:18 +0800
Subject: [PATCH] list: Remove duplicated and unused macro
 list_for_each_reverse
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-fix_list-v1-1-8fb8beb41e5d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJEv6WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mz3bTMiviczOISXVNT42QTE/OklFSDNCWg8oKiVKAc2Kjo2NpaAFi
 cbrtaAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ingo Molnar <mingo@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: PBPNEFXGRm1mF-qoq9AxFbNi8Y731PAQ
X-Proofpoint-GUID: PBPNEFXGRm1mF-qoq9AxFbNi8Y731PAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxlogscore=664 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409170055
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Remove macro list_for_each_reverse due to below reasons:

- it is same as list_for_each_prev.
- it is not used by current kernel tree.

Fixes: 8bf0cdfac7f8 ("<linux/list.h>: Introduce the list_for_each_reverse() method")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/list.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 5f4b0a39cf46..29a375889fb8 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -686,14 +686,6 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_for_each(pos, head) \
 	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
 
-/**
- * list_for_each_reverse - iterate backwards over a list
- * @pos:	the &struct list_head to use as a loop cursor.
- * @head:	the head for your list.
- */
-#define list_for_each_reverse(pos, head) \
-	for (pos = (head)->prev; pos != (head); pos = pos->prev)
-
 /**
  * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
  * @pos:	the &struct list_head to use as a loop cursor.

---
base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
change-id: 20240916-fix_list-553c447bde0f

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


