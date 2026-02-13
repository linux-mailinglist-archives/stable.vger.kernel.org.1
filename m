Return-Path: <stable+bounces-216152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHorGhktj2ksLgEAu9opvQ
	(envelope-from <stable+bounces-216152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CD136B26
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC92B305D6F0
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02534CFC3;
	Fri, 13 Feb 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtYxAFtp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FC23645D;
	Fri, 13 Feb 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990808; cv=none; b=Qhk4wlP3FOuKBds87ccIEyYn86xDykEiJloEANalDnbueCP6MTAf9GNC2Y10a+ddhreYlGgRgkczwezzySeANgfaDFwTFpHhD7FNP7o0bxaVnljfrzVOmEOnmfmkVeN2u54CSlLGMm9uczYPYEdMjsPeYpskxd/AFDwKfYCt/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990808; c=relaxed/simple;
	bh=M8qv4UwQb+RL3DCcYPMI/t/WD8CHrv8v/BQopYHLyWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga7wmLS9JZk3BxvIXR/NQ+iQuBzS9d4T40qUILTRlGNI9lBKjLMTQfn+xSLqCgnlhmnmD0rLF6drVReC+mvXk0SX+FrSfOyiWEqPm8XxaXxFw4Riabz/Ex3bW9UISI9lV4f0dkpiuPrncJ6GvsIP7jmCCqtYPGwYtMqVaw1/tFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OtYxAFtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B99C116C6;
	Fri, 13 Feb 2026 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990808;
	bh=M8qv4UwQb+RL3DCcYPMI/t/WD8CHrv8v/BQopYHLyWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtYxAFtpGtX0y+YW+CenErcPivsgyWZV/8GECdHjTH31x/5i/y1UhA4MJ5O02kXzV
	 dP6xUqpgJlFlGUMRfwfNd2S+gb0ECxmQZN4rYlVR8ri+5HqsEDvfbbgWzHvBAvTSoA
	 jeU8YeXO/u+m9iHuNiOErXs6qmZTX79HxJi8St1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.18 30/49] crypto: iaa - Fix out-of-bounds index in find_empty_iaa_compression_mode
Date: Fri, 13 Feb 2026 14:48:14 +0100
Message-ID: <20260213134709.986203326@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216152-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,intel.com:email]
X-Rspamd-Queue-Id: B73CD136B26
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 48329301969f6d21b2ef35f678e40f72b59eac94 upstream.

The local variable 'i' is initialized with -EINVAL, but the for loop
immediately overwrites it and -EINVAL is never returned.

If no empty compression mode can be found, the function would return the
out-of-bounds index IAA_COMP_MODES_MAX, which would cause an invalid
array access in add_iaa_compression_mode().

Fix both issues by returning either a valid index or -EINVAL.

Cc: stable@vger.kernel.org
Fixes: b190447e0fa3 ("crypto: iaa - Add compression mode management along with fixed mode")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -221,15 +221,13 @@ static struct iaa_compression_mode *iaa_
 
 static int find_empty_iaa_compression_mode(void)
 {
-	int i = -EINVAL;
+	int i;
 
-	for (i = 0; i < IAA_COMP_MODES_MAX; i++) {
-		if (iaa_compression_modes[i])
-			continue;
-		break;
-	}
+	for (i = 0; i < IAA_COMP_MODES_MAX; i++)
+		if (!iaa_compression_modes[i])
+			return i;
 
-	return i;
+	return -EINVAL;
 }
 
 static struct iaa_compression_mode *find_iaa_compression_mode(const char *name, int *idx)



