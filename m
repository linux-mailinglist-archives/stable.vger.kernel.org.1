Return-Path: <stable+bounces-238737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BB1CY4U5mnRrAEAu9opvQ
	(envelope-from <stable+bounces-238737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:57:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9DE42A599
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A28C30269F3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA139E6FF;
	Mon, 20 Apr 2026 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4bAmo7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133F2139C9
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685758; cv=none; b=KPJbmbp3oDmtZgFfLLIqZ85a4Erigyrxs15+urRrzkuPDaLHLg3LLTirxw+UEcLVe0+Y2BvcktbXBpBAvJ9j7stkuSHRsRjghg/ElPFHAT4wTo67I2OlrPwiui3PzLndOrPcRJpvBCGfbNjJ5mKsVYdeM6JGOWWJOcXYG+9alWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685758; c=relaxed/simple;
	bh=FYq3u2vFTIsG4AktCWpYdLj1p5HGz7GybA4JVBaBe8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mev95dgpB+ViCAtKIIKw6GKomg/U377ICcQtWL3w0DM9UQl8f04ZY5vpAxVwTE7YA0a1HoTqtr56UUQ5XOcA612PKc5pn4RkH9EpetkM+C8Ok11By6oApMJryFRSgnr++K35iCvMz0tP9ERJ15PRb9m0YTpYEoU7zLVLw0MOkjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4bAmo7H; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d103e46c3so2091391f8f.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776685755; x=1777290555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qBi9ldbtbrcpWyzJP2C0tv/H5iabsIC81OiRN0uJ2k=;
        b=I4bAmo7HjVMLSr31PHw0wpI9Q56qW7VFFRDZLINtP6VuZZpfArVSUOZeosM6PawckH
         mIf5CrW3UJZXH7L6BwuT0qfGOJCcGt2aOjwjDth2gqN56ECTCvd4GI9CJJHU67NmE0Ph
         ghqIPrzr/+VD9r0VicIkA8OnU5CIHeooQCs0giotz5X8h/BfiXQzV3bUlTO5ZynX9mDv
         PRsoSjp9s6DhsbZPK7yqhWZ+sL7eRv7LHvTUZ30K3PDKItKizB7KV9brerPhMnDyvPzP
         EP9PRZvHf/3HI1M9vfdHwT+PUqg77B/Gmvr9YGeZ/B3kZLuYukB5tU1FBAZ48XMgwrBr
         wTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685755; x=1777290555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qBi9ldbtbrcpWyzJP2C0tv/H5iabsIC81OiRN0uJ2k=;
        b=N96nBnOlZE5+MgQHyvLj+33kH6nj4VW84/VteYu9l3efz34xJ9CUsQVgMI1V6TBnzJ
         qONAW/RF/Ifuurdi4EWvJ0plGmALLJNZuUathi6o8z5YDwfcvZagclSaY5DWCQ7I7vd4
         jXAs6J4Iwt2zxbxnHZug/AK6XtYV5kWXyvNvCjSAK+KAPjPhSfjaU1TCf34rB5SjYJNK
         uYdcU53sy6TJVemEsGry9/Fe4POKImymRbp+5jLSa0eqcXVG/TqH8hG3qjyLe34pvxXg
         FYK+gPwc0/ND4uiA1yCbLuBYbvU4lpXOR6pCVtt1Exzzdm1oHoxYZAXmVVz9KYA4YbsD
         OknQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rvZTE3gtvBFR3Xr7zYLCcRQ6xaWBXsavAL6QMpWG+Go6vi4qBZQCHJeMUd5NxGAQ12rPRMwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bacT1aMktqxG9T3YwNiP3IaK0fQ/Tf860aCkRPAo6akDHJKC
	OL4M+KHrWbSYVpXOMSIqzrTHZWDCKxHjSqozmJe5f27DXXXE9Nb3A4ZaRbfH6fCyXIfjEC2VvcW
	UjA==
X-Received: from wmpv10.prod.google.com ([2002:a05:600c:4d8a:b0:486:fe68:2045])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8901:b0:488:d228:a133
 with SMTP id 5b1f17b1804b1-488fb778d15mr138129125e9.14.1776685754892; Mon, 20
 Apr 2026 04:49:14 -0700 (PDT)
Date: Mon, 20 Apr 2026 13:47:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260420114805.3572606-2-elver@google.com>
Subject: [PATCH] vmalloc: fix buffer overflow in vrealloc_node_align()
From: Marco Elver <elver@google.com>
To: elver@google.com, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Vitaly Wool <vitaly.wool@konsulko.se>, 
	stable@vger.kernel.org, "Harry Yoo (Oracle)" <harry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238737-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC9DE42A599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 4c5d3365882d ("mm/vmalloc: allow to set node and align in
vrealloc") added the ability to force a new allocation if the current
pointer is on the wrong NUMA node, or if an alignment constraint is not
met, even if the user is shrinking the allocation.

On this path (need_realloc), the code allocates a new object of 'size'
bytes and then memcpy()s 'old_size' bytes into it. If the request is to
shrink the object (size < old_size), this results in an out-of-bounds
write on the new buffer.

Fix this by bounding the copy length by the new allocation size.

Fixes: 4c5d3365882d ("mm/vmalloc: allow to set node and align in vrealloc")
Cc: <stable@vger.kernel.org>
Reported-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61caa55a4402..8b1124158f54 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4361,7 +4361,7 @@ void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align
 		return NULL;
 
 	if (p) {
-		memcpy(n, p, old_size);
+		memcpy(n, p, min(size, old_size));
 		vfree(p);
 	}
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

