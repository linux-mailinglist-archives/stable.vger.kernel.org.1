Return-Path: <stable+bounces-8878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002B2820545
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3C6B211AD
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00F611A;
	Sat, 30 Dec 2023 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vICrAiB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0079DE;
	Sat, 30 Dec 2023 12:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218B3C433C7;
	Sat, 30 Dec 2023 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937997;
	bh=gaYY3h/DIpDEPbgBmRoW3JZOSyBp2Ragi0UAK7lsSPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vICrAiB5rISB5mbh3gZUIKq8tysyO4VLYNOA13jfOaaaocCkxrIJdYBPY/lx/Dmq4
	 IXsaSOs6lLMi28y7AuX3WS/EqSMBq4R0iiYJs/0pb2jDC5+uKlTub4CkYbY67WlVou
	 UjasYEgATWC36AuZpwKU8SMOy9qTfqbyK7OQb568=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.6 144/156] pinctrl: starfive: jh7110: ignore disabled device tree nodes
Date: Sat, 30 Dec 2023 11:59:58 +0000
Message-ID: <20231230115817.029425075@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

From: Nam Cao <namcao@linutronix.de>

commit f6e3b40a2c89c1d832ed9cb031dc9825bbf43b7c upstream.

The driver always registers pin configurations in device tree. This can
cause some inconvenience to users, as pin configurations in the base
device tree cannot be disabled in the device tree overlay, even when the
relevant devices are not used.

Ignore disabled pin configuration nodes in device tree.

Fixes: 447976ab62c5 ("pinctrl: starfive: Add StarFive JH7110 sys controller driver")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -135,7 +135,7 @@ static int jh7110_dt_node_to_map(struct
 	int ret;
 
 	ngroups = 0;
-	for_each_child_of_node(np, child)
+	for_each_available_child_of_node(np, child)
 		ngroups += 1;
 	nmaps = 2 * ngroups;
 
@@ -150,7 +150,7 @@ static int jh7110_dt_node_to_map(struct
 	nmaps = 0;
 	ngroups = 0;
 	mutex_lock(&sfp->mutex);
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		int npins = of_property_count_u32_elems(child, "pinmux");
 		int *pins;
 		u32 *pinmux;



