Return-Path: <stable+bounces-27593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30587A8F2
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8136286D83
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33C4437C;
	Wed, 13 Mar 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="PQLA1zVL"
X-Original-To: stable@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98139AC3
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338574; cv=none; b=GyTI7F783rbeh8yqn9/RXkkO0jxO56VAZmofE7QTYUmMuYCgrmTARFvEE8dqveAaId1LvDx/fG8SgVEFEfFFWiUvuBJ0oRBzEMI2uh0gIGMCM6cdlmQ6XHnAf37hj9iVW7fnybgi704xXy5kSE065xNLkaPgFdb/WUU2clmNCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338574; c=relaxed/simple;
	bh=AX7xmkO30QA98nigOmzlZWAfs+apei7HSsoFjSpZWZo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j4/qVnIN0Peso0eWbdyFBD7Q9grzHSe6q6/DPOb+QONx4QpyW+bdrD1WCH+Qtt9uXBPJtOv0KjSopTRpBKgSS9iJR+4ETy5TksMZLzddWzCWY46yMh/OowW8Ci6rhONmgRB063he0/tx4AdtG/vVQozdhbaoKrfrW+53Q3AQECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=PQLA1zVL; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
X-ASG-Debug-ID: 1710338543-1cf4391a1cd52b0001-OJig3u
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id 5Ejmn0ZAPZlUvRxC for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:02:45 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=5ilevwRMTps9hdgnJbjN5uNvkki7F+RF5YHPE/SgtyE=;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:To:Content-Language:
	MIME-Version:Date:Message-ID; b=PQLA1zVLTBUxUxvixYd+S3cwFPMfISrUmwGHBXGEw4Cyw
	RGUD92V/x6F/iyt50C1NQSscEDIExlaAugFF3Fjzs0t2R7hSLNwrzD2kb8UrCbMTDJa1HQ/YzOuVq
	ehAuGTtCVnrDhlQtfjLS7So5c1QNYswB+UWQQ1zYN4jJo1Ti0=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 13125185 for stable@vger.kernel.org; Wed, 13 Mar 2024 10:02:23 -0400
Message-ID: <a764cc80-5b7c-4186-a66d-5957de5beee4@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Wed, 13 Mar 2024 10:02:23 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>
From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Content-Type: text/plain; charset=UTF-8
X-ASG-Orig-Subj: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1710338565
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1876
X-Barracuda-BRTS-Status: 1

commit 38b43539d64b2fa020b3b9a752a986769f87f7a6 upstream.

Fix an incorrect number of pages being released for buffers that do not
start at the beginning of a page.

  [ Tony: backport to v6.1 by replacing bio_release_page() loop with
    folio_put_refs() as commits fd363244e883 and e4cc64657bec are not
    present. ]

Fixes: 1b151e2435fc ("block: Remove special-casing of compound pages")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Tested-by: Greg Edwards <gedwards@ddn.com>
Link: https://lore.kernel.org/r/86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

This is the backport for 6.1.

The upstream patch should apply cleanly to 6.6, 6.7, and 6.8.

This patch does not need to be backported to 5.15, 5.10, 5.4, or 4.19,
since the backport of 1b151e2435fc to those kernels did not include
the bug fixed by this patch.

 block/bio.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 74c2818c7ec9..3318e0022fdf 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1112,19 +1112,16 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		struct page *page;
-		size_t done = 0;
+		size_t nr_pages;
 
 		if (mark_dirty) {
 			folio_lock(fi.folio);
 			folio_mark_dirty(fi.folio);
 			folio_unlock(fi.folio);
 		}
-		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
-		do {
-			folio_put(fi.folio);
-			done += PAGE_SIZE;
-		} while (done < fi.length);
+		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
+			   fi.offset / PAGE_SIZE + 1;
+		folio_put_refs(fi.folio, nr_pages);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);

base-commit: 61adba85cc40287232a539e607164f273260e0fe
-- 
2.25.1


