Return-Path: <stable+bounces-220183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HygHb4to2me+AQAu9opvQ
	(envelope-from <stable+bounces-220183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71381C55B1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E4CB3239F4D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57EB4BCAC5;
	Sat, 28 Feb 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyI5HPve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2A4BCABD;
	Sat, 28 Feb 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300090; cv=none; b=ct3OkJSKrvj+ri4RtImF5vBx6nF3y8g1nocH+eKS/8yYWyro8TXrFtKNunx/+n8JlDDzjYPdoOK70U3OcITAQhA3D3h5G7N47XtPsedg6tn+4kOCFvcHIKpKZifW0Sx+st+exFMAYsoU+VR0vA9O9HV/h4t+tgIitgBpz8aGS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300090; c=relaxed/simple;
	bh=oEQ7cxlEZJ+m+808c6oLL95QBAxAtktXtcZfXJjr7YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pg3cWtkS57nkx6qbVPeSo0yHq/fyCyMZ6OrkuyYmMW/1YucZcaq/+MxiJ2n5a2vrxgjtwimbUFgVpmhQ1RBJG/kfwNjxqs8Lw8XjWKOsjdV/YB2/0TFyQKRhRQJLQyIHoVa6sa0AWDtAs2nubk8V1E5lJIo7de2IA/92ADYD67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyI5HPve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A51C116D0;
	Sat, 28 Feb 2026 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300090;
	bh=oEQ7cxlEZJ+m+808c6oLL95QBAxAtktXtcZfXJjr7YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyI5HPve/iXATzANggjllAXf5qlaxVSQRRElgXoUqpfKTluPwTFmfYzMSTHH+ufVB
	 KTXcXtPw0Hv5xN5FoIISl6XsxUnETc6m28Q1YbowimjWQHacsuYGQkEQcn2nM74hok
	 mp3tRc+/jABylrM0K/RX41AsRG8j8X5CYgLI9S5aNZNHBd5l7o4MDCyL2c4NxIvVqQ
	 EQz4CVZCJYQfgYUOZuJ/fdT7vDM2T/dVVlyPYEydAgd8snh6h3CpSfvZhaW7YZGq5K
	 g0JXZdtBiZTZj56Zvo7eHGpJB5i72dDc3Tz25bPT2uXdcD1t8Oi+niJaOsMcSOnIDN
	 UTAnjY172TAtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 105/844] clocksource/drivers/timer-integrator-ap: Add missing Kconfig dependency on OF
Date: Sat, 28 Feb 2026 12:20:18 -0500
Message-ID: <20260228173244.1509663-106-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220183-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: E71381C55B1
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 2246464821e2820572e6feefca2029f17629cc50 ]

This driver accesses the of_aliases global variable declared in
linux/of.h and defined in drivers/base/of.c. It requires OF support or
will cause a link failure. Add the missing Kconfig dependency.

Closes: https://lore.kernel.org/oe-kbuild-all/202601152233.og6LdeUo-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20260116111723.10585-1-bartosz.golaszewski@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index aa59e5b133510..fd91127065454 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -254,6 +254,7 @@ config KEYSTONE_TIMER
 
 config INTEGRATOR_AP_TIMER
 	bool "Integrator-AP timer driver" if COMPILE_TEST
+	depends on OF
 	select CLKSRC_MMIO
 	help
 	  Enables support for the Integrator-AP timer.
-- 
2.51.0


