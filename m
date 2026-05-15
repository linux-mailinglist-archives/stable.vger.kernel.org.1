Return-Path: <stable+bounces-248516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCHNAztQB2qayAIAu9opvQ
	(envelope-from <stable+bounces-248516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F15543A2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED81E349DDAE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BFF3FD953;
	Fri, 15 May 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTRuSBC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392B3FD947;
	Fri, 15 May 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861929; cv=none; b=qpxFuRTYquFmKJBRPNzorb08X7BZY+XChi7w+UODmQk5CXZwf6Wc3nDCo5LzHiME6c5iCj4zb/kWyUcmdhjOEXVTTE4WlVn2HqnzxxH5uMAyO09zckjSZKyc9sCA6/Qc5nEM6FbIcw0qS9NBmBmlUhoRpYnxOLcGipD0TyZi1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861929; c=relaxed/simple;
	bh=klHMJwOiid6qfYOGFlhtit9NLzWxTjzHGvSrylyeTSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjV4N5SJQWjpHSvHvDb8bymPdW92dM+O7tUpIfIRv51H04NOcfYS6j+XqiezuCoBAn370gLh8RiEPIoKeS5d0OI+X3vtr2+CqlUc1zMaiKtpS8ZmM+gEJvAgN8im6dro80NqRpCEyFTW29IPSm/HXeNRx9RM++1KwOGbq4djKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cTRuSBC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD586C2BCB0;
	Fri, 15 May 2026 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861929;
	bh=klHMJwOiid6qfYOGFlhtit9NLzWxTjzHGvSrylyeTSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTRuSBC9MRjCcNBDsZVk5Bvtdz0ViehjsEGsvFJSTNrCbiXLr+tHPb53lX71im6tf
	 Ay+cY6Jrdhp00JT7hWuH6vis9K6Hy4nshcnBmKPAeOFJtuBo8C6qx2i5azo5bcrebT
	 tLe+rb2Ajpv4fYUa+iQzfdKP72zBVWanNedIL7vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sunny Luo <sunny.luo@amlogic.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 042/188] spi: amlogic-spisg: fix controller deregistration
Date: Fri, 15 May 2026 17:47:39 +0200
Message-ID: <20260515154658.227350960@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F6F15543A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248516-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amlogic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 84d31bb1f6256eea0db6cf64a3c7a53145f92bb9 upstream.

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Cc: stable@vger.kernel.org	# 6.17: b8db95529979
Cc: stable@vger.kernel.org	# 6.17
Cc: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-amlogic-spisg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -801,7 +801,7 @@ static int aml_spisg_probe(struct platfo
 		goto out_clk;
 	}
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi controller registration failed\n");
 		goto out_clk;
@@ -824,6 +824,8 @@ static void aml_spisg_remove(struct plat
 {
 	struct spisg_device *spisg = platform_get_drvdata(pdev);
 
+	spi_unregister_controller(spisg->controller);
+
 	if (!pm_runtime_suspended(&pdev->dev)) {
 		pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
 		clk_disable_unprepare(spisg->core);



