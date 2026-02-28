Return-Path: <stable+bounces-220825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGslAxVGo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E31C758B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EA4B313E911
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6781416529;
	Sat, 28 Feb 2026 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAyzzzez"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB9416521;
	Sat, 28 Feb 2026 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300711; cv=none; b=aD/W6IBtVtu11BJJ0nyaRCK0C8veMEPZQ8GG1W3H8LORgm1Qxjad4npAKVw7QdN//2SP6yBqi6iie9NtJcwrASGs+2OTjOECXO61XHUD9HQe4tKYZV8kJVoAWaLaJMpKHKWiGva93eYjzExFJ36ONYea1yIe87pjXDl/jnFn9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300711; c=relaxed/simple;
	bh=KKRH8BqmA8D24Dq5Sat9mQBwtLCDGlq0H+A/IIvoLjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7qby9t8m16JifqnmuQLhh0+pGA/EllVW35ldEZDUNHp+KQN0s4FLzpYPTVYZVfNHargWFovYCN//jWoB0eO0Ho8cQkyQVTRdYGBJPJXKTIDONSHXPGRuO2nK1o+JeT1wWfixfyOzCYHGh7mveEYzUyEPvmWjH3IUY4YFOh2CrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAyzzzez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F65AC19424;
	Sat, 28 Feb 2026 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300711;
	bh=KKRH8BqmA8D24Dq5Sat9mQBwtLCDGlq0H+A/IIvoLjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAyzzzez6PQ5iyCSrSQoa4YU3xUsEu4VtYJflmIsOc3NcZbVAyFAtgGp10XMt0d0h
	 NdDR6WWf58jM/f+LLgnT3YWbdNOWtNLwFWgQ+BZUvWVr5Ry4fPWtEY+7yTxl7nMMWu
	 oPneFYPBUBXqm5cEynjBc2OI7PCvWGs/3KXpKyHa74nsopW6Nu1d7HKI6fuzlfXT4L
	 iWn0NrJHYeKrOxOQU5anvFTSJdoHl6u9z8rSY1g3v/X0LCepqW7h7fqNDysWlVO4ez
	 rUSEOrvnVX116WXVd8hHXuYlxLpTkixjp0Wp8vkB2rvBRLDRxLeM3O7EKgwtTRV1rI
	 ZfZAyorKvkeiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 746/844] usb: dwc2: fix resume failure if dr_mode is host
Date: Sat, 28 Feb 2026 12:30:59 -0500
Message-ID: <20260228173244.1509663-747-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220825-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: E14E31C758B
X-Rspamd-Action: no action

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit a52e4f2dff413b58c7200e89bb6540bd995e1269 ]

commit 13b1f8e25bfd1 ("usb: dwc2: Force mode optimizations") removed the
dwc2_force_mode(hsotg, true) in dwc2_force_dr_mode() if dr_mode is host.

But this brings a bug: the controller fails to resume back as host,
further debugging shows that the controller is resumed as peripheral.
The reason is dwc2_force_dr_mode() missed the host mode forcing, and
when resuming from s2ram, GINTSTS is 0 by default, dwc2_is_device_mode
in dwc2_resume() misreads this as the controller is in peripheral mode.

Fix the resume failure by adding back the dwc2_force_mode(hsotg, true).

Then an obvious question is: why this bug hasn't been observed and fixed
for about six years? There are two resons: most dwc2 platforms set the
dr_mode as otg; Some platforms don't have suspend & resume support yet.

Fixes: 13b1f8e25bfd1 ("usb: dwc2: Force mode optimizations")
Cc: stable <stable@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://patch.msgid.link/20260129021534.10411-1-jszhang@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index c3d24312db0fe..f375c5185bfe2 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -578,6 +578,7 @@ void dwc2_force_dr_mode(struct dwc2_hsotg *hsotg)
 {
 	switch (hsotg->dr_mode) {
 	case USB_DR_MODE_HOST:
+		dwc2_force_mode(hsotg, true);
 		/*
 		 * NOTE: This is required for some rockchip soc based
 		 * platforms on their host-only dwc2.
-- 
2.51.0


