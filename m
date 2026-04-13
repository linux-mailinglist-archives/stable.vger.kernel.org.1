Return-Path: <stable+bounces-237143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKg0OEUh3Wn4aAkAu9opvQ
	(envelope-from <stable+bounces-237143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE83F07C8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 040C43012D69
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC42D8364;
	Mon, 13 Apr 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHYPsoS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF9307AC7;
	Mon, 13 Apr 2026 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098699; cv=none; b=JBtCWowXMLXSohF3UFq+LZN6ujGIEvJZo8pF7dkdENbz0iIInnhfuzqTMrR3Me2c0jWWhlCfWgAqyVbM6a+8EOo00sIVG7RPO+dwIk8wCjwRIdY2YqKFy20rfxusztxAOe7e91o/m4c6S8HcEYxxe/W8QB+DZhpObYyJUfzdX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098699; c=relaxed/simple;
	bh=KfQKxqwlE9DEZcSCTt6VdBuiiajmGfTyCQXIQl/lbD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffb71DGgEHGJiyPWlPzd0NNjxdIQNuPah9ySzQiVQGaXp2LNrHEbN5oG5LT3Mq4vYAiZcIubrLq0uudyISa+PdjK2bj/NDuN1Wmh25jB/TpXoDajEN62ZfPn+ZF5lDCEvZy9bKpXubAiOiGSB0lvmLisVNVpQiqyberRTlkxWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHYPsoS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEDBC2BCAF;
	Mon, 13 Apr 2026 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098699;
	bh=KfQKxqwlE9DEZcSCTt6VdBuiiajmGfTyCQXIQl/lbD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHYPsoS5Huv1hx7s3omiiJ2gsMOx7NvRDfvS74IDX8LHKvblIm+/AItfksor41J6w
	 f345yYmdfRP0ab4EWVAShzavJBUN+zQLt2fpacurxVfLXLTLE5esL8RK5GAhsEr+lw
	 Mrvyszw+05gRVXiY1BXSt4++51yLiBX3dYoBC+Hw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Piotr Mazek <pmazek@outlook.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/491] ACPI: PM: Save NVS memory on Lenovo G70-35
Date: Mon, 13 Apr 2026 17:54:59 +0200
Message-ID: <20260413155821.073845887@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237143-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CEE83F07C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Piotr Mazek <pmazek@outlook.com>

[ Upstream commit 023cd6d90f8aa2ef7b72d84be84a18e61ecebd64 ]

[821d6f0359b0614792ab8e2fb93b503e25a65079] prevented machines
produced later than 2012 from saving NVS region to accelerate S3.

Despite being made after 2012, Lenovo G70-35 still needs NVS memory
saving during S3. A quirk is introduced for this platform.

Signed-off-by: Piotr Mazek <pmazek@outlook.com>
[ rjw: Subject adjustment ]
Link: https://patch.msgid.link/GV2PPF3CD5B63CC2442EE3F76F8443EAD90D499A@GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/sleep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index e79c004ca0b24..df03b6ed16fbb 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -372,6 +372,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "80E1"),
 		},
 	},
+	{
+	.callback = init_nvs_save_s3,
+	.ident = "Lenovo G70-35",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "80Q5"),
+		},
+	},
 	/*
 	 * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using
 	 * the Low Power S0 Idle firmware interface (see
-- 
2.51.0




