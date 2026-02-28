Return-Path: <stable+bounces-220162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AR6Ivcso2me+AQAu9opvQ
	(envelope-from <stable+bounces-220162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 408291C54A9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82E5331DD24A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832DB4963B6;
	Sat, 28 Feb 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWUbJ3MW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A974963AD;
	Sat, 28 Feb 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300070; cv=none; b=Sg6ibb6EarVyyxZ+Alb5aCO/BYpvw0MwzwB5vLp53IMYxppvhc3KW5ypvAZMb3gps5rpSwiVJoozh8coZ0H1UDbzL5r0VgeCEQLCvVBcmeEVRRz0DsMvIhR3imRxdX5aN8WGZYI2zyK/cfsaITkY3c7zPerkPf/0X9FLUNIG/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300070; c=relaxed/simple;
	bh=UR2i7G4HhfAb4y8Ra8SYvSvCSZT6TKtawcwG5ZL5Fs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoPUZLAD3BCq5gV4f7Ut1d19n5zsoVn8CdDkigH3oH78GliQjCZR3R/iegJJy8SxDPJFOwF2O/BkhPCehyeTdta8/wj9PrUORUfRd8BGz1oPxCqTQFtnizU4EEoMfqy+q4yxRIW0IdMLkl44cMNfHN7hFSLpc8UZ3GAHv6WqiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWUbJ3MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7BFC19423;
	Sat, 28 Feb 2026 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300069;
	bh=UR2i7G4HhfAb4y8Ra8SYvSvCSZT6TKtawcwG5ZL5Fs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWUbJ3MWm+SKJF7AL9WQbeTJyInhEWmGrMc3j7laim/9Nxwex5WEOlpTlFdB45Gdj
	 81akm3KtgwAhVFAwBLRqf7LAMq8cpJ5fkW0kWB4EGOc1M1h767gEH337HH+vZAIQ/D
	 tC5i98mLSgHqQOWoH1i56Kc2RVlemHENkrgQy2hYQGv/DnKEb0TyMMFpdOCeCIS4Fj
	 hs3TGaiW9JR8mx5aA1SpOeUbya9R3Ea2+lmdk3tFxjLTPxGB6ywOcHar8/EPrf78Mr
	 JNMgf8kk0rB9nZFMslCwE7s9Kz/qHDZMalo1JRAPcyj1lemvhbMdbTR3vFAYoOmFiM
	 nqA6agqEMM8iA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 084/844] ACPI: battery: fix incorrect charging status when current is zero
Date: Sat, 28 Feb 2026 12:19:57 -0500
Message-ID: <20260228173244.1509663-85-sashal@kernel.org>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-220162-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 408291C54A9
X-Rspamd-Action: no action

From: Ata İlhan Köktürk <atailhan2006@gmail.com>

[ Upstream commit bb1256e0ddc7e9e406164319769b9f8d8389f056 ]

On some laptops, such as the Huawei Matebook series, the embedded
controller continues to report "Charging" status even when the
charge threshold is reached and no current is being drawn.

This incorrect reporting prevents the system from switching to battery
power profiles, leading to significantly higher power (e.g., 18W instead
of 7W during browsing) and missed remaining battery time estimation.

Validate the "Charging" state by checking if rate_now is zero. If the
hardware reports charging but the current is zero, report "Not Charging"
to user space.

Signed-off-by: Ata İlhan Köktürk <atailhan2006@gmail.com>
[ rjw: Whitespace fix, braces added to an inner if (), new comment rewrite ]
[ rjw: Changelog edits ]
Link: https://patch.msgid.link/20260129144856.43058-1-atailhan2006@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 34181fa52e937..4b28ef79e6ac8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -211,7 +211,14 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
 			val->intval = acpi_battery_handle_discharging(battery);
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			/* Validate the status by checking the current. */
+			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
+			    battery->rate_now == 0) {
+				/* On charge but no current (0W/0mA). */
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			} else {
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (acpi_battery_is_charged(battery))
-- 
2.51.0


