Return-Path: <stable+bounces-20706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD285AB65
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1CB28330A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C23482C0;
	Mon, 19 Feb 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kpqgAKFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE845C04
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368499; cv=none; b=LtotsNbz6XLnAe+/ZpyV3KF8NoXr2KOwCd6ib1WR7lnsOvPwUJZJGLId7nvZAO9H3zZxiFRTdbRbjiu77gsB5JGvhhrjcm21U6DUdlLKfaepED+uF7TgfmpChwqBi+AaQuVxnQ2inH2nlq2B6cnbrD42XFMHr+jsL3KSC/LGkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368499; c=relaxed/simple;
	bh=NtRH3bWOgLLZi+/wplaMD9MhA24swX/QC/9q/WRNKMI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dxRHiZpgeFIrH9BH0GQYkwx/psu0BbtqnAedJFGFkAZjMjOWVoIn3eTROeX7YEetrOdP7y3FIscAmeV2b5X341f5kiFWaaEpbObpPXOyXr0KkLfMCXauNWtoPFwWfPvnnjD6kyDrYc99VObe28LTtJy2r/uONfBc4J/MtE1d3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kpqgAKFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C364BC433F1;
	Mon, 19 Feb 2024 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368499;
	bh=NtRH3bWOgLLZi+/wplaMD9MhA24swX/QC/9q/WRNKMI=;
	h=Subject:To:Cc:From:Date:From;
	b=kpqgAKFTp1JbF9N7tt7PkG+UQfyOqOIt/joUkzi8329FiDvjTXsEZL13RGL5uKN/v
	 Oi5ThSRoZPLYbl1SzBdfo4cuPedznbbIwlttq2YSu8n8qD/fJWNHuSYu6GeK9yePV8
	 qBFq6T++eNB6jxHuvaQQoWDl5RvwlsF1DtFjH6Fk=
Subject: FAILED: patch "[PATCH] s390/qeth: Fix potential loss of L3-IP@ in case of network" failed to apply to 4.19-stable tree
To: wintera@linux.ibm.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:48:08 +0100
Message-ID: <2024021907-craziness-snuggle-7e2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2fe8a236436fe40d8d26a1af8d150fc80f04ee1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021907-craziness-snuggle-7e2b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


