Return-Path: <stable+bounces-220479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEJ/DlBLo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:08:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31F1C7F29
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 267BD310E129
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF63C4C5A;
	Sat, 28 Feb 2026 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhawvEi1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FBB3C4C52;
	Sat, 28 Feb 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300365; cv=none; b=tStrP09c7MQLZXVbwpzL4LUvIT5NqUTzOI4kJB/an+qjhNfNxERP1fXyK0MuMFPl/fVj+hliPHGYW0mai1Jv21XaKQbUIESmme4SPoS6F5tvxEz2QcEgSmFCy96JZ1EstjUrREqbIYrwi/h+sRE1OOrWcBtBZfopySm2B8vFsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300365; c=relaxed/simple;
	bh=xTcTq8oodcuv1Ba4/+yqPFIurfKOhpE/WebVsNgyVC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4jztyfw5VfC3+MtiEh0RSHY7lBcmXCMU7qdaLF7MG0zX0fDS45Zyw+xbE05+K8oAdsMvlRnOE6CKf3ZuYdLe1dsFgRvlUOVbyEchTBiMeOOpZABIS6qCaiUD4/Qvj8AXw1VL1eSdNUtg7iEEfGWpfyT8p8jCDZdUXTMHT/IZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhawvEi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A36C116D0;
	Sat, 28 Feb 2026 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300365;
	bh=xTcTq8oodcuv1Ba4/+yqPFIurfKOhpE/WebVsNgyVC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhawvEi17zezplLH5gR4JhHATVMoSmRKgA2hTJkNPWjqJgcCB8TssxBZFjsPKHlLv
	 UxkdUpm/ElxNcZ0fu92ergRtVfhEhQz5oWxN3ed64v9fQBq1SRsmP0ZYCvaygfPeAo
	 jLK6z9ZnoXFBrgHXALYX9bpz5N4viWlgBmXwoxdOg6WxLdgJ3szq01YVcOT0YBObWP
	 8hJ2GWe58kqYlePEeyjYbqRTtLeNrIq/55V4kFM5+0GPb0GxQD7LGFfy2Hy9EIPvpB
	 y4Y6vtKCRrDf7r1/4P0ETD/Av1KwL9utRqpM/gTxT3DdSgYotmJVdFN32TLSx9TdzC
	 xs2RC0Q8O75Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 400/844] iio: magnetometer: Remove IRQF_ONESHOT
Date: Sat, 28 Feb 2026 12:25:13 -0500
Message-ID: <20260228173244.1509663-401-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220479-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,analog.com:email,glider.be:email]
X-Rspamd-Queue-Id: 6B31F1C7F29
X-Rspamd-Action: no action

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit a54e9440925e6617c98669066b4753c4cdcea8a0 ]

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.
The force-threading functionality is required on PREEMPT_RT because the
handler is using locks with can sleep on PREEMPT_RT.

Remove IRQF_ONESHOT from irqflags.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3fd0171e5d69b..d30315ad85ded 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -581,7 +581,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 		irq = gpiod_to_irq(data->eoc_gpiod);
 
 	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
-			      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			      IRQF_TRIGGER_RISING,
 			      dev_name(&client->dev), data);
 	if (rc < 0) {
 		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);
-- 
2.51.0


