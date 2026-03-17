Return-Path: <stable+bounces-226394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBKBNF2KuWkjJwIAu9opvQ
	(envelope-from <stable+bounces-226394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:07:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF62AEFCA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C793185E2E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828363EF641;
	Tue, 17 Mar 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KgVdmOHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445483F0778;
	Tue, 17 Mar 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766509; cv=none; b=MRi3ixNxsJCSLeF7UAh7mU70z9nCjtNfH2wlhvTpC6TaNsqHCQt+b3sQIv7/anOJvuOqv0HHQ329KgL+lKASIpdYSLoaS2xGTEEkZl+WVVwLlIThRo5Vr6CG/EgczjmUj2GBeXovIguK5qw1rsgdJeCagxdajEL1pHmgU6e7q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766509; c=relaxed/simple;
	bh=2iaan1LBsOu1V+mi2bohOubPDWyQjBijCGRUEotAVDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0zXwOSU/O4JVFsO54KPqTDDOufDRPbK5gKNPqXtfY966E0U5rKyegPRJBLX2b/2cIXR8L1BdhGF9+UokIEQQrPs2gWIjbUUoZEqJKitrzGudGbH7b4kgHUkQCoIo5rgSlZxVgYm3SFaG2UrD1twARHhfaVw+m/LBnEjSNag0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KgVdmOHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906B8C4CEF7;
	Tue, 17 Mar 2026 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766509;
	bh=2iaan1LBsOu1V+mi2bohOubPDWyQjBijCGRUEotAVDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgVdmOHurLF4SbiGAWm3SZlPJUS01rQvUvmVU6EBVy0QchE09GnEVGalD+KX9A/BN
	 KXvgkTzPf8nc6N7kAulWZlazpRfqasV4hOBWACYO5ydz63Xf0IH4svbivjrWnOLNdW
	 cjOJPX5bPB6UOLkaZsRFKLdP4CrpboziCXQuXV7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 6.19 261/378] ice: fix retry for AQ command 0x06EE
Date: Tue, 17 Mar 2026 17:33:38 +0100
Message-ID: <20260317163016.616241936@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226394-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:url,mpg.de:email]
X-Rspamd-Queue-Id: 38EF62AEFCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>

commit fb4903b3354aed4a2301180cf991226f896c87ed upstream.

Executing ethtool -m can fail reporting a netlink I/O error while firmware
link management holds the i2c bus used to communicate with the module.

According to Intel(R) Ethernet Controller E810 Datasheet Rev 2.8 [1]
Section 3.3.10.4 Read/Write SFF EEPROM (0x06EE)
request should to be retried upon receiving EBUSY from firmware.

Commit e9c9692c8a81 ("ice: Reimplement module reads used by ethtool")
implemented it only for part of ice_get_module_eeprom(), leaving all other
calls to ice_aq_sff_eeprom() vulnerable to returning early on getting
EBUSY without retrying.

Remove the retry loop from ice_get_module_eeprom() and add Admin Queue
(AQ) command with opcode 0x06EE to the list of commands that should be
retried on receiving EBUSY from firmware.

Cc: stable@vger.kernel.org
Fixes: e9c9692c8a81 ("ice: Reimplement module reads used by ethtool")
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html [1]
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c  |    1 
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   35 ++++++++++-----------------
 2 files changed, 15 insertions(+), 21 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1854,6 +1854,7 @@ static bool ice_should_retry_sq_send_cmd
 	case ice_aqc_opc_lldp_stop:
 	case ice_aqc_opc_lldp_start:
 	case ice_aqc_opc_lldp_filter_ctrl:
+	case ice_aqc_opc_sff_eeprom:
 		return true;
 	}
 
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4508,7 +4508,7 @@ ice_get_module_eeprom(struct net_device
 	u8 addr = ICE_I2C_EEPROM_DEV_ADDR;
 	struct ice_hw *hw = &pf->hw;
 	bool is_sfp = false;
-	unsigned int i, j;
+	unsigned int i;
 	u16 offset = 0;
 	u8 page = 0;
 	int status;
@@ -4550,26 +4550,19 @@ ice_get_module_eeprom(struct net_device
 		if (page == 0 || !(data[0x2] & 0x4)) {
 			u32 copy_len;
 
-			/* If i2c bus is busy due to slow page change or
-			 * link management access, call can fail. This is normal.
-			 * So we retry this a few times.
-			 */
-			for (j = 0; j < 4; j++) {
-				status = ice_aq_sff_eeprom(hw, 0, addr, offset, page,
-							   !is_sfp, value,
-							   SFF_READ_BLOCK_SIZE,
-							   0, NULL);
-				netdev_dbg(netdev, "SFF %02X %02X %02X %X = %02X%02X%02X%02X.%02X%02X%02X%02X (%X)\n",
-					   addr, offset, page, is_sfp,
-					   value[0], value[1], value[2], value[3],
-					   value[4], value[5], value[6], value[7],
-					   status);
-				if (status) {
-					usleep_range(1500, 2500);
-					memset(value, 0, SFF_READ_BLOCK_SIZE);
-					continue;
-				}
-				break;
+			status = ice_aq_sff_eeprom(hw, 0, addr, offset, page,
+						   !is_sfp, value,
+						   SFF_READ_BLOCK_SIZE,
+						   0, NULL);
+			netdev_dbg(netdev, "SFF %02X %02X %02X %X = %02X%02X%02X%02X.%02X%02X%02X%02X (%pe)\n",
+				   addr, offset, page, is_sfp,
+				   value[0], value[1], value[2], value[3],
+				   value[4], value[5], value[6], value[7],
+				   ERR_PTR(status));
+			if (status) {
+				netdev_err(netdev, "%s: error reading module EEPROM: status %pe\n",
+					   __func__, ERR_PTR(status));
+				return status;
 			}
 
 			/* Make sure we have enough room for the new block */



