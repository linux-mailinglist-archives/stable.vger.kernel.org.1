Return-Path: <stable+bounces-74757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A637E97314B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F831C25411
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C618F2C3;
	Tue, 10 Sep 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kuklftvu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C631885A5;
	Tue, 10 Sep 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962740; cv=none; b=L6YLUGWcGshKJkzT5BiBFgZfjLdSFOHYqQPk3fp2rwMrx762aj1lDo6KnYIRoGO0w4oMRYvJFULzCPzMMoaD6pFqBccpmuGJ+bAuOvuKRtiODHvMXXuaQ5vCaZMTOKKECAolnF9/WgxsdCajS8COBg8Kjtg7Hc9tUbrGQlCw+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962740; c=relaxed/simple;
	bh=FiZl7rL1L0kCvRQICIRFEoweDpRAiTNKO1VqReBs6Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwzDmsJAOOcWFUFMDskg0R2j/JBTO/8bNm94LwDUWisKNycI0DUmqbjMlfUOcGC+h9O6mFkC9XcmZvrBPzZ9WOTz2AfK1pqvzo0T9+ETGbD48irB9iP/35Mg7MRNLdtg6AGxmHd0xI8ifnEjCuZGZj/NHbyrEpXcK/sDh2jrgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kuklftvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7071C4CEC3;
	Tue, 10 Sep 2024 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962740;
	bh=FiZl7rL1L0kCvRQICIRFEoweDpRAiTNKO1VqReBs6Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuklftvuW5R3HWfHSphv+16AeNnWJFWm0dKK2E9zhvxeumLzBC5oADUTNVvoGp6Rm
	 nxKlwGy0lbLSjrDrBoAxkxvEMEB63eeJH7yFEDdHL2uY4UnyggcEyrvdAF6gRSj8yI
	 NDK5+TSt20LiFX+TZQUtAI3y1h9btFKvkLP8SqL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 014/192] irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()
Date: Tue, 10 Sep 2024 11:30:38 +0200
Message-ID: <20240910092558.533625817@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
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

From: Ma Ke <make24@iscas.ac.cn>

commit c5af2c90ba5629f0424a8d315f75fb8d91713c3c upstream.

gicv2m_of_init() fails to perform an of_node_put() when
of_address_to_resource() fails, leading to a refcount leak.

Address this by moving the error handling path outside of the loop and
making it common to all failure modes.

Fixes: 4266ab1a8ff5 ("irqchip/gic-v2m: Refactor to prepare for ACPI support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240820092843.1219933-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v2m.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -438,12 +438,12 @@ static int __init gicv2m_of_init(struct
 
 		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
 				      &res, 0);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
 
+	if (ret && child)
+		of_node_put(child);
 	if (!ret)
 		ret = gicv2m_allocate_domains(parent);
 	if (ret)



