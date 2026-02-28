Return-Path: <stable+bounces-220823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHt5FclYo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:06:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B68D1C8C65
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615B4301466B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563DA416510;
	Sat, 28 Feb 2026 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S13CKTwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654A416505;
	Sat, 28 Feb 2026 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300709; cv=none; b=QncT2NtQYhJGqFFa6SqfHrsVlE+pvUzVrUHIesHizBoYZ8TufkdVSq6EMaZNUaX8RaP+Qb6vuIKnrjiXrDJB9VL6dxVGJHbz+5J0h5ND8Y5E+xgDdh5vVDaT/j7kvgtPa4s3hDvjiaaTmuL0e3gaVZSVRzoQx5vj0z8tV6DxtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300709; c=relaxed/simple;
	bh=+Ste2ttJfZAd6L9l4wmVUyZ5HJ1zQqi8hqqC0X2Ssoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CStrQZwb5FmqkQjvtqAet2YNufWvBqlTv+2tWuCelvUOoftaULN7jve5so/8RqPYUfXgrSigt9/21/GLCFDC9aPasm2iy6ypE+dEOstxNyPzRNoDexKGgO5YAotzs6SjaxHWWhTAR+L6dVyT2EqbsH+B76YAxqFFOdzE5ga0XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S13CKTwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF4FC19423;
	Sat, 28 Feb 2026 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300709;
	bh=+Ste2ttJfZAd6L9l4wmVUyZ5HJ1zQqi8hqqC0X2Ssoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S13CKTwjuFfVlA+LG/p4SjQdue+VuljfHRj7/m1LxX1Lxfao5U9yWMbwIVzfsN36S
	 UjOjoy9qo+2u10/B50+++Nlso2jML9aMVM8IIzGi05Y43z0m6weRIGbFoqwTSpFPJj
	 8CEcCTG3FnIi3pe8dGWGN02U7m+zJpGTz59WwXn5lsdE1ixIhEBLsmHEJXjbYgdycZ
	 jecP6rTPIc6+QQgt7Fjvr6iiQsw8pDnV3P7xM42t/kSztYdR3+WeEtPD2FnGWOA/yT
	 FSu9IXQhYSb/UJ+DvjhnLuU9KKgB+obbCoOYRtb0EtsYOw1FZNlDfvzxESiFa5cMEi
	 gBCnCuOsYFJDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 744/844] mux: mmio: fix regmap leak on probe failure
Date: Sat, 28 Feb 2026 12:30:57 -0500
Message-ID: <20260228173244.1509663-745-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220823-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ti.com:email]
X-Rspamd-Queue-Id: 9B68D1C8C65
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 3c4ae63073d84abee5d81ce46d86a94e9dae9c89 ]

The mmio regmap that may be allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
Cc: stable@vger.kernel.org	# 6.16
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://patch.msgid.link/20251127134702.1915-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mux/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 3409af1ffb80f..0611ef28bb69a 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -72,7 +72,7 @@ static int mux_mmio_probe(struct platform_device *pdev)
 		if (IS_ERR(base))
 			regmap = ERR_PTR(-ENODEV);
 		else
-			regmap = regmap_init_mmio(dev, base, &mux_mmio_regmap_cfg);
+			regmap = devm_regmap_init_mmio(dev, base, &mux_mmio_regmap_cfg);
 		/* Fallback to checking the parent node on "real" errors. */
 		if (IS_ERR(regmap) && regmap != ERR_PTR(-EPROBE_DEFER)) {
 			regmap = dev_get_regmap(dev->parent, NULL);
-- 
2.51.0


