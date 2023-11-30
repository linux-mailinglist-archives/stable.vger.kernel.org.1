Return-Path: <stable+bounces-3288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798357FF4E2
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF0E1C20F2B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F754F92;
	Thu, 30 Nov 2023 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VStrS4Lx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32D54BFC;
	Thu, 30 Nov 2023 16:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279D0C433C7;
	Thu, 30 Nov 2023 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361451;
	bh=P+ZpjbtGpeQfaEPcKhjiQgpfByepDqcIrt1x58KnR1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VStrS4LxIJyWcREV1d5JakD9iKKbU9jt6GKPV4u2C9tiWDl20tROcffskLFt2Sfbb
	 CO5pNKe+q2PGy4HA4xVtvLlyGpI43rxkrAj7y9dIeBslol5AItPSAmVJjEFhW0qcjs
	 wLW/HwPH6ZGPkuQKuD6rMGrD495vC2V1VcSlH40k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 008/112] s390/ism: ism driver implies smc protocol
Date: Thu, 30 Nov 2023 16:20:55 +0000
Message-ID: <20231130162140.582341825@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerd Bayer <gbayer@linux.ibm.com>

[ Upstream commit d565fa4300d9ebd5ba3bbd259ce841f8dab609d6 ]

Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
you can build the ism code without selecting the SMC network protocol.
That leaves some ism functions be reported as unused. Move these
functions under the conditional compile with CONFIG_SMC.

Also codify the suggestion to also configure the SMC protocol in ism's
Kconfig - but with an "imply" rather than a "select" as SMC depends on
other config options and allow for a deliberate decision not to build
SMC. Also, mention that in ISM's help.

Fixes: a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/netdev/afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org/
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/Kconfig   |  3 +-
 drivers/s390/net/ism_drv.c | 93 +++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 4902d45e929ce..c61e6427384c3 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -103,10 +103,11 @@ config CCWGROUP
 config ISM
 	tristate "Support for ISM vPCI Adapter"
 	depends on PCI
+	imply SMC
 	default n
 	help
 	  Select this option if you want to use the Internal Shared Memory
-	  vPCI Adapter.
+	  vPCI Adapter. The adapter can be used with the SMC network protocol.
 
 	  To compile as a module choose M. The module name is ism.
 	  If unsure, choose N.
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 6df7f377d2f90..81aabbfbbe2ca 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -30,7 +30,6 @@ static const struct pci_device_id ism_device_table[] = {
 MODULE_DEVICE_TABLE(pci, ism_device_table);
 
 static debug_info_t *ism_debug_info;
-static const struct smcd_ops ism_ops;
 
 #define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
 static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
@@ -289,22 +288,6 @@ static int ism_read_local_gid(struct ism_dev *ism)
 	return ret;
 }
 
-static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
-			  u32 vid)
-{
-	union ism_query_rgid cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.request.hdr.cmd = ISM_QUERY_RGID;
-	cmd.request.hdr.len = sizeof(cmd.request);
-
-	cmd.request.rgid = rgid;
-	cmd.request.vlan_valid = vid_valid;
-	cmd.request.vlan_id = vid;
-
-	return ism_cmd(ism, &cmd);
-}
-
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
@@ -429,23 +412,6 @@ static int ism_del_vlan_id(struct ism_dev *ism, u64 vlan_id)
 	return ism_cmd(ism, &cmd);
 }
 
-static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
-			  u32 event_code, u64 info)
-{
-	union ism_sig_ieq cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
-	cmd.request.hdr.len = sizeof(cmd.request);
-
-	cmd.request.rgid = rgid;
-	cmd.request.trigger_irq = trigger_irq;
-	cmd.request.event_code = event_code;
-	cmd.request.info = info;
-
-	return ism_cmd(ism, &cmd);
-}
-
 static unsigned int max_bytes(unsigned int start, unsigned int len,
 			      unsigned int boundary)
 {
@@ -503,14 +469,6 @@ u8 *ism_get_seid(void)
 }
 EXPORT_SYMBOL_GPL(ism_get_seid);
 
-static u16 ism_get_chid(struct ism_dev *ism)
-{
-	if (!ism || !ism->pdev)
-		return 0;
-
-	return to_zpci(ism->pdev)->pchid;
-}
-
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
@@ -569,11 +527,6 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u64 ism_get_local_gid(struct ism_dev *ism)
-{
-	return ism->local_gid;
-}
-
 static int ism_dev_init(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
@@ -774,6 +727,22 @@ module_exit(ism_exit);
 /*************************** SMC-D Implementation *****************************/
 
 #if IS_ENABLED(CONFIG_SMC)
+static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
+			  u32 vid)
+{
+	union ism_query_rgid cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_QUERY_RGID;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	cmd.request.rgid = rgid;
+	cmd.request.vlan_valid = vid_valid;
+	cmd.request.vlan_id = vid;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static int smcd_query_rgid(struct smcd_dev *smcd, u64 rgid, u32 vid_valid,
 			   u32 vid)
 {
@@ -811,6 +780,23 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
 	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
 }
 
+static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
+			  u32 event_code, u64 info)
+{
+	union ism_sig_ieq cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	cmd.request.rgid = rgid;
+	cmd.request.trigger_irq = trigger_irq;
+	cmd.request.event_code = event_code;
+	cmd.request.info = info;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static int smcd_signal_ieq(struct smcd_dev *smcd, u64 rgid, u32 trigger_irq,
 			   u32 event_code, u64 info)
 {
@@ -830,11 +816,24 @@ static int smcd_supports_v2(void)
 		SYSTEM_EID.type[0] != '0';
 }
 
+static u64 ism_get_local_gid(struct ism_dev *ism)
+{
+	return ism->local_gid;
+}
+
 static u64 smcd_get_local_gid(struct smcd_dev *smcd)
 {
 	return ism_get_local_gid(smcd->priv);
 }
 
+static u16 ism_get_chid(struct ism_dev *ism)
+{
+	if (!ism || !ism->pdev)
+		return 0;
+
+	return to_zpci(ism->pdev)->pchid;
+}
+
 static u16 smcd_get_chid(struct smcd_dev *smcd)
 {
 	return ism_get_chid(smcd->priv);
-- 
2.42.0




