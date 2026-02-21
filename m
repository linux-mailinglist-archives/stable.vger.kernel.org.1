Return-Path: <stable+bounces-217636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAwqKy3LmWkXWwMAu9opvQ
	(envelope-from <stable+bounces-217636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 16:11:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1852816D207
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 16:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C6B301CCCB
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09E20299B;
	Sat, 21 Feb 2026 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw+i1+24"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B138FA3
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686683; cv=none; b=Ot4AD2gSmTEs0ts8PmnHmDUdADEIhN9v6el+LWrSjYJ4O7yIkgWE2QXllR4YWxqJAun6l04rcN2mXTL78CXutqQg8pIQVZ+ePJrmcvO/iD8U/9J10Yx2a8E7GK2skuhVoR5Bxn4RB1z7MgSx4QaAPLtLItrQJEVCDa1UCtNbtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686683; c=relaxed/simple;
	bh=31YwMowNkuM4idkQhWbY+/kiCcVdVFVM42qTq+Hc+Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1sosIAkc5EaPMSRyp/A0y+JcM6wyzaMo0fneGdG+ETMFZGiz+mlxjQQpZSEb7uJCiGTK+8dMZleMxYXbg2m+/tUDjFlT/MmfffoADO3C5iGTE8t6tQb2PkHO65BeCkPT9CawxzGEk1R8sTbM7LTz0AEcyEFHM4dleXjhipD6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw+i1+24; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so27063275ad.2
        for <stable@vger.kernel.org>; Sat, 21 Feb 2026 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686680; x=1772291480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ1v4uZYYfrFz53g2OEyCTHVBc4Ni9iWSFPy2XJU9Bc=;
        b=Xw+i1+24a7ShCNdUHTu3QJ6UUyUHuTHUrHuO+kNehuHppUQBNb+uSzQOl7w6Lwtn5p
         w4B8kzrBuYt7oCq4itdLHvYTdFPlh68tcTNqidcJtBC/bAB5x9umqtv1HILIe+wjAv9o
         /9YpP+PGMSNDg/qfE00m1FUVCYvqBjzxVcAuLtGtlHdO/lmM6ibgZL0XaUagS+SQzgYv
         VlX2wB11hgTFVgmhBl+tOHqCJ30BudirxCUNVJS7MMIbOOqRdJk4zAe704WkiCWP6OPi
         HJPgssQb2qVtlZhirZCPmoEUXTJ/CbgILsheUKTGVra9PCT9WTF8oE58AbcBZzPzznuj
         qp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686680; x=1772291480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ1v4uZYYfrFz53g2OEyCTHVBc4Ni9iWSFPy2XJU9Bc=;
        b=EWGTN7BCfqgaCT8pSf1oUoPWSTeBe+09PeaBWOjtIgXBBj8JEpU4MjvAfCO6aABroK
         LcRi2h3M/1nmWQdDFzZm+lj/x09w71uXgN6NIjTX7VeU1kWazWwg1S4ASexpz8J4+wqK
         qLbe6mu4UaICkZLwB2mSkvG01ILELSPGV6cR0FwDxoBdNeEZRXxNI2H408R6fi7+nMTf
         MsUm4JPPyVj6ntt5EUSli0Xj7sqBcKdEnf/D5Gkz3YRHgNQucUptLpR6VEiM6iYJbAHn
         uJV86jVy7LVj2rSD+//aPkXi6wWMwmW5k1tPCuqSA8R6exCo9jGqIJi0qQGBqXtevf9Z
         QD7w==
X-Forwarded-Encrypted: i=1; AJvYcCXUH1ojx93SG180KiCKPklZzLAmhU+OXD/HFDeyHnZuMXZap9WjUAZGAY6bw/lTlgMpkpXSWFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVbsUhsYc7pEljqbAnLGnd5QcVDb1h9D3R4wP2Vic7Eh8R/NY
	JD4ClRlu9pUTdyLNMMOlrB/4eQ1UMYRjw7dndjrs++WVopoZ4eV4H7RS
X-Gm-Gg: AZuq6aLmeaUOCruq7JkbrA5ef4wEkadIBkr4RIK23QFpME7Rz+4E+IWefY+xx2Uq/cu
	IZWimYn90WJyyVftFh9NF5Bc7rsga2imzLCAMqGaEodnuWZoK11R0XhI9E75PNz9ZIR+zD0izID
	rLnKFY55iKnFoZpMtlNaFN3mNSIa+Kh98ipETSTC/N6ypZUWvbMuODhCu4gyv6F44uMFYCfX0dA
	yKyBrU91U4U8zZeYzmHzOMhTlqm3YeqLwvL27kSuBJf28wZX39o576qgCGZkMJrIyOBeDB9yZuo
	pXmWUsWkM5xNHq24y1u/hxIzsukM0vcgk157u/t8QIura4bLG2oGtyod5TJ5B4oEHEqsI8A3aAn
	8W8upIEqPEtNhLQN0PHmSDFITEgsRjbfJ1V5QTLFWl8H6UsGy2JqOW6Bno5lNErqNmT9qYoJPfZ
	nPPI5yceFlkzaXkhsv8A8=
X-Received: by 2002:a17:902:d50b:b0:2aa:fad8:7474 with SMTP id d9443c01a7336-2ad744ec585mr29723225ad.33.1771686679877;
        Sat, 21 Feb 2026 07:11:19 -0800 (PST)
Received: from lmao.. ([2405:201:2c:5868:cba9:7936:c19a:9313])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e346sm34517345ad.49.2026.02.21.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:11:19 -0800 (PST)
From: Manas <ghandatmanas@gmail.com>
To: davem@davemloft.net,
	herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Manas <ghandatmanas@gmail.com>,
	Rakshit Awasthi <rakshitawasthi17@gmail.com>
Subject: [PATCH] Crypto : Fix Null deref in scatterwalk_pagedone
Date: Sat, 21 Feb 2026 20:40:41 +0530
Message-ID: <20260221151041.65141-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-217636-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghandatmanas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1852816D207
X-Rspamd-Action: no action

`sg_next` can return NULL which causes NULL deref in
`scatterwalk_start`

Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Signed-off-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
---
 include/crypto/scatterwalk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 32fc4473175b..abbb67391710 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -78,7 +78,8 @@ static inline void scatterwalk_pagedone(struct scatter_walk *walk, int out,
 		page = sg_page(walk->sg) + ((walk->offset - 1) >> PAGE_SHIFT);
 		flush_dcache_page(page);
 	}
-
+	if (sg_next(walk->sg) == NULL)
+		return;
 	if (more && walk->offset >= walk->sg->offset + walk->sg->length)
 		scatterwalk_start(walk, sg_next(walk->sg));
 }
-- 
2.43.0


