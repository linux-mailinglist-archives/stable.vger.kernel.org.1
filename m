Return-Path: <stable+bounces-212562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L5CJG47emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:38:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BEAA5E9D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A613217D89
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DED42FF178;
	Wed, 28 Jan 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="deQf2NFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56191D6AA;
	Wed, 28 Jan 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615935; cv=none; b=KbxI7xS+5CPq2dQF5on97us6mWBir9KDIXrOr61yCzFKBK5fkYX2sLJ3d3mNJbGiJ1+CZSq4PL6/zSM2fhw8Zlkhh2pYVleksPP6rIj5EV246nRLH2T1fgYt9aGA1+MDBEDQ5Lcs938PUJXa2jYpOiq76U+KSljfOv343I5AUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615935; c=relaxed/simple;
	bh=ZIA44+6LY/QL4QtUXU77QAipUYKt3y0sJ9IAH8louIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGcORpTclMbSyBcpjvVnxYYTsAtX1P3jUK/mfC+I9rM1Q2FrOZNwQYgCNdMRAQoVFll/HRELPPivU9pL+Cwzp7XU1xJkdYUW6YpYzEUiTzyriAuQmeTVLk9FUxKakvWe8TO2QnyaNyWberVdCoVCdEQHYvn/wzEo1xWpgtRedig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=deQf2NFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD41C4CEF1;
	Wed, 28 Jan 2026 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615934;
	bh=ZIA44+6LY/QL4QtUXU77QAipUYKt3y0sJ9IAH8louIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deQf2NFKvqbqjrkPgch+gZ88S3wgcAojUXZFQ3zBOLBXWmvvLXPyvqtnty6Ep9Fxp
	 /IzuBsy0q4B8HzlE8LOjBSKElXXVoM++1cssHTpBA2WuhJ3kHfkPNwptsZqkQl1y9g
	 XHb1lZrga1YzvI5uY09qWl6acvexuZGa2yoKcIMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 157/227] iio: accel: adxl380: fix handling of unavailable "INT1" interrupt
Date: Wed, 28 Jan 2026 16:23:22 +0100
Message-ID: <20260128145350.103187266@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212562-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,analog.com:email,huawei.com:email,baylibre.com:email]
X-Rspamd-Queue-Id: 00BEAA5E9D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Lavra <flavra@baylibre.com>

commit 4ff39d6de4bf359ec6d5cd2be34b36d077dd0a07 upstream.

fwnode_irq_get_byname() returns a negative value on failure; if a negative
value is returned, use it as `err` argument for dev_err_probe().
While at it, add a missing trailing newline to the dev_err_probe() error
message.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/adxl380.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1728,9 +1728,9 @@ static int adxl380_config_irq(struct iio
 		st->int_map[1] = ADXL380_INT0_MAP1_REG;
 	} else {
 		st->irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
-		if (st->irq > 0)
-			return dev_err_probe(st->dev, -ENODEV,
-					     "no interrupt name specified");
+		if (st->irq < 0)
+			return dev_err_probe(st->dev, st->irq,
+					     "no interrupt name specified\n");
 		st->int_map[0] = ADXL380_INT1_MAP0_REG;
 		st->int_map[1] = ADXL380_INT1_MAP1_REG;
 	}



