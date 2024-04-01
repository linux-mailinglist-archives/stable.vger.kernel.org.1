Return-Path: <stable+bounces-34384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5C893F20
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F92B20A46
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B864778C;
	Mon,  1 Apr 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WyEra/W8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376A43AD6;
	Mon,  1 Apr 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987941; cv=none; b=MrHPlfjRDKJgWpnC/x9qJBjdr9Q0S3kxBZMgAFEn6kD++nSyn5RYTJEyGAbSRrwH7/DjcOwKx1tCZx0bR0iDO3lAcv43Znta0MI1Qxml9K4pG6Anj/d857wxvZWzFHiIQEgnduyqBcUJF69z3ke1VuiQjux4JqpA3OxlfYZT8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987941; c=relaxed/simple;
	bh=DOTmmK/GTkfoMrH+J0aJmTr4YFOTR8AXqHxXTvlx1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZoH7iLTiPrs8UUT1JLhpDr3IPRQChSFkkR0Oy4semTx1k59FFZiEyEqfUlZ0QtKi9EuecF8BIjp0yYxXTF3qHDs5Tx3wk6MKusPcXB4lH3gZqEPPjeIHUkMIKPEa5zzDZanFPRmpHZhxFyUrNz7VR2YPqvl4/BL1XY0L0ZsXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WyEra/W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3783C43390;
	Mon,  1 Apr 2024 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987939;
	bh=DOTmmK/GTkfoMrH+J0aJmTr4YFOTR8AXqHxXTvlx1tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyEra/W8QPL/B0njrMyspmPUkSQYIBlYzWLT8A78bwkwl3EFtdMqXRJ5hKQRw+DGl
	 C39rLG8j1ICXkKUAbIqx+HvRmJ6agxN8Gf9FCAv1r/lodySy7Ye53jtuRlfxLs0F37
	 QiKOxgs/dTtaJy0cbC1f7q3IIQoXs6NfU1gAD7Zo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 036/432] powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core
Date: Mon,  1 Apr 2024 17:40:23 +0200
Message-ID: <20240401152554.209619642@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 5580e96dad5a439d561d9648ffcbccb739c2a120 ]

If nr_cpu_ids is too low to include at least all the threads of a single
core adjust nr_cpu_ids upwards. This avoids triggering odd bugs in code
that assumes all threads of a core are available.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231229120107.2281153-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/prom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b1..58e80076bed5c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -375,6 +375,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	if (IS_ENABLED(CONFIG_PPC64))
 		boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
 
+	if (nr_cpu_ids % nthreads != 0) {
+		set_nr_cpu_ids(ALIGN(nr_cpu_ids, nthreads));
+		pr_warn("nr_cpu_ids was not a multiple of threads_per_core, adjusted to %d\n",
+			nr_cpu_ids);
+	}
+
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
 	 * meet various levels of the architecture:
-- 
2.43.0




