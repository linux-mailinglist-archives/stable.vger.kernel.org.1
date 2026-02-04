Return-Path: <stable+bounces-214236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHRhCkttg2kFmwMAu9opvQ
	(envelope-from <stable+bounces-214236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:01:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9650E9BC6
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC2A31A5480
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A41C5D57;
	Wed,  4 Feb 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WY/8gVTT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B531273D77;
	Wed,  4 Feb 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219017; cv=none; b=GlddHXt3PYQeSOPdb+dFT5iJMzHGWr3CIuAZAfEyJl32FR6Vg7EjI9kY5vQsoGn1/+y2a80ZY2QMEtGbLbEzfcXlzxteCiHvLf+WTJj4rPsgOaUTwaxk4+qQvZxj0ZWelBLwDfWmbzwq38Fb6Rctp5g7/gLILAd2oP5SOuc2vqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219017; c=relaxed/simple;
	bh=DiAbA63cqEiVTrctA1VxBNvvdKPsT/cvTL3i+NTqdQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTBSu9arIGn0yaRZ0rVFZ+5/sUqjfKx6SP23Fv/rwqce8CITgdNxGuL/RWvO0asLjnGLiUOtmjMBYstNJjefMEPYzaMLI829GGEWvqyQxG71s/OOof56xpbgvyWjA+kMvAgaUxarMD8uA3zp+U8tIrtdkLVdvaLUkMth4GIR7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WY/8gVTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841C5C4CEF7;
	Wed,  4 Feb 2026 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219016;
	bh=DiAbA63cqEiVTrctA1VxBNvvdKPsT/cvTL3i+NTqdQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WY/8gVTTHSiEa3T04Ob4PuusHYavO53XA5FB2xOAJXKFDBs9SeEi0+/e0hJkPGr8h
	 Mu8glAlHnF1T0pifVuiWYy/ffeBqorsuXA9o4g1J+n/dJ+krylYP/JTPpDAD8yPcFv
	 zQQa54FAINzlAnXCvT/iSBL+4W5RJTTQ0Wdu6Sqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis Sergeev <denserg.edu@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 042/122] gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler
Date: Wed,  4 Feb 2026 15:40:24 +0100
Message-ID: <20260204143853.372986370@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linuxtesting.org:query timed out];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214236-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[westeri.kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url,qualcomm.com:email]
X-Rspamd-Queue-Id: B9650E9BC6
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Sergeev <denserg.edu@gmail.com>

[ Upstream commit c0ae43d303e45764918fa8c1dc13d6a5db59c479 ]

The BIT() macro uses unsigned long, which is 32 bits on 32-bit
architectures. When iterating over GPIO pins with index >= 32,
the expression (*value & BIT(i)) causes undefined behavior due
to shifting by a value >= type width.

Since 'value' is a pointer to u64, use BIT_ULL() to ensure correct
64-bit mask on all architectures.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 2c4d00cb8fc5 ("gpiolib: acpi: Use BIT() macro to increase readability")
Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
Reviewed-by: Mika Westerberg <westeri@kernel.org>
Link: https://lore.kernel.org/r/20260126035914.16586-1-denserg.edu@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index d441c1236d8ca..2ac6c708d927a 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1159,7 +1159,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		mutex_unlock(&achip->conn_lock);
 
 		if (function == ACPI_WRITE)
-			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT(i)));
+			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT_ULL(i)));
 		else
 			*value |= (u64)gpiod_get_raw_value_cansleep(desc) << i;
 	}
-- 
2.51.0




