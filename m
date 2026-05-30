Return-Path: <stable+bounces-259310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJKHOO9MG2r1AgkAu9opvQ
	(envelope-from <stable+bounces-259310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 22:47:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A796134ED
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 22:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3983F302F4F3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A435CBCB;
	Sat, 30 May 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEvd9gxn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95F35CB6E;
	Sat, 30 May 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173890; cv=none; b=bXBCeUt65S01Wt8niMc9sWv3rmkerW32C4JVfrkq7JVd0O1pUzgU9EDruifUA6dvszyPEDQNqjxSYCehwKCgfTUWtEe6XCuVbZIT8deN2cZCCAcF5FLXl9+/XvfJbNl4AN1GW7onjLYWRr5/y/M3K+THRT1HZTc5VpwuZvLhyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173890; c=relaxed/simple;
	bh=Fldar6aVFdZpwE0xREOfBeZJH5lmLPF7z/wAgyoC4d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPiFxmhj3cBbu4olp3+J+JQ7rCkMwEzhq6lREzmTkr7sAToU+g/An8v48PaKmbIKN2iZ+gNiuQnprxpz/EliDM9NNLS2XUSUl+w7KKB9FCoOFlhHT0DlBoeytWYjoEmfl1LILE6ny21Ca+UTlVe7WcyU7XhMabUcE8ytOg8MURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEvd9gxn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC551F00898;
	Sat, 30 May 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173888;
	bh=vwFDcMX4HVrRIm6mxIs+rA1Z26u1mTV76c73txfblnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VEvd9gxnwNayqFTnUbDBO3Wm02LAJoFB4WFq3643r4Y3HeoBSQA0TKbYRyB0BIePD
	 ONFrDj5JfrsW7a7+xc2AAf1wsgb5PrIVesJRIVURNVtL+PEohj516ojbNRixYCSRoj
	 e1yaYKPGRvK8wM/dWrB3wRB0P6kBk9MqfUrbS8qHORwAiDOpjv9RsoS6qfNajZ2FD0
	 n2RnsPgSVi1SMxi8ZaOEzY1Y4RkYtvDg+ujg/iaZ4E0kAVNsMAefbVDmD13zLi/jLb
	 +9lbv7kcfssS4GXXReQtIx/uwg4ZKlGLZyGbud9F8ct6yol6O56+2q+2VWEZNPmG6P
	 ekYQsbS4+Oteg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 7/8] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
Date: Sat, 30 May 2026 21:44:20 +0100
Message-ID: <20260530204421.116824-8-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204421.116824-1-srini@kernel.org>
References: <20260530204421.116824-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259310-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 62A796134ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

The pm_runtime_enable() and pm_runtime_use_autosuspend() calls are
supposed to be balanced on exit, add these calls.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 540a62999655..8b207efeadbc 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1582,8 +1582,11 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
+	}
 
 	return ret;
 }
@@ -1696,6 +1699,7 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
-- 
2.53.0


