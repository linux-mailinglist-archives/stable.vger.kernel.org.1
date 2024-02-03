Return-Path: <stable+bounces-17982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2C8480E6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490761C21331
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9321AADB;
	Sat,  3 Feb 2024 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmRyxsE9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589261AAD8;
	Sat,  3 Feb 2024 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933460; cv=none; b=DEAxdII0VMsrYOTnUQgwIMHZHyE/UWKpGFTOhavJajPk07ejd9fMv1OS2udFpoY2XQV/UCLXb9KBDeXoFwEaxRzN7K1VWfIISr1Cedadu7g49Ky9JlyrCufUfz4+J5fBiPBXIrmuF+YL49uQV6jn6VqMLTLy7vSftKt5Z06G75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933460; c=relaxed/simple;
	bh=xdKv7mEpW/x/XWk7a59yUAY9hAvQO9jvQfKVdkpSZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGuxDMWIzXn2EjHsZiCJARn+tgdq4uQFFlMScelpyzTkIj5J3q+IsZwfTOCKhVh/QZ8VyDShdywfX8DmgsOLLZ+Qls3Evi+/pvbrJIvzOmoAPy6tHnl80lxhCgzN8oOSrBxR3HHXMeoM9Ahoh0dr8zAMtQsCMZGbtrvGXVL3Biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmRyxsE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214C7C433F1;
	Sat,  3 Feb 2024 04:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933460;
	bh=xdKv7mEpW/x/XWk7a59yUAY9hAvQO9jvQfKVdkpSZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmRyxsE9wkcZXHrXJ6zuvRPsdMp/YztCUgIsGjfSFN8oUe3ncpa/vXjsMgxg6hqkl
	 9akjE4JZ/xC3vD5JYUjyHcus1Apxr87U2/DJeixNGx0ydcOVEkxLjI19S4JNIqApII
	 EcKIvCiRWzk/nJkIqMBi547zmtVNmyhIcjIQRAPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.1 197/219] ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()
Date: Fri,  2 Feb 2024 20:06:10 -0800
Message-ID: <20240203035344.891756122@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bbc404d20d1b46d89b461918bc44587620eda200 ]

All error handling paths, except this one, go to 'out' where
release_swfw_sync() is called.
This call balances the acquire_swfw_sync() call done at the beginning of
the function.

Branch to the error handling path in order to correctly release some
resources in case of error.

Fixes: ae14a1d8e104 ("ixgbe: Fix IOSF SB access issues")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index fe2d2d2f0494..cdc912bba808 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -717,7 +717,8 @@ static s32 ixgbe_read_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 		error = (command & IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK) >>
 			 IXGBE_SB_IOSF_CTRL_CMPL_ERR_SHIFT;
 		hw_dbg(hw, "Failed to read, error %x\n", error);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (!ret)
-- 
2.43.0




