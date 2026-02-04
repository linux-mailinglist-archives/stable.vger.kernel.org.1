Return-Path: <stable+bounces-214311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAiXF/9og2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C067EE9314
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF8430E5B72
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BAE41B356;
	Wed,  4 Feb 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y9HFB+oh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA7410D23;
	Wed,  4 Feb 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219266; cv=none; b=CK5sqtAogoRD3WtFYu0PU38buO7+jfRlJVKSZw+edAgf52ZNMdU32dfAbYX9of7V1JHgPLuJq0VC4x989hjQacRAqmruDARMrJQ0oLwgUydATVcie6mQ6i5NfzaeW+WayDWwccIfItBtL0pj8/+vrLhacuIpztB+4n6vpfhWHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219266; c=relaxed/simple;
	bh=2zlSTorgqcCupppnNrST0yYGxMsXrGFJjcXYrT5qZJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qoosq8SMPdp2Xq1A1NNrR8xDPNNYw8guzg5TSdWcO7Ioj6QvQmW0RKqJsKF/YxEbLNPpcWuhxsksMYU4RExY2I3z4kz5yTOg+xY4h5z3i6yK3uvFLGByTLWgixuTds+HTzjt4/dIUGoqU8wWzmxr4iSZfPXqoLkfZg8Wh8mBX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y9HFB+oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F3CC2BCB1;
	Wed,  4 Feb 2026 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219266;
	bh=2zlSTorgqcCupppnNrST0yYGxMsXrGFJjcXYrT5qZJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9HFB+ohWY4saElGuBVqKlb+Iczlr1w9c73npigUxFkMiitvPbquaxAVbgolUXY4y
	 c+mowVgRZQ3mABOVkF7DPUxbtz3U3vEiuuTEbVVBwNUkb+7wMbNkjOeGIBPGSx0173
	 Ol0wcbIFMkuRp2l8yjj/vrU/Ioogx+6sPLk1Wh3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.18 116/122] gpiolib: acpi: Fix potential out-of-boundary left shift
Date: Wed,  4 Feb 2026 15:41:38 +0100
Message-ID: <20260204143856.025721955@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214311-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url,qualcomm.com:email]
X-Rspamd-Queue-Id: C067EE9314
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1104,6 +1104,7 @@ acpi_gpio_adr_space_handler(u32 function
 		unsigned int pin = agpio->pin_table[i];
 		struct acpi_gpio_connection *conn;
 		struct gpio_desc *desc;
+		u16 word, shift;
 		bool found;
 
 		mutex_lock(&achip->conn_lock);
@@ -1158,10 +1159,22 @@ acpi_gpio_adr_space_handler(u32 function
 
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



