Return-Path: <stable+bounces-217294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J22Dna7lWntUQIAu9opvQ
	(envelope-from <stable+bounces-217294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:15:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8E61568B3
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C65C301BC33
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8828C84A;
	Wed, 18 Feb 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOEIDHfy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7461F8AC5
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420529; cv=none; b=Ao9Xo3OnkCsszGkh7RZ21YwKeskDNBhBNCiQ1O9rM5lNPzPAXO/S72B+IkTO+og3p6rgUne7KVr1hKHxHr7/9DHGYPYYlTTyQ7sfH8Tjfnnoa+B0FdmbDnxMi5ovfYKza+iQ5l7iLPiVXd/GKFJBxaZxWTv6/+iPA6spAr6YHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420529; c=relaxed/simple;
	bh=qgqQM3BicoLp//iJlSD25LJvavgVBcGFV4txdNSMKCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhiqCOD6aFw+IlbRqe8S/nSXc2NdAxScCkEIkSnVQ1LhY10iR4C0xAQdjS2mua/mVxAHQCnPfrlUwOoW93YEYxDigQ8Ed8UfwUT9x71blTfe385/2nBDgGvaK+QtsPxdSxcczCWbZIHhONLIEHFHcwEpjZkOfoHP+bFeS9AoPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOEIDHfy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so4879635e9.3
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 05:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771420527; x=1772025327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTS3P2DdO9rrBOyQJCIkcrjqmQuomaNDxfVohLWWfaM=;
        b=BOEIDHfyJAnAb+MmVxlF7oKteh+9yF8AAjiUS1L/zSJBVnmSk1IiyJ0VpslIDNDhIU
         /pVVl1/CGkRulDOYA0NU9ijlWhoHDsYXPGEmA3QKKd5dYdBtn1itD8aa34PERtHWIgxL
         cYIgNl5IWS619S5Yu8GK2xH7p4twJW4Q74i/jhNBZSbGCIryeX9RY+kMSPGW5IqajR/c
         oPesqM00beaWkNfyTF+PsfYm6ggWvlesaQ0nyVnwWeLco8nHvs74nMR05kTAICWluVRK
         EyatqpJDwEziafERzM6Z3KmYzCqQF9pGttqzvz1p8P4fDh0sVYq63Js6+hfNa9YCk3s2
         xImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420527; x=1772025327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTS3P2DdO9rrBOyQJCIkcrjqmQuomaNDxfVohLWWfaM=;
        b=IaBzb5UsjSqWDjnCTChWSIQ1XGUsbj0qW9H6VpEZ0DubYNwa+lsdmUIkyCjM+ho/wT
         LJBKEr+iNkzHaekSPe4XBgGfVL7wQNBne1tIp0oe5H/6QcIGgpl9AKZBTR1ijgq4MgJD
         h7PuOUfuaQFX4bsoeRGk319fNLd3NoOYaFc6wrAm0E52vIsA5UGdDolILhhcZf7Zv31n
         r+bB3Ak6otR4wJUBaeoTRLwUXoz5U4iJ0QcKX0cc+PPdcpSRkNl3ZRpniOVJA/cWxyt1
         +LnsHPq2HZ8Z/610PPXaSOQMVuYOTUMywNa0YB5a1Fl8jWgDFX7k3f+61IuZZ0eht8tk
         hqzg==
X-Forwarded-Encrypted: i=1; AJvYcCWhH45mcZ2EYLTUb2MjaidtYL+OpgpdCxZQR3FxlPR7SOIjUU4r57PnHbErGZuMPYb3vpGDG4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxizq3f0XXY93KjnLOqM6Z+oOKa+JI+va5I81MBAWJ1TdhbF+aL
	n5vL1zJfOWbuwxy6T3/ZN9R7R5paEiZu6EeVVt65yJ736BQqHAcHWVca
X-Gm-Gg: AZuq6aIUlPdqx0/AHS2uQnJ19aGz5VaevDgRaEntYNIjjNKmW+RGCW1kkb7qCMNBbxX
	ghKh01P/dbCBClpsKyjTls37XYR0wup6bxTDTZ0czx054lonPAbVRWCbCyD3RxyuUcWvToHpdhg
	khXM5YpNe+q7Q8+1vEJ4ZJOb6uIuz8eYYBdMD4zCTW8x2/1tRDaxxoMbcaVW6jeDPcft+pR4v7n
	8PJvfwZy8CkhCjbDO/jIIn7CvShileuRxO8A5v2TKQkzQzN3PaF8jUWjKeHVjird6wZl82XZYE7
	QIRHOTuAOyGUyNCen9nMFYT9/f7LSHhl7CPcLLXhRsRb8MIEbhh+PDw+Ltohy7Pb1mK24ASyIFO
	FEDwx0/uTQ9zFJKjSjlXJ4gTVEiQdEpwTolX9W0zkkNTwoZ2uLuurzVY3PC7NueR5icRsUe2iC0
	vLF5s3SC56QRPJbE7tDQpTlbuXcn2bxNMOpKrjLVUeq7OscdGlw3PU2QfvaDklJ2/QOW33sVq/e
	UqdJ2bbRqCdWarxq58/YIN52I+K4gk=
X-Received: by 2002:a05:600c:6912:b0:477:aed0:f402 with SMTP id 5b1f17b1804b1-48371067b29mr185755875e9.8.1771420526501;
        Wed, 18 Feb 2026 05:15:26 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-204.paris.inria.fr. [128.93.82.204])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43796acffcesm38768246f8f.37.2026.02.18.05.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:15:26 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Simon Horman <horms@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] wifi: brcmsmac: Fix dma_free_coherent() size
Date: Wed, 18 Feb 2026 14:07:37 +0100
Message-ID: <20260218130741.46566-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217294-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,broadcom.com,intel.com,kernel.org,tuxdriver.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E8E61568B3
X-Rspamd-Action: no action

dma_alloc_consistent() may change the size to align it. The new size is
saved in alloced.

Change the free size to match the allocation size.

Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index c739bf7463b3..13d0d6b68238 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -483,7 +483,7 @@ static void *dma_ringalloc(struct dma_info *di, u32 boundary, uint size,
 	if (((desc_strtaddr + size - 1) & boundary) != (desc_strtaddr
 							& boundary)) {
 		*alignbits = dma_align_sizetobits(size);
-		dma_free_coherent(di->dmadev, size, va, *descpa);
+		dma_free_coherent(di->dmadev, *alloced, va, *descpa);
 		va = dma_alloc_consistent(di, size, *alignbits,
 			alloced, descpa);
 	}
-- 
2.43.0


