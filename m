Return-Path: <stable+bounces-54172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFA90ED04
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BF51F214C3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940E143C58;
	Wed, 19 Jun 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NKCUh3Cw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F441422B8;
	Wed, 19 Jun 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802798; cv=none; b=FCvmXVjhX0GRgp2rMRj+OdUp+Dqev0qliT+6udjQb0lB2DupFZh+sH063Dp3jZ1HqP9R5JhznOIdePTMU+RR8GLHZFLmA8OblEFXBKBVA0LyOkkrBqzJPJVaTS83JhnJ7fT25kgm51kT2AMf3QV3h4eAje7wW+9VzvJuH6IfENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802798; c=relaxed/simple;
	bh=bsn9h5LjGXgmxnwtpjtGU8pdyvJq1yRIjZZ2YvsWhZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkn265GiWe0jeeIUEZT4Rcx4q/0freLdgFw8+GFfIbiuEuYcMD3CIKjznYO0fhjiXxsz5//+HEisCWVvMsEpPlf5FNHp+tlrBXWFg4nojS1e9b3G01qbkCAoGhDFfHLHQ1NVDCbM+MbY4Cv6OkzXuclFYXoN5PkamUeSp6Zx4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NKCUh3Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C177EC2BBFC;
	Wed, 19 Jun 2024 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802798;
	bh=bsn9h5LjGXgmxnwtpjtGU8pdyvJq1yRIjZZ2YvsWhZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKCUh3Cw3stmhLfTRZFBXKXW47RncqKf9UyG1HnTkf1glDPOAqgetk9o4R7zfwsoJ
	 6kvaw33ZneGMZMtkeRUAj31bR/knCrCRBZqgTypnau7Dan0xyxG+n6LrcFM0E/jiZl
	 y2K4zGbfPJ+xUvp9XRRP+en7tRyVogZQFoZj3N1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 051/281] ice: fix reads from NVM Shadow RAM on E830 and E825-C devices
Date: Wed, 19 Jun 2024 14:53:30 +0200
Message-ID: <20240619125611.814158954@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit cfa747a66e5da34793ac08c26b814e7709613fab ]

The ice driver reads data from the Shadow RAM portion of the NVM during
initialization, including data used to identify the NVM image and device,
such as the ETRACK ID used to populate devlink dev info fw.bundle.

Currently it is using a fixed offset defined by ICE_CSS_HEADER_LENGTH to
compute the appropriate offset. This worked fine for E810 and E822 devices
which both have CSS header length of 330 words.

Other devices, including both E825-C and E830 devices have different sizes
for their CSS header. The use of a hard coded value results in the driver
reading from the wrong block in the NVM when attempting to access the
Shadow RAM copy. This results in the driver reporting the fw.bundle as 0x0
in both the devlink dev info and ethtool -i output.

The first E830 support was introduced by commit ba20ecb1d1bb ("ice: Hook up
4 E830 devices by adding their IDs") and the first E825-C support was
introducted by commit f64e18944233 ("ice: introduce new E825C devices
family")

The NVM actually contains the CSS header length embedded in it. Remove the
hard coded value and replace it with logic to read the length from the NVM
directly. This is more resilient against all existing and future hardware,
vs looking up the expected values from a table. It ensures the driver will
read from the appropriate place when determining the ETRACK ID value used
for populating the fw.bundle_id and for reporting in ethtool -i.

The CSS header length for both the active and inactive flash bank is stored
in the ice_bank_info structure to avoid unnecessary duplicate work when
accessing multiple words of the Shadow RAM. Both banks are read in the
unlikely event that the header length is different for the NVM in the
inactive bank, rather than being different only by the overall device
family.

Fixes: ba20ecb1d1bb ("ice: Hook up 4 E830 devices by adding their IDs")
Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20240603-net-2024-05-30-intel-net-fixes-v2-2-e3563aa89b0c@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c  | 88 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_type.h | 14 ++--
 2 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index a0ad950cc76d9..8510a02afedcc 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -375,11 +375,25 @@ ice_read_nvm_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u1
  *
  * Read the specified word from the copy of the Shadow RAM found in the
  * specified NVM module.
+ *
+ * Note that the Shadow RAM copy is always located after the CSS header, and
+ * is aligned to 64-byte (32-word) offsets.
  */
 static int
 ice_read_nvm_sr_copy(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u16 *data)
 {
-	return ice_read_nvm_module(hw, bank, ICE_NVM_SR_COPY_WORD_OFFSET + offset, data);
+	u32 sr_copy;
+
+	switch (bank) {
+	case ICE_ACTIVE_FLASH_BANK:
+		sr_copy = roundup(hw->flash.banks.active_css_hdr_len, 32);
+		break;
+	case ICE_INACTIVE_FLASH_BANK:
+		sr_copy = roundup(hw->flash.banks.inactive_css_hdr_len, 32);
+		break;
+	}
+
+	return ice_read_nvm_module(hw, bank, sr_copy + offset, data);
 }
 
 /**
@@ -1024,6 +1038,72 @@ static int ice_determine_active_flash_banks(struct ice_hw *hw)
 	return 0;
 }
 
+/**
+ * ice_get_nvm_css_hdr_len - Read the CSS header length from the NVM CSS header
+ * @hw: pointer to the HW struct
+ * @bank: whether to read from the active or inactive flash bank
+ * @hdr_len: storage for header length in words
+ *
+ * Read the CSS header length from the NVM CSS header and add the Authentication
+ * header size, and then convert to words.
+ *
+ * Return: zero on success, or a negative error code on failure.
+ */
+static int
+ice_get_nvm_css_hdr_len(struct ice_hw *hw, enum ice_bank_select bank,
+			u32 *hdr_len)
+{
+	u16 hdr_len_l, hdr_len_h;
+	u32 hdr_len_dword;
+	int status;
+
+	status = ice_read_nvm_module(hw, bank, ICE_NVM_CSS_HDR_LEN_L,
+				     &hdr_len_l);
+	if (status)
+		return status;
+
+	status = ice_read_nvm_module(hw, bank, ICE_NVM_CSS_HDR_LEN_H,
+				     &hdr_len_h);
+	if (status)
+		return status;
+
+	/* CSS header length is in DWORD, so convert to words and add
+	 * authentication header size
+	 */
+	hdr_len_dword = hdr_len_h << 16 | hdr_len_l;
+	*hdr_len = (hdr_len_dword * 2) + ICE_NVM_AUTH_HEADER_LEN;
+
+	return 0;
+}
+
+/**
+ * ice_determine_css_hdr_len - Discover CSS header length for the device
+ * @hw: pointer to the HW struct
+ *
+ * Determine the size of the CSS header at the start of the NVM module. This
+ * is useful for locating the Shadow RAM copy in the NVM, as the Shadow RAM is
+ * always located just after the CSS header.
+ *
+ * Return: zero on success, or a negative error code on failure.
+ */
+static int ice_determine_css_hdr_len(struct ice_hw *hw)
+{
+	struct ice_bank_info *banks = &hw->flash.banks;
+	int status;
+
+	status = ice_get_nvm_css_hdr_len(hw, ICE_ACTIVE_FLASH_BANK,
+					 &banks->active_css_hdr_len);
+	if (status)
+		return status;
+
+	status = ice_get_nvm_css_hdr_len(hw, ICE_INACTIVE_FLASH_BANK,
+					 &banks->inactive_css_hdr_len);
+	if (status)
+		return status;
+
+	return 0;
+}
+
 /**
  * ice_init_nvm - initializes NVM setting
  * @hw: pointer to the HW struct
@@ -1070,6 +1150,12 @@ int ice_init_nvm(struct ice_hw *hw)
 		return status;
 	}
 
+	status = ice_determine_css_hdr_len(hw);
+	if (status) {
+		ice_debug(hw, ICE_DBG_NVM, "Failed to determine Shadow RAM copy offsets.\n");
+		return status;
+	}
+
 	status = ice_get_nvm_ver_info(hw, ICE_ACTIVE_FLASH_BANK, &flash->nvm);
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Failed to read NVM info.\n");
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 9ff92dba58236..0aacd0d050b8e 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -481,6 +481,8 @@ struct ice_bank_info {
 	u32 orom_size;				/* Size of OROM bank */
 	u32 netlist_ptr;			/* Pointer to 1st Netlist bank */
 	u32 netlist_size;			/* Size of Netlist bank */
+	u32 active_css_hdr_len;			/* Active CSS header length */
+	u32 inactive_css_hdr_len;		/* Inactive CSS header length */
 	enum ice_flash_bank nvm_bank;		/* Active NVM bank */
 	enum ice_flash_bank orom_bank;		/* Active OROM bank */
 	enum ice_flash_bank netlist_bank;	/* Active Netlist bank */
@@ -1084,17 +1086,13 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
 
 /* CSS Header words */
+#define ICE_NVM_CSS_HDR_LEN_L			0x02
+#define ICE_NVM_CSS_HDR_LEN_H			0x03
 #define ICE_NVM_CSS_SREV_L			0x14
 #define ICE_NVM_CSS_SREV_H			0x15
 
-/* Length of CSS header section in words */
-#define ICE_CSS_HEADER_LENGTH			330
-
-/* Offset of Shadow RAM copy in the NVM bank area. */
-#define ICE_NVM_SR_COPY_WORD_OFFSET		roundup(ICE_CSS_HEADER_LENGTH, 32)
-
-/* Size in bytes of Option ROM trailer */
-#define ICE_NVM_OROM_TRAILER_LENGTH		(2 * ICE_CSS_HEADER_LENGTH)
+/* Length of Authentication header section in words */
+#define ICE_NVM_AUTH_HEADER_LEN			0x08
 
 /* The Link Topology Netlist section is stored as a series of words. It is
  * stored in the NVM as a TLV, with the first two words containing the type
-- 
2.43.0




