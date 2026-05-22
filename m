Return-Path: <stable+bounces-253806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGMjJB5uEGqgXAYAu9opvQ
	(envelope-from <stable+bounces-253806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:54:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8905C5B687A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C2E9319737C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6AF472767;
	Fri, 22 May 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNdA2MDi"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A421407CEC
	for <stable@vger.kernel.org>; Fri, 22 May 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459929; cv=none; b=CnnbtVYCbHRbjYX9rupTlYNq/Ay4bhCA0f8zSx+IfKkZppoxCuHtVYqmEfgfK7ePLJ1aHg+4BsPeMVQSBrRsHm07DsBM1MExIVAEb5yLvvGE9fWffjHEk9WtuZavUA6xzakHXwcdtSaBJ4O8X8rcNbQ+83H3Ns0kKghsd40sbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459929; c=relaxed/simple;
	bh=cWSh40/GBkttyPJ/iR24UYVatT/zc5uUkj3jx626xU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIxA5OD+zNJ5VkRAlWNnwEriX3bNpQM3suKasNo2mdHfs6QU+/QDqTm0/SbkFDHJwAf9U8bV68f1wS/xqdH/WMFoHG9rotV58hUZvvx5zIuBpDQst7TRnDpvNP/2TgKXPByMadRz6OF+EbR9FvHVhlam097hn2ZzhkXJHkTO7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNdA2MDi; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5873983d19eso583371e0c.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459927; x=1780064727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PhUPrY9J+tGC6063Eguxk+7GNvzjRZ0H6G2mBc3a4ck=;
        b=XNdA2MDirl4r0ZpG/N6JL08puEgHUY4HPJd2lkruU/L36d1oZVAyp1j8M6/RU0RkpV
         SBcz3NNwEuh88MZg6P4pCIRySWRDdQwkbFct0Hl4GpsA+aA+RWNQuhken8dn85a7+bZw
         apMfV+qnRDoM0Cfh4ocdTyej/iD35iguqSX0UtdcYiAjlu0+zvHPuUU1YpS/inu6TnDc
         rXpzDK59J2PFeom7Z4b4IXUfkyShhbs2jQMAarQUAQLGk1H6qEpgD89CLHSXiyOJsIkJ
         Tx7PYQxi+isap0rTIt/Dq6hmjC+P54O1mfzKN7wl5oWN4C83Rzfhkk0fj9cSV3jwxCiI
         GhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459927; x=1780064727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhUPrY9J+tGC6063Eguxk+7GNvzjRZ0H6G2mBc3a4ck=;
        b=YlZO+LyIN7j/+DlWZNFzEIQB7KT/XZAKpXxSWxzOJHa1wYbidWeHQBgbYiBdP0kz9g
         6QXsRh3wQGeRQq/+R5f0FBK+5AXQVtwTFupyRI1ki2Eopf5FbM7NM8zAeUKweo5MSnHU
         L/Z9qe7wYYI0WqxqJ4vqUOcaoCgRvX0+YorRe1kLpkWKH3an8Wf8wwrHSsNsbGautb2x
         GDvW9N3QSsrGuR/JKhpsUpsvyC00jOCvQQVNp6laiOpRLaWKBtoDxIvUmBL5s13B1uCn
         0b2qyNjCDNQ86oT/P3YXNOfBURbqe12Fk8gm/94xKxT6tIRxPr8az5KsoJ0GtPEDMy15
         I4Og==
X-Forwarded-Encrypted: i=1; AFNElJ8035lms6V6jGi7EIUUGWLTzjfOTIq/DLDSxs5jdgXaF9Cs4eBJ9juQKY4julPTb5dGIrBGuY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl5LMzBl103McqHfvkQHUd3b6PJ87uZn9SJwhW75/Z+j1UNXLP
	uDeyRjsewugT9XKLDqcYUf7huGb8k4IUEZlrJjo+CIPmzKfC8E229GNZ
X-Gm-Gg: Acq92OFPbQAyjYt3ZW7gA8EfhgOS5phfQ9VwJgKhRoqREa/QBuDg52L6P8E7sY0Kzru
	YDtKoLUP6phllnTqXzloDThzJT9COD62D8cYcVjNOW2qOGlp1K3gr8ta6SJ5eMU52Kq+IljbEjz
	uW4fSjSxZZEB5hDMUsudyV7kYt/ln5DXvFfESRN/+bX+d5rWV04MKsEI8R01apeifzQf4yCwVYN
	JHnuNuX4Ejde/FD1U61TCiFPYAoqYp4CR4ML2coJC7+67d/JZB1GVMVgWE/udhCHOdNDPlifYXw
	Q6niati/GO8jjL4x80qLmcwtAjjNFRDHEqSI8SbZ1jqTSLq5cLNyqbzZrCW0gSH4nQfw7470Kq/
	JM3zyPQOoRJS6LWTypBss9vfplqvLIFU6SGMjt8y6nCH0Ws0j82flrxhTcZ7Es706hF0AwmTxt1
	XH5qyVWYU3i4xxzLhdIPtxcPW9OKVhgMoTruqOaoqpQjEykKo2T/WiIsskemGB8t0OGK1ZZK8wk
	T66TYlsWy22/uWpwAaSX3qkySgUFEr5iloK7d463GdSv2HjEokMNTf28KSlRq2t
X-Received: by 2002:a05:6122:ca3:b0:575:33d4:d101 with SMTP id 71dfb90a1353d-5865e69bf5bmr2257085e0c.2.1779459927094;
        Fri, 22 May 2026 07:25:27 -0700 (PDT)
Received: from sekiura-Standard-PC-i440FX-PIIX-1996.. ([186.122.244.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f8f6cd40sm2403881e0c.16.2026.05.22.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:25:26 -0700 (PDT)
From: Takao Sato <takaosato1997@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	w@1wt.eu,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	chopps@chopps.org,
	stable@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>
Subject: [PATCH net v3] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Fri, 22 May 2026 11:25:04 -0300
Message-ID: <20260522142504.1394864-1-takaosato1997@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,1wt.eu,davemloft.net,gondor.apana.org.au,chopps.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253806-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8905C5B687A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_consume_frags() transfers paged fragments from one socket buffer
to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
the same class of bug that was fixed in skb_try_coalesce() for
CVE-2026-46300: when fragments backed by read-only page-cache pages are
merged, the marker indicating their shared nature must be preserved so
that ESP can decide correctly whether in-place encryption is safe.

Apply the same two-line fix used in skb_try_coalesce() to
iptfs_consume_frags().

Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e5..4db85e158 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
	       sizeof(fromi->frags[0]) * fromi->nr_frags);
	toi->nr_frags += fromi->nr_frags;
+	if (fromi->nr_frags)
+		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
	fromi->nr_frags = 0;
	from->data_len = 0;
	from->len = 0;
-- 
2.43.0

