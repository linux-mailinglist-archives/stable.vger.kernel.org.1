Return-Path: <stable+bounces-249905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VNv6J7usDWq51QUAu9opvQ
	(envelope-from <stable+bounces-249905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:44:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1D58E0DE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01F5F3009F38
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FA3D811E;
	Wed, 20 May 2026 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJuCyU09"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B593DA5A5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281074; cv=none; b=Vs2I5+okz6HgzbDgDGmtKU14AW7z2WHlxDZVjUXry28YAq4F9UPsSJ+a4PXkgjhOSQa6dwNVqssXQ35TR25EUEQZ+gpiIVzpeOaiWXcknt7NgHW+YjWGSoVOyx4OgtAb/vIQyNSESUbVfJ+757CxAmKXt5T4h2vcU3qi1twrdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281074; c=relaxed/simple;
	bh=thxoksPQ+15g5hS+3SczibJzhdj7OfrhTFsfdTgiklA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVbxdcmgydzmPjAL8/BpaOmDEOhGuWaWJJzkytupqUwHP+S+HXpGyj+7yRdM3/k8ceh7WpeQgoifjHgoMKMSFtC/DfmDUAIFoUpwwhIqct+sRwPhBXGyT97UnTdGpNYQYAghZr0naUU1SrGrvjxLSS22gdUBBfwWr/HrgOXi0Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJuCyU09; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so32060705e9.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281071; x=1779885871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5eLz8Qn47d0khh31ps9ZsK9pvOA5rKAX3QPAASD/ZA=;
        b=JJuCyU09+0cIJBznTa1ERor6YqcU/jATezzLfr1erIFuYbTY4n7xZaerP7nIhQ7xYx
         X5z7OTZuELOvRyddfzQ1cocE40Htwi81xU+QOKRVAfywKCT6apzHn9FkZeEEgbtt1jFg
         l3fr3AXdUl+aoasL7Ax9u7MFhfDf/cKlCs5xsCRHLhIT2j4tKpe3vCm2b7+kqNMiG1nl
         dbQw0eH+biiJlx4uyaL6x+1h0GdEGuZ8LtTTdGKDuneY++YtYjGJa5qW7sHr8Ql76Qoj
         9X1DWJwwzAzQo0OO4v/0vbsOy0L/0s2hQ2CJN+DHDAQeYb2OWlWl6l+RJBgCHvJqelrE
         R7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281071; x=1779885871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5eLz8Qn47d0khh31ps9ZsK9pvOA5rKAX3QPAASD/ZA=;
        b=tEJSYct1ptUFczafI4DXeM1r2Te0Jtohe6bZBpLJd0x+KmAXBIKNFH6ufkMtM5tVEg
         SIZ+iiawOPb6XqItDaLgKIsnjQRQf9/hMVdiND29wkWShTFyhRRkYQC7F63Mn0u9uvXh
         53lK/Nq+VmSnPydnA2XOnbCFq9t+IIvwUvUlwHYf/Jc5QhqphdBLtoJKRKKiMOShFYo1
         nJ/eZkNhlLs8p2Mte3mNzLC4K99fJUr5VHt1BPIhvU1awE8Ywfmvz4Nv5xsMuW/AYqrZ
         iCV/aaZvEduK5Et4YzTPqLZwl74eOxZIuQnS3yv9bN0EMv4GlFY28ofdCQEI6zSF6J9L
         m1/A==
X-Forwarded-Encrypted: i=1; AFNElJ8SnTs65ato2EiP/9mjR/ae4mUHpAYnotn1oZSr3MHO8UctqVFmovgfoZbsQIk9ZaAGr5Ks/ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpaD9IV/DqkH3vkDywbmNQd4IGYr2TL5MyvxUAbM6c7fW4y70z
	vrrLRVoIi10yjbH21XfPo/R3YZuf6EJ5cQ5SCRpojpADlY+nCiqarUpW
X-Gm-Gg: Acq92OF8kZHlAfY+83yWAdFLsN9PIhL+6IZpCvfwuYaF5HILogmHDtRphY4gT2FxOKA
	n4TWFJ6Wn/wdSdiECcJMDaUJr5nX63CgDLW9Y/Qzsf8OGodULYaa/wQBNnl8iEG5hPJ3H9zlgEi
	FzBdRb0Umwqsye3cNrFtVkrJLvWnrozcCQux9JWA0pQZDriaBcYjvPk6g5sGuXZ/7O/CszdoLvj
	xqEehvrQBK0Wjc2O2ZB3vwJFFbLfc7A/bZSJI6YxtVKZC0rh/Xn+7zH+IjBHOKKOekeDKxOFEy3
	wecgR3CFmjK/9DOMY/wZ37YCHwwP+wDSvm99FiSy/EHMZo0O+zFWSuVd17vKsu6d/v6z3/ZELF0
	GoWl5nubqYjHaJGlZGwparuxOrT5H7xTkRziU3lKzASlNwFNfap+FdFd5L+zRJvzZ8AiHMHCwDC
	i+jYaVU4fbU8MysCSF9ea5e4Q2qDSHMlEaeaXf
X-Received: by 2002:a05:600c:1709:b0:490:327a:1b47 with SMTP id 5b1f17b1804b1-490327a1b5dmr7754165e9.8.1779281070939;
        Wed, 20 May 2026 05:44:30 -0700 (PDT)
Received: from localhost.localdomain ([31.4.38.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm387739955e9.4.2026.05.20.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:44:30 -0700 (PDT)
From: Justin Iurman <justin.iurman@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	justin.iurman@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: ioam: refresh hdr pointer before ioam6_event()
Date: Wed, 20 May 2026 14:42:42 +0200
Message-Id: <20260520124242.32320-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249905-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4AA1D58E0DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reported by Sashiko:

In ipv6_hop_ioam(), the hdr pointer is initialized to point into the
skb's linear data buffer. Later, the code calls skb_ensure_writable(),
which might reallocate the buffer:

	if (skb_ensure_writable(skb, optoff + 2 + hdr->opt_len))
		goto drop;

	/* Trace pointer may have changed */
	trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
					   + optoff + sizeof(*hdr));

	ioam6_fill_trace_data(skb, ns, trace, true);

	ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
		    GFP_ATOMIC, (void *)trace, hdr->opt_len - 2);

If the skb is cloned or lacks sufficient linear headroom,
skb_ensure_writable() will invoke pskb_expand_head(), which reallocates
the skb's data buffer and frees the old one, invalidating pointers to
it. While the code recalculates the trace pointer immediately after the
call to skb_ensure_writable(), it fails to recalculate the hdr pointer.

This patch fixes the above by recalculating the hdr pointer before
passing hdr->opt_len to ioam6_event(), so that we avoid any UaF.

Fixes: f655c78d6225 ("net: exthdrs: ioam6: send trace event")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 47c5502a34a2..2f991c974395 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -967,8 +967,8 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 			goto drop;
 
 		/* Trace pointer may have changed */
-		trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
-						   + optoff + sizeof(*hdr));
+		hdr = (struct ioam6_hdr *)(skb_network_header(skb) + optoff);
+		trace = (struct ioam6_trace_hdr *)((u8 *)hdr + sizeof(*hdr));
 
 		ioam6_fill_trace_data(skb, ns, trace, true);
 
-- 
2.34.1


