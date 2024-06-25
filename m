Return-Path: <stable+bounces-55325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7936B91631D
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34180281755
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D4149C6C;
	Tue, 25 Jun 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARreRYHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B5148FE5;
	Tue, 25 Jun 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308571; cv=none; b=prdRA3aDPOCWYuYqYf638TFyDnc/jzz2ZnVny5oWejykFevF7/DNvRIMPj1inMyT21qPhiWohocWikPeaVa4P2Eguoq14ty+rm222aGuzLky4ff9uSAc39M3rX4xAQdrGN1dJW7jql51rk4F09S+q9sRJL99/gjqMwwNHG3cN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308571; c=relaxed/simple;
	bh=xWplLOVqC8+ZqJus+9afpxB+Bx51jTPbadH1HnjlEgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrMeowb+UhxByEeq54jXATTXDvgQeNG61GZ3/ipNNUiiH45tO/PXkEXF0hqUKJElbqJ2qZlbd1klIwt3HvUr7IZUF7GTHZeHZfNZI7VxaQYGvsPMuc1LFBJ07v7LOzB1Tbap/if8+4PtM8T4ZoknDLRGA3tl11YoBbVbSkYfpIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARreRYHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE333C32781;
	Tue, 25 Jun 2024 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308571;
	bh=xWplLOVqC8+ZqJus+9afpxB+Bx51jTPbadH1HnjlEgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARreRYHzMKWmq3l1FK/3ucKP4PEQBUUJ6EH/TYe1GMeUsEG9XtldHEYM05ea4pozR
	 XSLKdHS3gp/RsbGN50vmyn1KG5DyZq4P52tYv6SXtefipAY1n6YxZZOi8H+KymlAHw
	 u3/gqoh/oUd5LsFrRimMkEQFEPhvGVkENCNIxd2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geetha sowjanya <gakula@marvell.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 135/250] octeontx2-pf: Fix linking objects into multiple modules
Date: Tue, 25 Jun 2024 11:31:33 +0200
Message-ID: <20240625085553.243822520@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 1062d03827b78614259b3b4b992deb27ee6aa84d ]

This patch fixes the below build warning messages that are
caused due to linking same files to multiple modules by
exporting the required symbols.

"scripts/Makefile.build:244: drivers/net/ethernet/marvell/octeontx2/nic/Makefile:
otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf

scripts/Makefile.build:244: drivers/net/ethernet/marvell/octeontx2/nic/Makefile:
otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf"

Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/Makefile       | 3 +--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 7 +++++++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 5664f768cb0cd..64a97a0a10ed6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -9,10 +9,9 @@ obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o
-rvu_nicvf-y := otx2_vf.o otx2_devlink.o
+rvu_nicvf-y := otx2_vf.o
 
 rvu_nicpf-$(CONFIG_DCB) += otx2_dcbnl.o
-rvu_nicvf-$(CONFIG_DCB) += otx2_dcbnl.o
 rvu_nicpf-$(CONFIG_MACSEC) += cn10k_macsec.o
 
 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index 28fb643d2917f..aa01110f04a33 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -54,6 +54,7 @@ int otx2_pfc_txschq_config(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_config);
 
 static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -122,6 +123,7 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_alloc);
 
 static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -260,6 +262,7 @@ int otx2_pfc_txschq_update(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_update);
 
 int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 {
@@ -282,6 +285,7 @@ int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_pfc_txschq_stop);
 
 int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 {
@@ -321,6 +325,7 @@ int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_config_priority_flow_ctrl);
 
 void otx2_update_bpid_in_rqctx(struct otx2_nic *pfvf, int vlan_prio, int qidx,
 			       bool pfc_enable)
@@ -385,6 +390,7 @@ void otx2_update_bpid_in_rqctx(struct otx2_nic *pfvf, int vlan_prio, int qidx,
 			 "Updating BPIDs in CQ and Aura contexts of RQ%d failed with err %d\n",
 			 qidx, err);
 }
+EXPORT_SYMBOL(otx2_update_bpid_in_rqctx);
 
 static int otx2_dcbnl_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
 {
@@ -472,3 +478,4 @@ int otx2_dcbnl_set_ops(struct net_device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_dcbnl_set_ops);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 4e1130496573e..05956bf03c05d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -112,6 +112,7 @@ int otx2_register_dl(struct otx2_nic *pfvf)
 	devlink_free(dl);
 	return err;
 }
+EXPORT_SYMBOL(otx2_register_dl);
 
 void otx2_unregister_dl(struct otx2_nic *pfvf)
 {
@@ -123,3 +124,4 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
 				  ARRAY_SIZE(otx2_dl_params));
 	devlink_free(dl);
 }
+EXPORT_SYMBOL(otx2_unregister_dl);
-- 
2.43.0




