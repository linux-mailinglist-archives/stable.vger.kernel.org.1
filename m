Return-Path: <stable+bounces-8278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0803D81C23C
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 01:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5221F25A93
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE04199;
	Fri, 22 Dec 2023 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hatguy.io header.i=@hatguy.io header.b="qdxhOv/M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Wq41iKuy";
	dkim=pass (2048-bit key) header.d=hatguy.io header.i=@hatguy.io header.b="llRIkYwq"
X-Original-To: stable@vger.kernel.org
Received: from a3i634.smtp2go.com (a3i634.smtp2go.com [203.31.38.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B819C
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hatguy.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em868002.hatguy.io
Received: from [10.149.244.204] (helo=hatguy.io)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96.1-S2G)
	(envelope-from <a2brenna@hatguy.io>)
	id 1rGTCG-ynliMF-0R
	for stable@vger.kernel.org;
	Fri, 22 Dec 2023 00:15:24 +0000
Received: by hatguy.io (Postfix, from userid 1000)
	id 8329B60C54; Thu, 21 Dec 2023 19:15:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hatguy.io; s=201907;
	t=1703204122; bh=q50PPnyO6KUJypvqIvmW7eL4xLpcJG10thR/G3ZNeFM=;
	h=Date:From:To:Subject:From;
	b=qdxhOv/MNhEZ+DLW+bg+CfvmANpbqly1yz5vfN4Ba5XHGlHg46eQyxm4iiS9JWpjh
	 ihIZnEVCTiofv/KYnYtr9Ttl3HJ+0JznAoLLoyRPscDHOhmetvR6qtx1C5VJ2itXjY
	 xnA1AoQQlYSCxhyXfExGWR8X7kNsm/1Od/u/wkSqqELVb0pOblvFe74ydy32cmEYKw
	 7XEEObXVMYhnlb3EQQoMswIP5dlpuXGVNKgVnmHT5Izpp5Cn2iN5yob/2uXAEmN1TK
	 nulHAtjoqpvEEu9oQFaO8icCFYL6xACaNiSeuRwfLX1bRHvG8Z7HPVOQ1WKemP5uDz
	 3KvZ8oXQQq6JQ==
Date: Thu, 21 Dec 2023 19:15:22 -0500
From: Anthony Brennan <a2brenna@hatguy.io>
To: stable@vger.kernel.org
Subject: [PATCH] netfs: Fix missing xas_retry() calls in xarray iteration
Message-ID: <20231222001522.GA32730@hatguy.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-smtpcorp-track: 1rGTCGyn_iuF0R.hDldi-IAxCu4y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1703204125; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=Xtf6nJlGTm0FnOMrsbqM21LZZSdN2RESSZQGO3Dj8rk=;
 b=Wq41iKuy6C4IO+0faMv6TMzw5gM8/9sCzeR7r++jsSpH2taujQiO62054Ry0fGEdLdDhF
 4Fzhgl5vrE20dGqXrK1Xb8U91ladhlvQ6FsLMdQf0l6doz7xFy/agu9oHUv4m/4povf4VaP
 EsAwQ24J+rHqBidmk3TBmJFeKo/sp1AoMs2xzVldr38f+SQgOnOr7BApLvXdfGmzM7uzrp9
 5LeFaydubgoD0UdetUiPEHhuKRkfCCZhK8Z1LxZ/Lwx8fxStYVEHIrSvKISRLEYlC2k6MQs
 uuurQTn8cNcuZ3nv3ZBdSdLr3zbr409eKguoF0KG/hkAoXUjdnpNg4V6nYnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hatguy.io;
 i=@hatguy.io; q=dns/txt; s=s868002; t=1703204125; h=from : subject :
 to : message-id : date;
 bh=Xtf6nJlGTm0FnOMrsbqM21LZZSdN2RESSZQGO3Dj8rk=;
 b=llRIkYwqQbIGsHentsbQzfo53Cip+7U4dQHyhBTo2V/0ppV0V2f4lQpoZ9ib2ut4n8tn2
 dsY7T7t991eXc+sLA/0ltrs0565b9XgRv+knLlWalXIhd7l/MjU2jab72z7TWFW1cPxGF4B
 sI8ENVgEds4NDD7xQYis342gySWNOpIbXvBHYEU0PJckVf6tgAy3ScRgD1wX8onxifJcly5
 FoKCPZ98n/+P2VK2za9EY/ZujPdury9x/cLt5WQOZXcY2rR2FfvzLTawoAVPpHsAribfIYE
 sz9yY5ZmcAgdyAxrvv/Q4DRB0hdU0Gj77FS4iqnp1a2CrJq+eS9XKTbptgxQ==

commit 59d0d52c30d4991ac4b329f049cc37118e00f5b0 upstream

Stops kernel from crashing when encountering an XAS retry entry. Patch modified
from upstream to work with pages instead of folios, and omits fixes to "dodgy
maths" as unrelated to fixing the crash.

Signed-off-by: Anthony Brennan <a2brenna@hatguy.io>
---
 fs/netfs/read_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 242f8bcb34a4..4de15555bceb 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -248,6 +248,9 @@ static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq,
 		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
 
 		xas_for_each(&xas, page, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
+			if(xas_retry(&xas, page))
+				continue;
+
 			/* We might have multiple writes from the same huge
 			 * page, but we mustn't unlock a page more than once.
 			 */
@@ -403,6 +406,9 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 		unsigned int pgend = pgpos + thp_size(page);
 		bool pg_failed = false;
 
+		if(xas_retry(&xas, page))
+			continue;
+
 		for (;;) {
 			if (!subreq) {
 				pg_failed = true;
-- 
2.30.2

