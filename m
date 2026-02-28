Return-Path: <stable+bounces-220448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLGACQ04o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E564B1C63CD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BFA63127ACF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7913B7FB1;
	Sat, 28 Feb 2026 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWonVJbm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2D3B7FA9;
	Sat, 28 Feb 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300337; cv=none; b=H1o8Q0cVWmeKEW6iDn+MqWPgV6DHPak3WSLsZ/CYFe6VHb+pVuEA8S/m6SQcn2UFVPU1jA+yK2GZlOwlL3KPGaNZ+NA9HMxFGDPHpz51rYacSSCNOK1vImMkplREkkyAQwHyeYKq3SgIw7lxZycWqnkp85Z2ITL+/1tzDRFwo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300337; c=relaxed/simple;
	bh=yW97gJuKPxnqIsyq6Bu4iNRGSpevK2HY9UmX1o2LC+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCzhQppSpXyIDi6ppgU6t+JmlHsr8GQs0/Mo3h4PM/2SdJGWGRwuTaSaBe/tZMK2wfI6UD9qI7CPWJs7jTtKFxyGGkqoRDrgaPM2XOwTXr76SZi35aoGulbtZXEpIOur8MQyeFD/R/gy1NXaujf9mZlCnFchiLhfRLRcQyDnUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWonVJbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E584C116D0;
	Sat, 28 Feb 2026 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300336;
	bh=yW97gJuKPxnqIsyq6Bu4iNRGSpevK2HY9UmX1o2LC+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWonVJbmNhSTFGsQ+Wv0kkzY4VNchI4FExtyHPsxMVr1fRX6AKnU+4YiK83sl3HjB
	 zNKDvvaUGvU8QqIX2gUDcqWwJo1f6T8ZPv13RqYPtb2cghZ3HXWShXMSfGVmnRPSoV
	 3y+Ur75QBClamx+tc7rqyutNHYMy4Gyt+phlsKo91CtTNwM1Ja8n55KxC9DJhZntPO
	 ferfz2l7sAXzFYke3lCwTNEH0qChw0TFdmYQ0N4wdz9VzfEAsKAPjl52XB5UoQbFix
	 sEJNmZUIjYE8Y8VHKpSwwm3YjMMJ01NF3sbjxhJ+4R7LeJLKn3qkcMZsRfVJ+fiU8z
	 wMqgSnjqM0YgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 369/844] serial: 8250_dw: handle clock enable errors in runtime_resume
Date: Sat, 28 Feb 2026 12:24:42 -0500
Message-ID: <20260228173244.1509663-370-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220448-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E564B1C63CD
X-Rspamd-Action: no action

From: Artem Shimko <a.shimko.dev@gmail.com>

[ Upstream commit d31228143a489ba6ba797896a07541ce06828c09 ]

Add error checking for clk_prepare_enable() calls in
dw8250_runtime_resume(). Currently if either clock fails to enable,
the function returns success while leaving clocks in inconsistent state.

This change implements comprehensive error handling by checking the return
values of both clk_prepare_enable() calls. If the second clock enable
operation fails after the first clock has already been successfully
enabled, the code now properly cleans up by disabling and unpreparing
the first clock before returning. The error code is then propagated to
the caller, ensuring that clock enable failures are properly reported
rather than being silently ignored.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
Link: https://patch.msgid.link/20251104145433.2316165-2-a.shimko.dev@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 27af83f0ff463..0f8207652efe6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -741,11 +741,18 @@ static int dw8250_runtime_suspend(struct device *dev)
 
 static int dw8250_runtime_resume(struct device *dev)
 {
+	int ret;
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	clk_prepare_enable(data->pclk);
+	ret = clk_prepare_enable(data->pclk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(data->clk);
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		clk_disable_unprepare(data->pclk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.51.0


