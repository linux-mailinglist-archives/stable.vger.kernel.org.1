Return-Path: <stable+bounces-4393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4180474B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC562281603
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FD48C03;
	Tue,  5 Dec 2023 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="apwMRK/p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224346FB1;
	Tue,  5 Dec 2023 03:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD746C433C8;
	Tue,  5 Dec 2023 03:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747422;
	bh=CmUo1ewU4PyP7ZUGUrLxCdeV6lIVZS3noyIO5vGB5e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apwMRK/pYgPEMaD2c7OYSyA6V5do3tsNa7FNxJ8sOlzWsqFemp75xCRHrnbLO9Rbq
	 DWm9RKr9nNQncFotMBFQg9QIKvFcarpA/UsxNVh/AkvbPjtS7IECpjsprW4+T0wtCX
	 rllCSWSZN0Cr+7tZ2ZxAJ53VWbgR+PnDWgvkHHHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maria Yu <quic_aiquny@quicinc.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.10 071/135] pinctrl: avoid reload of p state in list iteration
Date: Tue,  5 Dec 2023 12:16:32 +0900
Message-ID: <20231205031534.958466534@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maria Yu <quic_aiquny@quicinc.com>

commit 4198a9b571065978632276264e01d71d68000ac5 upstream.

When in the list_for_each_entry iteration, reload of p->state->settings
with a local setting from old_state will turn the list iteration into an
infinite loop.

The typical symptom when the issue happens, will be a printk message like:

  "not freeing pin xx (xxx) as part of deactivating group xxx - it is
already used for some other setting".

This is a compiler-dependent problem, one instance occurred using Clang
version 10.0 on the arm64 architecture with linux version 4.19.

Fixes: 6e5e959dde0d ("pinctrl: API changes to support multiple states per device")
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
Cc:  <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231115102824.23727-1-quic_aiquny@quicinc.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1239,17 +1239,17 @@ static void pinctrl_link_add(struct pinc
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = p->state;
+	struct pinctrl_state *old_state = READ_ONCE(p->state);
 	int ret;
 
-	if (p->state) {
+	if (old_state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
 		 * of mux owner for that pingroup. Any pingroups which are
 		 * still owned by the new state will be re-acquired by the call
 		 * to pinmux_enable_setting() in the loop below.
 		 */
-		list_for_each_entry(setting, &p->state->settings, node) {
+		list_for_each_entry(setting, &old_state->settings, node) {
 			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
 				continue;
 			pinmux_disable_setting(setting);



