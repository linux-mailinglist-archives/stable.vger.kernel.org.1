Return-Path: <stable+bounces-20711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E285AB72
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1D91F23A2F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB1482FE;
	Mon, 19 Feb 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGZJdi82"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07970482F5
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368542; cv=none; b=KNfMfh8FrMfbnO1y+nHk2QzQHxUnhQAOyKvb/wGpb+cn/P2EurE+dcqFZrDGGWe7+M33NBSjdzW81koFNlkdr0w6Ui+6XRHSX783dmxH/JFW9CAiqYuY1Ybc+XUom9ROdHdd3wzbRVXVzWEWHyGBGA7k2gGWKjVk+u5xIlkztEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368542; c=relaxed/simple;
	bh=sNXq248MMEtoln/P7vvc66QyOhrXNk7Ii9Hb0YS52/E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aYKqjwahn5q5sHrw7qokusLLFXp40zHNvSMYXAvPvTQocZalAHpgiCucA3ktAH7+27ohO3ZEA7yvdoRazsq75zkc1Uf33B5Ej2rRqC/Kp/oi/S4A2QBSPYiSCA6FyCwS/nlDgviOpyheOmr6JvelgI4GPtUFGsVo9eZFbGYle/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGZJdi82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1699DC433C7;
	Mon, 19 Feb 2024 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368541;
	bh=sNXq248MMEtoln/P7vvc66QyOhrXNk7Ii9Hb0YS52/E=;
	h=Subject:To:Cc:From:Date:From;
	b=PGZJdi82x54toZbOQKpwgo6wDm7qaG4c8QDL0PIGHLFcrDlzvTuifzkRf/CdSPIkm
	 TjZt4bPX/398cFFZTm51rZCDDshTEdrn24JZWfdq5YGfEqBYVTE+NuKY8ZQlRIuHAy
	 hUN2fLJnLHmwfYA8TwlUP6s5a+W/tf0nyoD05lok=
Subject: FAILED: patch "[PATCH] pmdomain: renesas: r8a77980-sysc: CR7 must be always on" failed to apply to 4.19-stable tree
To: geert+renesas@glider.be,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:48:48 +0100
Message-ID: <2024021948-carload-deniable-e02d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x f0e4a1356466ec1858ae8e5c70bea2ce5e55008b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021948-carload-deniable-e02d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

f0e4a1356466 ("pmdomain: renesas: r8a77980-sysc: CR7 must be always on")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0e4a1356466ec1858ae8e5c70bea2ce5e55008b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 12 Jan 2024 17:33:55 +0100
Subject: [PATCH] pmdomain: renesas: r8a77980-sysc: CR7 must be always on
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The power domain containing the Cortex-R7 CPU core on the R-Car V3H SoC
must always be in power-on state, unlike on other SoCs in the R-Car Gen3
family.  See Table 9.4 "Power domains" in the R-Car Series, 3rd
Generation Hardware User’s Manual Rev.1.00 and later.

Fix this by marking the domain as a CPU domain without control
registers, so the driver will not touch it.

Fixes: 41d6d8bd8ae9 ("soc: renesas: rcar-sysc: add R8A77980 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/fdad9a86132d53ecddf72b734dac406915c4edc0.1705076735.git.geert+renesas@glider.be
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/renesas/r8a77980-sysc.c b/drivers/pmdomain/renesas/r8a77980-sysc.c
index 39ca84a67daa..621e411fc999 100644
--- a/drivers/pmdomain/renesas/r8a77980-sysc.c
+++ b/drivers/pmdomain/renesas/r8a77980-sysc.c
@@ -25,7 +25,8 @@ static const struct rcar_sysc_area r8a77980_areas[] __initconst = {
 	  PD_CPU_NOCR },
 	{ "ca53-cpu3",	0x200, 3, R8A77980_PD_CA53_CPU3, R8A77980_PD_CA53_SCU,
 	  PD_CPU_NOCR },
-	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON },
+	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON,
+	  PD_CPU_NOCR },
 	{ "a3ir",	0x180, 0, R8A77980_PD_A3IR,	R8A77980_PD_ALWAYS_ON },
 	{ "a2ir0",	0x400, 0, R8A77980_PD_A2IR0,	R8A77980_PD_A3IR },
 	{ "a2ir1",	0x400, 1, R8A77980_PD_A2IR1,	R8A77980_PD_A3IR },


