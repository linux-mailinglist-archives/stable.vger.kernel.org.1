Return-Path: <stable+bounces-257183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JT2DkgYG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714E60ECAF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D187308636E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B927133FE15;
	Sat, 30 May 2026 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dgr3JAix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501632D42B;
	Sat, 30 May 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160099; cv=none; b=IACILd/lGvRgzPdTxMuDCFNOWkt9n2dDWIUn6TC7hoh6r1GnITqt4go9rVWkC8NNBXsuzN2pGiPiNkvmtfGe9S95eHLXlGfFxLPF5ebKBBEoFMOtEe7Y2ycb45lD6v0xCkFmPF3NX0PDIw191RyIhTj3OP/lNJNb7iT7Ec293pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160099; c=relaxed/simple;
	bh=yLslDqGJZscVY50+pwe4CnUsWtn1Y8T6AZJ3V5CA81k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5jxosk0k9x9tykMyBsS3sB7pdAqkcYRZ8EWdrsXalRXAL+oBguoLF7YrsuZep30d3GWiGquvbppiyGntqdtNBPlH05sVugg3hIgcyr/jl9UsVaqcSitpfOLzXKq79RT9EkZKxdnuJQ6uJOXUnb4FfAiFFZtzEki7ZDkkOKFpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dgr3JAix; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0C21F00893;
	Sat, 30 May 2026 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160098;
	bh=f0zvAF+Uehc2PkYMSQ+anEv4Ywu9inSi9PmAChjVFiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dgr3JAixjO5yt6GTzqkuMl/b2zXwWYfrGIGvTrGefPVAR0ybUOljgFxK65XbTRc/t
	 UNPygwu57PL4liNh9MsF6puh7bUn2UAFy0a0Gezdf58iG6gyoGwbHS+bftvdK+7l9D
	 OBDdLR/6jxiiZ8s0IhZIlbMn9ScLiJc2kzFWdwkI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Kim <james010kim@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 245/969] mtd: docg3: fix use-after-free in docg3_release()
Date: Sat, 30 May 2026 17:56:09 +0200
Message-ID: <20260530160307.226809428@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257183-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bootlin.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9714E60ECAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Kim <james010kim@gmail.com>

[ Upstream commit ca19808bc6fac7e29420d8508df569b346b3e339 ]

In docg3_release(), the docg3 pointer is obtained from
cascade->floors[0]->priv before the loop that calls
doc_release_device() on each floor. doc_release_device() frees the
docg3 struct via kfree(docg3) at line 1881. After the loop,
docg3->cascade->bch dereferences the already-freed pointer.

Fix this by accessing cascade->bch directly, which is equivalent
since docg3->cascade points back to the same cascade struct, and
is already available as a local variable. This also removes the
now-unused docg3 local variable.

Fixes: c8ae3f744ddc ("lib/bch: Rework a little bit the exported function names")
Cc: stable@vger.kernel.org
Signed-off-by: James Kim <james010kim@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/docg3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 8cb25cfd9c10a..2f82bc7c07931 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2049,7 +2049,6 @@ static int __init docg3_probe(struct platform_device *pdev)
 static void docg3_release(struct platform_device *pdev)
 {
 	struct docg3_cascade *cascade = platform_get_drvdata(pdev);
-	struct docg3 *docg3 = cascade->floors[0]->priv;
 	int floor;
 
 	doc_unregister_sysfs(pdev, cascade);
@@ -2057,7 +2056,7 @@ static void docg3_release(struct platform_device *pdev)
 		if (cascade->floors[floor])
 			doc_release_device(cascade->floors[floor]);
 
-	bch_free(docg3->cascade->bch);
+	bch_free(cascade->bch);
 }
 
 #ifdef CONFIG_OF
-- 
2.53.0




