Return-Path: <stable+bounces-262898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NuQxMrzQK2pCFgQAu9opvQ
	(envelope-from <stable+bounces-262898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:26:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9C6783CB
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=Jc+RMvIW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262898-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262898-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63CB23170AFF
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2334252C;
	Fri, 12 Jun 2026 09:25:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30435AC2F;
	Fri, 12 Jun 2026 09:25:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256336; cv=none; b=EuoPc9rPT614HeQ4Vy7sXfbQK9AgvdBWy9OKF36ZrZ5n6FnDNADygxVv+oPAQ1E85jwJabhaR+vAmzBjl63s0Y9E67iIf3HIRcn7ZoUZkr17QOs8y14SUbpI+Q+UlkcOTQfBrpZvmUeUmtBTi91b7gSG7lD5/NkRsUtSQUkmDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256336; c=relaxed/simple;
	bh=apO9j1tTvUkrPnNr+WYDF0+/fx0zX+1VmcJwSSBmOEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhkpOjpiAvG+wd4UrmyXU2yqajBopDdl4MLafSnthsS2QGVGYT+kpbM4grWeWbIKqeOiz9j0ZayNn5hMZWpqt5VdSyDBdzbHEy2EoDQATIp95Yx06c6HPC9QPEgK3MFweShIGHyyxPwax/mLmzqyurrFdan7QsNjOTKB4bhAn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jc+RMvIW; arc=none smtp.client-ip=115.124.30.112
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781256327; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H7NlujdXN8k/6W15pMd399ufm9d8I1OLQ+JNiHTnqlY=;
	b=Jc+RMvIWUpsrdvErRZ4C00i7fpBJkyrbD/0B9cHG+475jHEU/8ZRAIa8mPweDb9ckzJjfduhq7zx586mrpGGQPTkc7g99oELoIwkhBt58Q4ngxJo7ogJ9cyJ0Vy+9nWTd9qjTtXAUlxfQB8YWfMB18mipD/dCnIvFmSd72Cpp60=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4iFGNT_1781256326;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X4iFGNT_1781256326 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Jun 2026 17:25:27 +0800
From: ZongYao.Chen@linux.alibaba.com
To: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Michael Roth <michael.roth@amd.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: ccp: Fix SNP range list bounds check
Date: Fri, 12 Jun 2026 17:25:25 +0800
Message-ID: <20260612092525.1203150-1-ZongYao.Chen@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:ashish.kalra@amd.com,m:thomas.lendacky@amd.com,m:john.allen@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:michael.roth@amd.com,m:jarkko@kernel.org,m:bp@alien8.de,m:brijesh.singh@amd.com,m:tianjia.zhang@linux.alibaba.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ZongYao.Chen@linux.alibaba.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[ZongYao.Chen@linux.alibaba.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262898-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ZongYao.Chen@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B9C6783CB

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

snp_filter_reserved_mem_regions() checks the range list size before
adding a new entry. If the page-sized SNP_INIT_EX buffer is already
full, the next matching resource can still write one entry past the end
of the buffer.

Check that there is room for the next entry before appending it, and
compute the next entry pointer only after the bounds check.

Fixes: 1ca5614b84ee ("crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP")
Cc: stable@vger.kernel.org
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
---
 drivers/crypto/ccp/sev-dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d1e9e0ac63b6..9e6efb3ec175 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1324,17 +1324,19 @@ static int snp_get_platform_data(struct sev_device *sev, int *error)
 static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
 {
 	struct sev_data_range_list *range_list = arg;
-	struct sev_data_range *range = &range_list->ranges[range_list->num_elements];
+	struct sev_data_range *range;
 	size_t size;
 
 	/*
 	 * Ensure the list of HV_FIXED pages that will be passed to firmware
 	 * do not exceed the page-sized argument buffer.
 	 */
-	if ((range_list->num_elements * sizeof(struct sev_data_range) +
+	if (((range_list->num_elements + 1) * sizeof(struct sev_data_range) +
 	     sizeof(struct sev_data_range_list)) > PAGE_SIZE)
 		return -E2BIG;
 
+	range = &range_list->ranges[range_list->num_elements];
+
 	switch (rs->desc) {
 	case E820_TYPE_RESERVED:
 	case E820_TYPE_PMEM:
-- 
2.47.3


