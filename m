Return-Path: <stable+bounces-20705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EA085AB64
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A303C1C210A0
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF441C78;
	Mon, 19 Feb 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4z5Yf0B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B61D53C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368490; cv=none; b=CBxpHj2s0oHUim1HmGsvKVGSSi7dcn33ywQsrPLu2cANzDpFhqrCtfKw/4zxUm0FFDxkin1BX6tt/x85D+y2Biqnd7nUauVV0ILcrGtRcHiJyoyXSixUiPZfRHqXboIHZcOLT+kajwCQpHYXwD6rJlSMRDxqgs5VIjC7kX7dA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368490; c=relaxed/simple;
	bh=RArP1AxNxnnce3KKf/K7sjn8+lxxWtX+MxdJjV2juq8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nwq25gbYVCM9mOK33BV0oFcWUmnuGA8TKO6B35ukspseGrXwOypdS15qHMrjiUFryIb1KWAh/ePQu8blhbaemfFRxJEJT7l8MvNnxn7LxgYfTFRUlfZjL/HgQRmNAtxAECXaGSjAM6X94/GCtYIEWpqH9trOdGxRLu/ETAeOyfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4z5Yf0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAD4C433F1;
	Mon, 19 Feb 2024 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368489;
	bh=RArP1AxNxnnce3KKf/K7sjn8+lxxWtX+MxdJjV2juq8=;
	h=Subject:To:Cc:From:Date:From;
	b=c4z5Yf0BgtJeT6KfqQM2xXs+ZqeBNnevKlSRkpyBiwi5UEVmNQCnXA3DmfPLOeuxA
	 /9zk1OMd1Pqfw+1q8vZSPXYL4E2LxhKAmnZUv5j0Q5IfYz5hRYP1onPh+CMggm+V+T
	 MkmZX83pP8Nv1Qb1/8P6AaxO5TgF+Dno2kpbnOs4=
Subject: FAILED: patch "[PATCH] s390/qeth: Fix potential loss of L3-IP@ in case of network" failed to apply to 5.4-stable tree
To: wintera@linux.ibm.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:48:06 +0100
Message-ID: <2024021906-aspirin-starless-d7df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2fe8a236436fe40d8d26a1af8d150fc80f04ee1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021906-aspirin-starless-d7df@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

2fe8a236436f ("s390/qeth: Fix potential loss of L3-IP@ in case of network issues")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fe8a236436fe40d8d26a1af8d150fc80f04ee1a Mon Sep 17 00:00:00 2001
From: Alexandra Winter <wintera@linux.ibm.com>
Date: Tue, 6 Feb 2024 09:58:49 +0100
Subject: [PATCH] s390/qeth: Fix potential loss of L3-IP@ in case of network
 issues

Symptom:
In case of a bad cable connection (e.g. dirty optics) a fast sequence of
network DOWN-UP-DOWN-UP could happen. UP triggers recovery of the qeth
interface. In case of a second DOWN while recovery is still ongoing, it
can happen that the IP@ of a Layer3 qeth interface is lost and will not
be recovered by the second UP.

Problem:
When registration of IP addresses with Layer 3 qeth devices fails, (e.g.
because of bad address format) the respective IP address is deleted from
its hash-table in the driver. If registration fails because of a ENETDOWN
condition, the address should stay in the hashtable, so a subsequent
recovery can restore it.

3caa4af834df ("qeth: keep ip-address after LAN_OFFLINE failure")
fixes this for registration failures during normal operation, but not
during recovery.

Solution:
Keep L3-IP address in case of ENETDOWN in qeth_l3_recover_ip(). For
consistency with qeth_l3_add_ip() we also keep it in case of EADDRINUSE,
i.e. for some reason the card already/still has this address registered.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Link: https://lore.kernel.org/r/20240206085849.2902775-1-wintera@linux.ibm.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b92a32b4b114..04c64ce0a1ca 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -255,9 +255,10 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 		if (!recover) {
 			hash_del(&addr->hnode);
 			kfree(addr);
-			continue;
+		} else {
+			/* prepare for recovery */
+			addr->disp_flag = QETH_DISP_ADDR_ADD;
 		}
-		addr->disp_flag = QETH_DISP_ADDR_ADD;
 	}
 
 	mutex_unlock(&card->ip_lock);
@@ -278,9 +279,11 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			rc = qeth_l3_register_addr_entry(card, addr);
 
-			if (!rc) {
+			if (!rc || rc == -EADDRINUSE || rc == -ENETDOWN) {
+				/* keep it in the records */
 				addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			} else {
+				/* bad address */
 				hash_del(&addr->hnode);
 				kfree(addr);
 			}


