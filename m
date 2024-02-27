Return-Path: <stable+bounces-25193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2F869877
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E72B2EFD5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03882143C46;
	Tue, 27 Feb 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0LyNtVF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B528C13DBBC;
	Tue, 27 Feb 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044122; cv=none; b=mu29YD9/XWJidzteosh/HtDug5yz4z3rEDSWogzNBYzkMI1v5cRT62e6njq0QvHbE9/r6JdYxYZNMZJiFT/fVMcI5Tkeb/HSalpONwRJBBCeakd/s7jftxa4sJYEfSaCxjUNNHO5+vkq98m+LXrWUMJ5RrNGoWVfZqSuosr4EjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044122; c=relaxed/simple;
	bh=Y6GQ3NhJcjsthDQUjVAKYjy1w1v0OhbosZDOijBAmbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qbv+eQzDL0HXsJhiZveyzFOWJv6ozpuQoZr+0zsrgUzhYAJ6UPV3sHGqk88yJqfpXGJlo1s2AOoAtgsqwih3OKAnTWAo+JnHFcjht9uLG3j7PQrbVkKUdIfb3Ptk6MLlVurhMVFPy1evKLTsmnMsyER+0ks7MHgCVqsmpEjZ6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0LyNtVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAF9C433C7;
	Tue, 27 Feb 2024 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044122;
	bh=Y6GQ3NhJcjsthDQUjVAKYjy1w1v0OhbosZDOijBAmbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0LyNtVFrJtrPidbsH7mjfLXahB/lK3mJsjknmG1pbPwKT/hfz4uJF/79vIoiQC56
	 cvqIXjGgWMz50/T3AYHatMPbr3Ms+8ISa3RGrxi0DiOu/AOrxa792i7A/VEDdcZBAt
	 aKbMyDuH1vhJ3AUVUayRfrqSBIGTMsuloAaUpZqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 042/122] pmdomain: renesas: r8a77980-sysc: CR7 must be always on
Date: Tue, 27 Feb 2024 14:26:43 +0100
Message-ID: <20240227131600.085326148@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f0e4a1356466ec1858ae8e5c70bea2ce5e55008b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/renesas/r8a77980-sysc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/r8a77980-sysc.c b/drivers/soc/renesas/r8a77980-sysc.c
index 39ca84a67daad..621e411fc9991 100644
--- a/drivers/soc/renesas/r8a77980-sysc.c
+++ b/drivers/soc/renesas/r8a77980-sysc.c
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
-- 
2.43.0




