Return-Path: <stable+bounces-234176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Od8GHqb1mnDGggAu9opvQ
	(envelope-from <stable+bounces-234176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:16:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 712F53C0510
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B1563007A7E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876D39EF2B;
	Wed,  8 Apr 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9Np6e8n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55737C10F;
	Wed,  8 Apr 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672180; cv=none; b=ihrN6WWySoF0Ur1tgAlUX5vCwiPWPvtWxjR1lhhwLTLvSwtaeCHicJy6F9Ri4VW+OLnWSdDda7MMYNW5qYlz1rzFlLOfIBhH0Bs8UOtL29FC6Bw367GhnSz0U5OPKbpphFkuPinT+0RFlcHtzKSYkl1yhNPr65lWzhkpOvx7HjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672180; c=relaxed/simple;
	bh=x5YwPnSfVOoitFMS5ysrgLI6/3H0f4C1maan9adVUws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUzkx+cZHcIsRXcB2i/i1DioR8oeOGuLY4yQT+f4lhcH+K3qUIPxraE2d4v/I5sUH2HhgjbtRViqlcKQ3JoUmLCPRihmir48cozletKzQxmfUBXZp2HFZba+AR6gyv+Si8qOEcvIcsZNoVNmpVmjdR6ofzk6Hx00d8donNGQfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9Np6e8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D01C19421;
	Wed,  8 Apr 2026 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672180;
	bh=x5YwPnSfVOoitFMS5ysrgLI6/3H0f4C1maan9adVUws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9Np6e8nfQu0HTuGFz2J7eT1WvrpzlYH/oMUVQqLUDyIzLCy1eFzApPalf7hNgq8U
	 crqLspOG6MaYCcvquOG+GpLPjT9+8LtSai29OLilx7Kj8fPg60e2dgi+NfmIo2nHtG
	 l4K8VYXkS84xFyz3wt7GhJlrOKTU+YQWMb56d+h8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 193/312] hwmon: (pxe1610) Check return value of page-select write in probe
Date: Wed,  8 Apr 2026 20:01:50 +0200
Message-ID: <20260408175940.966693859@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234176-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,roeck-us.net:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,juniper.net:email]
X-Rspamd-Queue-Id: 712F53C0510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

[ Upstream commit ccf70c41e562b29d1c05d1bbf53391785e09c6fb ]

pxe1610_probe() writes PMBUS_PAGE to select page 0 but does not check
the return value. If the write fails, subsequent register reads operate
on an indeterminate page, leading to silent misconfiguration.

Check the return value and propagate the error using dev_err_probe(),
which also handles -EPROBE_DEFER correctly without log spam.

Fixes: 344757bac526 ("hwmon: (pmbus) Add Infineon PXE1610 VR driver")
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260329170925.34581-4-sanman.pradhan@hpe.com
[groeck: Fix "Fixes" SHA]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pxe1610.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
index 52bee5de29883..12d5d7297b5c9 100644
--- a/drivers/hwmon/pmbus/pxe1610.c
+++ b/drivers/hwmon/pmbus/pxe1610.c
@@ -104,7 +104,10 @@ static int pxe1610_probe(struct i2c_client *client)
 	 * By default this device doesn't boot to page 0, so set page 0
 	 * to access all pmbus registers.
 	 */
-	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to set page 0\n");
 
 	/* Read Manufacturer id */
 	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
-- 
2.53.0




