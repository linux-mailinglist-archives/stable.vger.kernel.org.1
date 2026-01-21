Return-Path: <stable+bounces-210843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFSkIxQhcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:55:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5C5B9DD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA01AAD6BE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25744381710;
	Wed, 21 Jan 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEopUStb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E53587B0;
	Wed, 21 Jan 2026 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019571; cv=none; b=jkHssB1g4YscmUaYtWrUOQBPV+v8owTXlEqd3uPXRBhlVPZpDNPKn3IeBWMZzcXOnaMYdLmrMe47MqkSAf8apP0n1cRw58qjFGZ2ma+t/08jJ96E7r7gwK0UsAi7ed+xN5JuIb2A1Zt9wLkFyJxsTU8y2q+og+JugUw/Ga67sBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019571; c=relaxed/simple;
	bh=rJKIOXlpZ1A32rd85yBOlmogNhPDU3TZi/cMS48ZbN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boBpPEh6plc5WjPiJthUJfCM/11y8ANuWPHdrvpeM3BIzKk0R2q9fV2N5HO9TtzXQCMpSbp9Md/crX8zudvAxXU++zHsobuRhxt1JG6WPytT8Kxr7CcNxQfjr7Iw8TXVTFtmnQPryI3w/X61h8+/Rh9+fx8dl4Aa+MLFruqFKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEopUStb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2461BC4CEF1;
	Wed, 21 Jan 2026 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019570;
	bh=rJKIOXlpZ1A32rd85yBOlmogNhPDU3TZi/cMS48ZbN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEopUStbHEnH/h+Iv/0aw/jloqbHHzU/oGctmquwCZ47p0hDUzF8ADg9aEMTThFT/
	 fK704JPXu93wejrUHtMG+bYBjbwTj6GoZSnwA+ZnChrIc7uDA/uJLftqu2ykVfRkfQ
	 BgS8HF0ncMLSHf5BHDpeklX+rZQl5Ln1C4nub4tY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lizhi Hou <lizhi.hou@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Anthony Brandon <anthony@amarulasolutions.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/139] dmaengine: xilinx: xdma: Fix regmap max_register
Date: Wed, 21 Jan 2026 19:14:52 +0100
Message-ID: <20260121181413.041251171@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210843-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0AF5C5B9DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthony Brandon <anthony@amarulasolutions.com>

[ Upstream commit c7d436a6c1a274c1ac28d5fb3b8eb8f03b6d0e10 ]

The max_register field is assigned the size of the register memory
region instead of the offset of the last register.
The result is that reading from the regmap via debugfs can cause
a segmentation fault:

tail /sys/kernel/debug/regmap/xdma.1.auto/registers
Unable to handle kernel paging request at virtual address ffff800082f70000
Mem abort info:
  ESR = 0x0000000096000007
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
[...]
Call trace:
 regmap_mmio_read32le+0x10/0x30
 _regmap_bus_reg_read+0x74/0xc0
 _regmap_read+0x68/0x198
 regmap_read+0x54/0x88
 regmap_read_debugfs+0x140/0x380
 regmap_map_read_file+0x30/0x48
 full_proxy_read+0x68/0xc8
 vfs_read+0xcc/0x310
 ksys_read+0x7c/0x120
 __arm64_sys_read+0x24/0x40
 invoke_syscall.constprop.0+0x64/0x108
 do_el0_svc+0xb0/0xd8
 el0_svc+0x38/0x130
 el0t_64_sync_handler+0x120/0x138
 el0t_64_sync+0x194/0x198
Code: aa1e03e9 d503201f f9400000 8b214000 (b9400000)
---[ end trace 0000000000000000 ]---
note: tail[1217] exited with irqs disabled
note: tail[1217] exited with preempt_count 1
Segmentation fault

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xdma-regs.h | 1 +
 drivers/dma/xilinx/xdma.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
index 6ad08878e9386..70bca92621aa4 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -9,6 +9,7 @@
 
 /* The length of register space exposed to host */
 #define XDMA_REG_SPACE_LEN	65536
+#define XDMA_MAX_REG_OFFSET	(XDMA_REG_SPACE_LEN - 4)
 
 /*
  * maximum number of DMA channels for each direction:
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 718842fdaf98e..2726c7154fcef 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -38,7 +38,7 @@ static const struct regmap_config xdma_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = XDMA_REG_SPACE_LEN,
+	.max_register = XDMA_MAX_REG_OFFSET,
 };
 
 /**
-- 
2.51.0




