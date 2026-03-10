Return-Path: <stable+bounces-224217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPA6BjsCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA924B157
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D13A33053F23
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5325387562;
	Tue, 10 Mar 2026 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1nY5TaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC43803CD;
	Tue, 10 Mar 2026 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141915; cv=none; b=Y/ycRt2Ee7w8BDGs4uJ41KcoBB6LbWG6W9jcGB5iQTfyRXL1m2VRMPJql43tyTPKTrh4X6X3Wd3WgV5mLr+G2TVQrWbvJpKcKN68aqLPEHxniHk+LCbVv7h0kaTsBn1KqDKGm7yfbrN9fhzyUrYoppXHqYEySTDvyQtEYejR+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141915; c=relaxed/simple;
	bh=fzjESTB8EpULEbHybToauaFfmA49OFoUBEvUZ4KvArc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFd8P+pG/HOtL1VD0BN1iJtN0smyEsK9Z8vaJQz2bRr8zF0V4D31LENeEjuBVo4ZKnS+edc3hkt8ykIH7aSxcmPV2RxzhRCJjOLxmTYRRZzkkzq7OFb9dcRgrUrEMEDzQblkiOg7Gen4WEepu03WoKLwvwmUUgqoKubHOapBAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1nY5TaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D03C2BC86;
	Tue, 10 Mar 2026 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141915;
	bh=fzjESTB8EpULEbHybToauaFfmA49OFoUBEvUZ4KvArc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1nY5TaRJPLh5IujS+BF4vqaOvCMMq140tw7C/KmGkBQXEvfqw1GoMDW999Vi5/ur
	 4Wh4SoLd9Sq8FZWJpZx1CjMVpzaTJugPJ3g7kdcRGrnTbdS/XgvN5YGzqZwuEF9crI
	 rp1synDZQQueV3hKOJev27e6MASWsBooDSzOD9KJxNyJh7Ll1E9NIdIwj2d+//aSBd
	 bSL2HtxJzenIC44oGP2EfREWqZwDm1IR7s0CSo+ZYUlaFRsjSczOq0LtY9VUTw39xD
	 WuH6mdFiO36y8Xz2vHAS/X/RHjrp2iLmj8s8CFVEQT3glwD9t73w1bjtMdDUrTIeJh
	 x7kN3A6Prgcpw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 038/314] zloop: check for spurious options passed to remove
Date: Tue, 10 Mar 2026 07:14:57 -0400
Message-ID: <205783f2b89fc539924d802cbe8d5bd8b4319f7b.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53FA924B157
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224217-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lst.de:email,kernel.dk:email]
X-Rspamd-Action: no action

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3c4617117a2b7682cf037be5e5533e379707f050 ]

Zloop uses a command option parser for all control commands,
but most options are only valid for adding a new device.  Check
for incorrectly specified options in the remove handler.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zloop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 2419677524453..26364e43aeb34 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1076,7 +1076,12 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 	int ret;
 
 	if (!(opts->mask & ZLOOP_OPT_ID)) {
-		pr_err("No ID specified\n");
+		pr_err("No ID specified for remove\n");
+		return -EINVAL;
+	}
+
+	if (opts->mask & ~ZLOOP_OPT_ID) {
+		pr_err("Invalid option specified for remove\n");
 		return -EINVAL;
 	}
 
-- 
2.51.0


