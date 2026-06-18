Return-Path: <stable+bounces-266974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6FXZE5RbM2r7/gUAu9opvQ
	(envelope-from <stable+bounces-266974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 04:44:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E6669D27D
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 04:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FDepir9H;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266974-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266974-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A5A3020A74
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B079311946;
	Thu, 18 Jun 2026 02:44:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0272E7369
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:44:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781750672; cv=none; b=nVpjCvxmm2FJ6VsSh+ALUEcPQFAiYZDcDi+0lmMy5n3+qwmczCfrbAQia+1tzvGQWpM1r7h754Yittnr72lLfA/L/1TZ47TFoBHdJLLAzZ8dzP35su6LnNmJ17gU8wisln/6oQD6K8cTEDKpkc4CoizvFvy2KkjVT5YokuTjcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781750672; c=relaxed/simple;
	bh=7bAObQLTyy9s44BGJlTbjZHHgxaspgxxncZP39Mxvzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY6dJ19axm/CCR/X735GXvUT+qUxAtW+P/P9GD6uSbJVY3EgvBxcYN9mSmXUx0ES/MSgzZ3/+lpUV/z2JXifUL6Cr+oRs7cZ79U18VrhDPTKR1xk/MPiKaiBjIRimIhD0y7Rt+rmIFEMVy9n707BBq4vT4hWkOpb3ANwi7O4+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDepir9H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4718F1F000E9;
	Thu, 18 Jun 2026 02:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781750670;
	bh=3IxmB1Xk1B2KIfVQKqy6+bI1mB6UiqD/O5jn6rGkP4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDepir9HLzqL+SxS7syq9uIvCZkloZViwbnZ4AZy1r+qHvw/MSBH5Dh/CZwINXlRr
	 JieOqEp3ntl1jRoss+6h8lj8pDtAjEzY6OS7bobXsKMSwUQPoXog+6Z4yd/0z1TpaO
	 UaZ00JuUwSN3L8nxtOUSQk2nOGqHQLrYOmgcyXRffWQKfGBqXsYjGFzhvZHqZTXnQM
	 F1msStop9KF/9RE9rS2U0/fccVpr0B/9VUq18G+oANPX7wpIVcYcl9SQszu2mHBg8b
	 IldwrU7bs0c12nbHYNnbN6NYhllgC4adBLe6zLhgWc+NkHv7vVgg4lbWVPhXqlSyyq
	 nPgRBV6f6kNJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
Date: Wed, 17 Jun 2026 22:44:28 -0400
Message-ID: <20260618024428.548061-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061529-policy-vagabond-c0af@gregkh>
References: <2026061529-policy-vagabond-c0af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266974-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93E6669D27D

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 6a003446b725c44b9e3ffa111b0effbaa2d43085 ]

The pm_runtime_enable() and pm_runtime_use_autosuspend() calls are
supposed to be balanced on exit, add these calls.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-8-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ed1eb491430bac..d23442d51feee2 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1491,6 +1491,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
@@ -1606,6 +1608,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pdr_handle_release(ctrl->pdr);
 	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
-- 
2.53.0


