Return-Path: <stable+bounces-189872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617FBC0AD4C
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2C3B3CEC
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CA218EB1;
	Sun, 26 Oct 2025 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfKSDhVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE1B2080C8
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495929; cv=none; b=VjLxwcxLxAV/LZIeVdu7Mhxpo3lA/F1F+zpRs/pghgWozRksCx7DybWHNdvWxl4VQI4VaeGMx/5BPklld8rD41sDt6VF2ZmrVadh00jwcXVx1LjrGLJa08yC/pJ6/SIsPjYN9cdo7pjUsz54t1s6p8Wq8ZxvbPa5N8Fnol8twfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495929; c=relaxed/simple;
	bh=x3QlgeWGH5Azd3bx9wXI7yK4rf72Qv8NmLiozT7qHPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOq9WNm2pjIslOQYWFXHVFGCR9rNbEqhaeYEgPneKc2Rd4mXDFJ8Jl92GxJXAg63n9XRlql9I2ntj9Y+yjOOM/Xqi8BhEvULLM1THIwg6vFSHkSsc94qzLGCaZ6Ggcs6loJHneR7ecnxHPDqrGbMVWeakusbIMiQfq42VUZO2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfKSDhVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D23DC4CEE7;
	Sun, 26 Oct 2025 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495929;
	bh=x3QlgeWGH5Azd3bx9wXI7yK4rf72Qv8NmLiozT7qHPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfKSDhVWhhVHpUoQiCeFZJxkT8G8eFgdhIHtGDyiTnT5aRhWzW4A8UOTL8trPYxvf
	 PNtBxDZId8FSSsAbRDc5FfSfHuhBvYv9PkN72bwQQboy9C/WjaEpKh0lVCpzdUNCF7
	 FxjV0xLlmXH4mdgqGOt3Sc1b88LtHmAd8gV6v0ip1524I/Rl0VLApYh8/EMYUPHL67
	 QzeQboAs9gUb4vUGIt7GRyJkcjZc9m6TlvcpOm2PRVcN7Ip+ZS7UMC+K86akdSucmo
	 4zaQkZ3fhlTHqYjxn2C4m0ETtUjmC6eQ1osiGEhETWqxYytHd/EQT4hDtjK0wILH1a
	 R+W+tBmOk1mmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	stable <stable@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Sun, 26 Oct 2025 12:25:25 -0400
Message-ID: <20251026162525.110118-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102641-hydrant-wake-e29d@gregkh>
References: <2025102641-hydrant-wake-e29d@gregkh>
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
index 31bd6f4e5dc47..69dea9825f6a5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -290,7 +290,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
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


