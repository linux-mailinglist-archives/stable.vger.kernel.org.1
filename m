Return-Path: <stable+bounces-133184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17CBA91EFD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA2D8A119D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA3250BF5;
	Thu, 17 Apr 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZWwR+LfF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F48250BF4
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898248; cv=none; b=Tbb6fHHTohql3FJ8um38Q/Ou2jZHECU9HDx0y5UwKDyVhvb0rLRj9nJLOAkAImdo6zA98MkvQZtVsQSS7/XPWm3s3c2W5XH08CBBK4yUjkDCE1Qrrev+7rWZb3Vh6kNcmN+EElwagUx6/ziu5S0YbelnIaIUPP65qbpSuaBPWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898248; c=relaxed/simple;
	bh=XAbLs3DCoDJqxzHt0HH4aMqb8T/5C/ALEms2Ff3Os3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XNee/eJEG2674zGYIG3KY5Vks4IhfkfnHaBu1CZufTDVbhg1RkIuYIkwLWfiPsBT1xAarQ//oiMXGvk62sBLZwu7+HxkDjeqMcLfJlOMwP9D2nBrYYLLSAr62gqKffeQBGak8w8VyjefXz6ZR14U6n2/M/Bb8N6ZRfdgmPDyHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZWwR+LfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E122C4CEE4;
	Thu, 17 Apr 2025 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744898248;
	bh=XAbLs3DCoDJqxzHt0HH4aMqb8T/5C/ALEms2Ff3Os3M=;
	h=Subject:To:Cc:From:Date:From;
	b=ZWwR+LfFXnsRYXICHE53iGEI8JLIffb27Xt0XKOlh4H00bDAcvo0SKozhWqW9ozLt
	 Z/C9FNIm2nhOCx4NsFd1nZD2owur7jX2VCWDdC1oRdLoSEaUrclavCVMuPebXyE4pq
	 btaqahFgM5b/RDZnCLV997cYE8YhC7AVLgYO4DAk=
Subject: FAILED: patch "[PATCH] of/irq: Fix device node refcount leakage in API" failed to apply to 5.15-stable tree
To: quic_zijuhu@quicinc.com,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:55:30 +0200
Message-ID: <2025041730-pointed-lived-89e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0cb58d6c7b558a69957fabe159bfb184196e1e8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041730-pointed-lived-89e3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0cb58d6c7b558a69957fabe159bfb184196e1e8d Mon Sep 17 00:00:00 2001
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Sun, 9 Feb 2025 20:58:55 +0800
Subject: [PATCH] of/irq: Fix device node refcount leakage in API
 of_irq_parse_one()

of_irq_parse_one(@int_gen_dev, i, ...) will leak refcount of @i_th_phandle

int_gen_dev {
    ...
    interrupts-extended = ..., <&i_th_phandle ...>, ...;
    ...
};

Refcount of @i_th_phandle is increased by of_parse_phandle_with_args()
but is not decreased by API of_irq_parse_one() before return, so causes
refcount leakage.

Rework the refcounting to use __free() cleanup and simplify the code to
have a single call to of_irq_parse_raw().

Also add comments about refcount of node @out_irq->np got by the API.

Fixes: 79d9701559a9 ("of/irq: create interrupts-extended property")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250209-of_irq_fix-v2-2-93e3a2659aa7@quicinc.com
[robh: Use __free() to do puts]
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6c843d54ebb1..95456e918681 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/list.h>
@@ -339,10 +340,12 @@ EXPORT_SYMBOL_GPL(of_irq_parse_raw);
  * This function resolves an interrupt for a node by walking the interrupt tree,
  * finding which interrupt controller node it is attached to, and returning the
  * interrupt specifier that can be used to retrieve a Linux IRQ number.
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_args *out_irq)
 {
-	struct device_node *p;
+	struct device_node __free(device_node) *p = NULL;
 	const __be32 *addr;
 	u32 intsize;
 	int i, res, addr_len;
@@ -367,41 +370,33 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
-	if (!res)
-		return of_irq_parse_raw(addr_buf, out_irq);
+	if (!res) {
+		p = out_irq->np;
+	} else {
+		/* Look for the interrupt parent. */
+		p = of_irq_find_parent(device);
+		/* Get size of interrupt specifier */
+		if (!p || of_property_read_u32(p, "#interrupt-cells", &intsize))
+			return -EINVAL;
 
-	/* Look for the interrupt parent. */
-	p = of_irq_find_parent(device);
-	if (p == NULL)
-		return -EINVAL;
+		pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
 
-	/* Get size of interrupt specifier */
-	if (of_property_read_u32(p, "#interrupt-cells", &intsize)) {
-		res = -EINVAL;
-		goto out;
+		/* Copy intspec into irq structure */
+		out_irq->np = p;
+		out_irq->args_count = intsize;
+		for (i = 0; i < intsize; i++) {
+			res = of_property_read_u32_index(device, "interrupts",
+							(index * intsize) + i,
+							out_irq->args + i);
+			if (res)
+				return res;
+		}
+
+		pr_debug(" intspec=%d\n", *out_irq->args);
 	}
 
-	pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
-
-	/* Copy intspec into irq structure */
-	out_irq->np = p;
-	out_irq->args_count = intsize;
-	for (i = 0; i < intsize; i++) {
-		res = of_property_read_u32_index(device, "interrupts",
-						 (index * intsize) + i,
-						 out_irq->args + i);
-		if (res)
-			goto out;
-	}
-
-	pr_debug(" intspec=%d\n", *out_irq->args);
-
-
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr_buf, out_irq);
- out:
-	of_node_put(p);
-	return res;
+	return of_irq_parse_raw(addr_buf, out_irq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_one);
 


