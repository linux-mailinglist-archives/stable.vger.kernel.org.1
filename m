Return-Path: <stable+bounces-267449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /9iSIvCrNWrR2wYAu9opvQ
	(envelope-from <stable+bounces-267449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:52:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1D76A7B97
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:51:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h1OovN4s;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267449-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267449-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15467300FCAE
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79643C10A4;
	Fri, 19 Jun 2026 20:51:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC433D4E4;
	Fri, 19 Jun 2026 20:51:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902312; cv=none; b=ZHgBtc4wqKKVU/KkQAuWDIoRRYHYUeoao3s8m9UtT/PWhGzNb1enV5NC7EQwPZJInaTzUz63aizNInSpuW9wGfPRCTMYJZmmcgg+u4caAXVGxlYqSXlnUr/yvvSDBo6BKvBtnfkywHfHVUqXCyFu8BHbrhV8+Iqs6WDHZ69EwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902312; c=relaxed/simple;
	bh=Gyz/K4csJI0UfKAbXzLIi3BIMnhcQOycKEtnC+z4rFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXYakCG7tzGIfVSbAWCM9b+TWA6RMm5Jqt2XLxOvu55ZjisnNTI8rvx5uFVDMFCh4JBgZukHrKvBwwdAhPvq6DrDQi2xrVZoM4weyNXDVfaIJxQSPutFfVwnIdR4BHgL2IGFAKs5+Y7/aO3wIHFeAjSYSGmao21zWBs7O4XRR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1OovN4s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5F21F000E9;
	Fri, 19 Jun 2026 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781902311;
	bh=4iq0ijo90COF3Rq3DtHD6rw3T7Yg//ZMNQpyM055t7Q=;
	h=From:To:Cc:Subject:Date;
	b=h1OovN4sxY+yovVJ4XlVy27s5+y10ZuVfIBbIbydeh9OnbDkr+eYx8cPyiR3q5j+C
	 GVikjWO2PHiS906CfWT4guAhMyn/S4moYzQKGLfmTi6xVj1/A7GbnYzzbg+3mLhdb7
	 R5Mp19yxBUCqaVpJPHTSBu+NO5PAJL2rrnib2acSYL7hO/NAvOOCToKF0lpH9LHf7W
	 dVz9nlgef0HbkOQ8I1Y+oFjCMkMX+XRUwOqi5tzPYnEZymQ0hHWxQn3ZbEnK3ii3qe
	 WqBbKxqdMrTHl8ChLcJ3yNEwNgrU6YxNdB275kEGLFGBJ6pZUbno+1gHg837V3574V
	 OzZUHgQM0SYsQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon: handle zero sampling interval in damon_max_nr_accesses()
Date: Fri, 19 Jun 2026 13:51:43 -0700
Message-ID: <20260619205144.150664-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267449-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E1D76A7B97

damon_max_nr_accesses() causes divide-by-zero if sampling interval is
zero.  Fix it by handling the case.

The issue was dicovered [1] by Sashiko.

[1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 64d75c78f4df4..b6fbe6089abc6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1066,8 +1066,10 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
+	unsigned long sample_interval = attrs->sample_interval ? : 1;
+
 	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
+	return min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
 }
 

base-commit: 7a58ae62cdf3c006a53b805bbb12079ab2621a07
-- 
2.47.3

