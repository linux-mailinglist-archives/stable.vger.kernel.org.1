Return-Path: <stable+bounces-258456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGcyNqQnG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480261110D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E42283021D0F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5E3B7B72;
	Sat, 30 May 2026 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxFPPGUo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675233112C1;
	Sat, 30 May 2026 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164411; cv=none; b=E/6ZjuJ7ZPCJ0nADJnA1nq5gxfiNbDvb4QpLqQlCaVipFqg34DQ8Dkr9YljGXsTvzTYsgUrjkaPqtgngzCEIFYmbQE6aHBqM5OPmJ4PovC7r0O5XqPoOvNKYtN88rKH4X2DOrTfaKGWf4OK0KNy/HN2dVLVOaiI78qkbXIVHozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164411; c=relaxed/simple;
	bh=9hOjCKXrUFv+Ozf0pSTZBTSsLTGBSeMMtwUaYkJ8T3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBqmxGjl0ecgxinn5jLdW7Y5YLo3F35FqB0tX7k/M8nwM7MCUz0dVX2bItabemVaNK+Fo9SKzfgzfPc9KImnY/3y2+BcIuFs5nmJTeyWJV+LKdeWtKNhpMeb84RjdQ2q69LNG6QbqarkxNFCcvzDYR11l2EGfCMJxm7oWD8vo9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxFPPGUo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0891F00893;
	Sat, 30 May 2026 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164410;
	bh=93G2vq46l0qUQcuOQdty9rvSBOqe3HdRFq0ZrQF4vPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxFPPGUoP9WwNlU2RvjQx6iHYEDwtBK3KUjWozAztrdZ3qh7Ml/tioqwRNb3pO/38
	 6fZALqRKB5CTsMdXfAUw9BFQzFoGaF9gYAF1Nb9codExBlLAQYqNEMpU9M/db635bH
	 Wt3CkCFqyB6cWiisR1TEfFrqEM52vVKhnBKNnkMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 546/776] clk: qoriq: avoid format string warning
Date: Sat, 30 May 2026 18:04:20 +0200
Message-ID: <20260530160254.280902161@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258456-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7480261110D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 096abbb6682ee031a0f5ce9f4c71ead9fa63d31e ]

clang-22 warns about the use of non-variadic format arguments passed into
snprintf():

drivers/clk/clk-qoriq.c:925:39: error: diagnostic behavior may be improved by adding the
      'format(printf, 7, 8)' attribute to the declaration of 'create_mux_common' [-Werror,-Wmissing-format-attribute]
  910 | static struct clk * __init create_mux_common(struct clockgen *cg,
      | __attribute__((format(printf, 7, 8)))
  911 |                                              struct mux_hwclock *hwc,
  912 |                                              const struct clk_ops *ops,
  913 |                                              unsigned long min_rate,
  914 |                                              unsigned long max_rate,
  915 |                                              unsigned long pct80_rate,
  916 |                                              const char *fmt, int idx)
  917 | {
  918 |         struct clk_init_data init = {};
  919 |         struct clk *clk;
  920 |         const struct clockgen_pll_div *div;
  921 |         const char *parent_names[NUM_MUX_PARENTS];
  922 |         char name[32];
  923 |         int i, j;
  924 |
  925 |         snprintf(name, sizeof(name), fmt, idx);
      |                                              ^
drivers/clk/clk-qoriq.c:910:28: note: 'create_mux_common' declared here
  910 | static struct clk * __init create_mux_common(struct clockgen *cg,

Rework this to pass the 'int idx' as a varargs argument, allowing the
format string to be verified at the caller location.

Fixes: 0dfc86b3173f ("clk: qoriq: Move chip-specific knowledge into driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-qoriq.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 5eddb9f0d6bdb..4baec1bf3557f 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -905,13 +905,11 @@ static const struct clockgen_pll_div *get_pll_div(struct clockgen *cg,
 	return &cg->pll[pll].div[div];
 }
 
-static struct clk * __init create_mux_common(struct clockgen *cg,
-					     struct mux_hwclock *hwc,
-					     const struct clk_ops *ops,
-					     unsigned long min_rate,
-					     unsigned long max_rate,
-					     unsigned long pct80_rate,
-					     const char *fmt, int idx)
+static struct clk * __init __printf(7, 8)
+create_mux_common(struct clockgen *cg, struct mux_hwclock *hwc,
+		  const struct clk_ops *ops, unsigned long min_rate,
+		  unsigned long max_rate, unsigned long pct80_rate,
+		  const char *fmt, ...)
 {
 	struct clk_init_data init = {};
 	struct clk *clk;
@@ -919,8 +917,11 @@ static struct clk * __init create_mux_common(struct clockgen *cg,
 	const char *parent_names[NUM_MUX_PARENTS];
 	char name[32];
 	int i, j;
+	va_list args;
 
-	snprintf(name, sizeof(name), fmt, idx);
+	va_start(args, fmt);
+	vsnprintf(name, sizeof(name), fmt, args);
+	va_end(args);
 
 	for (i = 0, j = 0; i < NUM_MUX_PARENTS; i++) {
 		unsigned long rate;
-- 
2.53.0




