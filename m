Return-Path: <stable+bounces-229110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN6XNHdXwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-229110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E82F5D80
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF7B830225C8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A736681E;
	Mon, 23 Mar 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y3FBJPH4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201D25A2B5;
	Mon, 23 Mar 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278091; cv=none; b=mrUVXEQAxKpmfEQjjv8eiEtYAKnTpckyD3pJVLti2wJe6EyVdz0yM5orKT82iAL9dSKsBT35pDHcVSXP0ucBoIG9FOqJ6+hMud/kK9yEn/Rct2C0jz8REnGegDpUfvKXVWQZSoS8RN+lepNhCgGDjRmij5Ceff3UtzDtDHScEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278091; c=relaxed/simple;
	bh=a0iiakJfTgMGALNxqPtocnXsIqpoTVQG4tn0dFTKsu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwp2dMbgEtKvaMDmCdZgMa4bX4VRZ+YrXm/B/vSK2OrfjTZxQ5dBI/ZmAY/No8R99kPh6w7yn9iKcCwyFh5wbV5PaliM8CprrC2XU/YFfwzn0zNOPIcKKS+VAyKoGpPmZzReqtlt3yLHuA8EBXxbnIUfrqTViddEPWdb+BlO8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y3FBJPH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B482C2BC9E;
	Mon, 23 Mar 2026 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278091;
	bh=a0iiakJfTgMGALNxqPtocnXsIqpoTVQG4tn0dFTKsu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y3FBJPH4eq07PDrRs/v7Kwc6hDyqKq1Vus5mA9bWAx0aBVAHR+H/ofPcgb3jHcaNK
	 x8kZQNG857EA3qwiE2mA0HU8VZSzTqrbfua+lZcAKZWiIrsmoKxuHIwehjPaHw8DVu
	 butlkqeJJ8DfEM+/52werzcK4zgACZK2wjRuIRT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Piotr Mazek <pmazek@outlook.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 199/567] ACPI: PM: Save NVS memory on Lenovo G70-35
Date: Mon, 23 Mar 2026 14:41:59 +0100
Message-ID: <20260323134538.772493628@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229110-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8E8E82F5D80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 728acfeb774d8..2fd51b18d13c4 100644
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




