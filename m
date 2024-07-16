Return-Path: <stable+bounces-59598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E2F932ADC
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842451F22158
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5631448ED;
	Tue, 16 Jul 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UTKZ2+Mt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD34B641;
	Tue, 16 Jul 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144331; cv=none; b=BrGBDdEmI3ZHNPcFbOotB7y+78f0RZk1VWqD3EveZ3UPn1efEcQtBjZmLHAo7cyL+F//WDnXlzcCTUTAe6Gv4pHIGKceX7qeRZ+432nXSpDg2F7gUi6j8XmsbdplqzkDTH5OsonUIMieuvna19k6wSc9hmq1kxtPFZy2cp5vMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144331; c=relaxed/simple;
	bh=lfM+6k/rouzS4RL0B95zjf0hPFXBuMa922+uqAO7ye0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5MTbif4MZ6qbUcCQFTvScqz6U1/gbyyWd9w55kkq5qRix9CydSGlj9V033jZTLIWaPzJv66ANXOWvyOCUULVJfELm0q0mjurzsc0jvAFlFqgtWl2w+/EfPNjVbMv7D5LoRor5QqT7IwisT7Om+tHB6UO3M7rGW6I62mfvtnuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UTKZ2+Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E5C116B1;
	Tue, 16 Jul 2024 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144330;
	bh=lfM+6k/rouzS4RL0B95zjf0hPFXBuMa922+uqAO7ye0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTKZ2+MtwiyUAS94/8UmsOcHos0wRSWQv9zreeZa7iVkcKw5HKUn60IDbEBmsatLu
	 ihRE5U8pAw0fu0GqioLH0pyzdBlaqX1zt7O98J6cZVFOd+iWnP2J2nwmiJeFVBJ9jF
	 82pIQX/hOv4CyAkcsw1NqGVfdcSIi+0kXGUcYHp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Greg Kurz <groug@kaod.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 19/78] powerpc/xmon: Check cpu id in commands "c#", "dp#" and "dx#"
Date: Tue, 16 Jul 2024 17:30:51 +0200
Message-ID: <20240716152741.372730135@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152740.626160410@linuxfoundation.org>
References: <20240716152740.626160410@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kurz <groug@kaod.org>

[ Upstream commit 8873aab8646194a4446117bb617cc71bddda2dee ]

All these commands end up peeking into the PACA using the user
originated cpu id as an index. Check the cpu id is valid in order
to prevent xmon to crash. Instead of printing an error, this follows
the same behavior as the "lp s #" command : ignore the buggy cpu id
parameter and fall back to the #-less version of the command.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/161531347060.252863.10490063933688958044.stgit@bahia.lan
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 6d130c89fbd85..5991fd06b6525 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1214,7 +1214,7 @@ static int cpu_cmd(void)
 	unsigned long cpu, first_cpu, last_cpu;
 	int timeout;
 
-	if (!scanhex(&cpu)) {
+	if (!scanhex(&cpu) || cpu >= num_possible_cpus()) {
 		/* print cpus waiting or in xmon */
 		printf("cpus stopped:");
 		last_cpu = first_cpu = NR_CPUS;
@@ -2571,7 +2571,7 @@ static void dump_pacas(void)
 
 	termch = c;	/* Put c back, it wasn't 'a' */
 
-	if (scanhex(&num))
+	if (scanhex(&num) && num < num_possible_cpus())
 		dump_one_paca(num);
 	else
 		dump_one_paca(xmon_owner);
@@ -2668,7 +2668,7 @@ static void dump_xives(void)
 
 	termch = c;	/* Put c back, it wasn't 'a' */
 
-	if (scanhex(&num))
+	if (scanhex(&num) && num < num_possible_cpus())
 		dump_one_xive(num);
 	else
 		dump_one_xive(xmon_owner);
-- 
2.43.0




