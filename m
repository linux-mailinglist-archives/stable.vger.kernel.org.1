Return-Path: <stable+bounces-187844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2EBED247
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51054E3AC3
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC631F3BA2;
	Sat, 18 Oct 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QguKNl1z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A2EEBB
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800453; cv=none; b=DP6zam9ePWnes4zHPb4h3QQ/lQ3R5Wk+HOyYNHPy7PogSfTv8Bbla60hlL7iPf5++fQhFPdC9l2qKuQNjX0q7jJve3fN/EUAo8PTbCUT7NCqUOdPg2sPSIvPgozTKlXAA2/EOCdTAvSp9STnxT0Vu5sH6yfvYwC2BQqxr2houkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800453; c=relaxed/simple;
	bh=SCwAPnzbFicBTxhqkOrIah7n6hoIu4n2W+SY6m2jrrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1118B8SES6brT4ZSpbJb9ia4NRrN+tbIxZmTr8k8QwvpobBrTAaK1IrYRW5oeBLSTJ+W7s5SGiptJePcse02ZH6s7idkTCQ53cWjyGFzo0kD1X+7N48LgHLkFcQUgC9BCo+iY/Ymi2zrw1CpoBctThOHgDxA8EpA6M+ejBhDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QguKNl1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1396DC4CEF8;
	Sat, 18 Oct 2025 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760800453;
	bh=SCwAPnzbFicBTxhqkOrIah7n6hoIu4n2W+SY6m2jrrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QguKNl1znR44YdUPHI4lcM54PEt807flE1+JDi6XtUqDFvJ2D/BT9VVZHuuIvhG7X
	 5GNlRJ5bPet9XZSuhyeoQmGZafx8KBAJlzu/vlTmlat/wcqC8TvsIUabEUuqL52Odt
	 4I6NH1GresE1rqpSrYiDtvOIBlGnAutiglTacT2EOZeebqt+jKe7bh6dsmIc/L4ffJ
	 U/AJUGeH33ispHfjZiSCkXa643T1Rf3bi6qtVGFJpZgDVzReUhVBCaTLH0pO6s3b2M
	 X4yxlxsQPgGshX/JygPHqCWZ/f2h3G1KPvMXfWIDMAV6Nz6V83j8TWSzaPH6qamavL
	 q6fQTQbZa6dGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] cdx: Fix device node reference leak in cdx_msi_domain_init
Date: Sat, 18 Oct 2025 11:14:10 -0400
Message-ID: <20251018151410.809778-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018151410.809778-1-sashal@kernel.org>
References: <2025101657-coaster-squall-0e3f@gregkh>
 <20251018151410.809778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 76254bc489d39dae9a3427f0984fe64213d20548 ]

Add missing of_node_put() call to release
the device node reference obtained via of_parse_phandle().

Fixes: 0e439ba38e61 ("cdx: add MSI support for CDX bus")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Nipun Gupta <nipun.gupta@amd.com>
Link: https://lore.kernel.org/r/20250902084933.2418264-1-linmq006@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdx/cdx_msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 0bb32829d9084..d7bade143998e 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -174,6 +174,7 @@ struct irq_domain *cdx_msi_domain_init(struct device *dev)
 	}
 
 	parent = irq_find_matching_fwnode(of_fwnode_handle(parent_node), DOMAIN_BUS_NEXUS);
+	of_node_put(parent_node);
 	if (!parent || !msi_get_domain_info(parent)) {
 		dev_err(dev, "unable to locate ITS domain\n");
 		return NULL;
-- 
2.51.0


