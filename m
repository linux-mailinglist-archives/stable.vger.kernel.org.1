Return-Path: <stable+bounces-254230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAJCBRLsFGp9RQcAu9opvQ
	(envelope-from <stable+bounces-254230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:40:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F85D5CF4F1
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35CDD3019F37
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F91274B5F;
	Tue, 26 May 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha4OP5Xw"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E0272801
	for <stable@vger.kernel.org>; Tue, 26 May 2026 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779756044; cv=none; b=YG1Sgfb8d4tKLea6wCKPMJ//qnEtqBwYz5RFlBhpes4Ow4FjhOJsPiB+0yoFPnlKZiZgBI99rwzQqXxFw4HYKifHFYK4rj+q3sWZOMdqJV1VWiD5Kxv0sm1Hsnsr36UhGqyWhPMCzOG7Nj1TxGWV4yHDqs/xZacKxZBi2GHZLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779756044; c=relaxed/simple;
	bh=aI73dLAsoMnIz2OoRYSyNZeZBTVcQgWYmXKRdLg8hGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCklk+xjIbTGHjFMEQoS7p/uHXIzSWNIr3tuLxfHG6VAdE03kNL/EzRMI1K5rfEBa0mrzUppywVa9e2aEax8EYDZ4UB+lFUG4kjF8jsY7kb2JounsHxDg6bxaf40sYWIrL0znU3Q22cj1/tHkROoEiylVqn1qRSA5N9SVcx/dEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha4OP5Xw; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-575171b1ce7so3319059e0c.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 17:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779756042; x=1780360842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=ha4OP5XwDhrA523lX4bzijXg2HUoWfx8fyvOcZIZ4DGN0A5vE6Jmx/pzpA+QZ3u1QI
         735lHTnuqCJFnGWJF/ZL+EM/AXZpVHOxA9+byPd/nT1yeVA3f0TUvylIYJ+wmJmT4iH+
         erdbPCio1lfKDz1Tl/fTLqlwLB2x6yiMUDEVtVec/oJ6nhy/NDSJhUZlbtSEpzoHpSYj
         T5E6L9rNugcezTds+KhhmSpJYQzGCcRWieYXqVMtX0MCghdJoNPDN9jR5qho+lYZnAAx
         fj1SMqjmIfSqwuow84OBMv0/Nxq3FO2FKJpZYb6x317NlNq8ioP0bPaRkeJs1h1Ucsr0
         CKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779756042; x=1780360842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=nlCiwQbZRUaYJ6Yi/lfUy4B0ejqQ51v3kZh/UcVOfVYHjyy4o2GP+30ZnRsc4n6UHS
         cIFEecRXYRYDCu5cp/2YBze7US0PtgfdTY+goc4mm64m+xisLdu/JKyVFlE33g08xrIY
         +nZa6MflaNtkh3Kk1DHqwRdawe4/ILiD7WP4KCXXcrZMN3MdU7jPmWghS0hilD2/V+rU
         ypGh70EssBydZW9k3+CBPq5s71NNMefKx2BBXojSlZ04Cn8w33XxEA/jwQVfJscAQ+IG
         rvZbAV/q3AtIFMXW/l1h4BAMyMV5AyvTR8Z/eVb2/0IkTEA3/eA48sx0GJVF2kPuIlN7
         zVYg==
X-Forwarded-Encrypted: i=1; AFNElJ8N9TxAIQiSqpOqGn1l9dg5U7ooVPk6DO+cP9xf2VeOcIHxxP9G3yV9rzN4JQ8dsZwWc8ovElE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExSkONotbg5V8fPpYmZbmJbfPBBJuvx5HNGkhwlY5cIebBaFA
	qOziwscgj2DrK9l6zC6SMVg4YmkHkUG9AYx1OhfTrwp89GQqCbaYLwLf
X-Gm-Gg: Acq92OGa1r1fZp6nXtwv0l6B0WRaQwq7hjVYvY7Fa50IVlIYTL1nf5wNs7VxMbeasoB
	3/4Tmf6v8vHOQaAqU+3CBBi3eeUxstyIfj8UsYLe+VnLyynVselWmP7jowU6HuXHofuQIlTLVNe
	j7tNFFO1maQ7BLdxhUSLJKD9uf/dQxsY1lKOkTcrVa5D2CmfDtY+ygqMkXFe/LXYqv4g90FGXkN
	SbjZYOao97QA4LMDX898+l6EVY/cYx4vC9CudXglx+LNqQVUCfUXVzoCJ6vH+7tr5wlCfdkPTn0
	4p8I/xJ9gvRKE9kK9F1rF7ciPwmnMHAqWwOf6D5tDnFCA2kfs05Nixh13HXGRDBwM0UAIIyJ4dj
	gPTe9uc9ixydQ6MroV4KFp0tGxoTOPWBVa7Q7OHj5YQvv4SlVWCYgTYveimjTHnBYa+4zh+kkBL
	Qq0RfQ+sjpQa+VdnBeb2/Ho9h4la1+sdlYLPr++VFTlZC1ZzcBJQ8xYJE7boittpf/FlNyjRshC
	zYXXjRMMCqSbCjwk9Kq/n6I7CzNIO1+LMXunWiPWCorrFHs6bFEp4PpJwcqyI+0
X-Received: by 2002:a05:6122:3214:b0:56f:2609:cd95 with SMTP id 71dfb90a1353d-586626bd8acmr8961529e0c.9.1779756042074;
        Mon, 25 May 2026 17:40:42 -0700 (PDT)
Received: from sekiura-Standard-PC-i440FX-PIIX-1996.. ([186.122.244.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-588c129cba5sm11799269e0c.14.2026.05.25.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 17:40:41 -0700 (PDT)
From: Takao Sato <takaosato1997@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	w@1wt.eu,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	chopps@chopps.org,
	pfalcato@suse.de,
	stable@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>
Subject: [PATCH net v4] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Mon, 25 May 2026 21:40:35 -0300
Message-ID: <20260526004035.1023696-1-takaosato1997@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,1wt.eu,davemloft.net,gondor.apana.org.au,chopps.org,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254230-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F85D5CF4F1
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
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
---
Changes since v3:
- Corrected Cc: stable tag from "# 6.8+" to "# 6.14+". IPTFS was
  introduced in v6.14, so earlier stable branches do not need this
  fix. Pointed out by Pedro Falcato.

Changes since v2:
- Removed security impact paragraph from commit message as requested
  by Steffen Klassert.

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

