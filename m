Return-Path: <stable+bounces-215222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP/lJMvyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:44:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3CE110D1F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EFCF300D4E8
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A237AA71;
	Mon,  9 Feb 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7NvS9dr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808136828A;
	Mon,  9 Feb 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648083; cv=none; b=l4Ogp7S5lvrhNjgGcPZUGRwjrO69BTSEW2OLNHaUKnhwkHAFRCn0HieQcOS7AA5KR+xkHBnp5hcGaaAA3amm3SR0ZQKo7BBShXsg1skB1ZNVgVwRvoXreRX+KqKUKpjwWkIVPMAZsP/GFI/Jj+BDNazGh2YyjmZe1QsAqz+AqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648083; c=relaxed/simple;
	bh=jZrVqw25Xi3U3MKC0KYEEt9r2ezjhbIHinJ0gBWH49o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU9TgZnNspBz6X0UEFSk7GS8QP1L7NAUCcTQayhqnxU/Cy3gsmxlRGaxEdmNhNREiLDcddUeDGDqrzDSFb/TOMfHyHsGmnac0LVA1oJMMXPRFoq9kN1cEQxPBGKiTNOeGENe8Qpm9DkQ1iBBcZJu0DD3B5o4PiO/Ed1qgLz/ByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7NvS9dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28371C116C6;
	Mon,  9 Feb 2026 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648082;
	bh=jZrVqw25Xi3U3MKC0KYEEt9r2ezjhbIHinJ0gBWH49o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v7NvS9drTLmKikIScNrCcNCm86/9fcCWaQHgMxx1I81yRtcsxby+Ew5F8hK7hk+is
	 im/fafWjQO4iPhx0rn5Vwa28GAIxCnUIRzKQvAgRD2C2+OuHgLGM9/H/tGc222fMSM
	 mIoEuUeNZrtzHu5sjQ8xDf5ZLP3rvpIwVmQUjBi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 101/113] hwmon: (occ) Mark occ_init_attribute() as __printf
Date: Mon,  9 Feb 2026 15:24:10 +0100
Message-ID: <20260209142313.805698199@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215222-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,arndb.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 4B3CE110D1F
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 831a2b27914cc880130ffe8fb8d1e65a5324d07f ]

This is a printf-style function, which gcc -Werror=suggest-attribute=format
correctly points out:

drivers/hwmon/occ/common.c: In function 'occ_init_attribute':
drivers/hwmon/occ/common.c:761:9: error: function 'occ_init_attribute' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]

Add the attribute to avoid this warning and ensure any incorrect
format strings are detected here.

Fixes: 744c2fe950e9 ("hwmon: (occ) Rework attribute registration for stack usage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20260203163440.2674340-1-arnd@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/occ/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index b3694a4209b97..89928d38831b6 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -749,6 +749,7 @@ static ssize_t occ_show_extended(struct device *dev,
  * are dynamically allocated, we cannot use the existing kernel macros which
  * stringify the name argument.
  */
+__printf(7, 8)
 static void occ_init_attribute(struct occ_attribute *attr, int mode,
 	ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf),
 	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-- 
2.51.0




