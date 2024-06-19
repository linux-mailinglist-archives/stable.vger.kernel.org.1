Return-Path: <stable+bounces-54171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5090ED03
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA6284265
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725D143C4E;
	Wed, 19 Jun 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6ES/HFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621D14389C;
	Wed, 19 Jun 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802795; cv=none; b=p17BvoKR67nb2xnUU1R+xbBSksgMDoQvfOZkZspLZVAtH6stSKgGWQrg5PfdXjWY51Y8mkeMogcvkl3h6IZYayjZGGTXncYcElrMq2yJ2ixXJ0XYNXcdAl3HdeCZ26AU2ydefHTZy2QqIrmS3luPfxU/8O0xdQoBXp8QCId2o8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802795; c=relaxed/simple;
	bh=Xqw4xIIkXbKBfNQCnBw0y115+xhsagbqu1sgXo60yL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBwpOpWDweGZtdgUWB5Ax2H/wjfyckvz0YP3OKNemDA2Ns7M2qKN0TJ8BGJimbIvoYbKJRt9xFfQ5wVJwiVMex6x6aiUYSRX9dJ8b5RznhPvodRnrYs1LyMpS/ZnXHA/A+zCtICRH0xBRLo2AYcDundnA6EBmLhE/d51opagjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6ES/HFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7F2C2BBFC;
	Wed, 19 Jun 2024 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802795;
	bh=Xqw4xIIkXbKBfNQCnBw0y115+xhsagbqu1sgXo60yL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6ES/HFmDkIeoB9U2UDu7J9srTZceqRvsf2Ni7tBa+Al/RxqioFIcaEViqgzNcum6
	 iqPZ4tuIYnsmLqenZ3KstK0y6r/KDH56WDsZ/wChWm0vQt9tjDzCxG0GaGy4suI0/w
	 4bSmjb4QM3u0jA0Hzo/oxn/WoqNGlYvCSbDJii3I=
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
Subject: [PATCH 6.9 050/281] ice: fix iteration of TLVs in Preserved Fields Area
Date: Wed, 19 Jun 2024 14:53:29 +0200
Message-ID: <20240619125611.775790959@linuxfoundation.org>
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

[ Upstream commit 03e4a092be8ce3de7c1baa7ae14e68b64e3ea644 ]

The ice_get_pfa_module_tlv() function iterates over the Type-Length-Value
structures in the Preserved Fields Area (PFA) of the NVM. This is used by
the driver to access data such as the Part Board Assembly identifier.

The function uses simple logic to iterate over the PFA. First, the pointer
to the PFA in the NVM is read. Then the total length of the PFA is read
from the first word.

A pointer to the first TLV is initialized, and a simple loop iterates over
each TLV. The pointer is moved forward through the NVM until it exceeds the
PFA area.

The logic seems sound, but it is missing a key detail. The Preserved
Fields Area length includes one additional final word. This is documented
in the device data sheet as a dummy word which contains 0xFFFF. All NVMs
have this extra word.

If the driver tries to scan for a TLV that is not in the PFA, it will read
past the size of the PFA. It reads and interprets the last dummy word of
the PFA as a TLV with type 0xFFFF. It then reads the word following the PFA
as a length.

The PFA resides within the Shadow RAM portion of the NVM, which is
relatively small. All of its offsets are within a 16-bit size. The PFA
pointer and TLV pointer are stored by the driver as 16-bit values.

In almost all cases, the word following the PFA will be such that
interpreting it as a length will result in 16-bit arithmetic overflow. Once
overflowed, the new next_tlv value is now below the maximum offset of the
PFA. Thus, the driver will continue to iterate the data as TLVs. In the
worst case, the driver hits on a sequence of reads which loop back to
reading the same offsets in an endless loop.

To fix this, we need to correct the loop iteration check to account for
this extra word at the end of the PFA. This alone is sufficient to resolve
the known cases of this issue in the field. However, it is plausible that
an NVM could be misconfigured or have corrupt data which results in the
same kind of overflow. Protect against this by using check_add_overflow
when calculating both the maximum offset of the TLVs, and when calculating
the next_tlv offset at the end of each loop iteration. This ensures that
the driver will not get stuck in an infinite loop when scanning the PFA.

Fixes: e961b679fb0b ("ice: add board identifier info to devlink .info_get")
Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20240603-net-2024-05-30-intel-net-fixes-v2-1-e3563aa89b0c@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 28 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index d4e05d2cb30c4..a0ad950cc76d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -441,8 +441,7 @@ int
 ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		       u16 module_type)
 {
-	u16 pfa_len, pfa_ptr;
-	u16 next_tlv;
+	u16 pfa_len, pfa_ptr, next_tlv, max_tlv;
 	int status;
 
 	status = ice_read_sr_word(hw, ICE_SR_PFA_PTR, &pfa_ptr);
@@ -455,11 +454,23 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		ice_debug(hw, ICE_DBG_INIT, "Failed to read PFA length.\n");
 		return status;
 	}
+
+	/* The Preserved Fields Area contains a sequence of Type-Length-Value
+	 * structures which define its contents. The PFA length includes all
+	 * of the TLVs, plus the initial length word itself, *and* one final
+	 * word at the end after all of the TLVs.
+	 */
+	if (check_add_overflow(pfa_ptr, pfa_len - 1, &max_tlv)) {
+		dev_warn(ice_hw_to_dev(hw), "PFA starts at offset %u. PFA length of %u caused 16-bit arithmetic overflow.\n",
+			 pfa_ptr, pfa_len);
+		return -EINVAL;
+	}
+
 	/* Starting with first TLV after PFA length, iterate through the list
 	 * of TLVs to find the requested one.
 	 */
 	next_tlv = pfa_ptr + 1;
-	while (next_tlv < pfa_ptr + pfa_len) {
+	while (next_tlv < max_tlv) {
 		u16 tlv_sub_module_type;
 		u16 tlv_len;
 
@@ -483,10 +494,13 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 			}
 			return -EINVAL;
 		}
-		/* Check next TLV, i.e. current TLV pointer + length + 2 words
-		 * (for current TLV's type and length)
-		 */
-		next_tlv = next_tlv + tlv_len + 2;
+
+		if (check_add_overflow(next_tlv, 2, &next_tlv) ||
+		    check_add_overflow(next_tlv, tlv_len, &next_tlv)) {
+			dev_warn(ice_hw_to_dev(hw), "TLV of type %u and length 0x%04x caused 16-bit arithmetic overflow. The PFA starts at 0x%04x and has length of 0x%04x\n",
+				 tlv_sub_module_type, tlv_len, pfa_ptr, pfa_len);
+			return -EINVAL;
+		}
 	}
 	/* Module does not exist */
 	return -ENOENT;
-- 
2.43.0




