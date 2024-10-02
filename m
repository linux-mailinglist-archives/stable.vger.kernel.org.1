Return-Path: <stable+bounces-78779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5298D4F1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED13B213CC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B51D0780;
	Wed,  2 Oct 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SEMsP68Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9571D049F;
	Wed,  2 Oct 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875506; cv=none; b=gE+jlwj7MFz4pM8eU7PIGZOPFWWa0OTlKB0BG1EIHU5GSSS9YTP8gIiRN+j9w/yHz2cP+fz50zNxHEG7CNrf+JUrhSOJjpuwBmVe+k6femF5G4KjnRZ6i97imEvKNVJXPMg2rOIQuo6NxwHgQE2KfKPKYkY5ySZV8jy+ELvaFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875506; c=relaxed/simple;
	bh=QiQm5FCk22w/KQRfGIabHwR/Rq/xCqj9oVPP+hIYLaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGAuhjpCfleW+GqO0Zi5SXQl+hxRcSK7Dbu/pyBFzz9lyG8nlN0ejEk1HL6iNJz6H4Kefvrdc7PGYY/xdBUv2OJaHZCEpHXpQzhYVHdEjF+tHjxzcjs/Ur9dDx2WAMKXlgF3XJkALWs+FJPHqGzm6rD5UlsU6buzI/uxsk4iadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SEMsP68Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC27C4CEC5;
	Wed,  2 Oct 2024 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875506;
	bh=QiQm5FCk22w/KQRfGIabHwR/Rq/xCqj9oVPP+hIYLaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEMsP68ZSj/MEjUudhl0JIRdzU5oKbdXGwhTNbRj8KK+MyOL+5TKf4GRgIjUUV9+J
	 I1mljoYZtDKP7x1pGntvajSCbZJVSgdeq3ou+s8nUrna+q3MigC4k+MplyQbkC91ij
	 oxCxh/P5DnQD9HLP5T9eHYGprvqXWms48KdFwepw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Shah <amit.shah@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 6.11 082/695] crypto: ccp - do not request interrupt on cmd completion when irqs disabled
Date: Wed,  2 Oct 2024 14:51:20 +0200
Message-ID: <20241002125825.754619735@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Shah <amit.shah@amd.com>

[ Upstream commit 3401f63e72596dcb7d912a5b67b4291643cc1034 ]

While sending a command to the PSP, we always requested an interrupt
from the PSP after command completion.  This worked for most cases.  For
the special case of irqs being disabled -- e.g. when running within
crashdump or kexec contexts, we should not set the SEV_CMDRESP_IOC flag,
so the PSP knows to not attempt interrupt delivery.

Fixes: 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump")

Based-on-patch-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Amit Shah <amit.shah@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9810edbb272d2..1775bac7f5973 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -910,7 +910,18 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 
 	sev->int_rcvd = 0;
 
-	reg = FIELD_PREP(SEV_CMDRESP_CMD, cmd) | SEV_CMDRESP_IOC;
+	reg = FIELD_PREP(SEV_CMDRESP_CMD, cmd);
+
+	/*
+	 * If invoked during panic handling, local interrupts are disabled so
+	 * the PSP command completion interrupt can't be used.
+	 * sev_wait_cmd_ioc() already checks for interrupts disabled and
+	 * polls for PSP command completion.  Ensure we do not request an
+	 * interrupt from the PSP if irqs disabled.
+	 */
+	if (!irqs_disabled())
+		reg |= SEV_CMDRESP_IOC;
+
 	iowrite32(reg, sev->io_regs + sev->vdata->cmdresp_reg);
 
 	/* wait for command completion */
-- 
2.43.0




