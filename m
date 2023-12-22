Return-Path: <stable+bounces-8286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38281C2BE
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 02:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A641F23368
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B527A23;
	Fri, 22 Dec 2023 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hatguy.io header.i=@hatguy.io header.b="FAqbJl2J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Nnl1xuTu";
	dkim=pass (2048-bit key) header.d=hatguy.io header.i=@hatguy.io header.b="UYX71NuD"
X-Original-To: stable@vger.kernel.org
Received: from a3i634.smtp2go.com (a3i634.smtp2go.com [203.31.38.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536D4422
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hatguy.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em868002.hatguy.io
Received: from [10.149.244.204] (helo=hatguy.io)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96.1-S2G)
	(envelope-from <a2brenna@hatguy.io>)
	id 1rGUOr-04o5eV-1U
	for stable@vger.kernel.org;
	Fri, 22 Dec 2023 01:32:29 +0000
Received: by hatguy.io (Postfix, from userid 1000)
	id 2473560C54; Thu, 21 Dec 2023 20:32:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hatguy.io; s=201907;
	t=1703208749; bh=17Ta881lFppcobE23U09uxazlgMPpfhAXimDdMYaFWM=;
	h=Date:From:To:Subject:From;
	b=FAqbJl2JIhmGQpq5FaV6vkUOcMkZnpK67B9PUAo6Lc2wimT1bEv4yhjhq9q4a8eqt
	 sx1T1PcBsUk7IlojbNkyAl1NpsTL0CIfyEKocKflUyahY2EGjbm/JrEiAcaUX1240u
	 7FQ/+lwsMTxyr0ERI7OXdzYl4/CpdlPsahhs6MZlGxxGC8gVW6Ij5MYq8UlsHCrAbh
	 s43nw7HRyUE99PSiKLK0JTR0Qob3vDt/OGKjnlvm7qfCH98WzgssrjbfVuJeh+NXOV
	 tPPlaPZe57JdJsJLwLXpbGSxdP5KyVqDzD+gN+va8FnxUozLu66omlp/iNJ9AIV4xL
	 BVLCNmBx9GFOQ==
Date: Thu, 21 Dec 2023 20:32:29 -0500
From: Anthony Brennan <a2brenna@hatguy.io>
To: stable@vger.kernel.org
Subject: [PATCH v2] netfs: Fix missing xas_retry() calls in xarray iteration
Message-ID: <20231222013229.GA1202@hatguy.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-smtpcorp-track: 1rGlOr04o5-V1l.hjcsidXeqHI0Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1703208751; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=jn2owgDB5JWp+yRPPciqyggblTvznSWOdVHvaCuhovU=;
 b=Nnl1xuTuQ8MGp3cBi06PWqGE+MOSOATlNdiV6SQOXb6xsY2ooOvQrseFSL1VprJTSmL30
 qajmu7ZhoGM0dLlZ84JcDSbgCZmaY/Q2jr7i7v06NeeTYfp8et9Ig84NNUVvoaQPv+mkIBI
 lD7wHQRtLJeEfouzFO/5sB051bwx0SuJl4LFbaD8xv4wC1kY451h7lMitim6X/+y2iDvNf7
 kbINlugKd+ywVOhxTgR1PEgWlZUd+cYixAbdj454pk4r4hrZrFE82MZrT69vlN+ctFBgcCo
 s9YN+4bmeZf7MWMYO6aF4+xeYmfDLIOTASgua3j3bIU7QlDvzlePZIsYNyhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hatguy.io;
 i=@hatguy.io; q=dns/txt; s=s868002; t=1703208751; h=from : subject :
 to : message-id : date;
 bh=jn2owgDB5JWp+yRPPciqyggblTvznSWOdVHvaCuhovU=;
 b=UYX71NuDFVjuwPoT3hk9BUjqHgFVkTTURb8TA4mhSLzP3/Sx21sFe890u9b01qNRqmCSk
 ix6A/w1erGxzTcF7IWGTT8GyJpSTO9pQvzpDfJT3xCTe0ybQ2gBMjtvWMz1tchIf6wt2a3S
 ouOaPIEZSluBN2trqfqWFw1YkVo3aeolts6AonIm7E6+f1ZcLQDRoCvmHgp2Zw/cBdVU/P+
 dFbv4nqFvOx7+ugEI1x7oux9TjWhkdXqs/k7uC+6WB3iaTczZWuaChi9oyqySP92bpe3l0K
 j1ULHFqRyzy44AXiiqn5vuF0e9hqptrneDYGRHsQEXf9XAsAM8ygkB+V+gOA==

To be applied to linux-5.15.y.

commit 59d0d52c30d4991ac4b329f049cc37118e00f5b0 upstream

Stops kernel from crashing when encountering an XAS retry entry. Patch
modified from upstream to work with pages instead of folios. Also omits
fixes to "dodgy maths" as unrelated to fixing the crash.

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

