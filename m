Return-Path: <stable+bounces-250467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHWVDvryDWry4wUAu9opvQ
	(envelope-from <stable+bounces-250467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE2594728
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A077E3513D33
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882639A05A;
	Wed, 20 May 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mv3UXHcy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AD31A575;
	Wed, 20 May 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295488; cv=none; b=FpN51/wfERjpUTI77ozaPLPq1f2UNBjoiANNRyc5z0ytCHwx/LnVGxr43+pDAMH3BvMb64JA6DFNIeoLV8tHtiz14efSWnu+zw2Mq5IID7PaQjnVZkU0coT+8ayofKTYLd4ecMqiMKsuL5gkssAnZpr3UVfR9+E9IuuFoSTsdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295488; c=relaxed/simple;
	bh=VfQzBJyCSjYxEMeLgi5cp7pVDyH3DeezVUwF9daEZyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTnX5sw3amO9lP+Jdf9Vom3PSOBtaa7OIFGBZXd6IYKOFm4oG/p8YfIIRtq04YngRYzGmDuGCSzbNX4Oe9itRHj+PMKQLtAF/H7tXUcFmT81O+LUwD/Wvzco960JoJXTGy1nfwpAcz0LmCvhZW+V8JxTBaG907YcWt40UPbm9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mv3UXHcy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D061F000E9;
	Wed, 20 May 2026 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295487;
	bh=PzfERCNEutF50+H2hCmT5sPpdQg3fU1pLmf7J8mZPPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mv3UXHcyXbaZl38aW2AKwwDOrz3K90LZs/dOGcw/h8mkqbbbfBIBUTI+ycCgeUGtf
	 W5uzjiZ3MxtsDuxrFjbKIEZCSqKFWqeizdXY5ot+VJ4cjPA8XG7ofT06rocILLVfwo
	 Mdok/EYmRxp3kaT1xN8VlFTiXZoqVufZcxxYiTNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0439/1146] spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
Date: Wed, 20 May 2026 18:11:29 +0200
Message-ID: <20260520162158.134428904@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250467-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 87CE2594728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 5e75c1d4d386fb7d64e2b19355e4d38dd4fd8845 ]

I got mislead while analyzing the driver by the fact that the second
opcode byte was in all cases smashed:

        if (op->cmd.dtr)
                opcode = op->cmd.opcode >> 8;
        else
                opcode = op->cmd.opcode;

While at a first glance this doesn't let a chance to the second byte to
be shifted out on the bus, this is actually the second step of an
initialization, where the byte being apparently "ignored" in DTR mode
has already been written in a dedicated "extended opcode" register. As
such, the comment and the extra check that I proposed were entirely
wrong, remove them.

Fixes: bee085476d27 ("spi: cadence-qspi: Make sure we filter out unsupported ops")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260410-winbond-6-19-rc1-oddr-v1-1-2ac4827a3868@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1b0d6186c7efa..057381e56a7fd 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1544,10 +1544,6 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 		if (op->data.nbytes && op->data.buswidth != 8)
 			return false;
 
-		/* A single opcode is supported, it will be repeated */
-		if ((op->cmd.opcode >> 8) != (op->cmd.opcode & 0xFF))
-			return false;
-
 		if (cqspi->is_rzn1)
 			return false;
 	} else if (!all_false) {
-- 
2.53.0




