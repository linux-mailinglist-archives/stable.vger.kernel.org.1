Return-Path: <stable+bounces-75359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72879973425
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60371C24E22
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EC618C928;
	Tue, 10 Sep 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQYHCiVw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537DA17B50F;
	Tue, 10 Sep 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964502; cv=none; b=tZwEhNHoq1F9GEYDbFFbcTgiSHn0oF2TySncWP+i9z1UlfhbJQ1BvcbuMirHMMnzK48fchcH/es21gYA211NzBAl5j1nW3bmIkNF2HrOMH1t8wycj44Tbvjv4QPkLWWSdokyKXUr6z0Mg7hJ+YBxF2cxcs5Z54fcM+AgL1r6U/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964502; c=relaxed/simple;
	bh=vIScGY4OZ7lUDO9QuwLczAst8ZXHdWN5n1dhcRZ2axE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSYvjc9gK2j6iuQa89Hv7yuXQP2d4/2Kk7dhDn1FFDyj2WdZYwyaMbaJi/O6VI62xzaeAbhTWFS9e83r19puByWcWk2FMVeE9JcdK60dT1KQJrK2vd8foyb4KDzuvJUEUZcww+gZF4mNhxHvpG/ezEZPp9b8MZZqH0OoBURzSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQYHCiVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2DAC4CEC3;
	Tue, 10 Sep 2024 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964502;
	bh=vIScGY4OZ7lUDO9QuwLczAst8ZXHdWN5n1dhcRZ2axE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQYHCiVwQMlq59Kg4tpvIIHBnQ05v6IIetp6335dqqUdnt2zyByqsjAQXQ22IfqPi
	 K1HQLdab0gdn83qVXZHmU8PbJDyGxge9U9bSqM4A9H1ZCuVeIHcf8MrSmyVAb4koGQ
	 lP/tR3hE+ed8c6F/CEcQflTMTRvAh7DbLl0yv/7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Florian Larysch <fl@n621.de>
Subject: [PATCH 6.6 204/269] intel: legacy: Partial revert of field get conversion
Date: Tue, 10 Sep 2024 11:33:11 +0200
Message-ID: <20240910092615.342279444@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

From: Sasha Neftin <sasha.neftin@intel.com>

commit ba54b1a276a6b69d80649942fe5334d19851443e upstream.

Refactoring of the field get conversion introduced a regression in the
legacy Wake On Lan from a magic packet with i219 devices. Rx address
copied not correctly from MAC to PHY with FIELD_GET macro.

Fixes: b9a452545075 ("intel: legacy: field get conversion")
Suggested-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Florian Larysch <fl@n621.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -2573,7 +2573,7 @@ void e1000_copy_rx_addrs_to_phy_ich8lan(
 		hw->phy.ops.write_reg_page(hw, BM_RAR_H(i),
 					   (u16)(mac_reg & 0xFFFF));
 		hw->phy.ops.write_reg_page(hw, BM_RAR_CTRL(i),
-					   FIELD_GET(E1000_RAH_AV, mac_reg));
+					   (u16)((mac_reg & E1000_RAH_AV) >> 16));
 	}
 
 	e1000_disable_phy_wakeup_reg_access_bm(hw, &phy_reg);



