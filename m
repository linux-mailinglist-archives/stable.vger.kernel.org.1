Return-Path: <stable+bounces-34837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1AC89411A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7B028351B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580D47A6B;
	Mon,  1 Apr 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hW5X76gY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B010A3B;
	Mon,  1 Apr 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989465; cv=none; b=SUrt0gkuDVsHEUbF+88jUvdMdZyJ7gmZEHZ7AtSG74GMzEM1ALkDmpBCW6MI9JVTttIRBSKzdKhsUvPz21sNB9qJaKn8EVkR8QEodCPnNldFc5coAOc2riEhhREPpSUeh4AdZmO/VyNnVIjF70mS7nndgcRz0GoNLh5wtJcZQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989465; c=relaxed/simple;
	bh=BtuyZbF6wcEIc6pRwqotNKXSRW44lrjKZc4Nu8CHsZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCc5fMgBvIv+5WWRPuTJQgjzcK4G2GH1wDh5Gw4k4rEqXJDvUH7diIaOqPbiJD9hqzV9jA/wFdhwhcfPxHPVpPz8Q13nHCAXqgse34yE42nDJEox0oVjrpgEf0zRbI9UCm2kNySGfDAWFwwmqTRcZY0E7mMXiIDTjfyzOVIhBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hW5X76gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CD4C433F1;
	Mon,  1 Apr 2024 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989464;
	bh=BtuyZbF6wcEIc6pRwqotNKXSRW44lrjKZc4Nu8CHsZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hW5X76gY4Ou/hHtrKcVyHx11vRmZl/e2/WtiWL72oQe0TGCyOsoOL0C7v9nMU67GS
	 9YUrlRIqeoG7O0WMSx2FyjYMZF9cQfsEh6odK+YW6Xqj4H0P+l0ZzYUc0VirAXiHUt
	 FiG4zVthnohEBkrqmpniKNccNKZbc86ioDPGrkrk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Tor Vic <torvic9@mailbox.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 028/396] cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_perf()
Date: Mon,  1 Apr 2024 17:41:17 +0200
Message-ID: <20240401152548.743050476@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Tor Vic <torvic9@mailbox.org>

[ Upstream commit b26ffbf800ae3c8d01bdf90d9cd8a37e1606ff06 ]

In the function amd_pstate_adjust_perf(), the 'min_perf' variable is set
to 'highest_perf' instead of 'lowest_perf'.

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Tor Vic <torvic9@mailbox.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: 6.1+ <stable@vger.kernel.org> # 6.1+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1791d37fbc53c..07f3419954396 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -570,7 +570,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (target_perf < capacity)
 		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
 
-	min_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
 
-- 
2.43.0




