Return-Path: <stable+bounces-251458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC/rKaj7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAD595E21
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8DEB335B058
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F353C6A5C;
	Wed, 20 May 2026 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFmVhPNz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAD369999;
	Wed, 20 May 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298034; cv=none; b=tcNSQKPCxeGnhEMaUj1hnY7q6/5oblZQgDrn7+nq/OCAJJmNfx4GfJUD/mIx7DH13JAzt/ek+hm0o0/XjD2jo9ZGOseo0t3PwIXWqu7ItdXobVHOIdsnIctuD7qhS9M3s2Wa3IRVUHCu9kqddQhw/veGW3KOOzikzzMDh5/RsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298034; c=relaxed/simple;
	bh=md3Undh0Ue3bpjV5rt1O7AZygQOj3KUCw1pWSJBEwY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfuO2bro38AJP3RFn0uTuTMgnScfup6RceaeOCt94aDfbrqfj1ZpBvo48KM6if3u7XCLtTMfNg0mPaF2hI1AiePlm/6Z6RYrRsn1/W0/O4vUcmeFLmuBfNLxQYysntAjEb6jowdaRblBWqNxhHVpSlQKl6sNYUOm+/KPGZ8odqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFmVhPNz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95BE1F00893;
	Wed, 20 May 2026 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298033;
	bh=YVgh1QDpbE1Nn/hWysgxD+ot5UrXs8H1q1chh3q2/OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NFmVhPNzIHaryXYIZNnxPF95YJowt+MMAD/f1BhVAVncl+63th0qEU6pL/UZBWdlz
	 NfCViYhdcNDrdBR68dZIjM6iBMnTHlXzbuL34h3Sm+Y1vsruur3+fiNLWUhFY21WEC
	 4BjE3I9i42OTrF4rDKuX4minauVgtQEUajz0bPK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xifer <xiferdev@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 255/957] PCI: Fix alignment calculation for resource size larger than align
Date: Wed, 20 May 2026 18:12:18 +0200
Message-ID: <20260520162140.073493277@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,roeck-us.net,linux.intel.com,google.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251458-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 1DCAD595E21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 8cb081667377709f4924ab6b3a88a0d7a761fe91 ]

The commit bc75c8e50711 ("PCI: Rewrite bridge window head alignment
function") did not use if (r_size <= align) check from pbus_size_mem() for
the new head alignment bookkeeping structure (aligns2[]). In some
configurations, this can result in producing a gap into the bridge window
which the resource larger than its alignment cannot fill.

The old alignment calculation algorithm was removed by the subsequent
commit 3958bf16e2fe ("PCI: Stop over-estimating bridge window size") which
renamed the aligns2[] array leaving only aligns[] array.

Add the if (r_size <= align) check back to avoid this problem.

Fixes: bc75c8e50711 ("PCI: Rewrite bridge window head alignment function")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/b05a6f14-979d-42c9-924c-d8408cb12ae7@roeck-us.net/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xifer <xiferdev@gmail.com>
Link: https://patch.msgid.link/20260324165633.4583-11-ilpo.jarvinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 29ad8d8718974..522e25d725bad 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1342,7 +1342,14 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 			}
 			size += max(r_size, align);
 
-			aligns[order] += align;
+			/*
+			 * If resource's size is larger than its alignment,
+			 * some configurations result in an unwanted gap in
+			 * the head space that the larger resource cannot
+			 * fill.
+			 */
+			if (r_size <= align)
+				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
 
-- 
2.53.0




