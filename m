Return-Path: <stable+bounces-244910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ5BIwOw/mkqvAAAu9opvQ
	(envelope-from <stable+bounces-244910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:54:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB94FDF9C
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBB23017C22
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865B637C935;
	Sat,  9 May 2026 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0cggDrm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A1279DC3
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778298864; cv=none; b=UYLMsOc3m2wgRDadko5cMVwek1kgbA6t2bCqPg1MFwBszmwUw5GLxqVeSONH8liwSY5YpQg1+aG3X3FAom6zUc7QfKB+c24/Sk/kouCuck2oT137R/m/rq9XW2ocrgopfStsQeGrJDVtEejFd+OVxy3z0XGk3NGrV144ZBFhA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778298864; c=relaxed/simple;
	bh=jSZxxzhP+uoENkzrtWpFk6i7UUabOIp1OYvcR9Z9ygM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyFVj6qJaiXPJ1tCU3L1gxfbf8Q8n8gLtDXas9yB/dHTcS4R0wUSk+Too/yqQiMBWJd8W+romCmUbQs5u84nyU9A3rMfArZI1nihboMWrkyAHHnltFEW0IaX64xmF0xp42ooAWg9nZOJQXNSSrlPnxxppmxw8CnsCcWESg+Ea6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0cggDrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80702C2BCB2;
	Sat,  9 May 2026 03:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778298864;
	bh=jSZxxzhP+uoENkzrtWpFk6i7UUabOIp1OYvcR9Z9ygM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0cggDrmP0MvTuRl9SvXOxa80d3ivP07lMKO8/FnvyCP6mH/3xAwXSV+ODOpuu14L
	 lBG1bYn+rwuOjCVYaJI7IY84lh4IH0LgbDr3byie6ibxyv4sEJcucf015K5R/iGrlb
	 seqCHr1cppwPiF0XXS3s5FXSfD5XHZav3rhgUtMktveNFo7D79YW+WWcB+VQB/Bo+R
	 RiWCZZmMAq6w99Td/SPWAPnuZJ/c8wpZr6x5XJuiyi0ma4s+wXUBdlizBLNV8zD8s2
	 O+IB/JP84zUAPTFJq6JuazBIoIUYKLm3YaIYgYM9LHdjVrsLryYlDxLxYcJ8vHkjDt
	 A3h3H5Js/PU5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()
Date: Fri,  8 May 2026 23:54:21 -0400
Message-ID: <20260509035421.3122562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050415-landmark-dedicator-394a@gregkh>
References: <2026050415-landmark-dedicator-394a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8FCB94FDF9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,gmail.com,linux.alibaba.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Action: no action

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 21e161de2dc660b1bb70ef5b156ab8e6e1cca3ab ]

Some crafted images can have illegal (!partial_decoding &&
m_llen < m_plen) extents, and the LZ4 inplace decompression path
can be wrongly hit, but it cannot handle (outpages < inpages)
properly: "outpages - inpages" wraps to a large value and
the subsequent rq->out[] access reads past the decompressed_pages
array.

However, such crafted cases can correctly result in a corruption
report in the normal LZ4 non-inplace path.

Let's add an additional check to fix this for backporting.

Reproducible image (base64-encoded gzipped blob):

H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+g
dilSJo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9i
PNtbjhan04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz
2DF/21+20T/ldgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1w
ywAAAAAAAADwu14ATsEYtgBQAAA=

$ mount -t erofs -o cache_strategy=disabled foo.erofs /mnt
$ dd if=/mnt/data of=/dev/null bs=4096 count=1

Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
[ inverted condition to early-out `goto docopy` form and used `ctx->inpages`/`ctx->outpages` instead of `rq->` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/decompressor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 86e088fd386ee..18e4da98309d5 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -133,6 +133,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 	if (rq->inplace_io) {
 		omargin = PAGE_ALIGN(ctx->oend) - ctx->oend;
 		if (rq->partial_decoding || !may_inplace ||
+		    ctx->outpages < ctx->inpages ||
 		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
 			goto docopy;
 
-- 
2.53.0


