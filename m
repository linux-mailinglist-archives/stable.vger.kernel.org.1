Return-Path: <stable+bounces-52378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBABE90ADC8
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5745F288BA7
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099916C6AF;
	Mon, 17 Jun 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vbw0EOC8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F717345E
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626594; cv=none; b=pUtldKSeVT9AfzpP68P9n2Pv6NK5iX2nHa4sjkefmwzRuow9DPlGdclSvoCzHrmpVs8Z15LFKZqYlgvZP/rWq5JNUXsxJ8MEEdGydI680ISucTD8Ta5OVnaOK6Vxa5QbS3yqFY2fXJFJqWfV4nTL1/Ee9T+HV96O7oJ22N9hkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626594; c=relaxed/simple;
	bh=QBjTmjvkZ74gxEqe+KdRX06Pak4Wi5NIYizHq48R2D8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WSje4E4v8KKnDRpaVBl9vWuABQGV8R7iWV2bcdgIgmbAmy7mCAkF2DTlUUTx/jdblFcIrKF/JQovElln1Ztu9ZtoTcWu3CHe8XDykUcgF4X4PuWtvXZK97ypWuL4u4bDFao2yPXoNfzL1uiOV9wfnXpQd/R1qcgYD1fkC6fVUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vbw0EOC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A2C2BD10;
	Mon, 17 Jun 2024 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718626594;
	bh=QBjTmjvkZ74gxEqe+KdRX06Pak4Wi5NIYizHq48R2D8=;
	h=Subject:To:Cc:From:Date:From;
	b=Vbw0EOC8/E1XP3SRANhnuE8T2jPDq8clGTI3+rqKnHazRRz9vXb7pp1eMfij8g0cK
	 3bRjoGkGPKcR3Ygu53M4IIE/S/rFoaTNmkqTYOdG8Ewuz2QcMNLuEWTkuAXA6GgmNh
	 o6QJCHzpDfwykk20FGThfOIxq5Nj4sL+DqnR+DKE=
Subject: FAILED: patch "[PATCH] scsi: mpt3sas: Avoid test/set_bit() operating in" failed to apply to 4.19-stable tree
To: leitao@debian.org,kbusch@kernel.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 14:16:31 +0200
Message-ID: <2024061730-impale-expletive-e0db@gregkh>
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
git cherry-pick -x 4254dfeda82f20844299dca6c38cbffcfd499f41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061730-impale-expletive-e0db@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

4254dfeda82f ("scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory")
ffedeae1fa54 ("scsi: mpt3sas: Gracefully handle online firmware update")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4254dfeda82f20844299dca6c38cbffcfd499f41 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Wed, 5 Jun 2024 01:55:29 -0700
Subject: [PATCH] scsi: mpt3sas: Avoid test/set_bit() operating in
 non-allocated memory

There is a potential out-of-bounds access when using test_bit() on a single
word. The test_bit() and set_bit() functions operate on long values, and
when testing or setting a single word, they can exceed the word
boundary. KASAN detects this issue and produces a dump:

	 BUG: KASAN: slab-out-of-bounds in _scsih_add_device.constprop.0 (./arch/x86/include/asm/bitops.h:60 ./include/asm-generic/bitops/instrumented-atomic.h:29 drivers/scsi/mpt3sas/mpt3sas_scsih.c:7331) mpt3sas

	 Write of size 8 at addr ffff8881d26e3c60 by task kworker/u1536:2/2965

For full log, please look at [1].

Make the allocation at least the size of sizeof(unsigned long) so that
set_bit() and test_bit() have sufficient room for read/write operations
without overwriting unallocated memory.

[1] Link: https://lore.kernel.org/all/ZkNcALr3W3KGYYJG@gmail.com/

Fixes: c696f7b83ede ("scsi: mpt3sas: Implement device_remove_in_progress check in IOCTL path")
Cc: stable@vger.kernel.org
Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20240605085530.499432-1-leitao@debian.org
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 258647fc6bdd..1092497563b2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -8512,6 +8512,12 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pd_handles_sz = (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pd_handles_sz++;
+	/*
+	 * pd_handles_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory touch may occur.
+	 */
+	ioc->pd_handles_sz = ALIGN(ioc->pd_handles_sz, sizeof(unsigned long));
+
 	ioc->pd_handles = kzalloc(ioc->pd_handles_sz,
 	    GFP_KERNEL);
 	if (!ioc->pd_handles) {
@@ -8529,6 +8535,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pend_os_device_add_sz = (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pend_os_device_add_sz++;
+
+	/*
+	 * pend_os_device_add_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory may occur.
+	 */
+	ioc->pend_os_device_add_sz = ALIGN(ioc->pend_os_device_add_sz,
+					   sizeof(unsigned long));
 	ioc->pend_os_device_add = kzalloc(ioc->pend_os_device_add_sz,
 	    GFP_KERNEL);
 	if (!ioc->pend_os_device_add) {
@@ -8820,6 +8833,12 @@ _base_check_ioc_facts_changes(struct MPT3SAS_ADAPTER *ioc)
 		if (ioc->facts.MaxDevHandle % 8)
 			pd_handles_sz++;
 
+		/*
+		 * pd_handles should have, at least, the minimal room for
+		 * set_bit()/test_bit(), otherwise out-of-memory touch may
+		 * occur.
+		 */
+		pd_handles_sz = ALIGN(pd_handles_sz, sizeof(unsigned long));
 		pd_handles = krealloc(ioc->pd_handles, pd_handles_sz,
 		    GFP_KERNEL);
 		if (!pd_handles) {


