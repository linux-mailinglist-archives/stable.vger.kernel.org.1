Return-Path: <stable+bounces-265867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IbfgFo2RMWrRmwUAu9opvQ
	(envelope-from <stable+bounces-265867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:10:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DC4693DB9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:10:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=KwtQKLwb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265867-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265867-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 521243032E77
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4353D45D0;
	Tue, 16 Jun 2026 18:10:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515133CC324;
	Tue, 16 Jun 2026 18:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633419; cv=none; b=q40hs8yLiZ/6CeP/E909T3AM7sOWX+Ihgk/2lxLEo4/tG6++z9xQiY31h67BN/+s1gOlWdR19NoJStvfB/lPrKDjfkp074mq9FYVjLSd2VUmlgKugeC5vryE+L/yGf3ScXviGnDzktbA8ihlS6ehb1uvtuDudOpRSNLRZFIwHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633419; c=relaxed/simple;
	bh=8RATmtimUNz0U2uJjKEQ8WHDpOwxh9YXo6jN5KUc9Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWOnb52RjA+v/wDr425BXrlXOeDQhm7tNSxJoykqWkjC7/NVZUnjuxdx3NY0HBlLgF2N+Yin0+peCeduOAnmQRjiWVp7ZUS0pZydrDiW9Ko8lEe+cFRJoG4Of3W0enc+HAsrh7a7KIT+zAPGqPK9TNOsgYCsVBz5efy4OfMOYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwtQKLwb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BCE1F000E9;
	Tue, 16 Jun 2026 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633418;
	bh=XTnCm4eCP65i7xvp221Oq7+XadSVCfU1HcsTKrREIMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KwtQKLwbQBx7xdl1mZibc2u2IqkJLRHmWxYhK2u++l4KTQ683FiMqTzuRzqYrx9Ma
	 QIKhZC+AyCzcO8AUWwCHFxDnZGW9ZOSWFJ0ks+Z6Twqwr8XhTBEyhMGGeycGAJggms
	 OcivhZqjS8W5qWr2W2uuCAVQHUxZyHmTfBiDY348=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salah Triki <salah.triki@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5.15 075/411] iio: temperature: tsys01: fix broken PROM checksum validation
Date: Tue, 16 Jun 2026 20:25:13 +0530
Message-ID: <20260616145104.259794318@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265867-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:salah.triki@gmail.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:salahtriki@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7DC4693DB9

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Salah Triki <salah.triki@gmail.com>

commit 4701e471c16866e7aa8f5e6a3a6b0d31e097e2c9 upstream.

The current implementation of tsys01_crc_valid() incorrectly sums the
first word (n_prom[0]) repeatedly instead of iterating over the 8 words
retrieved from the PROM. This leads to a checksum mismatch and probe
failure on hardware.

According to the TSYS01 datasheet, the PROM consists of 8 words. A valid
check must iterate through all 8 words to verify the integrity of the
calibration data. The current driver only checks the first word 8 times.

Note: This fix was identified during a code audit and is based on
datasheet specifications. It has not been tested on real hardware.

Fixes: 43e53407f680 ("Add tsys01 meas-spec driver support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/temperature/tsys01.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -119,7 +119,7 @@ static bool tsys01_crc_valid(u16 *n_prom
 	u8 sum = 0;
 
 	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
-		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
+		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
 
 	return (sum == 0);
 }



