Return-Path: <stable+bounces-234557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDlvGyOh1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F19623C1319
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB96D30AA7EF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2BC36166F;
	Wed,  8 Apr 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AAHoSyEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D5328B75;
	Wed,  8 Apr 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673168; cv=none; b=XTj+ZMkGMJ9N9nIBQCcmbBe6bEqQcrA1Y4BvlSbwJfJjSohPqAwYyYs7E3yFpg2NUCEzzPM7Y7Fzn+Vtyrl5O0JyX5frDEL3N4kIK4JMu0o3PLirJr46HI7w6wHKUzam3Z6KYN706IYLvvnviDV9yBG6qgoXAC+QFdGCx/VyUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673168; c=relaxed/simple;
	bh=jffVQHPZ5LJCEvpYuwPAn09p1bK+fcHdg4B9bqpRbBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4k6QCLyhlN+m2Ral0bdGhDOiJGFQkH4rztKGwddxI/REWAqSyimVVLUYLo3WR+ckOHHFSOVrBHihBWiqHPsNG3RsaRxEdrDsNPsUdrJ0bfTejUjOc3O/C4CJK2hPhpCmAfW+K1qpe863QeMh33RfZNzUquOgGcz8WAp9I2W5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AAHoSyEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E58C2BC87;
	Wed,  8 Apr 2026 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673168;
	bh=jffVQHPZ5LJCEvpYuwPAn09p1bK+fcHdg4B9bqpRbBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAHoSyEV0dD0wyL820egJdfVA3MmJnwUlxh0OyG/Y1/uLB+D0MUVA4ro7wSqWbhu3
	 IBcwGl9ZnapOT1FevX5aiAKjju6i0g9c3nSNRNG0YQhofRE6fOXJl/2XhkpzNSNWO+
	 Mj/3YuaO+T8FNqFvTRKk5D3FZ/QkMpkj+4/eSbjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 110/277] hwmon: (pxe1610) Check return value of page-select write in probe
Date: Wed,  8 Apr 2026 20:01:35 +0200
Message-ID: <20260408175937.981360021@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234557-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,juniper.net:email]
X-Rspamd-Queue-Id: F19623C1319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

[ Upstream commit ccf70c41e562b29d1c05d1bbf53391785e09c6fb ]

pxe1610_probe() writes PMBUS_PAGE to select page 0 but does not check
the return value. If the write fails, subsequent register reads operate
on an indeterminate page, leading to silent misconfiguration.

Check the return value and propagate the error using dev_err_probe(),
which also handles -EPROBE_DEFER correctly without log spam.

Fixes: 344757bac526 ("hwmon: (pmbus) Add Infineon PXE1610 VR driver")
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260329170925.34581-4-sanman.pradhan@hpe.com
[groeck: Fix "Fixes" SHA]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pxe1610.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
index 6a4a978eca7e8..24c1f961c7668 100644
--- a/drivers/hwmon/pmbus/pxe1610.c
+++ b/drivers/hwmon/pmbus/pxe1610.c
@@ -104,7 +104,10 @@ static int pxe1610_probe(struct i2c_client *client)
 	 * By default this device doesn't boot to page 0, so set page 0
 	 * to access all pmbus registers.
 	 */
-	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to set page 0\n");
 
 	/* Read Manufacturer id */
 	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
-- 
2.53.0




