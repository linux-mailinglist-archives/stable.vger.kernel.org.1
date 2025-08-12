Return-Path: <stable+bounces-167934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C835B23297
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EE6164CBF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6C2F5E;
	Tue, 12 Aug 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="khcLJ7Bu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51202FD1C1;
	Tue, 12 Aug 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022484; cv=none; b=mycFNSfOEiMDrM7l9JvLweesH098f6xiWhBx1QI1R/WWYWtW5HjI4+0W1YYi+q5QELeqEdkP74dEUonbmp0ABVLuew2A/bWzJLa1SCB4shwF4HFj+Yh80g+lJ0wIyKe8qQ5esyxbJxOTUGa7RYNkLZ9UkGxVq464byMgbDnJuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022484; c=relaxed/simple;
	bh=oZkPh6r5ZA26CGJ9xJ8mypiZeOddzf+YYun5YdEeW4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvOjzw1PKR3Bb4nNQjOpG0KwTzZcz+bnHm0hZK4MwoXjUrCsg8ptgWfWzugsTBBBti6LbDpYYYUKEqFgz9DRHPULFCz7aFqhYlLsP7YVOhqt63QrWvu6uD7sVI8D54zaeAUn5ONGFZYNRl2cYuSKPeZk3dv/HNjNjSQYCU/tDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=khcLJ7Bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A3AC4CEF0;
	Tue, 12 Aug 2025 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022483;
	bh=oZkPh6r5ZA26CGJ9xJ8mypiZeOddzf+YYun5YdEeW4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khcLJ7BuzQsFkCaRT2iCqfmQIN1LMxjE4apkGEazhyWkAa3Z7v75IQ2wXYQ5/dsMW
	 5Ly/MVpveWvARQ624uDuXp9JrKobam00j1RD0ZYvAZ8oHpG+LkTOcs2LvVuDZSl5tt
	 zrz//ZvDbbyaRI/ZAAJJwZx7c8dq5o5ArM9uYVSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jerome Brunet <jbrunet@baylibre.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 167/369] PCI: endpoint: pci-epf-vntb: Return -ENOENT if pci_epc_get_next_free_bar() fails
Date: Tue, 12 Aug 2025 19:27:44 +0200
Message-ID: <20250812173021.052727821@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 7ea488cce73263231662e426639dd3e836537068 ]

According the function documentation of epf_ntb_init_epc_bar(), the
function should return an error code on error. However, it returns -1 when
no BAR is available i.e., when pci_epc_get_next_free_bar() fails.

Return -ENOENT instead.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
[mani: changed err code to -ENOENT]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250603-pci-vntb-bar-mapping-v2-1-fc685a22ad28@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093..3cddfdd04029 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -700,7 +700,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
-			return barno;
+			return -ENOENT;
 		}
 		ntb->epf_ntb_bar[bar] = barno;
 	}
-- 
2.39.5




