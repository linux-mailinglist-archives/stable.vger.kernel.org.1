Return-Path: <stable+bounces-193220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24848C4A165
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8DBF4EF0AB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A9214210;
	Tue, 11 Nov 2025 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MZPYaXkb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBC1DF258;
	Tue, 11 Nov 2025 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822583; cv=none; b=tmyoNpBs1Q0islde0H8CpyuB5r+L4rB+t0Il+TdqbLMRVdRiyAcOglAl3YOpb3URKbMkXkzlC7DR8wFU3G/vUhkqC+oAKeVJ7PfTFprBpHUsoZ+8Mps4GSA//CuspOVDsQsqJYwDWVZSZpjL/m1jXE/219ziunPjHv6vPPMeXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822583; c=relaxed/simple;
	bh=gQb6YBSDGlwKF0w8YdH/uoGYEME8Sjh0brqGJsxgeSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg3OtpiHQRCDXvVmI4X/coVEx9Efui6EcRcOzvAKvAKnnbyBwg33HvGtkSMegisQFSMqxZWRXE5ZD0r4V9uJshcwT3MIPDADCOYJEX9xj0T8HlSSAYFkWgaK5r9OAffpxzZG1r8vxKXx/oWPT63C7PJG2pwFNB1jmYW5i2eQm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MZPYaXkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A69C4CEFB;
	Tue, 11 Nov 2025 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822582;
	bh=gQb6YBSDGlwKF0w8YdH/uoGYEME8Sjh0brqGJsxgeSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZPYaXkbSKdlp5uqOrlpfgcUYz8PKr51qtAXRnlvjLwaBtZ7yDj1Hd5NoXW+NPgUL
	 FU+JAKef/wHM3SHa/kbLdLZkaB4pqBFvPwZ70r+XIpvgxKmgfLmHtco0o820o+9IkJ
	 A98iSuTZpP2ULuTaLfmxhngsNoI5Nahb2jFoqn/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Doug Smythies <dsmythies@telus.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 079/565] cpuidle: governors: menu: Select polling state in some more cases
Date: Tue, 11 Nov 2025 09:38:55 +0900
Message-ID: <20251111004528.746148730@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit db86f55bf81a3a297be05ee8775ae9a8c6e3a599 ]

A throughput regression of 11% introduced by commit 779b1a1cb13a ("cpuidle:
governors: menu: Avoid selecting states with too much latency") has been
reported and it is related to the case when the menu governor checks if
selecting a proper idle state instead of a polling one makes sense.

In particular, it is questionable to do so if the exit latency of the
idle state in question exceeds the predicted idle duration, so add a
check for that, which is sufficient to make the reported regression go
away, and update the related code comment accordingly.

Fixes: 779b1a1cb13a ("cpuidle: governors: menu: Avoid selecting states with too much latency")
Closes: https://lore.kernel.org/linux-pm/004501dc43c9$ec8aa930$c59ffb90$@telus.net/
Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/12786727.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/governors/menu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -324,10 +324,13 @@ static int menu_select(struct cpuidle_dr
 
 		/*
 		 * Use a physical idle state, not busy polling, unless a timer
-		 * is going to trigger soon enough.
+		 * is going to trigger soon enough or the exit latency of the
+		 * idle state in question is greater than the predicted idle
+		 * duration.
 		 */
 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-		    s->target_residency_ns <= data->next_timer_ns) {
+		    s->target_residency_ns <= data->next_timer_ns &&
+		    s->exit_latency_ns <= predicted_ns) {
 			predicted_ns = s->target_residency_ns;
 			idx = i;
 			break;



