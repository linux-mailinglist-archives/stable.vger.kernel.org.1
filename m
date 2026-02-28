Return-Path: <stable+bounces-220160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HRbOR8ro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240A1C5252
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EEA131D3AA0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AB495527;
	Sat, 28 Feb 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvqFzOZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5B494A1E;
	Sat, 28 Feb 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300068; cv=none; b=BPR6ucZSxS1yLZPmHN0LS3kw0VBEAMPrqlNJili8OW+5+D5Yj4aeCWM0MZ2OOJ4xZrS41rx3R9KCSqLhAxj8Gys3uDBLzHh0jHh3GKaU7r18yWunBTjhgqrV4zjHN22HdeR6CJDRHrT4OaTAlYrxam4lz7MLawB6ih4E4rMFw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300068; c=relaxed/simple;
	bh=Mcfvj2nZM5JB64KW50/Cmp3FQ/BWsJZ+wF1KoAyR0zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyPAXQjknNuNvecKc5LBP0dNbPbuTDmfjnhJXt2wNggiCWvT0ViUDixsk8KwDTOqJxu9yWgt0VE3kBGT6xhr4Wqdhdo8T2vdAtml2vt9x4RB5E94rbWUAhL9tqwOjdnaV6yIiSUc/ipi3YDB/jUSikOMHdxALCdc4+swqFftEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvqFzOZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA43C116D0;
	Sat, 28 Feb 2026 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300068;
	bh=Mcfvj2nZM5JB64KW50/Cmp3FQ/BWsJZ+wF1KoAyR0zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvqFzOZJ6BzJBpk554CNm/F5FySYKyHXH1osnflUoz7EtDYXxXr+pIP2RQU9NpLS3
	 KaA5b5ZnyUqEDY30fK+9ZqA8jrKtH4FeSgZZXvZ9kfzc2EpT84bY3C48ERu7TrC6cN
	 QIImDJsXQzDflCXAloOqi9QKJu0hx3oIr4Gp50+gmFQ329wej8jfpkYo6dCT9s7kDA
	 SAikbG63IDpc0pJgAVcRCBPFe8qAhPsP4cTn+L8PZn6ZkV3u0EbK+QUMue7yPF+zGY
	 859OZp4lMpEAS5cZDcjJC1jK7NSjzHgcQUES1QyMLcsZ4v46N+6eeVZ/SAiGVsc5I7
	 SUV23tC2a8zRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>,
	Antheas Kapenekakis <antheas@antheas.dev>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 082/844] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9 (Turn On Display)
Date: Sat, 28 Feb 2026 12:19:55 -0500
Message-ID: <20260228173244.1509663-83-sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[gmail.com,antheas.dev,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,antheas.dev:email]
X-Rspamd-Queue-Id: 6240A1C5252
X-Rspamd-Action: no action

From: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>

[ Upstream commit 229ecbaac6b31f89c554b77eb407377a5eade7d4 ]

Windows 11, version 22H2 introduced a new function index (Function 9) to
the Microsoft LPS0 _DSM, titled "Turn On Display Notification".

According to Microsoft documentation, this function signals to the system
firmware that the OS intends to turn on the display when exiting Modern
Standby. This allows the firmware to release Power Limits (PLx) earlier.

Crucially, this patch fixes a functional issue observed on the Lenovo Yoga
Slim 7i Aura (15ILL9), where system fans and keyboard backlights fail to
resume after suspend. Investigation linked shows the EC on this device
turns off these components during sleep but requires the Function 9
notification to wake them up again.

This patch defines the new function index (ACPI_MS_TURN_ON_DISPLAY) and
invokes it in acpi_s2idle_restore_early_lps0(). The execution order is
updated to match the logic of an "intent" signal:

 1. LPS0 Exit (Function 6)
 2. Turn On Display Intent (Function 9)
 3. Modern Standby Exit (Function 8)
 4. Screen On (Function 4)

Invoking Function 9 before the Modern Standby Exit ensures the firmware
has time to restore power rails and functionality (like fans) before the
software fully exits the sleep state.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications#turn-on-display-notification-function-9
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220505
Suggested-by: Antheas Kapenekakis <antheas@antheas.dev>
Signed-off-by: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
Link: https://patch.msgid.link/20260127200121.1292216-1-riemenschneiderjakob@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/s2idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index cc3c83e4cc23b..2189330ffc6d3 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -49,6 +49,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_EXIT		6
 #define ACPI_LPS0_MS_ENTRY      7
 #define ACPI_LPS0_MS_EXIT       8
+#define ACPI_MS_TURN_ON_DISPLAY 9
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
@@ -356,6 +357,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 			return "lps0 ms entry";
 		case ACPI_LPS0_MS_EXIT:
 			return "lps0 ms exit";
+		case ACPI_MS_TURN_ON_DISPLAY:
+			return "lps0 ms turn on display";
 		}
 	} else {
 		switch (state) {
@@ -617,6 +620,9 @@ static void acpi_s2idle_restore_early_lps0(void)
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		/* Intent to turn on display */
+		acpi_sleep_run_lps0_dsm(ACPI_MS_TURN_ON_DISPLAY,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		/* Modern Standby exit */
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-- 
2.51.0


