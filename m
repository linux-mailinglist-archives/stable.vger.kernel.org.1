Return-Path: <stable+bounces-216200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOFrDvEtj2ksLgEAu9opvQ
	(envelope-from <stable+bounces-216200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:58:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEA136CF9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F093530A6EB0
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6435FF61;
	Fri, 13 Feb 2026 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmuZ5T6F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A71684BE;
	Fri, 13 Feb 2026 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990972; cv=none; b=hbYRH/OXW57DHB+K8hqAC4naNTCMeOi2V/jdvOLoynYyIQUKgQoLFgxdHQSkukdBdS9zTscWoTfVU1R60PdVzN9zhm7vA6PMS35Ve4ivXoNMbFKiQmAhxDfL0kSzG0+90vzy1aMXBCkoBGj2f3zg6uwENMMEU8Ixn0jCrcOnC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990972; c=relaxed/simple;
	bh=vIzNQ9Ftr8D9x99QpWZ8n+Q+s7aI7tjJiEWuumV2bKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDUeYMWwQl+FWDcbKWzRqyXpgHe9smjPwPQDEr5ec/WQKiVnlsESwtpjSqSwLHIyh3TlvkP+3WZiUU4KeZQu8nTSi/IgSxm7Z++c6KVJE7ImYlQe7LChrzImknPGRX3KVkfuITTq8jAwvtD8VVVgYI6e6Wx7V7qwFfc9jj9k3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmuZ5T6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A99C116C6;
	Fri, 13 Feb 2026 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990972;
	bh=vIzNQ9Ftr8D9x99QpWZ8n+Q+s7aI7tjJiEWuumV2bKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmuZ5T6FcMqJdSstlqEVZeO7CTuKb/0daGcckELCJMz+eSXbsWMq7XzwpGl3NHZHf
	 W8eE3fvBkBFPSjFBskMUaJv5AW4c57dmTlHQSeE4p+JTghP+cg8S7DZOnkH/G1JxaW
	 EjKS/5Z676IUjN135uvgEiGrxqWdyWos7pf0igQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.12 06/24] crypto: iaa - Fix out-of-bounds index in find_empty_iaa_compression_mode
Date: Fri, 13 Feb 2026 14:48:25 +0100
Message-ID: <20260213134704.963899569@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134704.728003077@linuxfoundation.org>
References: <20260213134704.728003077@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216200-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linux.dev:email,intel.com:email,apana.org.au:email]
X-Rspamd-Queue-Id: 96EEA136CF9
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -223,15 +223,13 @@ static struct iaa_compression_mode *iaa_
 
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



