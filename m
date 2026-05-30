Return-Path: <stable+bounces-258952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOLyK4IwG2p5AAkAu9opvQ
	(envelope-from <stable+bounces-258952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:46:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F8612760
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 105103046E85
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A063D2EF652;
	Sat, 30 May 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dd0672A/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F18313E34;
	Sat, 30 May 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166096; cv=none; b=R3NLoNPEiVM4WETGsRGKBH8s+rhOIOVgzMThVxfpC/0dxHqR5OeKmqGAyoxJ4jm9jT2aqSqAm1szD/lzUZ5mNLmxT5htILebWVCDeG+dXRA+7xHX1KsrZsJgFknR0ziS0VmAQIoJLZ38pWEKHtr4blIWnEEUF7detdrY6pyptso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166096; c=relaxed/simple;
	bh=n4L4sQuFvfrWIE1Tgw/SU1lNHqDJWs3TuWM2wH2m2Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3W3y6oHHR+YT+O+mrUzm8fqR/V+SKAnaDuOR4fMBqNmjX6PuCOHyBSDHFgip0k996V3oFUaT7nEv+LXdfacYFVmP6utHXl7LZqSuGCG9NOil4Pg34lgND5p879hXIpXdWePNT4tsf4d6ShRldoH3lHc7l//VDdTS5EsecWNWh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dd0672A/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA32F1F00893;
	Sat, 30 May 2026 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166095;
	bh=UuRAdDo0/Y2s2+8MQvRob9mpDWWMOEfYcLgrzb27PoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dd0672A/T4QXsAMnhTwJsyVG/46Wvzf6PZ/5Gp1D3ctlT+C0jRD8oS4eGuximqK5O
	 AIVIRvMeqEpIstZ5fXmLzl0UCZrfliXqX0RgbQiSqvX+2N0LthTazGxhtDc80gN3Bu
	 ulXK4+APZwY6mp7t5LfuTYGuJ+gu8KT5OZ4PlpQ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10 271/589] spi: imx: fix runtime pm leak on probe deferral
Date: Sat, 30 May 2026 18:02:32 +0200
Message-ID: <20260530160232.103493809@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-258952-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:email]
X-Rspamd-Queue-Id: 424F8612760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit a1d50a37d3b1df84f536a982f692371039df4a48 upstream.

Make sure to balance the runtime PM usage count before returning on
probe failure (e.g. probe deferral) so that the controller can be
suspended when a driver is later bound.

Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
Cc: stable@vger.kernel.org	# 5.10
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125632.1537235-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-imx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1764,6 +1764,7 @@ out_bitbang_start:
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_disable(spi_imx->dev);
+	pm_runtime_put_noidle(spi_imx->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(spi_imx->clk_ipg);



