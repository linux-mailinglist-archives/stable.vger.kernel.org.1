Return-Path: <stable+bounces-50451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015EB90660C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CA31C23D27
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094613D52B;
	Thu, 13 Jun 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rpct+86z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213C13D529
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265481; cv=none; b=HINJuQJ5imD7p0Z5wksRzlGY7Sfe7YAEGpTLKQqC0VH0MJlwW8m6MZrjPrAo1oZ+5SncgLHUFpjOKtheWvAby2lzpJ8lbipI7xyTYp4QZG/d3NTlg4Oy6gI0fVgAerSt6LtOh6WCzLRvy5QWTOLr5CkVofGAji7ews17RWyyl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265481; c=relaxed/simple;
	bh=T2i2jngzpXoL3XY1C4I0yV8Ie1n+J6cPAMwjzG7SWp0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qXJLZ9yV+D7f6m+COZ2271/QsF+lc7xDdzuw57wuPsP8uwuIgxCtRwi/xKMkgwpL586hX+qOnHOmTUMygvsZcn+CKE8GAqznpJHbSoAG0pRwbNuOm8ir/tZJ3pKjamzDOAKCiLPN4FfkFJik2qYIiOQdv7AEa4OgHlzUWzLGJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rpct+86z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFEAC2BBFC;
	Thu, 13 Jun 2024 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265481;
	bh=T2i2jngzpXoL3XY1C4I0yV8Ie1n+J6cPAMwjzG7SWp0=;
	h=Subject:To:Cc:From:Date:From;
	b=rpct+86zgZr7S7yCR8s9NFk13Osl0SrOG1ecv5hy4IawvmThUyT8UlR6ghAEcWpzZ
	 3EXLw8tYd+qDsMqWDf0b7c2hs50H7gAS4EtmsPS+N29xj0zMGTXfeECfJIP70W6fhE
	 TCXARgj7AOF43VOAPovRHwaERHLqKMFnjOxIMFdQ=
Subject: FAILED: patch "[PATCH] irqchip/riscv-intc: Prevent memory leak when" failed to apply to 6.6-stable tree
To: sunilvl@ventanamicro.com,anup@brainfault.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:57:58 +0200
Message-ID: <2024061358-defile-outplayed-f986@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0110c4b110477bb1f19b0d02361846be7ab08300
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061358-defile-outplayed-f986@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0110c4b11047 ("irqchip/riscv-intc: Prevent memory leak when riscv_intc_init_common() fails")
f4cc33e78ba8 ("irqchip/riscv-intc: Introduce Andes hart-level interrupt controller")
96303bcb401c ("irqchip/riscv-intc: Allow large non-standard interrupt number")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0110c4b110477bb1f19b0d02361846be7ab08300 Mon Sep 17 00:00:00 2001
From: Sunil V L <sunilvl@ventanamicro.com>
Date: Mon, 27 May 2024 13:41:13 +0530
Subject: [PATCH] irqchip/riscv-intc: Prevent memory leak when
 riscv_intc_init_common() fails

When riscv_intc_init_common() fails, the firmware node allocated is not
freed. Add the missing free().

Fixes: 7023b9d83f03 ("irqchip/riscv-intc: Add ACPI support")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240527081113.616189-1-sunilvl@ventanamicro.com

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 9e71c4428814..4f3a12383a1e 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -253,8 +253,9 @@ IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
-	struct fwnode_handle *fn;
 	struct acpi_madt_rintc *rintc;
+	struct fwnode_handle *fn;
+	int rc;
 
 	rintc = (struct acpi_madt_rintc *)header;
 
@@ -273,7 +274,11 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	}
 
-	return riscv_intc_init_common(fn, &riscv_intc_chip);
+	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
+	if (rc)
+		irq_domain_free_fwnode(fn);
+
+	return rc;
 }
 
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,


