Return-Path: <stable+bounces-228972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC8sAdNXwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF292F5E60
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 201613042FE5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF5386554;
	Mon, 23 Mar 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oAGfXqZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501DD36C59E;
	Mon, 23 Mar 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277653; cv=none; b=WBISIthwTc3q8b7RWc9nzM/pa0UnlP6f/lolVmZjUAbsSIjJtVArHUskOd1aeiGtNGrhUoqQFcFqtfpiaCv21KVbxCcCMpiUwtieBkUF6w8TTiYXgrw0T5OYJYAZcxHOz73p7KksvUBYvQcGosQKG93jgAN3RftYP1Oi0Lbhxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277653; c=relaxed/simple;
	bh=9dN/awB5/NXRqwiZZpIHv8deWirmBboB3LH8Xs9Wg8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAj1u6Zq/Kyn7QBP89HXiOtiDhdtVp91AInb0LfrGBy6b9fYU8zIYYt0AJYAbwS/YZ7HKxqmCWgnwzoX3+WAhXJtGxD8M0xVeQMjGCa67sEpM/XDSYSEL9/evDDu7liK+Hynr2KLiLmYbALOCN7e/C6R+ZN+5riOS6Aj4IZkgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oAGfXqZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78AEC4CEF7;
	Mon, 23 Mar 2026 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277653;
	bh=9dN/awB5/NXRqwiZZpIHv8deWirmBboB3LH8Xs9Wg8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAGfXqZAadmAms3PsS8AHxL99F9LDERNpukVDeAld8srxjMeg/xW6Z/v8VTuEZc+b
	 KtuUyK/p8TujhRsaaoGj6EWQQ4Iq46dC4HPMoS/Sd/dgLrW3Czl0GZyTcwmm6iGkLH
	 FFlwp8peSXx7oSNDIjGblR+PELT9nFFPoXmmtwvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 061/567] mailbox: sort headers alphabetically
Date: Mon, 23 Mar 2026 14:39:41 +0100
Message-ID: <20260323134535.326986382@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228972-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linaro.org,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ACF292F5E60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit db824c1119fc16556a84cb7a771ca6553b3c3a45 ]

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Stable-dep-of: fcd7f96c7836 ("mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c          | 14 +++++++-------
 include/linux/mailbox_client.h     |  2 +-
 include/linux/mailbox_controller.h |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 87de408fb068c..c7134ece6d5dd 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -6,18 +6,18 @@
  * Author: Jassi Brar <jassisinghbrar@gmail.com>
  */
 
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/module.h>
 #include <linux/device.h>
-#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "mailbox.h"
 
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 734694912ef74..c6eea9afb943d 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -7,8 +7,8 @@
 #ifndef __MAILBOX_CLIENT_H
 #define __MAILBOX_CLIENT_H
 
-#include <linux/of.h>
 #include <linux/device.h>
+#include <linux/of.h>
 
 struct mbox_chan;
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 6fee33cb52f58..5fb0b65f45a2c 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -3,11 +3,11 @@
 #ifndef __MAILBOX_CONTROLLER_H
 #define __MAILBOX_CONTROLLER_H
 
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/types.h>
-#include <linux/hrtimer.h>
-#include <linux/device.h>
-#include <linux/completion.h>
 
 struct mbox_chan;
 
-- 
2.51.0




