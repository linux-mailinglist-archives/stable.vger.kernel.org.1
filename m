Return-Path: <stable+bounces-155653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E0AE4355
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4E6179D22
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF7252910;
	Mon, 23 Jun 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNVkKGGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15790253B67;
	Mon, 23 Jun 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684986; cv=none; b=RX1q6xBY/BiJS7p2ZSrxXmiFd2kHEdA1OnU0s+rLG3/r9+MsA0eAirsnO1B8jEi+YLV8YNs6YXRe9OP6pP0U56QLolkfZ76WlGVdozmKkopHhtxA96UXb8zbvh9p3zP4VIWFZ6IQd0gUM5qAwmiSiFH0cQWrNglg7/Ll9VzqaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684986; c=relaxed/simple;
	bh=bmhSucPEHx344BICdeAEWG4mt250O1wafPRVe0xVouw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sysddsQEYXWl/sVvcXCizbjxGxC14qFqHWzmwUpknrmCWS9qlp5oYp6a2BVY316MwkoR9wZJzMs3pNvSl6MCH4aVuIfVgoyQBeXD/hFI3Asi0Y9hHOW6pA05zGkKa9xMNMDbCx2tI4LfBtwh8Bd0/M6sxNu7lMQowXJot3lB6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNVkKGGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529E3C4CEEA;
	Mon, 23 Jun 2025 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684985;
	bh=bmhSucPEHx344BICdeAEWG4mt250O1wafPRVe0xVouw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xNVkKGGcHe8KDnmNtStM/F9513f/5G4PDAb4Q0/5L4Rw0KLU8T4fD7OiOsaRjDOYq
	 HOPNSpfRpEt5y9lEb3VA6c8cvHxafJMIfMXW5ZEGZdAjQgHze18z1E3b/XqZVqxSyO
	 BuqPTYtTUehEo8hoUpPMIf0mxSfNK+bTYdKUQviQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Feng Xu <feng.f.xu@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 019/355] EDAC/skx_common: Fix general protection fault
Date: Mon, 23 Jun 2025 15:03:40 +0200
Message-ID: <20250623130627.375258293@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit 20d2d476b3ae18041be423671a8637ed5ffd6958 ]

After loading i10nm_edac (which automatically loads skx_edac_common), if
unload only i10nm_edac, then reload it and perform error injection testing,
a general protection fault may occur:

  mce: [Hardware Error]: Machine check events logged
  Oops: general protection fault ...
  ...
  Workqueue: events mce_gen_pool_process
  RIP: 0010:string+0x53/0xe0
  ...
  Call Trace:
  <TASK>
  ? die_addr+0x37/0x90
  ? exc_general_protection+0x1e7/0x3f0
  ? asm_exc_general_protection+0x26/0x30
  ? string+0x53/0xe0
  vsnprintf+0x23e/0x4c0
  snprintf+0x4d/0x70
  skx_adxl_decode+0x16a/0x330 [skx_edac_common]
  skx_mce_check_error.part.0+0xf8/0x220 [skx_edac_common]
  skx_mce_check_error+0x17/0x20 [skx_edac_common]
  ...

The issue arose was because the variable 'adxl_component_count' (inside
skx_edac_common), which counts the ADXL components, was not reset. During
the reloading of i10nm_edac, the count was incremented by the actual number
of ADXL components again, resulting in a count that was double the real
number of ADXL components. This led to an out-of-bounds reference to the
ADXL component array, causing the general protection fault above.

Fix this issue by resetting the 'adxl_component_count' in adxl_put(),
which is called during the unloading of {skx,i10nm}_edac.

Fixes: 123b15863550 ("EDAC, i10nm: make skx_common.o a separate module")
Reported-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Feng Xu <feng.f.xu@intel.com>
Link: https://lore.kernel.org/r/20250417150724.1170168-2-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/skx_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index b585cbe3eff94..1c408e665f7c9 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -112,6 +112,7 @@ EXPORT_SYMBOL_GPL(skx_adxl_get);
 
 void skx_adxl_put(void)
 {
+	adxl_component_count = 0;
 	kfree(adxl_values);
 	kfree(adxl_msg);
 }
-- 
2.39.5




