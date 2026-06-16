Return-Path: <stable+bounces-264121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YhLfMwdwMWo8jQUAu9opvQ
	(envelope-from <stable+bounces-264121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:47:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6191691624
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:47:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=HCf1g0Qk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264121-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264121-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9607530E6DEA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949F044D02B;
	Tue, 16 Jun 2026 15:37:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4A44CF2E;
	Tue, 16 Jun 2026 15:37:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624240; cv=none; b=ieCIosjth5NWZlGi1eUmaKw0Iqoj3i7ck2ToCX0aaaHuC15KHl3oQerSoP3ys1C1ihGora3y3fyOfwfO2R+9ATILVX6kDwQZ4XPpmY3ObpK/VmHqhrKRNl+9SulBFq0qrzp8iRLQdoZmtccB0Rzg7eQN9s7TpFfTmvfiidMmWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624240; c=relaxed/simple;
	bh=vdx5y4PfP6jnJ6eHgQX+Ga4Q5apdNPX7WBfzB48+TkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICnvM7ru/1O7iiojsx/9TlRNQNSAnHd/gRIbGjSByyxMuy/jm4qcxIVtj/4GxIn7Ku6y38EmYY2g3Eb1YIOmoVypdD5GApVxRvxYGFUMfL2IxEQVuQ1NcmG5QF6H/I5Z/YZ5aLC1TeKYWqy57lXOHjgbpWE2qC6mbA1lo26NKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCf1g0Qk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3131F000E9;
	Tue, 16 Jun 2026 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624239;
	bh=btjDXi4O8zxD6KpLr0Ej2XAcESRaL8BkNcpfE++AcdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCf1g0Qk6JqKvHWcy4EEtlvwOk3YUXaoR8z2JMkE2w6pmnWYSQjmeIpx/VTORCk0C
	 jFyL2AaqLyZGEsggtiRkaZihKd19A6WYTuU7BKmlpsoHzRucVD++0AbqrAAhrvuSqR
	 guzp3KW8n1qVhBcP993+tiDKMslU7bDDsSLzTa40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Judith Mendez <jm@ti.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH 7.0 297/378] pinctrl: mcp23s08: Read spi-present-mask as u8 not u32
Date: Tue, 16 Jun 2026 20:28:48 +0530
Message-ID: <20260616145125.701849870@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264121-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jm@ti.com,m:linusw@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,ti.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6191691624

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Judith Mendez <jm@ti.com>

commit b0c13ec17438577f90b379d448dfed1233e2c0a4 upstream.

The binding (microchip,mcp23s08) specifies microchip,spi-present-mask
as uint8, but driver would read u32, causing type mismatch. Use
device_property_read_u8 to match binding spec, hardware (8 chips max),
& prevent probe failure.

Cc: stable@vger.kernel.org
Fixes: 3ad8d3ec6d87 ("dt-bindings: pinctrl: convert pinctrl-mcp23s08.txt to yaml format")
Signed-off-by: Judith Mendez <jm@ti.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-mcp23s08_spi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
@@ -144,13 +144,13 @@ static int mcp23s08_probe(struct spi_dev
 	unsigned int addr;
 	int chips;
 	int ret;
-	u32 v;
+	u8 v;
 
 	info = spi_get_device_match_data(spi);
 
-	ret = device_property_read_u32(dev, "microchip,spi-present-mask", &v);
+	ret = device_property_read_u8(dev, "microchip,spi-present-mask", &v);
 	if (ret) {
-		ret = device_property_read_u32(dev, "mcp,spi-present-mask", &v);
+		ret = device_property_read_u8(dev, "mcp,spi-present-mask", &v);
 		if (ret) {
 			dev_err(dev, "missing spi-present-mask");
 			return ret;



