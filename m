Return-Path: <stable+bounces-134443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8FA92B14
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FA64A7C64
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968F72571C6;
	Thu, 17 Apr 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E//sW6wN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53684254B1F;
	Thu, 17 Apr 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916141; cv=none; b=lxVslgPRLUudtbRUwrndntuqfIHiqn9sGlQ9Szc1oSBkDTRZgGSGEZp5NEJCE/a8k4hFblZ7WPaZqOlwg92WhE31k5KaYxgRIm5Eazi66L/atoMc9wu6v402xSt8jgyCDxYjDpCSKkjzr7ciRlT1IA5J70toM8OPIfyKdiIM3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916141; c=relaxed/simple;
	bh=XfimzIs7IM9iRjQKDjrBz2MZMTbtbpMV7PEKR8VyEZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3xCazhJs3kThKw03qYUlw37a39cw3gboga+Ppw+GMzYgxP8MVXGAaK3qTbrOkT8Hjfl/vcd6Z/5zz7Y8/yL+MhVj8E+xjZz7HavaTmkCPVj+h4UdMf2s3ScBZc4s/n08I2oWR1JfYicWbzSg6AwnPzKlX4y0hRTlOGfXPosSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E//sW6wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA021C4CEE4;
	Thu, 17 Apr 2025 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916141;
	bh=XfimzIs7IM9iRjQKDjrBz2MZMTbtbpMV7PEKR8VyEZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E//sW6wNas6HrNAmEFYUszz/IagoJwtoj687Pk0LMLjNedIwibxgHO0QgD+eI92G5
	 zrG+FPQW2mTdYq9co2f0wlT4NTWLb4Bs+pKWTvVHdn2T6HH2TOOP9YLHo23zLOfqZW
	 +izqidwQYO8FNm1sVIqMmm7AO2+jrowkmrutzIu0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.12 357/393] of/irq: Fix device node refcount leakage in API of_irq_parse_one()
Date: Thu, 17 Apr 2025 19:52:46 +0200
Message-ID: <20250417175121.956660931@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit 0cb58d6c7b558a69957fabe159bfb184196e1e8d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/irq.c |   59 +++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

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
@@ -367,41 +370,33 @@ int of_irq_parse_one(struct device_node
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
-	if (!res)
-		return of_irq_parse_raw(addr_buf, out_irq);
-
-	/* Look for the interrupt parent. */
-	p = of_irq_find_parent(device);
-	if (p == NULL)
-		return -EINVAL;
-
-	/* Get size of interrupt specifier */
-	if (of_property_read_u32(p, "#interrupt-cells", &intsize)) {
-		res = -EINVAL;
-		goto out;
-	}
-
-	pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
+	if (!res) {
+		p = out_irq->np;
+	} else {
+		/* Look for the interrupt parent. */
+		p = of_irq_find_parent(device);
+		/* Get size of interrupt specifier */
+		if (!p || of_property_read_u32(p, "#interrupt-cells", &intsize))
+			return -EINVAL;
+
+		pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
+
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
 
-	/* Copy intspec into irq structure */
-	out_irq->np = p;
-	out_irq->args_count = intsize;
-	for (i = 0; i < intsize; i++) {
-		res = of_property_read_u32_index(device, "interrupts",
-						 (index * intsize) + i,
-						 out_irq->args + i);
-		if (res)
-			goto out;
+		pr_debug(" intspec=%d\n", *out_irq->args);
 	}
 
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
 



