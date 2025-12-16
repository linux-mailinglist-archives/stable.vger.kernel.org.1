Return-Path: <stable+bounces-201842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BCCC2851
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E87308E499
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2F355037;
	Tue, 16 Dec 2025 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjOIuNQF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F3355029;
	Tue, 16 Dec 2025 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885968; cv=none; b=s7pWlJmCvALKtUbdatVE78wceq3/Kt1sZ401WfSIMI8Nf2h0wGAvGyepqvosMZlrM0idSDJInEJiBvH8UWuZ+NcsYnHrD2LmsjvrPXiMbKl2EbZCmNDoBhy0SpXUdhBeLfT8+8eAWEcJdFu4T7d1YY9kSTRW5xybzh8tWDR4x0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885968; c=relaxed/simple;
	bh=j61JN4bg2v4rwWEUChzl+wu8Pi0QYIcn6+TEPVYVuak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sy/FQi288bCmIhzX9LDM/L4Ve9oIve41jWZh8WiXN07EVZCmbaBYBjvCH5c2uGVKfZ9VQN6+xUeDn1Z/r0Ao82qFHB1yWFeqaU2v3VUlEC4hfhDdJglgoydbN4gci91XvzA5esk4zCuGXQA1rsqnnddQt/TiTUm1T7IO9t3SO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjOIuNQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9404DC4CEF1;
	Tue, 16 Dec 2025 11:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885968;
	bh=j61JN4bg2v4rwWEUChzl+wu8Pi0QYIcn6+TEPVYVuak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wjOIuNQFqyJHv71bhS8K1MtEiqTPb72sxDrh5vMb0+bhCDKFm9C//bpopo28VILEs
	 z4YFn+TE6vcgse3knlRV9ehqNH9VdhQHYldNZ8SAOmnGKrb4yVNKVMvkj/z67YwubF
	 GQKRWo3EAMsC4q5101eOJfWVxUzAF0tCgkYr6fKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Dahl <ada@thorsis.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 298/507] net: phy: adin1100: Fix software power-down ready condition
Date: Tue, 16 Dec 2025 12:12:19 +0100
Message-ID: <20251216111356.270840765@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Dahl <ada@thorsis.com>

[ Upstream commit bccaf1fe08f2c9f96f6bc38391d41e67f6bf38e3 ]

Value CRSM_SFT_PD written to Software Power-Down Control Register
(CRSM_SFT_PD_CNTRL) is 0x01 and therefor different to value
CRSM_SFT_PD_RDY (0x02) read from System Status Register (CRSM_STAT) for
confirmation powerdown has been reached.

The condition could have only worked when disabling powerdown
(both 0x00), but never when enabling it (0x01 != 0x02).

Result is a timeout, like so:

    $ ifdown eth0
    macb f802c000.ethernet eth0: Link is Down
    ADIN1100 f802c000.ethernet-ffffffff:01: adin_set_powerdown_mode failed: -110
    ADIN1100 f802c000.ethernet-ffffffff:01: adin_set_powerdown_mode failed: -110

Fixes: 7eaf9132996a ("net: phy: adin1100: Add initial support for ADIN1100 industrial PHY")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20251119124737.280939-2-ada@thorsis.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/adin1100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index bd7a47a903aca..10b796c2daee7 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -201,7 +201,7 @@ static int adin_set_powerdown_mode(struct phy_device *phydev, bool en)
 		return ret;
 
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, ADIN_CRSM_STAT, ret,
-					 (ret & ADIN_CRSM_SFT_PD_RDY) == val,
+					 !!(ret & ADIN_CRSM_SFT_PD_RDY) == en,
 					 1000, 30000, true);
 }
 
-- 
2.51.0




