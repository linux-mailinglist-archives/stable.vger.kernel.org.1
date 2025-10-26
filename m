Return-Path: <stable+bounces-189876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F0C0ADBB
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF001888E31
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7624DCF9;
	Sun, 26 Oct 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDQXXC2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8D11712
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496657; cv=none; b=KbkfmqGOJYKPcq7uw6diQUbcIOoBP5yaq0JbkQERreJH0gC5IdFz3c/HwRE49wLO7VAb/NCBSHqOvK6s4yoVOI4k77aVaRPDsKpZ+bWeV9dquff6o+FmhyU9q/VLnveZF/Y52r5Agn8M4cys92VS1bRRenMASpPb/zEywLUdXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496657; c=relaxed/simple;
	bh=66al/Bk0ZkH1m+qa7OdNy5xOhTH/uRaMRmlzcd8O7n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNN4o9tMukIX6D0XXk9zvsZBNS2gbgHtpcqCNXmzCCBTjxEvHshCE4zMqy6oYOJVyFflVcGmyI4QGEcxcj2jUFMSzEb6cCqFUEAevurYuHQftShdhlWHt0q0/96Dfg95XxGCc85XACURBgrNlUHaz+6bmiKYhdo8zDny07KK9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDQXXC2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C51AC4CEE7;
	Sun, 26 Oct 2025 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761496656;
	bh=66al/Bk0ZkH1m+qa7OdNy5xOhTH/uRaMRmlzcd8O7n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDQXXC2uNRgaqNF4vSZZogRern2i0+nY8dcKtjQbsVcDrP7i2itI++jAwXpJyA1Fd
	 9R1B2bth69sQD9BQe85Q8zAzMG90gX2qQsU/Fuk8ur8Q7dKvUmxoadCI0ewiv9adGB
	 4C9ySYxVkGrS2GagAdcdcXZN8a2HPHgenOmiVaHnbDbc40q/0MBcKNATcr0obEz2Qb
	 yb62ckXkDytYjQHQSo8fpTHAg1pbvOWfK80ZUkn1MJe53VFJwUSeFDSimqKDqtbqPT
	 UEkBngOvvICKdLlI5fZCFoW8amZDDg8IehI59TJNIBRg2HvZu2FTTQtzSp+1ucBGBs
	 U08Zv7phbL0Lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	stable <stable@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Sun, 26 Oct 2025 12:37:34 -0400
Message-ID: <20251026163734.117582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102641-epilogue-pronto-38c8@gregkh>
References: <2025102641-epilogue-pronto-38c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 2eead19334516c8e9927c11b448fbe512b1f18a1 ]

Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
which causes the code to proceed with NULL clock pointers. The current
logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
valid pointers and NULL, leading to potential NULL pointer dereference
in clk_get_rate().

Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
"The error code within @ptr if it is an error pointer; 0 otherwise."

This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND NULL
pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true (proceed)
when cpu_clk is either valid or NULL, causing clk_get_rate(NULL) to be
called when of_clk_get() returns NULL.

Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid
pointers, preventing potential NULL pointer dereference in clk_get_rate().

Cc: stable <stable@kernel.org>
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities with current freq")
Link: https://patch.msgid.link/20250923174308.1771906-1-kaushlendra.kumar@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 51647926e6051..c701445ec99fa 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -196,7 +196,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial freq_factor value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(freq_factor, cpu) =
 				clk_get_rate(cpu_clk) / 1000;
 			clk_put(cpu_clk);
-- 
2.51.0


