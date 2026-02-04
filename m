Return-Path: <stable+bounces-214172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CN9G7Rog2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:41:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6607E9257
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D2623103061
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7F4219EA;
	Wed,  4 Feb 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBO/Fs9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC64218B9;
	Wed,  4 Feb 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218805; cv=none; b=kKgRgOQS23c+UTFKoMlHNlEMBN+CHjqx9zCsO49FQm5ietgvs4iigc6FU2svykZvJDBtXPIkVHvxUiCSsFJmKA4DDnk5bGO7bB7CuDrb/7Q9I+lbDVZTLiks6pQyVZgFaZBz+8idvTEcaN8SlVyKT9qlQgUGW7N9HsdYYkxOZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218805; c=relaxed/simple;
	bh=BoWSnHqmT5gBLGL3qGJf4EknfETrYJWlCx5T/LoFjhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifBZKuN4BtS1+AdtFvGogbprIwVtk6de29sryTTY1VzqkWCmo3LGiug2VFa9yI2GZ/fqmzLPhaUQg14u+rEUKDwsjiWiBqCM/tCeZS/Lb7Y8aPBbF7UGsSUXfEwxIF1lz6ogpIS0W3FLvLZQkNSWhAAH15sUVf/PVwCi8kII97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kBO/Fs9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75118C4CEF7;
	Wed,  4 Feb 2026 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218804;
	bh=BoWSnHqmT5gBLGL3qGJf4EknfETrYJWlCx5T/LoFjhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBO/Fs9NM3sZWiCspXMsgPtWVliNjwlUMTKujnbHrH5JrQL2VUzJGp1ws5YVDvfuF
	 vibZGcAtx/IZPHDCj+GsiGMoGnP/fT1waiO/J+IryePMV3a1IJNOzorAKr3DXIhzi1
	 K5Cg9esG1uKSkh+ceEQbvPHyRWHLcB11R9nINACQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.12 67/87] gpiolib: acpi: Fix potential out-of-boundary left shift
Date: Wed,  4 Feb 2026 15:41:05 +0100
Message-ID: <20260204143849.329825570@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214172-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email]
X-Rspamd-Queue-Id: D6607E9257
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit e64d1cb21a1c6ecd51bc1c94c83f6fc656f7c94d upstream.

GPIO Address Space handler gets a pointer to the in or out value.
This value is supposed to be at least 64-bit, but it's not limited
to be exactly 64-bit. When ACPI tables are being parsed, for
the bigger Connection():s ACPICA creates a Buffer instead of regular
Integer object. The Buffer exists as long as Namespace holds
the certain Connection(). Hence we can access the necessary bits
without worrying. On the other hand, the left shift, used in
the code, is limited by 31 (on 32-bit platforms) and otherwise
considered to be Undefined Behaviour. Also the code uses only
the first 64-bit word for the value, and anything bigger than 63
will be also subject to UB. Fix all this by modifying the code
to correctly set or clear the respective bit in the bitmap constructed
of 64-bit words.

Fixes: 59084c564c41 ("gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler")
Fixes: 2c4d00cb8fc5 ("gpiolib: acpi: Use BIT() macro to increase readability")
Cc: stable@vger.kernel.org
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260128095918.4157491-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-acpi-core.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1094,6 +1094,7 @@ acpi_gpio_adr_space_handler(u32 function
 		unsigned int pin = agpio->pin_table[i];
 		struct acpi_gpio_connection *conn;
 		struct gpio_desc *desc;
+		u16 word, shift;
 		bool found;
 
 		mutex_lock(&achip->conn_lock);
@@ -1148,10 +1149,22 @@ acpi_gpio_adr_space_handler(u32 function
 
 		mutex_unlock(&achip->conn_lock);
 
-		if (function == ACPI_WRITE)
-			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT_ULL(i)));
-		else
-			*value |= (u64)gpiod_get_raw_value_cansleep(desc) << i;
+		/*
+		 * For the cases when OperationRegion() consists of more than
+		 * 64 bits calculate the word and bit shift to use that one to
+		 * access the value.
+		 */
+		word = i / 64;
+		shift = i % 64;
+
+		if (function == ACPI_WRITE) {
+			gpiod_set_raw_value_cansleep(desc, value[word] & BIT_ULL(shift));
+		} else {
+			if (gpiod_get_raw_value_cansleep(desc))
+				value[word] |= BIT_ULL(shift);
+			else
+				value[word] &= ~BIT_ULL(shift);
+		}
 	}
 
 out:



