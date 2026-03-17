Return-Path: <stable+bounces-226102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN6jNjV0uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:33:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3D2AD193
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96AA330091ED
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8AA3BBA1A;
	Tue, 17 Mar 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpsxTZdj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D33EBF0B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761092; cv=none; b=nDV8Nr8WgtcLD04fiUsCaCMqxpDCk92nswRSMy+xpxp8UGUH2L2xEM3DSqpe0ac9k0cENTvvO+nzRokUvyA6WQFqbwS4c0doCwsdROTFYxy8k0UI75uw2mY90oZMs15tvnRBwk3OUUzBWJg+uyaz/7nA+kKkHIgcvU7wl86H4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761092; c=relaxed/simple;
	bh=bQzYP+oL7tT/zm7O3THYq/kPW2zfeInrxgDU6BfX1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfzWnYriuHxOEtaS558n35VPX7Vn+0QQIboAyubYhfxQdKlyoF/c0gf9a1cBPckIj7ud51lfKgbO3fyTZuxiZ/+UvJo9xTsWLtg2Y28tnEo0oBxUVsasNnnRqczC6bK1x8IYrcvdsSM+JZXisuNz2S2XQai5tRSV83u3pt4ooNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpsxTZdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF6DC4CEF7;
	Tue, 17 Mar 2026 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773761092;
	bh=bQzYP+oL7tT/zm7O3THYq/kPW2zfeInrxgDU6BfX1Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpsxTZdjkRiMixfxI+6yzwvd0u3KJxfOEZiQHqRExyLDXTaqnUEb4SUwJRouW4h8r
	 g2zqy6DdOhEec681i6FKXHPG0IdOF0yrZM0Az5vu53cYZnAIMPg7JNGpIu2gB2g0jz
	 kjIWk6eSJN1SeubIC2oxFKQcwFrDmopbWTtUym/xRQ6w0tBlpdJZjQ+ZKFQ1Au/x4P
	 8ZhS5xcdkaq3KkCkwFlLq28zNhFqQAvCy5XUJzrfeexYfBPph4KShqeT94GasziEqW
	 g2OugtrKmn3jQJ9MjehvIae2U8Rng1Ui3yxQBm9UEX/ZjHU6ZkFI/4QROpahDwuCF3
	 Bv4qtFLdpogPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/damon/core: disallow non-power of two min_region_sz
Date: Tue, 17 Mar 2026 11:24:50 -0400
Message-ID: <20260317152450.191424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031715-scrutiny-refurbish-a751@gregkh>
References: <2026031715-scrutiny-refurbish-a751@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226102-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: E7B3D2AD193
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: SeongJae Park <sj@kernel.org>

[ Upstream commit c80f46ac228b48403866d65391ad09bdf0e8562a ]

DAMON core uses min_region_sz parameter value as the DAMON region
alignment.  The alignment is made using ALIGN() and ALIGN_DOWN(), which
support only the power of two alignments.  But DAMON core API callers can
set min_region_sz to an arbitrary number.  Users can also set it
indirectly, using addr_unit.

When the alignment is not properly set, DAMON behavior becomes difficult
to expect and understand, makes it effectively broken.  It doesn't cause a
kernel crash-like significant issue, though.

Fix the issue by disallowing min_region_sz input that is not a power of
two.  Add the check to damon_commit_ctx(), as all DAMON API callers who
set min_region_sz uses the function.

This can be a sort of behavioral change, but it does not break users, for
the following reasons.  As the symptom is making DAMON effectively broken,
it is not reasonable to believe there are real use cases of non-power of
two min_region_sz.  There is no known use case or issue reports from the
setup, either.

In future, if we find real use cases of non-power of two alignments and we
can support it with low enough overhead, we can consider moving the
restriction.  But, for now, simply disallowing the corner case should be
good enough as a hot fix.

Link: https://lkml.kernel.org/r/20260214214124.87689-1-sj@kernel.org
Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>
Cc: <stable@vger.kernel.org>	[6.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ min_region_sz => min_sz_region ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b787cdb07cb25..7cb09d4453ceb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1236,6 +1236,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
 
+	if (!is_power_of_2(src->min_sz_region))
+		return -EINVAL;
+
 	err = damon_commit_schemes(dst, src);
 	if (err)
 		return err;
-- 
2.51.0


