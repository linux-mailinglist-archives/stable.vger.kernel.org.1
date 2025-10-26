Return-Path: <stable+bounces-189867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C325C0AD12
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BB63B2831
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B147F77;
	Sun, 26 Oct 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvAFYHdK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18B45C0B
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761494653; cv=none; b=NwnvwyROzOMabDv7d9uBMq/+j2068jAH74qO54WjsBxyLCgkiQbIRGc59cvklLqLC3FTjUfEKkPmP9OmBMxBjNNzWvyuFGJ8UKhZcsH6fqR8OwbpkIKGolPQcIaWPAJLrY8uVH/yfbqWsc2JdbrtVM1q8isHxE+mbSgk7zZAqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761494653; c=relaxed/simple;
	bh=GBLghVRIk7l7XF07Ryix04tAB0/j3SJzUcDb9bWfjs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/Mcpe7PksPcflTJoOGrPf5BWTMF25XlWw/WU9J76r9VDkmH5YbN+u/rI2eU37U1VcUrl+a/ZOW8czT4abq4DBV3HkB2GseyLOqvCgeQHRzFJcsnza2ZVGTypsqaj8mhviD12OaEYAVHmN5EEz0HF18kEmhHo1PJmIosfm4l3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvAFYHdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201A2C4CEE7;
	Sun, 26 Oct 2025 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761494651;
	bh=GBLghVRIk7l7XF07Ryix04tAB0/j3SJzUcDb9bWfjs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvAFYHdK/RUIaai7hd3CAQ8Gus+CAMR2mW7sG9UZG7N27cbbGJ68++Ari23PwF8Py
	 By4EOc+4Angd+BssDMFrf2wBFzUcy0Ti2m6aWw7QqDmQIacwj4Hgu3CgTxyti6tyWS
	 DoD1V1kW04DT6/8R12ggmt9C3ZQKrZM6rZXK6DSa/OENJRG7dUGokoCzyzgFUjw5JD
	 7ZDoivDEeF/kVL/yHQGVQ2lEsu+M0MSgWA5+4GATXDDT9GXld+oZcVuzDapWsKDpQB
	 /TUahts2Tb2CMsYEzi+vVbCzztuVxt/tYPWv4y9uDBeHhzchwr2V5ENHpceFVESWsu
	 sR971Z1/3HECQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	stable <stable@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Sun, 26 Oct 2025 12:04:08 -0400
Message-ID: <20251026160408.99204-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102641-derail-shine-9dd5@gregkh>
References: <2025102641-derail-shine-9dd5@gregkh>
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
index e7d6e6657ffa0..b97c5a240cc90 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -327,7 +327,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
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


