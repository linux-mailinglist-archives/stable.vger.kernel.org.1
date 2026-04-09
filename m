Return-Path: <stable+bounces-235373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMIFFQKG12mwPAgAu9opvQ
	(envelope-from <stable+bounces-235373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:57:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B798B3C9546
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC4A302B3B7
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0C63BED30;
	Thu,  9 Apr 2026 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTkQ23nS"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353A3B6C0B
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732179; cv=none; b=p8r2cJUkf5sokC7ewEBQ9FVhJsliwibcMc7TTQLIXn1CoFiwoKoxm05a2jI515HtIZAVGlrXSInYs21c1hTTBC7GooK/hp29n2gRY+V4opaJ5tQav9sHh+hQtORPIexXqBk0TdZczrAyHWVWT+NTP1gVw7el4leSsxEfOoNf5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732179; c=relaxed/simple;
	bh=lHhYUZEteG6CqChaxjtIhI6uj6mYGGHKGTcq5jFslNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MK22aKFCRCmoaw/e5ocgE23NFiyxA4xtm+tA1PpyKjYfHwyDrYSgtmiBLvg10vFX7uNGnGRK2j9weGrmpvSAwPWlBJF7YSUSrGzePuDJRfKsmn7lBZzpva0XH+FHwEJpdVhfCDiverFG2vp7bOnlM5YfmMYqVbrOci2PdA/La8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTkQ23nS; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775732166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RXnQZXBYa3vuKgwomSApzbPI2ilGOJnfCFu3tAYxZYE=;
	b=jTkQ23nSIGAct5EbtU5wkME0Jo50XoaZjEwlRExYqRInSP5Yd7p8AkLyAUK5xLR6A3FxqY
	Kko6YFhj1Zn8GGVbS5M9yh8K84G8GbczwZC/phUvWnrqbD3MIEzbERI7qeK6WVg1uxvjhV
	lyhokgv6Erru55AunByy49Tqi6a+2kU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank van der Linden <fvdl@google.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: fix early boot crash on parameters without '=' separator
Date: Thu,  9 Apr 2026 12:54:40 +0200
Message-ID: <20260409105437.108686-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=thorsten.blum@linux.dev; h=from:subject; bh=2OC4+YvS7JeDbioJ5TEwE9zyKJ+wa0upJUfw7ypAZ/A=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnXW3PrJqhuWL3/6r7vc7iSeKs+XHm+dMOc63csZ5RJm n2wfOFs01HKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATOfid4X+oVwFfyc2fU3im H1itdVKYz+rD9wWPPmUyKE73Fz9yNrWPkWHe6ab5DzPkRH9oq2b47Xpw29stbME+7Slndsxtu/2 Q24gVAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235373-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: B798B3C9546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If hugepages, hugepagesz, or default_hugepagesz are specified on the
kernel command line without the '=' separator, early parameter parsing
passes NULL to hugetlb_add_param(), which dereferences it in strlen()
and can crash the system during early boot.

Reject NULL values in hugetlb_add_param() and return -EINVAL instead.

Fixes: 5b47c02967ab ("mm/hugetlb: convert cmdline parameters from setup to early")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 327eaa4074d3..9fda39132d26 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4252,6 +4252,9 @@ static __init int hugetlb_add_param(char *s, int (*setup)(char *))
 	size_t len;
 	char *p;
 
+	if (!s)
+		return -EINVAL;
+
 	if (hugetlb_param_index >= HUGE_MAX_CMDLINE_ARGS)
 		return -EINVAL;
 

