Return-Path: <stable+bounces-234568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mECvNo6j1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F43C1C03
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B68E93032F4B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C43AF643;
	Wed,  8 Apr 2026 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QXQZlm8Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24F35B653;
	Wed,  8 Apr 2026 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673197; cv=none; b=Ij/YXSiv5JFwwC8o1Ykt3OlzovSPpXPJXVFS/m6vtcYn3wsqYhr0Vm9O8WfnvFVEXwLj7ndIJu3h1r3ACMrcsbOHrq7TOTJx9txZ05+vkP+DvJmoZQDwrXAmMlzdnk6/PX9r26Er6GGBOPwhoEjdWUcPHnA7IG6CTs6VcgbPvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673197; c=relaxed/simple;
	bh=p09tsTnsl1MpVSDaybH/PMtdsogbvKPHTRDuIM2By44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3jM+YsAY8zjFtwGcuJ5Ze75uMW4tYDpYyKmLVAowxJfLFuIpdPH59Dxq31un5J9Uzb8mCwvWUHb+MTIBU2L2yQQqZUD3N1FJUBlhvmfaOYBz1QLCDOA3+9j7JoMuLrOGYFVmWiElEwZ2Pxiv+0mgTC3nAaEqWe1NFIWoIu7ApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXQZlm8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D86C19421;
	Wed,  8 Apr 2026 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673197;
	bh=p09tsTnsl1MpVSDaybH/PMtdsogbvKPHTRDuIM2By44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXQZlm8Z5QJ+jbE1SNxvUSuQyrxIo4cerMbII+O+I8CcE8kSFRYisSWeqSHz1+mVD
	 znR/2Ai9XCBOJ+YwIK/2Go6LPqjWg766hgnP43jCPRjgYAWo9G+43SGFF2RVokxOuM
	 5YbZpUaqvpK8NY5oqz8L9zuQqySg6lYX2E+AYcCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 111/277] hwmon: (ltc4286) Add missing MODULE_IMPORT_NS("PMBUS")
Date: Wed,  8 Apr 2026 20:01:36 +0200
Message-ID: <20260408175938.018329722@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234568-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email,wiwynn.com:email]
X-Rspamd-Queue-Id: 679F43C1C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

[ Upstream commit a9d2fbd3ad0e6ac588386e699beeccfe7516755f ]

ltc4286.c uses PMBus core symbols exported in the PMBUS namespace,
such as pmbus_do_probe(), but does not declare MODULE_IMPORT_NS("PMBUS").

Add the missing namespace import to avoid modpost warnings.

Fixes: 0c459759ca97 ("hwmon: (pmbus) Add ltc4286 driver")
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260329170925.34581-5-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/ltc4286.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/ltc4286.c b/drivers/hwmon/pmbus/ltc4286.c
index aabd0bcdfeee3..8715d380784a0 100644
--- a/drivers/hwmon/pmbus/ltc4286.c
+++ b/drivers/hwmon/pmbus/ltc4286.c
@@ -173,3 +173,4 @@ module_i2c_driver(ltc4286_driver);
 MODULE_AUTHOR("Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>");
 MODULE_DESCRIPTION("PMBUS driver for LTC4286 and compatibles");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("PMBUS");
-- 
2.53.0




