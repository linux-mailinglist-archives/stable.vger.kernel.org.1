Return-Path: <stable+bounces-228329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cv9CoBLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:17:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41B2F41A9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F1473146122
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053843B27F5;
	Mon, 23 Mar 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZHtrqFP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B53AC0D2;
	Mon, 23 Mar 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274827; cv=none; b=eZPrsaU6WICqhHopYpKzDiw0h6e8zZiA8yqIwZPUw3mvyVrMZFotZfzavrhZdGEHf4GKE7/C9OlpqkFa1+Oyf2qJzshsgGplmpw4R+oSe+ksmRN1uVpbgcLgOun0Is8yFPGmVJfhNLGSyjzRZlbmkhPD0DMNxl3j/x/xa9Ci5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274827; c=relaxed/simple;
	bh=88Tdd2ntgLslEsWu0tY7IymLFVQ+yEqkgGp+KYdPhhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDXZqDxGPw+pdUGOgmVEbzKWXw/lYe4WIAi6+OKwXXbhvvwwLFxz1zcXGb/m2/9WNOGxrkJ2L57rS+wU9DWdm917pw3qt41stFpmDujn7N+E0+T3+V2PXWRBKVHt503N8GpxSusUtctvGmr2wcFCYk8Y5WqJrLI3QL4rfPI3JIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZHtrqFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ACFC4CEF7;
	Mon, 23 Mar 2026 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274827;
	bh=88Tdd2ntgLslEsWu0tY7IymLFVQ+yEqkgGp+KYdPhhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZHtrqFP5goHwZEMU+eNEf6NVBGHk0qCtXklFnPZri1lVflP7TZnvfUuvKSdSABoV
	 ENQcYNCmNvC6S7Pyu4PyC7u1dWyoI3hpGjPa3GRe9ZJNanV7J7iW8DvD9pXn+6lsYw
	 ADW0VqqVMB3YMivcYo70z8/PhQd0Dv4rZkfnwfXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 119/212] firmware: arm_ffa: Remove vm_id argument in ffa_rxtx_unmap()
Date: Mon, 23 Mar 2026 14:45:40 +0100
Message-ID: <20260323134507.530951010@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228329-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: AB41B2F41A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit a4e8473b775160f3ce978f621cf8dea2c7250433 ]

According to the FF-A specification (DEN0077, v1.1, §13.7), when
FFA_RXTX_UNMAP is invoked from any instance other than non-secure
physical, the w1 register must be zero (MBZ). If a non-zero value is
supplied in this context, the SPMC must return FFA_INVALID_PARAMETER.

The Arm FF-A driver operates exclusively as a guest or non-secure
physical instance where the partition ID is always zero and is not
invoked from a hypervisor context where w1 carries a VM ID. In this
execution model, the partition ID observed by the driver is always zero,
and passing a VM ID is unnecessary and potentially invalid.

Remove the vm_id parameter from ffa_rxtx_unmap() and ensure that the
SMC call is issued with w1 implicitly zeroed, as required by the
specification. This prevents invalid parameter errors and aligns the
implementation with the defined FF-A ABI behavior.

Fixes: 3bbfe9871005 ("firmware: arm_ffa: Add initial Arm FFA driver support")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Message-Id: <20260304120953.847671-1-yeoreum.yun@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 11a702e7f641c..f6ceae987acbc 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -205,12 +205,12 @@ static int ffa_rxtx_map(phys_addr_t tx_buf, phys_addr_t rx_buf, u32 pg_cnt)
 	return 0;
 }
 
-static int ffa_rxtx_unmap(u16 vm_id)
+static int ffa_rxtx_unmap(void)
 {
 	ffa_value_t ret;
 
 	invoke_ffa_fn((ffa_value_t){
-		      .a0 = FFA_RXTX_UNMAP, .a1 = PACK_TARGET_INFO(vm_id, 0),
+		      .a0 = FFA_RXTX_UNMAP,
 		      }, &ret);
 
 	if (ret.a0 == FFA_ERROR)
@@ -2093,7 +2093,7 @@ static int __init ffa_init(void)
 
 	pr_err("failed to setup partitions\n");
 	ffa_notifications_cleanup();
-	ffa_rxtx_unmap(drv_info->vm_id);
+	ffa_rxtx_unmap();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, rxtx_bufsz);
@@ -2108,7 +2108,7 @@ static void __exit ffa_exit(void)
 {
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
-	ffa_rxtx_unmap(drv_info->vm_id);
+	ffa_rxtx_unmap();
 	free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
 	free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
 	kfree(drv_info);
-- 
2.51.0




