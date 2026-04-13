Return-Path: <stable+bounces-236858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILdOORwd3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40F3EF976
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B19C63041491
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A56C225A38;
	Mon, 13 Apr 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkT7NtDU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E87238D27;
	Mon, 13 Apr 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097973; cv=none; b=Vz/vj/lFaJd9ZdhUta3mqjCYKueYK3DdDQGfbc7MI/mXMbIiqlT0gwzzcLvys+ixrqveZz8FWiKGcYU+hFzQMnoiwDOxf50mJe49wySvRY6WdRZOh0JsIDiVZkjS9pB4m6T7PMnr+Ov1YaQQ7nJYGksH0fRD6MnynB2zw+3esOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097973; c=relaxed/simple;
	bh=ox5f6537GHrXpXWAleqzpMknFfzro5WCbhaYkvN2cXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqKzsh7guF01ebeDr5pAtvndJdhmaLIgtSUsQIzTkDEY472FwHfY9LbdD46sNv5Z+KEQjjU5U8eGuSEGVIBWoiZZk+vc2NS+xeF1F37XWP8TmSndaBQE37wniiH+TKdEfMrWcrFFmB6RO+WPaGBnC1qCL8xhgH3o1gmtO2qlXt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkT7NtDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58295C2BCAF;
	Mon, 13 Apr 2026 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097973;
	bh=ox5f6537GHrXpXWAleqzpMknFfzro5WCbhaYkvN2cXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkT7NtDU4Fb3Xl65sKI4yBH/Arycyb2IIt3hE4vhCJgtKFqHODENXMk5IWht5ks+R
	 09QjZJH2LcJk+blpJbCSkletRyZI247epSaOuW9d/jnMKS59JdPtpObIMXmQTZJyIS
	 PWPdLT/IzlZJ1WrTCn1RzEsjFBMUqkuFq5yj/v3E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 345/570] regmap: Synchronize cache for the page selector
Date: Mon, 13 Apr 2026 17:57:56 +0200
Message-ID: <20260413155843.413844470@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236858-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,samsung.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B40F3EF976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 09e70e4f119ff650d24c96161fd2f62ac7e424b0 ]

If the selector register is represented in each page, its value
according to the debugfs is stale because it gets synchronized
only after the real page switch happens. Hence the regmap cache
initialisation from the HW inherits outdated data in the selector
register.

Synchronize cache for the page selector just in time.

Before (offset followed by hexdump, the first byte is selector):

    // Real registers
    18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
    ...
    // Virtual (per port)
    40: 05 ff 00 00 e0 e0 00 00 00 00 00 1f
    50: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
    60: 01 ff 00 00 ff ff 00 00 00 00 00 00
    70: 02 ff 00 00 cf f3 00 00 00 00 00 0c
    80: 03 ff 00 00 00 00 00 00 00 00 00 ff
    90: 04 ff 00 00 ff 0f 00 00 f0 00 00 00

After:

    // Real registers
    18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
    ...
    // Virtual (per port)
    40: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
    50: 01 ff 00 00 e0 e0 00 00 00 00 00 1f
    60: 02 ff 00 00 ff ff 00 00 00 00 00 00
    70: 03 ff 00 00 cf f3 00 00 00 00 00 0c
    80: 04 ff 00 00 00 00 00 00 00 00 00 ff
    90: 05 ff 00 00 ff 0f 00 00 f0 00 00 00

Fixes: 6863ca622759 ("regmap: Add support for register indirect addressing.")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260302184753.2693803-1-andriy.shevchenko@linux.intel.com
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e1380b08685f4..b1cae7db6318a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1629,6 +1629,7 @@ static int _regmap_select_page(struct regmap *map, unsigned int *reg,
 			       unsigned int val_num)
 {
 	void *orig_work_buf;
+	unsigned int selector_reg;
 	unsigned int win_offset;
 	unsigned int win_page;
 	bool page_chg;
@@ -1647,10 +1648,31 @@ static int _regmap_select_page(struct regmap *map, unsigned int *reg,
 			return -EINVAL;
 	}
 
-	/* It is possible to have selector register inside data window.
-	   In that case, selector register is located on every page and
-	   it needs no page switching, when accessed alone. */
+	/*
+	 * Calculate the address of the selector register in the corresponding
+	 * data window if it is located on every page.
+	 */
+	page_chg = in_range(range->selector_reg, range->window_start, range->window_len);
+	if (page_chg)
+		selector_reg = range->range_min + win_page * range->window_len +
+			       range->selector_reg - range->window_start;
+
+	/*
+	 * It is possible to have selector register inside data window.
+	 * In that case, selector register is located on every page and it
+	 * needs no page switching, when accessed alone.
+	 *
+	 * Nevertheless we should synchronize the cache values for it.
+	 * This can't be properly achieved if the selector register is
+	 * the first and the only one to be read inside the data window.
+	 * That's why we update it in that case as well.
+	 *
+	 * However, we specifically avoid updating it for the default page,
+	 * when it's overlapped with the real data window, to prevent from
+	 * infinite looping.
+	 */
 	if (val_num > 1 ||
+	    (page_chg && selector_reg != range->selector_reg) ||
 	    range->window_start + win_offset != range->selector_reg) {
 		/* Use separate work_buf during page switching */
 		orig_work_buf = map->work_buf;
@@ -1659,7 +1681,7 @@ static int _regmap_select_page(struct regmap *map, unsigned int *reg,
 		ret = _regmap_update_bits(map, range->selector_reg,
 					  range->selector_mask,
 					  win_page << range->selector_shift,
-					  &page_chg, false);
+					  NULL, false);
 
 		map->work_buf = orig_work_buf;
 
-- 
2.53.0




