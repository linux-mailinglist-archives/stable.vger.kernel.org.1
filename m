Return-Path: <stable+bounces-1867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE587F81BD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6C61C21E42
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146A33E9;
	Fri, 24 Nov 2023 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHEGao1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E928DBB;
	Fri, 24 Nov 2023 19:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFABC433C7;
	Fri, 24 Nov 2023 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852468;
	bh=q1YK2m0+uy1IAxG8YkQ3WAqsM+aK7DWWLM/90iT6i9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHEGao1BGBLz0whqwtL0cs3oauMtgU0kqgemms5SuiqdxPo+9oTVsZbtSVF1b+wM/
	 pzZzCSpq1GPxNq5PsIMAbtAV/380hvo1aeKUXvLKgJtdxa7HkS3PZoO2Kf8Z6St8BG
	 56XBYDGQMw07cTint6iebLwdV05Z0QgNfY/Ob8vM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.1 369/372] powerpc/powernv: Fix fortify source warnings in opal-prd.c
Date: Fri, 24 Nov 2023 17:52:36 +0000
Message-ID: <20231124172022.566443470@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit feea65a338e52297b68ceb688eaf0ffc50310a83 upstream.

As reported by Mahesh & Aneesh, opal_prd_msg_notifier() triggers a
FORTIFY_SOURCE warning:

  memcpy: detected field-spanning write (size 32) of single field "&item->msg" at arch/powerpc/platforms/powernv/opal-prd.c:355 (size 4)
  WARNING: CPU: 9 PID: 660 at arch/powerpc/platforms/powernv/opal-prd.c:355 opal_prd_msg_notifier+0x174/0x188 [opal_prd]
  NIP opal_prd_msg_notifier+0x174/0x188 [opal_prd]
  LR  opal_prd_msg_notifier+0x170/0x188 [opal_prd]
  Call Trace:
    opal_prd_msg_notifier+0x170/0x188 [opal_prd] (unreliable)
    notifier_call_chain+0xc0/0x1b0
    atomic_notifier_call_chain+0x2c/0x40
    opal_message_notify+0xf4/0x2c0

This happens because the copy is targeting item->msg, which is only 4
bytes in size, even though the enclosing item was allocated with extra
space following the msg.

To fix the warning define struct opal_prd_msg with a union of the header
and a flex array, and have the memcpy target the flex array.

Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Reported-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Tested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230821142820.497107-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/opal-prd.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -24,13 +24,20 @@
 #include <linux/uaccess.h>
 
 
+struct opal_prd_msg {
+	union {
+		struct opal_prd_msg_header header;
+		DECLARE_FLEX_ARRAY(u8, data);
+	};
+};
+
 /*
  * The msg member must be at the end of the struct, as it's followed by the
  * message data.
  */
 struct opal_prd_msg_queue_item {
-	struct list_head		list;
-	struct opal_prd_msg_header	msg;
+	struct list_head	list;
+	struct opal_prd_msg	msg;
 };
 
 static struct device_node *prd_node;
@@ -156,7 +163,7 @@ static ssize_t opal_prd_read(struct file
 	int rc;
 
 	/* we need at least a header's worth of data */
-	if (count < sizeof(item->msg))
+	if (count < sizeof(item->msg.header))
 		return -EINVAL;
 
 	if (*ppos)
@@ -186,7 +193,7 @@ static ssize_t opal_prd_read(struct file
 			return -EINTR;
 	}
 
-	size = be16_to_cpu(item->msg.size);
+	size = be16_to_cpu(item->msg.header.size);
 	if (size > count) {
 		err = -EINVAL;
 		goto err_requeue;
@@ -352,7 +359,7 @@ static int opal_prd_msg_notifier(struct
 	if (!item)
 		return -ENOMEM;
 
-	memcpy(&item->msg, msg->params, msg_size);
+	memcpy(&item->msg.data, msg->params, msg_size);
 
 	spin_lock_irqsave(&opal_prd_msg_queue_lock, flags);
 	list_add_tail(&item->list, &opal_prd_msg_queue);



