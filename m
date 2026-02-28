Return-Path: <stable+bounces-220306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN1ABYwxo2lN+QQAu9opvQ
	(envelope-from <stable+bounces-220306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A641C5A6E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B66A30C2968
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB70338D8F6;
	Sat, 28 Feb 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtFXyMCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86938D8ED;
	Sat, 28 Feb 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300209; cv=none; b=dcJoKQ+HPk4Bulm3avxJq/sYl8VLJT/shP4RcnfjXT6R5LQDRRkPp4BEY+4pS+Nz+Bl+TrpBLNYMPfkjVHVaHmNDrlMUXPyfRPiL5OsEVM1b40IFXOJkAnN1KGmQ2BmKahitv9nzxkhcjoEuqT6XXV6iiz5+m1+O2f0EqbfevwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300209; c=relaxed/simple;
	bh=qFrL+5AJ5lSWHyUdcL93osAkU/wRQ815d3F1yiyPzqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESmdGY8smxwiwslpust7zjRirTdOWkHWPLJ1Em7bhM6Aqd0vW+pNlBgV9Ho7wdI6D8Vcgq2WeKdcduBmDDtecPSLjhU3eYkQ8Pv8LgninS++0C26HRX6R5Byrbg8sPkqGhx0h+eeoOgsX41pE+02ogmranITVd47H6mNoEDgMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtFXyMCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4518C19425;
	Sat, 28 Feb 2026 17:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300209;
	bh=qFrL+5AJ5lSWHyUdcL93osAkU/wRQ815d3F1yiyPzqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtFXyMCCNYV6nMjfsg6OK0IO5eGb5E5kQ1Bg/QvHzg683Lzg+fNUP/b3S0R9O2maN
	 QXrr3VUrtegwxaoQ+kQIT9PVOrB1SIGLlCt4OZ/H/yxzg0+91sjvKRsc6jIsU13e5u
	 cU/hTH2DaRx8r06tCzD8eQES7xlZ1kJNiC0mUeMJ4Itgc+KrgJfB5eLaLtaNr7fX+k
	 /XPV2SHS+vh75hOen1Ym53WK4gkans9+vP+sEQMut9fiDKD7+EFze9hgot27dSuB3u
	 RFFyo5lfzeNCNsl5dhLvQ1NL4ynNRqLnQNG+f7NonTSla62zIksRUwi6k28z8llv6y
	 xJUR2aYOpJa5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 228/844] hwmon: (dell-smm) Add support for Dell OptiPlex 7080
Date: Sat, 28 Feb 2026 12:22:21 -0500
Message-ID: <20260228173244.1509663-229-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,roeck-us.net];
	TAGGED_FROM(0.00)[bounces-220306-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 53A641C5A6E
X-Rspamd-Action: no action

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 46c3e87a79179454f741f797c274dd25f5c6125e ]

The Dell OptiPlex 7080 supports the legacy SMM interface for reading
sensors and performing fan control. Whitelist this machine so that
this driver loads automatically.

Closes: https://github.com/Wer-Wolf/i8kutils/issues/16
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20260104000654.6406-1-W_Armin@gmx.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 93143cfc157cf..038edffc1ac74 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1325,6 +1325,13 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
 		},
 	},
+	{
+		.ident = "Dell OptiPlex 7080",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7080"),
+		},
+	},
 	{
 		.ident = "Dell OptiPlex 7060",
 		.matches = {
-- 
2.51.0


