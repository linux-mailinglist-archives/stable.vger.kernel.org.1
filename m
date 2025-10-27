Return-Path: <stable+bounces-190979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180AEC10F5B
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30F0564450
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1A31DD87;
	Mon, 27 Oct 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1aiFd83r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D52D6E70;
	Mon, 27 Oct 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592699; cv=none; b=DomYVK5Ju+mt3WIPmQJpXUtyZfYCmhRDjDMNu5gzgrriVpkn3c6Zfr07OoVZ4H67m9UOA8S8GfwbVcTADdREDyBAzL1Ja6NC+sgO4NjilxH+qBdybIeLQXjLYrmQk0FstN2CWzHWgTMGNjTOwbVqYpALBnANhP4M74AEJsKJP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592699; c=relaxed/simple;
	bh=j6nL9DxpLauzjuOEY7soJY6U+3khwRTrv6VsYZnMxAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCzvbbJ7O6GR5zB24bR16EQU+4uPeaIymg2oIg2OM5WzxepyQ2DmW/JRWX9Hw0OY+EqdZ8O/tU/vqi1C/KZM4XlEG55d+mMMJCDuJYEwFvQo1UF0LKsQXFhWsH3QU3+TMZu/bJiFuFuS7+BBLhaNlLohBpaF5qW4g8sTCCnk9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1aiFd83r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05EEC4CEF1;
	Mon, 27 Oct 2025 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592699;
	bh=j6nL9DxpLauzjuOEY7soJY6U+3khwRTrv6VsYZnMxAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1aiFd83rj1++FVBxHws3pcQoVYIusfrSLTlVRYDyvZ7MvTn+np5TvHU+GYWroz+NU
	 ZcmGNhs0FcnX8oG+D/ZCdz/oBjozqCvZN1A7JVsYa/pFk1mkzjYqQa82JVRnwsC4zl
	 R2Uj9NcJebC0m8p6MkbZnWqTVKkSB0458s9WJi1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 6.6 33/84] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Mon, 27 Oct 2025 19:36:22 +0100
Message-ID: <20251027183439.704393007@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
References: <20251027183438.817309828@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

commit 2eead19334516c8e9927c11b448fbe512b1f18a1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/arch_topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -326,7 +326,7 @@ bool __init topology_parse_cpu_capacity(
 		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(capacity_freq_ref, cpu) =
 				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);



