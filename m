Return-Path: <stable+bounces-197107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554AC8E9BE
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DF1A4E983F
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A43112BB;
	Thu, 27 Nov 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Fs7Nu9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FE2BE7CB;
	Thu, 27 Nov 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251399; cv=none; b=q5KplYsD12IzeM4ILAPrGgzQ+NCSGsfUz02J0EE8SoL+CKl3qn97evJ+rV+J8PXOh3In5t9GuwFPBhqy/xH03pI4TA3CNiYASCr3nnN95M3UUt3qbTm6BevJGWAjJbweDEpg8vAXZ/0zw9c4H4TmbmCJvBMcwtrBBCnWIz7rjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251399; c=relaxed/simple;
	bh=ldNQ9/HIcgP4MU2NFoKDrqzoOkSvGccrnrpLh4dpWbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzOGnj5rhdQJ3V1ys+KMnqEKNxyEO63kIVTzSorNXjDhIp0V68AJ9kBcKPxblhJSCAaWefBTGYf4M3eAw6wEPXE6ENldkQM/aekGoqKQm+iNPvzpjVcsP1SZb5wSDv0d1vRIHHkpVWYLuKEKRYmFxrGVISf0TyOEcFkO2TCP2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Fs7Nu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFC7C113D0;
	Thu, 27 Nov 2025 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251399;
	bh=ldNQ9/HIcgP4MU2NFoKDrqzoOkSvGccrnrpLh4dpWbk=;
	h=From:To:Cc:Subject:Date:From;
	b=h0Fs7Nu9fveSL39jsljibq1ALvjr0xLtJPmuB+Qy/wVNYiSP+U4AowUXkvD8DdmWz
	 Gj0Jn/nSITerg7WC87Q4AcoETKMoyq+kbd3Ze07fqBuRZEY0sV2v6lMUR6XCR0yigh
	 fqVWCTGXTlFhE6w3NFeiUMoq4mRo73pwhwgbWLa7MdL+woFAMXW53W7alY8RLeC2O8
	 f27sIMkbsYl60/pNBQ7WwMQl0KxgfL6wlJqMdT6Jjn05UqmyD0CNLHmtpC2oi7Bgge
	 bs0Qx2dqU5mYduB1Adm8HVNwMbboxDuzGq+8IYC0PptAUik3WeGM/eJbW6dvB4SmfJ
	 pXzCT2uEIt7tQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOcNl-000000000Yg-3iAQ;
	Thu, 27 Nov 2025 14:50:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: [PATCH] soc: ti: k3-socinfo: fix regmap leak on probe failure
Date: Thu, 27 Nov 2025 14:49:42 +0100
Message-ID: <20251127134942.2121-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmio regmap allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: a5caf03188e4 ("soc: ti: k3-socinfo: Do not use syscon helper to build regmap")
Cc: stable@vger.kernel.org	# 6.15
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/ti/k3-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 50c170a995f9..42275cb5ba1c 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -141,7 +141,7 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	regmap = regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
+	regmap = devm_regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.51.2


