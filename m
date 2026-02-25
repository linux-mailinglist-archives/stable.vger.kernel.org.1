Return-Path: <stable+bounces-218076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJmPE2tQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7985918EBCB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BB89304B92F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F82517AC;
	Wed, 25 Feb 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l2GqnmXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F2242D9B;
	Wed, 25 Feb 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982848; cv=none; b=WWufSISEPh+BH7jK4wXoLQWlO8FvIFabhJivnpEc+frdSZeHmg9r1ESfkg7iQMdsdjneEGKBQD36LYdrlSn0LxXrJLtpaCHeo6QNphEku3oltQo0nPg2HZlF2d/8p86TxZ/fZIco4/S5xovE7sSlFkjATZBhNqRqK+DWzDr7sYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982848; c=relaxed/simple;
	bh=UN6/Y0AQq4IZYzzM04KESWsTj+OZmChSgZ4BRJmO5ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDhJ54dZN+RRd5AP5wtJ0Qn6itnxuyzBBQHhlkM0grIddz9eT42Ztm4M64kG/DjJpnn6o4eziNxRqwpzE1dfLy/DZpXlEw3bJ2PnO1EoRKMGU+49M4xFBs1VznSfsiUpY8isBucbIK+uQ54CVMZrNJR75+lXuvW593xIMBWoPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l2GqnmXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40443C116D0;
	Wed, 25 Feb 2026 01:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982848;
	bh=UN6/Y0AQq4IZYzzM04KESWsTj+OZmChSgZ4BRJmO5ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2GqnmXtIwFoKIAK42V8xiWVpDkOhPSFUNBNoo7SDXqZIrjsSrkUrvJGt+ieKGFYk
	 Pm6ULxnnM58VXZ5frmqDwPDaIPGXVZaQ6yHF0D7yI58MeGmtc2DeX7aIa7Byh674Ih
	 uiEhwFFsJZ9E5BjwooDG+MGcaR5BiIzYm9WtRguQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 038/781] ACPI: processor: Update cpuidle driver check in __acpi_processor_start()
Date: Tue, 24 Feb 2026 17:12:27 -0800
Message-ID: <20260225012400.636359817@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218076-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7985918EBCB
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 0089ce1c056aee547115bdc25c223f8f88c08498 ]

Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
driver registration") moved the ACPI idle driver registration to
acpi_processor_driver_init() and acpi_processor_power_init() does
not register an idle driver any more.

Accordingly, the cpuidle driver check in __acpi_processor_start() needs
to be updated to avoid calling acpi_processor_power_init() without a
cpuidle driver, in which case the registration of the cpuidle device
in that function would lead to a NULL pointer dereference in
__cpuidle_register_device().

Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251223100914.2407069-4-lihuisong@huawei.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/processor_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 65e779be64ffc..7644de24d2faa 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,7 +166,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
-	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
+	if (cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
 	acpi_pss_perf_init(pr);
-- 
2.51.0




