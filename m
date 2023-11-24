Return-Path: <stable+bounces-1696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D992D7F80EC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158D61C21639
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DA35F1A;
	Fri, 24 Nov 2023 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A+wX7tyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1F2FC4E;
	Fri, 24 Nov 2023 18:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5A1C433C8;
	Fri, 24 Nov 2023 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852046;
	bh=13wTJIB0BYKRre6SRtmYfiKiBFJaEusrKlFhwvsk7qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+wX7tydEgfm/F+RV6FrFPRIYg0SPAPChF43iFMV4KC/VU9L7fnWls+8bI80yuAIW
	 y6uOy89RDZ+SqAQ3ffJVpuvCypfUbjfgQ0zGMGc/0qYEyKwBeDiflZjtjm4z4rYHpR
	 8Vc6m7TkZ9CwQvw583qGD6GYDFX9HDlDdSesWU2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rong Chen <rong.chen@amlogic.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 199/372] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
Date: Fri, 24 Nov 2023 17:49:46 +0000
Message-ID: <20231124172017.095275624@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rong Chen <rong.chen@amlogic.com>

commit 57925e16c9f7d18012bcf45bfa658f92c087981a upstream.

For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
Starting from SoC family C3, setting this bit without SG LINK data
address will cause the controller to generate an IRQ and stop working.

To fix it, don't set the bit CMD_CFG_ERROR anymore.

Fixes: 18f92bc02f17 ("mmc: meson-gx: make sure the descriptor is stopped on errors")
Signed-off-by: Rong Chen <rong.chen@amlogic.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231026073156.2868310-1-rong.chen@amlogic.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/meson-gx-mmc.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -817,7 +817,6 @@ static void meson_mmc_start_cmd(struct m
 
 	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
 
 	meson_mmc_set_response_bits(cmd, &cmd_cfg);
 



