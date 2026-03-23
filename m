Return-Path: <stable+bounces-228167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LgaFk1IwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267C2F3BCD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23AC3304E193
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B823B4E8A;
	Mon, 23 Mar 2026 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovU2x3uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA93B47FF;
	Mon, 23 Mar 2026 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274329; cv=none; b=WPVkL77poIsj4Ldf5wRuBAaNbt+5b5wgW+r6xOCmFcgbE0yEvIPp57JtnHUxvH3OEaI+9ZvuPHmzoda7zDYJEoZK2MfYBqB824txThEaY0dAjoWY0VWdko0uYxTMWs8SzXFLgainRaCMPpuTU+6oZj0Wny1wKO6ZzDRfQ6snNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274329; c=relaxed/simple;
	bh=oOGLML7tuVXQWDJaRyGqH/99TdOqaawIJqCfHjAdWAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gP0OZmHUVmoSpU8OG6I5QikpCFk3eFqhaQC6n29jN0DYagO05qthXcQeGRDURqkjhT1P+s9o3iRdDVqO4RXu8n85Zk4XEGUp4ORQvBOacdI7Xgo2cfwKijHRSAFKdRFE2DnLiXoq4hD68vUUBtdys7pGUlyXp5nNCZ9SPFbeQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovU2x3uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1407DC2BC9E;
	Mon, 23 Mar 2026 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274329;
	bh=oOGLML7tuVXQWDJaRyGqH/99TdOqaawIJqCfHjAdWAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovU2x3uzho+9Myax/4EVp4Q6oA0yOCP+Io+hQzQWV097UJV6oeag4H+gn6PXgVLxt
	 yckTlBVMscJz/ObsW1kTRTkwSUUB4rwI4nsvAeHyr4Dp336rzakU2y1V/BJU84XopN
	 Dh8hyjWDGONchq/b7Nn7HeHnkDfSN4vKiyXnQeFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.19 184/220] hwmon: (pmbus/mp2869) Check pmbus_read_byte_data() before using its return value
Date: Mon, 23 Mar 2026 14:46:01 +0100
Message-ID: <20260323134510.385549994@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228167-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,juniper.net:email,roeck-us.net:email]
X-Rspamd-Queue-Id: 1267C2F3BCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit c6f45ed26b6eb4766db06f21ff28a97ed485bcbb upstream.

In mp2869_read_byte_data() and mp2869_read_word_data(), the return value
of pmbus_read_byte_data() for PMBUS_STATUS_MFR_SPECIFIC is used directly
inside FIELD_GET() macro arguments without error checking. If the I2C
transaction fails, a negative error code is passed to FIELD_GET() and
FIELD_PREP(), silently corrupting the status register bits being
constructed.

Extract the nested pmbus_read_byte_data() calls into a separate variable
and check for errors before use. This also eliminates a redundant duplicate
read of the same register in the PMBUS_STATUS_TEMPERATURE case.

Fixes: a3a2923aaf7f2 ("hwmon: add MP2869,MP29608,MP29612 and MP29816 series driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260317173308.382545-4-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/mp2869.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

--- a/drivers/hwmon/pmbus/mp2869.c
+++ b/drivers/hwmon/pmbus/mp2869.c
@@ -165,7 +165,7 @@ static int mp2869_read_byte_data(struct
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct mp2869_data *data = to_mp2869_data(info);
-	int ret;
+	int ret, mfr;
 
 	switch (reg) {
 	case PMBUS_VOUT_MODE:
@@ -188,11 +188,14 @@ static int mp2869_read_byte_data(struct
 		if (ret < 0)
 			return ret;
 
+		mfr = pmbus_read_byte_data(client, page,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfr < 0)
+			return mfr;
+
 		ret = (ret & ~GENMASK(2, 2)) |
 			FIELD_PREP(GENMASK(2, 2),
-				   FIELD_GET(GENMASK(1, 1),
-					     pmbus_read_byte_data(client, page,
-								  PMBUS_STATUS_MFR_SPECIFIC)));
+				   FIELD_GET(GENMASK(1, 1), mfr));
 		break;
 	case PMBUS_STATUS_TEMPERATURE:
 		/*
@@ -207,15 +210,16 @@ static int mp2869_read_byte_data(struct
 		if (ret < 0)
 			return ret;
 
+		mfr = pmbus_read_byte_data(client, page,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfr < 0)
+			return mfr;
+
 		ret = (ret & ~GENMASK(7, 6)) |
 			FIELD_PREP(GENMASK(6, 6),
-				   FIELD_GET(GENMASK(1, 1),
-					     pmbus_read_byte_data(client, page,
-								  PMBUS_STATUS_MFR_SPECIFIC))) |
+				   FIELD_GET(GENMASK(1, 1), mfr)) |
 			 FIELD_PREP(GENMASK(7, 7),
-				    FIELD_GET(GENMASK(1, 1),
-					      pmbus_read_byte_data(client, page,
-								   PMBUS_STATUS_MFR_SPECIFIC)));
+				    FIELD_GET(GENMASK(1, 1), mfr));
 		break;
 	default:
 		ret = -ENODATA;
@@ -230,7 +234,7 @@ static int mp2869_read_word_data(struct
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct mp2869_data *data = to_mp2869_data(info);
-	int ret;
+	int ret, mfr;
 
 	switch (reg) {
 	case PMBUS_STATUS_WORD:
@@ -246,11 +250,14 @@ static int mp2869_read_word_data(struct
 		if (ret < 0)
 			return ret;
 
+		mfr = pmbus_read_byte_data(client, page,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfr < 0)
+			return mfr;
+
 		ret = (ret & ~GENMASK(2, 2)) |
 			 FIELD_PREP(GENMASK(2, 2),
-				    FIELD_GET(GENMASK(1, 1),
-					      pmbus_read_byte_data(client, page,
-								   PMBUS_STATUS_MFR_SPECIFIC)));
+				    FIELD_GET(GENMASK(1, 1), mfr));
 		break;
 	case PMBUS_READ_VIN:
 		/*



