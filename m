Return-Path: <stable+bounces-220312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJp3Gi0zo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F91C5C71
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E93543106BA3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155CE3907C5;
	Sat, 28 Feb 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzlI+9Xk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8163907BA;
	Sat, 28 Feb 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300214; cv=none; b=pR0QinnQtfDK7nxCo8jMpvp5mi3ibRwa9tIzIrafLO2lhomw6IVORY3XKI9PFe5O/LOPmLrGUvP3w8agaEwT8IFHoMWcf+OfjThbLUsalWomcZEzPGsMs2Tiu1lsvmMlwJdwf/LwQU/DyYxJ/bwTWVjQnLfAgJ+m4MLOu0v/7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300214; c=relaxed/simple;
	bh=qY5I0Wy2aMCKfW2z+0xbRo/coKUmjewIAn8v5cgq4OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3Ocq6MXznmWrjenAO7e2eZCUH9asGIJHgyqDWpwwE+JKz91wznC/Npcdn+6x3IR3GqTmUrXnNtG5cmJzSNoxpoWHPXj12789MAzLPlKU5yKMdJTPPk9D63o+CMD/gOguti0ekXsx8ZUhYLlc1dhAjqLRBhlPI5EzZvJnqQvnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzlI+9Xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062A8C116D0;
	Sat, 28 Feb 2026 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300214;
	bh=qY5I0Wy2aMCKfW2z+0xbRo/coKUmjewIAn8v5cgq4OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzlI+9XkVzMOtp5u84SQz5+AeAiVs9WByHaYFFfg2SWG11HXD+17LkdrPWo1MznDR
	 B3/p797wMk0m4KyVpyz93EWoNKiVhXGgqB34yvm0dt/1xhZQ7SIqWEagWcEicjMiCX
	 e4+DTGL18ZwO2FT9JPW3JNeSJiuIvf5VuiGlflGp0z4sauFgsPqHKaU2HpOmZ2pRZh
	 z7ep7CaiEDiJyRUka4NOJIg4AnwqwT+86HL5wN7fk4/H9Hjm+atrqSEDGDWk61ZjN9
	 wNC1W34Mp8ItANkBXMY9F7wH8GybeMVjpf8/rYCqgN7Bi5tcVpf4vaftpjbmDqyq3u
	 6S/FcwZ94N1Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 234/844] HID: logitech-hidpp: Add support for Logitech K980
Date: Sat, 28 Feb 2026 12:22:27 -0500
Message-ID: <20260228173244.1509663-235-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220312-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D78F91C5C71
X-Rspamd-Action: no action

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit af4fe07a9d963a72438ade96cf090e84b3399d0c ]

Add support for the solar-charging Logitech K980 keyboard, over
Bluetooth. Bolt traffic doesn't get routed through logitech-dj, so
this code isn't triggered when Bolt is used.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e871f1729d4b3..ca96102121b85 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4666,6 +4666,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb037) },
 	{ /* MX Anywhere 3SB mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
+	{ /* Slim Solar+ K980 Keyboard over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb391) },
 	{}
 };
 
-- 
2.51.0


