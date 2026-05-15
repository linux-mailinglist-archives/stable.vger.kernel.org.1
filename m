Return-Path: <stable+bounces-247569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GGVOF3hBmrVogIAu9opvQ
	(envelope-from <stable+bounces-247569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:03:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608E54BF18
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CD9F308486F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424140DFAE;
	Fri, 15 May 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bhh+SO41"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7B413236
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834041; cv=none; b=FTuP3tipz5OkYi5eU+8Qgpm7ojy2seut1spbvlelrDiWOuaoJ4h7VjAaqqUAIDT8cIDic0qFByc/as0vC5obwYjltAu4NywGXhvuY3eUJOl//ZhoKD4NCTJ6r8WasPqDzo5egW+xvWTugHRcBXWDpWVQascIOxfwPogdXO8papE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834041; c=relaxed/simple;
	bh=WHdL1k7tTb700pfbpiC+vVz6PLoKa1JKx0JwNqYuxIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rdJbZkhn3xDZ8kyiwzW398NmSDpoWy/1wrusKCGZBqoYOhtf/DiHURIFYQv94xiymoe5d4pWWnDERfFYl8hWbYt+6sVhc/QIsgQfkG/pZSxevyeNvkv4JK5Eki4s+r/gHYyBqaatXPz/A+K/hvKhRQVlJbMryanVsY9AuxHK3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bhh+SO41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC19C2BCC7;
	Fri, 15 May 2026 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834041;
	bh=WHdL1k7tTb700pfbpiC+vVz6PLoKa1JKx0JwNqYuxIo=;
	h=Subject:To:Cc:From:Date:From;
	b=Bhh+SO41T3qy33j3pkT3gU/imBePi/zqrhETy1z8ibwdrVMJ9pKNBxfiUU1gslj+G
	 shdrjP7SG8Kyhxnz9LeMUFxoKeKjh69sn/l/Uzf+C4+QHGVPSr/CMBUlmUw64+Yyb0
	 Zi2UqKfBYJVtJ0Q04EEmgcv/6MoWGA/hAFsmeUbU=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: fix clock imbalance on probe failure" failed to apply to 6.18-stable tree
To: johan@kernel.org,a-dutta@ti.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:34:05 +0200
Message-ID: <2026051505-sappy-agreement-5627@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3608E54BF18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247569-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x cba53fe20c18688c17ca668ad0e4ec05e31c70d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051505-sappy-agreement-5627@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cba53fe20c18688c17ca668ad0e4ec05e31c70d3 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 14:53:50 +0200
Subject: [PATCH] spi: cadence-quadspi: fix clock imbalance on probe failure

Drop the bogus runtime PM get on probe failures that was never needed
and that leaks a usage count reference while preventing the clocks from
being disabled (as runtime PM has not yet been enabled).

Fixes: 1889dd208197 ("spi: cadence-quadspi: Fix clock disable on probe failure path")
Cc: stable@vger.kernel.org	# 6.19
Cc: Anurag Dutta <a-dutta@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125354.1534871-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2ab6d2a81865..87e2bb66ad6c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2000,8 +2000,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_disable(dev);
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
+	clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 
 	return ret;
 }


