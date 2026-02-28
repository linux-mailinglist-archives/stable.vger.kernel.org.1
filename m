Return-Path: <stable+bounces-221027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CyQmIxZIo2mm/AQAu9opvQ
	(envelope-from <stable+bounces-221027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 058671C7889
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD32E34697E2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B24BCAD0;
	Sat, 28 Feb 2026 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRx+xC0/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBC33F377;
	Sat, 28 Feb 2026 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301369; cv=none; b=iuCU6HGTaoOUlJOKe5mtduoXcDr++Co6XjZsohxfUtYuzXl3VNdl+lK5Pleev4oPBd4sM4vBpBjAFm33xLoOGxOI7CXrLk7HFP9LZWlq4jovPo5YCBK0zKNOE83aDu2ErqrsaXQmNqS8JWTUOrsMVCGZZ8ibIWMvpfBsGHvf0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301369; c=relaxed/simple;
	bh=O5aNiLJoyiy/UOTviuDS1y3ZaxH8fE5X2bobRckl83s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJJWvWdWOp6TJctJ9kmHpfMdmEmuGaCPSY76xYe/BB1JZa7IeRD925OTBozEHrOLRTH38qcFIg9HhOw0KEf6n+vMHzj7hdjMZ2BcQ7rIwt3JQRKf/ZVnKKyr4bXyfEw91emcXwBBioB+Ye7BAz7Y+xXFT8RrGy55zhgp7Qjuhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRx+xC0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07C7C19424;
	Sat, 28 Feb 2026 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301369;
	bh=O5aNiLJoyiy/UOTviuDS1y3ZaxH8fE5X2bobRckl83s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRx+xC0/x7Jm6m7eIlWmT3xacDFutBiZ3E+bFbzvCTmon74QR9URMb1LsdbvbtQ96
	 5xlBx3+4vuxbGo8oE3HsFdRESn2v5xB/Tu2Ucc4Yvay5IAtU3qpKDEc1+9jn3UySek
	 VgA1l4NJBvsMJBpcMC1GHQObTzwGBFKO1c+8UXeIzUmJZ/TBajhfsFM7OyANAD6cp9
	 c5BqiLxiAh4Hv2YJ1XDzOPujjbBK9/int3bL6C3cioM0A8KxX1iosFqjbeURUfHo9e
	 amXdpbbBv2SxSCxZQRjarKbPpJKYqiII+r7of/kEVc9dJA+SyX4Xzz1DXz0ivGLpgm
	 VEqqfLuuMWzsQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 558/752] reset: gpio: suppress bind attributes in sysfs
Date: Sat, 28 Feb 2026 12:44:29 -0500
Message-ID: <20260228174750.1542406-558-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221027-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 058671C7889
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 16de4c6a8fe9ff497ca1aba33ef0dbee09f11952 ]

This is a special device that's created dynamically and is supposed to
stay in memory forever. We also currently don't have a devlink between
it and the actual reset consumer. Suppress sysfs bind attributes so that
user-space can't unbind the device because - as of now - it will cause a
use-after-free splat from any user that puts the reset control handle.

Fixes: cee544a40e44 ("reset: gpio: Add GPIO-based reset controller")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/reset-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
index 2290b25b67035..15353ba5758c3 100644
--- a/drivers/reset/reset-gpio.c
+++ b/drivers/reset/reset-gpio.c
@@ -110,6 +110,7 @@ static struct platform_driver reset_gpio_driver = {
 	.id_table	= reset_gpio_ids,
 	.driver	= {
 		.name = "reset-gpio",
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(reset_gpio_driver);
-- 
2.51.0


