Return-Path: <stable+bounces-220148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFsSDoYro2mF+AQAu9opvQ
	(envelope-from <stable+bounces-220148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BF01C52AC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 948F4309B3D1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670048B390;
	Sat, 28 Feb 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4pWfC8u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869A48C405;
	Sat, 28 Feb 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300057; cv=none; b=DgbYxAj6+3D2FmEsmMMTgIXmQcxykkerEWsmG8Y+KJ/xGY/mKanb9ug4gTB7nxowG8xsiY03XEqilJOlH7K9dhntXRay5R7vvzwhpQmuq9ICH4kiui1Dw/uOD1jQDW+TQ8/o5qr0ubeqeZ7nt+vXip48B/PjYw3dS3n1Kh7yDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300057; c=relaxed/simple;
	bh=HawuXlsx55D4Kfk39pDirEMY1A8otxhSLro4Pg4y1uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aleEF5gWoUfR0nE9AC1AQYCK8/nVma3MvgDdv3Q8yT9q+26vx3pRzyYIPIdYpefq2ekQPlSMn1uHcYkL6zgdKAfJ7uAil2TrsXz+D8snr4igA4SMhHAeOZJtXS8JiAVADVBAwnkXKuLpvVT9f7I+4/xQxRYzwttE8boMt7aUD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4pWfC8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82331C19423;
	Sat, 28 Feb 2026 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300057;
	bh=HawuXlsx55D4Kfk39pDirEMY1A8otxhSLro4Pg4y1uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4pWfC8uOsTaX40hD4MYPWv3i9Q5+j7VbcbYLhctUbDdrr+KH8iIyo6u7oVZwpxsP
	 49uEZwphX16r79NiWFmyE20i2d6I9hDMWIX0jSYQjTmRlGSmk4lFAQ3r+2+WraM6aW
	 lw2ePWeF9XODajLQmQZU475Tsb1bi86NhPltQCKFnNWfidUAm2f3SukJ6w7w4A7PjM
	 yAfgdztUXgu/+XoFh5UhzFNXuYcry86n7MnE2kyzDcgRHIAMPA2aLbqXCMY4TYoQEH
	 YHXp7M38/g2sV1rmgyl+I3CzHiquRo7GIayW443Mcp2c1xk6c3zqvpTY57fHuPwCIf
	 ZzOnn+jam9C+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 070/844] ACPI: resource: Add JWIPC JVC9100 to irq1_level_low_skip_override[]
Date: Sat, 28 Feb 2026 12:19:43 -0500
Message-ID: <20260228173244.1509663-71-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220148-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,intel.com:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 31BF01C52AC
X-Rspamd-Action: no action

From: Ai Chao <aichao@kylinos.cn>

[ Upstream commit ba6ded26dffe511b862a98a25955955e7154bfa8 ]

Like the JWIPC JVC9100 has its serial IRQ (10 and 11) described
as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh which
breaks the serial.

irq 10, level, active-low, shared, skip-override
irq 11, level, active-low, shared, skip-override

Add the JVC9100 to the irq1_level_low_skip_override[] quirk table to fix
this.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
Link: https://patch.msgid.link/20260113072719.4154485-1-aichao@kylinos.cn
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d16906f46484d..bc8050d8a6f51 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -532,6 +532,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
 		},
 	},
+	{
+		/* JWIPC JVC9100 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "JVC9100"),
+		},
+	},
 	{ }
 };
 
@@ -706,6 +712,8 @@ struct irq_override_cmp {
 
 static const struct irq_override_cmp override_table[] = {
 	{ irq1_level_low_skip_override, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ irq1_level_low_skip_override, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false },
+	{ irq1_level_low_skip_override, 11, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false },
 	{ irq1_edge_low_force_override, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 };
 
-- 
2.51.0


