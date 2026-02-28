Return-Path: <stable+bounces-220332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NuDB91Fo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832C1C754F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EEDF33166E4C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40B7397C9B;
	Sat, 28 Feb 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTyPEZVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84923397C8E;
	Sat, 28 Feb 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300232; cv=none; b=RuDmPkjwW8TGQ7I0CiLvbCDmADfHncBLekMiF3FHJbm2J6GkH3+nkbCZcl00xR048fj4gmt4DgX0jt8ikYn02Nf3FRdKe2F1lI9cSEVeB4/IqvcWVl6kxXPCrENobXoTfMIMVwynksz4AmrzKsM6ZrUIEosLKNraiNZfZ1IiCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300232; c=relaxed/simple;
	bh=Dt/wMIymTdav/UUeeLS7H4kMK41+6TdhOpRB1a3sCa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liNn3p7aSxaVAL/fhCu28kU3PBY/5iJnk9BiYOP46S+JZl35BbE0IbibD2jgF8AAqNL+AFGoPwq30P2SScmNh9P+RfDcFzL61F6dfcOd0PO3OZnjexa0/Db2CHhdqaf9c5LbJKmgn7UviS2n8CY3gvNWmUpXCQZl/yJa5xDMaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTyPEZVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCF0C19425;
	Sat, 28 Feb 2026 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300232;
	bh=Dt/wMIymTdav/UUeeLS7H4kMK41+6TdhOpRB1a3sCa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTyPEZVAQEyR/VJ9kSxmwKUu44Ggqk+QKlB/q0Vh0WiWC3bE3fRL12nfkatYboOML
	 eU5gxGK5V0Gq9c1ASIBZvwd+8jzFANStVT6sDswWvpvv0phWQh8ie526xeJAaBRj1s
	 qnLgKMerpuMMS07l/HCdtV4kdDo4FHr5T9t9Z27owsTEAO12MK8H+B/51e5gICZ355
	 GYSjqVvyB2K38bCnWhmn9ZqIYLFpzl6RDR6eIcT3iEvyHfHN+Xnr5qlDhWZczFUgMs
	 WcmFjiGv1fQz1qjnNMlRx2XlfKWa5gUgscIBFez8eHTOyT8N6AjGsYA1NAif73wzTz
	 6HHur/5tx5lVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsiu-Ming Chang <cges30901@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 254/844] wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H
Date: Sat, 28 Feb 2026 12:22:47 -0500
Message-ID: <20260228173244.1509663-255-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220332-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 1832C1C754F
X-Rspamd-Action: no action

From: Hsiu-Ming Chang <cges30901@gmail.com>

[ Upstream commit 77653c327e11c71c5363b18a53fbf2b92ed21da4 ]

Add support for Mercusys MU6H AC650 High Gain Wireless Dual Band USB
Adapter V1.30. It is based on RTL8811CU, usb device ID is 2c4e:0105.

Signed-off-by: Hsiu-Ming Chang <cges30901@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251205003245.5762-1-cges30901@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a0fffc359e25..8cd09d66655db 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -37,6 +37,8 @@ static const struct usb_device_id rtw_8821cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0105, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Mercusys */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
-- 
2.51.0


