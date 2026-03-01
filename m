Return-Path: <stable+bounces-221380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIiBMyOWo2lPHgUAu9opvQ
	(envelope-from <stable+bounces-221380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4A91CAAE4
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D044B3001A7A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25C17C211;
	Sun,  1 Mar 2026 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avRx4wjP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024ED2BD0B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328117; cv=none; b=rntFi2A90LWMaj+/aYybl3Ahj/RreGyQEp0ZWCrjejiPkUw+uRKlFvgXgu1F2WdRJ0dGivSVVHC8XcWFTisSQkq6InSNnjfm4PUpNeOrfuerAVwjyxVrBIkpASKGUq2kUBOVMOThJCVck1WOTdefQsGF7kPSGRnUu00IHHqE5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328117; c=relaxed/simple;
	bh=QymPUe1Ua5OHXJ9i+OgJ5XozqZ0nkB5DpJKgrtIWmPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/uChcwSO6Q+FlmAJBukCM9hGhSUayeq59vWvrIxgP88WPVIXv40hf8WxL4mnrYVu0DHBqJwFqtp54iCszjdhTQNjsAbynCaNtwWanqkhH3tfxnJz2j56/CJPBvRDJG2OrYtoGSIpECni+p0K5AlNHUh2K8hZoXaTCuERTlEppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avRx4wjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642A8C19421;
	Sun,  1 Mar 2026 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328116;
	bh=QymPUe1Ua5OHXJ9i+OgJ5XozqZ0nkB5DpJKgrtIWmPI=;
	h=From:To:Cc:Subject:Date:From;
	b=avRx4wjPMjAy/O0V8QqieecBT5U1KohQRCZssOPclumCVAX/ZhtPixl17QxZXqcSK
	 D/tVWpFBAak6GSFi6KZxSLp8ooG1yF/9sQ3Z08BmrAn+gpWTlb32a/KmZRijOXoTJs
	 hEmHcPlXETWw/X05ibHQN+lIHmnp94UOfKirUaTT1FxXj499zAUfRGubJ4eUIiOVEK
	 yE9XMpEWz3m2CKE9Ck4zwN3ImzM3Xs+z22j76nUE3rh6H4CNghD56y+JGrci31BPd9
	 hSw3yPz6kJIu8yRZ3zWqcZtX9DXeET/5Blu6U1lP55q/UeHFSxHsprI74uzxBPZRJv
	 qhLgJyi7hlo/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bartosz.golaszewski@oss.qualcomm.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: FAILED: Patch "reset: gpio: suppress bind attributes in sysfs" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:54 -0500
Message-ID: <20260301012155.1678013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221380-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,pengutronix.de:email]
X-Rspamd-Queue-Id: CE4A91CAAE4
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 16de4c6a8fe9ff497ca1aba33ef0dbee09f11952 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 4 Dec 2025 10:44:12 +0100
Subject: [PATCH] reset: gpio: suppress bind attributes in sysfs

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





