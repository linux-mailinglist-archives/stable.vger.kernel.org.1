Return-Path: <stable+bounces-266093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 87BtMFyWMWoxngUAu9opvQ
	(envelope-from <stable+bounces-266093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:30:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57431694329
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:30:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Ao41mKa2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266093-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266093-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EF3630A4632
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BA3DC4D9;
	Tue, 16 Jun 2026 18:30:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950734FF79;
	Tue, 16 Jun 2026 18:30:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634624; cv=none; b=eO7Dv0lglarFKXJhVAhe9r94D2QS6YK1VCysO+qZrlVwDXLUPwlGxmt5B78wH9yRAto3MI2nwjKbXfOxSbcz275t0mF93C37Uhy+Xwet/C/6s3pX8ZiYIz7l9atSn1HpCAYiqRyYju0Fn3pDDdYHgrGfN7j7s2xqM8Czd06k2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634624; c=relaxed/simple;
	bh=Pl3nll2BmjiYkI9mxxDw2co+UoynoUxnBlY/6REjX1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD8T9MqwRkePMjmepfwdfqDKPojjvFStRTZAu1uX9exG7lgq49Ib5Y33nRDltsyj0nGc7QryirkilRuRMJdHpyg36PhEATn5nXbAt1KjoSUuD6e08LK8ZwYwXW5DNuUI9I6KrZvzHnbHrhSb8tppwKWp4vjlCK3FZvH5ypTyIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ao41mKa2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFC61F000E9;
	Tue, 16 Jun 2026 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634623;
	bh=zF1D6WJsr5i0nk37hs5+3W/LPb6ONbGZy399Ci4OY+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ao41mKa2z7EYWUhhbCEKbyvLa++fxzjlDCqeD2lEAJqg9tBKT7mxn3Za8tEyMZSSy
	 w+A9t6q+4En0+3oRluMAbwxczqOn3lqs/0F+Eptze0Hcuo17gOx0Ije7SPUTMC0AwY
	 /3gSwG4C2shzxPIK+1LxyxByOnnBikJzBDP2Q2Mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 293/411] erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()
Date: Tue, 16 Jun 2026 20:28:51 +0530
Message-ID: <20260616145116.726572985@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,linux.alibaba.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-266093-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:hsiangkao@linux.alibaba.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,alibaba.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57431694329

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[ renamed `rq->outpages`/`rq->inpages` to `nrpages_out`/`nrpages_in` and inverted the check to `nrpages_out < nrpages_in` on the existing `goto docopy` chain ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/decompressor.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -140,6 +140,7 @@ static void *z_erofs_handle_inplace_io(s
 
 	if (rq->inplace_io) {
 		if (rq->partial_decoding || !support_0padding ||
+		    nrpages_out < nrpages_in ||
 		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
 			goto docopy;
 



