Return-Path: <stable+bounces-242594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHMrOejg9Wm8QAIAu9opvQ
	(envelope-from <stable+bounces-242594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 13:32:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFA4B1CEF
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 034933003BC7
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122A337107;
	Sat,  2 May 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzm3rxP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988830E84A
	for <stable@vger.kernel.org>; Sat,  2 May 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777721570; cv=none; b=s+9WGrY8S/GkuAZYm7sGkh6Fqf3DYKYYcxVKS4AcgEaRDCX2IsBYn2GvHD/w+5ZvhF+NxJhjbYlDSfRhBkZCRsxR6I7fkzsfDYJxxoR6AMcN3UELzaJ0BTur45ztVLIsHKZ8MJBkVueB+1bfDSKYPxKFUQ4f6WMQPsC9LPQj818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777721570; c=relaxed/simple;
	bh=CzOIK8yr0Ox4/96sOMfnWlZ9FE1gbFS4FyUF19xstqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2FNxOnSX+LEo0lvbUkb5LeIVAQAAChAXd1axvsXCxvZxHQ3OFBRwhN6cMN+qFJFaFIoU9YB0Y7aMSfw5oQ891iU+Ydb0o+Fn45dn1LveIN9KH9H8eCiur/fh7shMlyFNbesJ0mVZ7gEqwYkPIYIUHo6gsTXwPb/rDTw+yhHfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzm3rxP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8FCC19425;
	Sat,  2 May 2026 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777721570;
	bh=CzOIK8yr0Ox4/96sOMfnWlZ9FE1gbFS4FyUF19xstqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzm3rxP0LvJ8hcZwogw1iDSARHxPabC5SYq5zAxMeV0CpcPRehSB9BIgOhiXlGYu0
	 luuqYypf+QLDDzPGRilANU7B7WpUilLyHnouGmRnzvz0QCAMmFR+CMMXGicBareEEW
	 xSgF+VU1+k/Yv3oNZVg4npVbHkNqbCLq8RsdWY3pRuUSP5jS4EOV8mrJ3/SFvBwG0U
	 A3+OMmXNl2HWYQNnBU8tlITtEo22/kEgAyF3gYb9qDD6+hV6eSP2vR6ACMhpbkubii
	 LHB/EomZX0rPWtUVc20TqySoa1NOhkbXaADyFwkKMZI+dlPClTt8svQNv8b+U4B1jt
	 aaRQNj5+va1LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Kim <james010kim@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mtd: docg3: fix use-after-free in docg3_release()
Date: Sat,  2 May 2026 07:32:48 -0400
Message-ID: <20260502113248.404359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050109-veal-endurance-5d34@gregkh>
References: <2026050109-veal-endurance-5d34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEAFA4B1CEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242594-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
index fa42473d04c1b..378239c7513e0 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2042,7 +2042,6 @@ static int __init docg3_probe(struct platform_device *pdev)
 static int docg3_release(struct platform_device *pdev)
 {
 	struct docg3_cascade *cascade = platform_get_drvdata(pdev);
-	struct docg3 *docg3 = cascade->floors[0]->priv;
 	int floor;
 
 	doc_unregister_sysfs(pdev, cascade);
@@ -2050,7 +2049,7 @@ static int docg3_release(struct platform_device *pdev)
 		if (cascade->floors[floor])
 			doc_release_device(cascade->floors[floor]);
 
-	bch_free(docg3->cascade->bch);
+	bch_free(cascade->bch);
 	return 0;
 }
 
-- 
2.53.0


