Return-Path: <stable+bounces-129841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E4A801C3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979FD3A4CF8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B34268FD2;
	Tue,  8 Apr 2025 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qIjjCwHe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039F219301;
	Tue,  8 Apr 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112121; cv=none; b=REmRSELrwblf0ipp2t4J8XYQGX49DKVKj5O33osAItCG/eZgtF6R8ZkI2CevBQlWcRTrxGdQ4VHVBSjuI41bO1q7uv0WGFow4M/ZpdUpI9vfT3XBUEvR+3lMwHpUbjZDZgMi0uSStQJNUFneQG+3HjeY6NOqxAs7I8oshMJDUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112121; c=relaxed/simple;
	bh=qfIiDLPet1lVFcDApmqbQLZtbODYDgCXADwdmOozRjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+mKqhwoX4RPSY1swb7uPKKF8EDIZclRLdW6/L1OVJP3+a0ssoYQBHIiIdblx6kZ6m2MML+rvoG+kpQna2Mt60F1mgTFvjLl1Mgsw+jxTM2jMibuzM7cDRUz3H+1RBM7GkABDnnj8b/X9W0Fkujjopbe7W7ddIquHENlK0UwSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qIjjCwHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08070C4CEE5;
	Tue,  8 Apr 2025 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112120;
	bh=qfIiDLPet1lVFcDApmqbQLZtbODYDgCXADwdmOozRjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIjjCwHe7g77vzQ2X8zHK/xOWUFaRt0ntCATF/mT4Huh9Y/S9kZ3i4xeA0xItKAtm
	 A5DtlxBwsgIqcbK4ipYK0p9b5Shc16l/D+9xUxGHwox9CxhZgRGsyW+44aLMMEyFe0
	 voJN5LY0VFiu5CXJ/TbNNs7Sp8XBDKEbiwFshxX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 634/731] sfc: rip out MDIO support
Date: Tue,  8 Apr 2025 12:48:51 +0200
Message-ID: <20250408104929.018190556@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Cree <ecree.xilinx@gmail.com>

[ Upstream commit c339fcdd738be78c540407ae78fef5601ba5092a ]

Unlike Siena, no EF10 board ever had an external PHY, and consequently
 MDIO handling isn't even built into the firmware.  Since Siena has
 been split out into its own driver, the MDIO code can be deleted from
 the sfc driver.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://patch.msgid.link/aa689d192ddaef7abe82709316c2be648a7bd66e.1742493017.git.ecree.xilinx@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8241ecec1cdc ("sfc: fix NULL dereferences in ef100_process_design_param()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ef100_netdev.c     |  1 -
 drivers/net/ethernet/sfc/efx.c              | 24 ---------
 drivers/net/ethernet/sfc/mcdi_port.c        | 59 +--------------------
 drivers/net/ethernet/sfc/mcdi_port_common.c | 11 ----
 drivers/net/ethernet/sfc/net_driver.h       |  6 +--
 5 files changed, 2 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index 7f7d560cb2b4c..d941f073f1ebf 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -452,7 +452,6 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 				  NETIF_F_HIGHDMA | NETIF_F_ALL_TSO;
 	netif_set_tso_max_segs(net_dev,
 			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
-	efx->mdio.dev = net_dev;
 
 	rc = efx_ef100_init_datapath_caps(efx);
 	if (rc < 0)
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 650136dfc642f..112e55b98ed3b 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -474,28 +474,6 @@ void efx_get_irq_moderation(struct efx_nic *efx, unsigned int *tx_usecs,
 	}
 }
 
-/**************************************************************************
- *
- * ioctls
- *
- *************************************************************************/
-
-/* Net device ioctl
- * Context: process, rtnl_lock() held.
- */
-static int efx_ioctl(struct net_device *net_dev, struct ifreq *ifr, int cmd)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	struct mii_ioctl_data *data = if_mii(ifr);
-
-	/* Convert phy_id from older PRTAD/DEVAD format */
-	if ((cmd == SIOCGMIIREG || cmd == SIOCSMIIREG) &&
-	    (data->phy_id & 0xfc00) == 0x0400)
-		data->phy_id ^= MDIO_PHY_ID_C45 | 0x0400;
-
-	return mdio_mii_ioctl(&efx->mdio, data, cmd);
-}
-
 /**************************************************************************
  *
  * Kernel net device interface
@@ -593,7 +571,6 @@ static const struct net_device_ops efx_netdev_ops = {
 	.ndo_tx_timeout		= efx_watchdog,
 	.ndo_start_xmit		= efx_hard_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= efx_ioctl,
 	.ndo_change_mtu		= efx_change_mtu,
 	.ndo_set_mac_address	= efx_set_mac_address,
 	.ndo_set_rx_mode	= efx_set_rx_mode,
@@ -1201,7 +1178,6 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	rc = efx_init_struct(efx, pci_dev);
 	if (rc)
 		goto fail1;
-	efx->mdio.dev = net_dev;
 
 	pci_info(pci_dev, "Solarflare NIC detected\n");
 
diff --git a/drivers/net/ethernet/sfc/mcdi_port.c b/drivers/net/ethernet/sfc/mcdi_port.c
index ad4694fa3ddae..7b236d291d8c2 100644
--- a/drivers/net/ethernet/sfc/mcdi_port.c
+++ b/drivers/net/ethernet/sfc/mcdi_port.c
@@ -17,58 +17,6 @@
 #include "selftest.h"
 #include "mcdi_port_common.h"
 
-static int efx_mcdi_mdio_read(struct net_device *net_dev,
-			      int prtad, int devad, u16 addr)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	MCDI_DECLARE_BUF(inbuf, MC_CMD_MDIO_READ_IN_LEN);
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_MDIO_READ_OUT_LEN);
-	size_t outlen;
-	int rc;
-
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_BUS, efx->mdio_bus);
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_PRTAD, prtad);
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_DEVAD, devad);
-	MCDI_SET_DWORD(inbuf, MDIO_READ_IN_ADDR, addr);
-
-	rc = efx_mcdi_rpc(efx, MC_CMD_MDIO_READ, inbuf, sizeof(inbuf),
-			  outbuf, sizeof(outbuf), &outlen);
-	if (rc)
-		return rc;
-
-	if (MCDI_DWORD(outbuf, MDIO_READ_OUT_STATUS) !=
-	    MC_CMD_MDIO_STATUS_GOOD)
-		return -EIO;
-
-	return (u16)MCDI_DWORD(outbuf, MDIO_READ_OUT_VALUE);
-}
-
-static int efx_mcdi_mdio_write(struct net_device *net_dev,
-			       int prtad, int devad, u16 addr, u16 value)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	MCDI_DECLARE_BUF(inbuf, MC_CMD_MDIO_WRITE_IN_LEN);
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_MDIO_WRITE_OUT_LEN);
-	size_t outlen;
-	int rc;
-
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_BUS, efx->mdio_bus);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_PRTAD, prtad);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_DEVAD, devad);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_ADDR, addr);
-	MCDI_SET_DWORD(inbuf, MDIO_WRITE_IN_VALUE, value);
-
-	rc = efx_mcdi_rpc(efx, MC_CMD_MDIO_WRITE, inbuf, sizeof(inbuf),
-			  outbuf, sizeof(outbuf), &outlen);
-	if (rc)
-		return rc;
-
-	if (MCDI_DWORD(outbuf, MDIO_WRITE_OUT_STATUS) !=
-	    MC_CMD_MDIO_STATUS_GOOD)
-		return -EIO;
-
-	return 0;
-}
 
 u32 efx_mcdi_phy_get_caps(struct efx_nic *efx)
 {
@@ -97,12 +45,7 @@ int efx_mcdi_port_probe(struct efx_nic *efx)
 {
 	int rc;
 
-	/* Set up MDIO structure for PHY */
-	efx->mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_EMULATE_C22;
-	efx->mdio.mdio_read = efx_mcdi_mdio_read;
-	efx->mdio.mdio_write = efx_mcdi_mdio_write;
-
-	/* Fill out MDIO structure, loopback modes, and initial link state */
+	/* Fill out loopback modes and initial link state */
 	rc = efx_mcdi_phy_probe(efx);
 	if (rc != 0)
 		return rc;
diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index 76ea26722ca46..dae684194ac8c 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -448,15 +448,6 @@ int efx_mcdi_phy_probe(struct efx_nic *efx)
 	efx->phy_data = phy_data;
 	efx->phy_type = phy_data->type;
 
-	efx->mdio_bus = phy_data->channel;
-	efx->mdio.prtad = phy_data->port;
-	efx->mdio.mmds = phy_data->mmd_mask & ~(1 << MC_CMD_MMD_CLAUSE22);
-	efx->mdio.mode_support = 0;
-	if (phy_data->mmd_mask & (1 << MC_CMD_MMD_CLAUSE22))
-		efx->mdio.mode_support |= MDIO_SUPPORTS_C22;
-	if (phy_data->mmd_mask & ~(1 << MC_CMD_MMD_CLAUSE22))
-		efx->mdio.mode_support |= MDIO_SUPPORTS_C45 | MDIO_EMULATE_C22;
-
 	caps = MCDI_DWORD(outbuf, GET_LINK_OUT_CAP);
 	if (caps & (1 << MC_CMD_PHY_CAP_AN_LBN))
 		mcdi_to_ethtool_linkset(phy_data->media, caps,
@@ -546,8 +537,6 @@ void efx_mcdi_phy_get_link_ksettings(struct efx_nic *efx, struct ethtool_link_ks
 	cmd->base.port = mcdi_to_ethtool_media(phy_cfg->media);
 	cmd->base.phy_address = phy_cfg->port;
 	cmd->base.autoneg = !!(efx->link_advertising[0] & ADVERTISED_Autoneg);
-	cmd->base.mdio_support = (efx->mdio.mode_support &
-			      (MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22));
 
 	mcdi_to_ethtool_linkset(phy_cfg->media, phy_cfg->supported_cap,
 				cmd->link_modes.supported);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index f70a7b7d6345c..1d3e0f3101d4f 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -15,7 +15,7 @@
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
 #include <linux/timer.h>
-#include <linux/mdio.h>
+#include <linux/mii.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/device.h>
@@ -956,8 +956,6 @@ struct efx_mae;
  * @stats_buffer: DMA buffer for statistics
  * @phy_type: PHY type
  * @phy_data: PHY private data (including PHY-specific stats)
- * @mdio: PHY MDIO interface
- * @mdio_bus: PHY MDIO bus ID (only used by Siena)
  * @phy_mode: PHY operating mode. Serialised by @mac_lock.
  * @link_advertising: Autonegotiation advertising flags
  * @fec_config: Forward Error Correction configuration flags.  For bit positions
@@ -1131,8 +1129,6 @@ struct efx_nic {
 
 	unsigned int phy_type;
 	void *phy_data;
-	struct mdio_if_info mdio;
-	unsigned int mdio_bus;
 	enum efx_phy_mode phy_mode;
 
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(link_advertising);
-- 
2.39.5




