Return-Path: <stable+bounces-270080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /933KNZnRGoOuQoAu9opvQ
	(envelope-from <stable+bounces-270080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 03:05:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CADD6E8FE0
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 03:05:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b="lU/OloCj";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270080-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270080-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04A0C301BA43
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5903D18BC3D;
	Wed,  1 Jul 2026 01:05:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870F224FA
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:05:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867922; cv=none; b=Ok0EkS748dU7Tnm9SUzeU0LVv84VyspofTPUzzqA2sYb5MIjuMMhH3ZCj8ffvnU5fUZ9ukNRHMYPb8p4EGZmUK9QOPRClc6o2DTzq2gZjfyIEYonsecVHIvdzBAKq2W8p3Qio/ntDIRi4gf2t7X+HZQ286TFsEsXiuKUM2ij3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867922; c=relaxed/simple;
	bh=B0OtGF3UG7WFeZojiKUIfi8tdhYzvdLj2aPV+B86UtU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ari0NBQVUZin4EI6RtsqlRzn55rBBdQlavjL3As/1sh3q8RgVXmxE7nm7xwOynZ/mVptBNlHUsEkl7agTFDHMiyMmOhwG1KE33LUxggn688ac07tFOsn16qCnriLuKNRqVAL8EBjGj8mqQ+9dLNPcCXGnRTSC2CKc6PVKlx3Qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lU/OloCj; arc=none smtp.client-ip=203.205.221.192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782867911; bh=oWUC5SjRt3QR7F6zWqGGKKRWr47hvrPsFO+LiqcJkP4=;
	h=From:To:Cc:Subject:Date;
	b=lU/OloCjLqAuPIvVHoTz9oxngPyFplqOuYJLyeGycRl5S7W98l6BrTKE1vRsK0+9Y
	 IWWdvjfocyktFeSqgIpnZB7XQG3vqViKIYz/NGrRUHULMtTMuEsmLHQKf7gI5JnYlS
	 nImI6Xt/NPBeSTjmJpjpGWu40xQc1Ba/wmOx88QM=
Received: from QD202103290168A.neusoft.internal ([218.25.32.210])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 139A847C; Wed, 01 Jul 2026 09:04:57 +0800
X-QQ-mid: xmsmtpt1782867897txsx8dpp7
Message-ID: <tencent_35D37EF305C12D33B125C8E85312D86DA908@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+Y+SJyZAcTO+RSztLRfdi5AakedT6fqDeIZO/KrZNj/mlZWcx2q
	 z/XR6HnvTz/8RSIUJdkc562ec5W5MrgmJhdvM5KLhBYkRov1Qq6Uflm33u3O+FR+Fz6iQprx7sAw
	 jlYhb2bYmf8sCfIfIBT4W0WzbDaifGwbIuCFwniZuv/02VS5TuzjBRQZcEqCAOS0CWe1wyh/bmwl
	 gj6vNEX/bg415LUERVchCMYP1+b9qa08sod10rPevfHYtj5OX1B4P2MaSlO6BruFE2qy3BOMCAVM
	 Te86Gnrkr+qRCrtI54yiXmlIDy04sOXAC/k63n7XsVnI5ULulZ0olYIVimZUsR6zFZTJQdAJeoeV
	 nPjXI4Jkad9hIQxRz0x1yWXS7QLn3lPip3lCRFnDGj0g7ARbiJRqTCG3rVuz/htKcS5Sgy52F2zN
	 J+ZPWqY0Oky+l78dQfFS6jSQa3ZUgQvIg1bE/GzbUzFcCN5zsjcjwR90LZYZZ9H8AmHrwiyuu13K
	 LCGZzavQhrAYUjCOM0VU8uDCVmA7+0hkvJXI5iqvnZq/zDg9RsrB7w71DX60iU1KMSLDcmBARr93
	 pB9XtqfWnhDM47rBUtBuf4/I8wOkvCJshW5RKgByazsHPkejDQKvaEtTFIGhgZogm0bSkNLHe6ic
	 UNAC1YpVBcCg77NoLnS88P/Dm8R4b50dIM1lsXjivbbWTuqlF81K3DQLUUvXWrmSXJ7O2jxY/fiR
	 Yuu7wRG8kknDRiDv+ROigcW0CCDb2PkWKnqIUCBhCHomMBOLIwhMEK2j5BXHksRMSgNWNGyKzvAc
	 aub6YpZV3JJZUK/3nSP4sm9MrQ8Jk7AitzApLsAofLLWiJhYzgUsnJ4gSkF524aKQflBLi1/5AA5
	 3nQVtLSm1Wp/m6eJJdi4cr/LGNOXK0kviW7fL7wgqJ9Pty9sS/vSgm94fQgD/ylc9C0P46/mxmiN
	 a74Hykou1dNs0cx0DEczNt464ABRmKC2x9CRKDabsG08pEYxJsXaIrVH6evUeUVcTLqDzlcmixGr
	 dmsAv/G9fFoCyiHm0USFK/s7akuW9JX0awdznlvBYDBASXaYa4
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: mysteryli <929916200@qq.com>
To: 929916200@qq.com
Cc: stable@vger.kernel.org
Subject: [PATCH] power: supply: max17040: handle missing status supplier
Date: Wed,  1 Jul 2026 09:04:51 +0800
X-OQ-MSGID: <20260701010451.520-1-929916200@qq.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:929916200@qq.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270080-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[929916200@qq.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[qq.com];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[929916200@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CADD6E8FE0

MAX17040 does not report charger state itself, so the driver forwards
POWER_SUPPLY_PROP_STATUS to a supplier power supply. If no supplier is
registered, power_supply_get_property_from_supplier() returns -ENODEV and
leaves the output value untouched.

max17040_get_property() currently ignores that error and returns success,
so userspace can read an uninitialized status value from the battery power
supply. This happens on systems that use the fuel gauge without a charger
supplier relationship in firmware.

Return POWER_SUPPLY_STATUS_UNKNOWN when no supplier provides STATUS, and
propagate other supplier lookup errors.

Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: mysteryli <929916200@qq.com>
---
 drivers/power/supply/max17040_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 60c38e822b52..bba6d91c9b9b 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -405,7 +405,11 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = chip->low_soc_alert;
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
-		power_supply_get_property_from_supplier(psy, psp, val);
+		ret = power_supply_get_property_from_supplier(psy, psp, val);
+		if (ret == -ENODEV)
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (ret)
+			return ret;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		if (!chip->channel_temp)
-- 
2.39.0


