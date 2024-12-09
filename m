Return-Path: <stable+bounces-100172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58389E96EE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5AE16B439
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26C1ACEC9;
	Mon,  9 Dec 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="enocT7A7"
X-Original-To: stable@vger.kernel.org
Received: from ci74p00im-qukt09082501.me.com (ci74p00im-qukt09082501.me.com [17.57.156.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B01A23B9
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750772; cv=none; b=rt9I+g2hl7xDcmD9oy/zxdcP+Tg7MKkTdcdyZWEH4cecJ5IIg4vZ6i8OPio7BsySsjizvOQjLlNAjRDzAA0xwPnSXG0fBV5Cp28Yz0+lZ9ss7SKYCw2TrW3S2bhQBfJpT86P0XUP8XJwnVszfvUxNP//MQZOh/NGzYqe9RdYB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750772; c=relaxed/simple;
	bh=buSZ9Fabg4Kiu8V1aFg4lCJbzCY/oh3Pk+dTilUwq4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEn8/yyBzGKbSJNasBB2/vZjU0G8Rn0iBPwQ6+91hhRlSoALa8RFqo3rSinvrOohdm4a5o9qiGxPGAhV4zgqi0QMTZqzmiqgodinlfwDnDDqO7Da6SKkPbq1oqhKZkq69jVVmhO/jTDgGi6SF50T0UePiRX+jNBzPkhLi5x4vpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=enocT7A7; arc=none smtp.client-ip=17.57.156.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733750770;
	bh=C56FTWVpesqYqDvRuOPp99e/7K+5vPCrrmNEn8wL/GI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=enocT7A7mU6vzg8NHwAFTDtnofY/c5D4tQND8D/4ENwtuaFZ8CV9P3m+qhzdYO/V7
	 8bR8pBObqoyEXdbJTPlJ6QNtzl1edSmWRcbVCvectRzqYTEdgF/Ln8cjhCXCPZJvCz
	 nyWQukUP5v3+ZEgJpZJo5SSLXVzwbf3LfKlhAMeU9X2dkbyanfXFZeD/bS6ngXPzAG
	 ZXfxnEnTZ0uzKaORclqSgYdP1+jJ+Bz1Z7CUBfspDzZ0i/AfPygjH/AOwpuxoFH0MH
	 9iDy9fSQewwQCfnsBPR3XDWYxcWUwPdTYdixHxWIWgMBot1E8oyrS1UtQxBBxYIO0b
	 eHk6NkOsodc+Q==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082501.me.com (Postfix) with ESMTPSA id 2DE9A4AA048C;
	Mon,  9 Dec 2024 13:26:02 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Dec 2024 21:25:01 +0800
Subject: [PATCH 3/8] of/irq: Fix device node refcount leakage in API
 of_irq_parse_raw()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-of_irq_fix-v1-3-782f1419c8a1@quicinc.com>
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
In-Reply-To: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Stefan Wiehler <stefan.wiehler@nokia.com>, 
 Grant Likely <grant.likely@linaro.org>, Tony Lindgren <tony@atomide.com>, 
 Kumar Gala <galak@codeaurora.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Julia Lawall <Julia.Lawall@lip6.fr>, Jamie Iles <jamie@jamieiles.com>, 
 Grant Likely <grant.likely@secretlab.ca>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_irq_parse_raw() will return when meet condition (@ipar == @newpar)
but Refcount of device node @out_irq->np was increased twice when
directly return there, hence causes @out_irq->np refcount leakage.

Fix by putting @out_irq->np refcount before returning there.

Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 758eb9b3714868112e83469d131b244ce77d4e82..cb39624a5e7799b9d2f4525f42dac4cd921ab403 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -310,6 +310,12 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
+			/*
+			 * Has got @ipar's refcount, but the refcount was
+			 * got again by of_irq_parse_imap_parent() via its
+			 * alias @newpair.
+			 */
+			of_node_put(ipar);
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
 			return 0;
 		}

-- 
2.34.1


