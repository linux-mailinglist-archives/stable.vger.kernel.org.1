Return-Path: <stable+bounces-27600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F687A96F
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 15:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A53B22BF9
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708FB4645B;
	Wed, 13 Mar 2024 14:27:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0941238;
	Wed, 13 Mar 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340073; cv=none; b=HGyntaSSEytXU7naoU4vj51cafqHRJ3PB3gilySkugA7AMHOzJyRxlCEDuj0G9W1GFjImPkc8RL7VRBFXkt4v75QuRjCR3smpijAugXrjhI8NxfAxHuNB5cnl1eLo1Lsbw9fS3aSj6DMuxnxXmNU5Mw1WiQK2DLDL/5t6KAlpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340073; c=relaxed/simple;
	bh=njx6XWrO9GDHLYbSN+NMOIfll8WuGNwBJmiKbyMl33I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H7I8FfnrV1FtWBdfSQcXotmGJ5xmyo2zykbz4iVpy9xo8KaaHc6mhaToJvhgxhrC0Klv6lue7Qc30C2Z8+fmhbBSpQOwNVsdORmLG8wKUcew4Ap8TbQxKykb6oBVTq9XwWuZ9lovbUvvsBCIR9wenHiUy76HEyYW2JSofQceg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=lakka.kapsi.fi; arc=none smtp.client-ip=91.232.154.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lakka.kapsi.fi
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1rkP6J-007fkY-04;
	Wed, 13 Mar 2024 15:56:59 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1rkP6I-00AVWR-Eb; Wed, 13 Mar 2024 15:56:58 +0200
From: mikko.rapeli@linaro.org
To: linux-mmc@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mmc core block.c: initialize mmc_blk_ioc_data
Date: Wed, 13 Mar 2024 15:37:43 +0200
Message-Id: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.4 (-)
X-Rspam-Report: Action: no action
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: FUZZY_BLOCKED(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: R_DKIM_NA(0.00)
 Symbol: R_SPF_ALLOW(-0.20)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NO_DN(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: RCPT_COUNT_FIVE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20240313133744.2405325-1-mikko.rapeli@linaro.org
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

From: Mikko Rapeli <mikko.rapeli@linaro.org>

Commit "mmc: core: Use mrq.sbc in close-ended ffu" adds flags uint to
struct mmc_blk_ioc_data but it does not get initialized for RPMB ioctls
which now fail.

Fix this by always initializing the struct and flags to zero.

Fixes access to RPMB storage.

Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218587

Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/

Cc: Avri Altman <avri.altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..0df627de9cee 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 	struct mmc_blk_ioc_data *idata;
 	int err;
 
-	idata = kmalloc(sizeof(*idata), GFP_KERNEL);
+	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
 	if (!idata) {
 		err = -ENOMEM;
 		goto out;
-- 
2.34.1


