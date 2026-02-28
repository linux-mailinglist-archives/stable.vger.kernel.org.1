Return-Path: <stable+bounces-220703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLPNDx5Uo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:46:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C36331C8854
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54371325821C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0E3FA8F0;
	Sat, 28 Feb 2026 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBpdKgbq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10F3FA8E8;
	Sat, 28 Feb 2026 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300583; cv=none; b=FtPtUdsT8C6i4PJUXy+y5Gtmyi3oAXwaMjLgMqvbIyDSTW2HmX2FW/jbltBFljDO5CstU2bMn5HhDZh8/WFki5kFR1NNTXEAYRL32/83Mwq6UN+xInABIkMGaCEWUHC7oBHd4z3E1GuC3poMB9zIVEFdGC/SU2kv2aU+dbLyYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300583; c=relaxed/simple;
	bh=eMPU9koIKEZixE4sZuG8N2+QdGfAisHOg9zLI83Mqto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvTDso2iWemzOllIQKutmyoJD6zLRp6Ilt0CzA2Ul5C89Amzw/NXhrnbQJ9u74Yl6oXrK4CrdGqPJbQY4rW+mqf2cQzMHFaq/6h066Bx3uZAUCcdgE5JyvvHS4hHvLjC/WKmW6fJ4q3dCdpRiAlP/Oat6Vb7VLDTpJnK/MT+I4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBpdKgbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937BBC19423;
	Sat, 28 Feb 2026 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300583;
	bh=eMPU9koIKEZixE4sZuG8N2+QdGfAisHOg9zLI83Mqto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBpdKgbqrd9bhiPPseYt00alemR92mWHeZZWlM6uFrTCRdRYTZl3JLgscjQKcmLuG
	 nL2K4TVw5Y2P5RPyU+hVdd43ca9G35zHytkIb4XH2QTB+SSDjeLrZ5G9tlkgRScskK
	 AV4bJPUd3hZODJ97/whLhe9a77UW0FigN3WbuLvQnOhAyfzDxyS4oNs6IgwWuqeby0
	 LSE7AG7Aa42pXwrQT30sfZjkhifAMio0MlFh0wLv0FAlskpZRNSz+zURpzppvNXNYs
	 B/FbJMMo6fjpmj3TwzYGDEm0yhDW6MRZhYI9FcCJVSzL6Ei7qo2KvzbzD/P9Uj0Oxq
	 61DgJSAgW7bwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 624/844] reset: gpio: suppress bind attributes in sysfs
Date: Sat, 28 Feb 2026 12:28:57 -0500
Message-ID: <20260228173244.1509663-625-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220703-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C36331C8854
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
index e5512b3b596b5..626c4c639c155 100644
--- a/drivers/reset/reset-gpio.c
+++ b/drivers/reset/reset-gpio.c
@@ -111,6 +111,7 @@ static struct auxiliary_driver reset_gpio_driver = {
 	.id_table	= reset_gpio_ids,
 	.driver	= {
 		.name = "reset-gpio",
+		.suppress_bind_attrs = true,
 	},
 };
 module_auxiliary_driver(reset_gpio_driver);
-- 
2.51.0


