Return-Path: <stable+bounces-250597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCg7Kn30DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:50:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F3594BAB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D8173341180
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6B36D9EA;
	Wed, 20 May 2026 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kldMNDBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A0E356762;
	Wed, 20 May 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295828; cv=none; b=IMvJizLcvK/2ZwHw3rXQHRqYQSFYhkwUoxNG68TCev+v3mo22i/y+NMySARbmmdJFLT1DDwQSXYIWiEbI/7vIh6UjhcWKx0tfu5s2X+/ElmVPjOA+6YlmnKqsEk1uCCoduoHfTYdrztaqERn2PNueHsd2tjZDb6OgFSNLeSfFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295828; c=relaxed/simple;
	bh=e2Y6GRisY8U/ziP4B8BV2jp6seykzLP42oSyKquwVCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6rcF/8htb9bDOlKQlRo6lX8BJSDx8dcvjhrOh3ugJ0fqd2xoxDbDzk6NwBdsqeeWktF4E3/FRalzfJ7LwmgN9YqPpwiDfRtxQcw7/RhWbWhxpLOGrgn0h/Q0rMynYxhCZ2OYE9/oXDXVyJdaDyVP656OKD3TTwrWVLzCwMu3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kldMNDBM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5774B1F000E9;
	Wed, 20 May 2026 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295826;
	bh=6MzFwUT22kkiqjqNKG3DP2S0TdYog6rAOWOWJMfD55E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kldMNDBMDH5Brgk5L4qsn/1nQOLNeOdWIGTbrGG3EM0GR4UZqfktjVDVnt0NT5jt6
	 jMOJImnGMbmUivzpBiB4j+0svG5v3+enN4CSHweIQFmZLiwyCGOagS7uWd+A1qmt7O
	 evMtP9j6kuqiS/YffSQUXTBtwJo7sSN3Z+FPn3pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0560/1146] soc: qcom: aoss: compare against normalized cooling state
Date: Wed, 20 May 2026 18:13:30 +0200
Message-ID: <20260520162200.854890330@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250597-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,oracle.com:email]
X-Rspamd-Queue-Id: 110F3594BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit cd3c4670db3ffe997be9548c7a9db3952563cf14 ]

qmp_cdev_set_cur_state() normalizes the requested state to a boolean
(cdev_state = !!state). The existing early-return check compares
qmp_cdev->state == state, which can be wrong if state is non-boolean
(any non-zero value). Compare qmp_cdev->state against cdev_state instead,
so the check matches the effective state and avoids redundant updates.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Fixes: 05589b30b21a ("soc: qcom: Extend AOSS QMP driver to support resources that are used to wake up the SoC.")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260329195333.1478090-1-alok.a.tiwari@oracle.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/qcom_aoss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index a543ab9bee6c4..c255662b8fc3d 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -355,7 +355,7 @@ static int qmp_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 	/* Normalize state */
 	cdev_state = !!state;
 
-	if (qmp_cdev->state == state)
+	if (qmp_cdev->state == cdev_state)
 		return 0;
 
 	ret = qmp_send(qmp_cdev->qmp, "{class: volt_flr, event:zero_temp, res:%s, value:%s}",
-- 
2.53.0




