Return-Path: <stable+bounces-72708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203FB9683F7
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08AA2817D6
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F513C9DE;
	Mon,  2 Sep 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="riG4JvVq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xXZaSHp4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FE13AA20;
	Mon,  2 Sep 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271363; cv=none; b=t+khQVp1HyHmbEvUXU49A7/A0H1fVN5+Wp7tAFXeGH1MXxqbuw3T63129U8jde4laQrmz+tsCQguHxPF2hceGoJvYcMuyzczkrjG8hj+Srdoyn7jayUlPwjOHUGSASuizFat/ZCeIoIc7jEXfbmrXGxgWmsRCKKG+m0dg8ScHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271363; c=relaxed/simple;
	bh=+Ccpy757Xo2QQBLtqeMfI4RURw9qaPYoXr2k+lsFhEA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sAVyFyuUM6WwVPI5ny+BGtjgJvW5A6VZTatulHBjjBHeF52BvAjpIRJ1QfubbD98B+OazWMnzqWShW/dxa5oY9n/ka9tlr3DNFmp8M5wAiGgjkEO7zd/AX7OlIY6IBlFoPbTVy185lI5BYyJJ6N7LqjeYurh4Ua55IYi01+6Ct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=riG4JvVq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xXZaSHp4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Sep 2024 10:02:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAinpoIOYSPGCi971NxeKgs1budYuEapKTh7AShqhTc=;
	b=riG4JvVqoRt1jFUpFkXPtC9XjsNOUuaM8ziqE6utTM73KB2KYYvoj9WUISYusOUTjBnQhz
	gWEmKmTQNSQACii+s5EXd3GRdaj3xwdG4NdJcJiMZLZB23Dff/bEl1IdaHbQ6gpDY0h07n
	7JgTLDQ2ywwypEfAeRI5CMTaUH1nf28UeLgFQJGNXYVCd25u4Sh24ZbRJDv/3mnioDZ8Dg
	qtnRUjtzC6WvDu5zCn9DmtMLjfeS02Exczkk1UfJRY9R6qVyhq9OaKsgb+W48QrF2iEU77
	Pzjealvc+2Z1asisZdkOVUzOeT2IOOXRc9197FyUVEFWc1cvY5VZKVhj14StPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAinpoIOYSPGCi971NxeKgs1budYuEapKTh7AShqhTc=;
	b=xXZaSHp4pjIUrvWYPSjIphhXB880oZNBIpLf7sKEqAitZlFGkooiygTzl6RRYXjc200Srl
	ihmp0eF8W4LgS8AA==
From: "tip-bot2 for Jacky Bai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/imx-tpm: Fix next event not
 taking effect sometime
Cc: stable@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jason Liu <jason.hui.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240725193355.1436005-2-Frank.Li@nxp.com>
References: <20240725193355.1436005-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172527135957.2215.13837921315515857683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     3d5c2f8e75a55cfb11a85086c71996af0354a1fb
Gitweb:        https://git.kernel.org/tip/3d5c2f8e75a55cfb11a85086c71996af0354a1fb
Author:        Jacky Bai <ping.bai@nxp.com>
AuthorDate:    Thu, 25 Jul 2024 15:33:55 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 02 Sep 2024 10:04:15 +02:00

clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

The value written into the TPM CnV can only be updated into the hardware
when the counter increases. Additional writes to the CnV write buffer are
ignored until the register has been updated. Therefore, we need to check
if the CnV has been updated before continuing. This may require waiting for
1 counter cycle in the worst case.

Cc: stable@vger.kernel.org
Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240725193355.1436005-2-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index cd23caf..92c025b 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -91,6 +91,14 @@ static int tpm_set_next_event(unsigned long delta,
 	now = tpm_read_counter();
 
 	/*
+	 * Need to wait CNT increase at least 1 cycle to make sure
+	 * the C0V has been updated into HW.
+	 */
+	if ((next & 0xffffffff) != readl(timer_base + TPM_C0V))
+		while (now == tpm_read_counter())
+			;
+
+	/*
 	 * NOTE: We observed in a very small probability, the bus fabric
 	 * contention between GPU and A7 may results a few cycles delay
 	 * of writing CNT registers which may cause the min_delta event got

