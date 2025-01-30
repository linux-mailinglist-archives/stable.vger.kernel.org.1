Return-Path: <stable+bounces-111362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF77A22ECD
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D013A6309
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC001E9B28;
	Thu, 30 Jan 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/4gbe75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94141E9B25;
	Thu, 30 Jan 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246516; cv=none; b=cgywedQIrozv4fCCZrlavNF+S7rNsWcCQgmqMQzsmleQ9N4WnGmoGH/qwq0KXbmaQpFwZNGk2tbKApeps1uXj8M89X+9rtqLbJu5kOlVwiqG0u9dozPYh3pJgR/B9yg1UiVCuMMWn4Yj8XMXs9wBZTufpkL8vEQkM/PhM984S8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246516; c=relaxed/simple;
	bh=lCJq/YRfkCpF69WiJSiibgylYDDj4xdY76rY0TkTkag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzGT87amuPsM1T1MFq+RTfaAELHNvx042zPYhfRI2fEPY8v/vHCvmZATyNj4CmC7M4Jtn9xpxvRLwri6bhFQYdtzwwWPD0L477bO/5/pio/oA5AwhzGREaPA4Mf6ukJlfbKJdi8i70aB1zHBLBNwIVGzZjss2kTCALBgg+bD7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/4gbe75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB9CC4CED2;
	Thu, 30 Jan 2025 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246516;
	bh=lCJq/YRfkCpF69WiJSiibgylYDDj4xdY76rY0TkTkag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/4gbe7562bJgfVl9Ev9yCmJulRMXKjsy/G02lmGxbgncqIJALkA+XdQ7n7p3E5ru
	 ck9rL372ynn1exw5NI60GxIr1D4hT4KS6O5iZKqMUBUj66Vti3E8gXmnHL650gBmR6
	 pun/JtfPWW7oqtCbgwMHkdV+nv3wqQHGILLgfotI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 06/43] of/unittest: Add test that of_address_to_resource() fails on non-translatable address
Date: Thu, 30 Jan 2025 14:59:13 +0100
Message-ID: <20250130133459.157495774@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
References: <20250130133458.903274626@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring (Arm) <robh@kernel.org>

[ Upstream commit 44748065ed321041db6e18cdcaa8c2a9554768ac ]

of_address_to_resource() on a non-translatable address should return an
error. Additionally, this case also triggers a spurious WARN for
missing #address-cells/#size-cells.

Link: https://lore.kernel.org/r/20250110215030.3637845-1-robh@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest-data/tests-platform.dtsi | 13 +++++++++++++
 drivers/of/unittest.c                        | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index fa39611071b32..cd310b26b50c8 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -34,5 +34,18 @@ dev@100 {
 				};
 			};
 		};
+
+		platform-tests-2 {
+			// No #address-cells or #size-cells
+			node {
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				test-device@100 {
+					compatible = "test-sub-device";
+					reg = <0x100 1>;
+				};
+			};
+		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7986113adc7d3..3b22c36bfb0b7 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1186,6 +1186,7 @@ static void __init of_unittest_bus_3cell_ranges(void)
 static void __init of_unittest_reg(void)
 {
 	struct device_node *np;
+	struct resource res;
 	int ret;
 	u64 addr, size;
 
@@ -1202,6 +1203,19 @@ static void __init of_unittest_reg(void)
 		np, addr);
 
 	of_node_put(np);
+
+	np = of_find_node_by_path("/testcase-data/platform-tests-2/node/test-device@100");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	ret = of_address_to_resource(np, 0, &res);
+	unittest(ret == -EINVAL, "of_address_to_resource(%pOF) expected error on untranslatable address\n",
+		 np);
+
+	of_node_put(np);
+
 }
 
 static void __init of_unittest_parse_interrupts(void)
-- 
2.39.5




