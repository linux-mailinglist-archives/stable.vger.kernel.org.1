Return-Path: <stable+bounces-242608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHXWLyII9mk3RwIAu9opvQ
	(envelope-from <stable+bounces-242608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBCA4B2498
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85189301547F
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D262833D4FB;
	Sat,  2 May 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2HU+sIs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50E26D4DD
	for <stable@vger.kernel.org>; Sat,  2 May 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731592; cv=none; b=ZIgj1TrSIkz2O0x1WgYAxLNvlgIGpKVO9G8UJZI68b+VpAcFrkFhwOCFDIVpCQhcCub/U8SlORmlVvTwdcf2T018GUnABd7knqYos8Euvt9Nk+gsxsVh99byU8H2rr36FggAHrBVXfIG06B5/y+NbC4Vz9gPaYfqQ45ysnuPfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731592; c=relaxed/simple;
	bh=k+AkJcSPR6GWTz3BEXN8/5jElc3fjNG4wrYl2Mb984o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvzxgMRw566pH0o0lAjfKN+7K+EaywfS6wk9cs7IMHE3USu9CDBP6uVdl4Y2vE26lGl963GlagGWqwk5WNLO+Yfk5fxYhxAn0OE9FkIYYI3Gr1PT7Oy/EX6j1Qcea/4sCL1kiax+0NOnPmO+1QMIKkW7XZZ1SJoH1+BBpqkknos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2HU+sIs; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43eb05b1875so1400824f8f.3
        for <stable@vger.kernel.org>; Sat, 02 May 2026 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731589; x=1778336389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Xccp0tlIqEgZ2YXrZ9jc4pOkvj1KBEkw6Ll1vuHko=;
        b=d2HU+sIsZoZg9npnGPacoaM+MoqmTPfMdI/nO/UijPBT4o9RSvdUn/x4YiLD6aV/Fq
         0Bx7iCgNNJ+wubn5i8Ke/nYn9YuWVJ//EYkzzqvsoUIxJ5bVrxGycTwuraGetBNBQT1+
         Bios4ooy1v0FDnFqUpRtQGckt3E87eKeOAHpF9bo9FzHQpQylhdQTsqNSKABjOZpY17k
         8oY6nL5AuX79v417fPKY+Y/kdS2qP6BGWNfH5cu5hjUZ21UU062GwSWQYB1o9b9Q9n0i
         BJZXYi3BnBWDABtGn+SQfLLiXtHeMXrwDvjWzKoLuBBXD5Bym05PyQBRZXrpgvl0XBPZ
         osWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731589; x=1778336389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+Xccp0tlIqEgZ2YXrZ9jc4pOkvj1KBEkw6Ll1vuHko=;
        b=Cw2rDoDTmbOrw6pQCZOqaU6ANKSu/7dA0LLQY+mnsnsFhd2U2Q1YydPfo0wRl8Xcsx
         /O1hVXMKZAAabMUxLypFta/e3sMA7U9kazZkndKqRJLKCxgYvshavOZtx7BC95MW4jBr
         TvgLsHfJ3AE2JH5MpQAu4EDrR5wb0ONKA6Rw11tu0+ui0S8G2+oUYQtapnMCUbpp8lU4
         wrE/Hh1C5vnRYvUfPDPBONLXHd1oc8LKHaB+cRd8jMqVJDK9ZwI+2SCQrveHg0QmUEFm
         Q3RdCcORKt3f6jVqsFllxiqWAj7CiwwHoGxkwT62bNy2U9TjwYaIxXgQSLWueA6hqywG
         BsYg==
X-Forwarded-Encrypted: i=1; AFNElJ8N4E9TOMiLycjMqT9yo+KvGBSfZ9IwAWc8/yF0SBoiethFVEWOnj5oxV2q6e7Yi3qYCWpO5hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cBtdFZ9h9ijdSUZxgohojQJ139rrmF2kcB41UJHSB3oG9Rna
	x1e8nDfE2sDk/qWylg65HjF3wC2Rp6b28Xm/sW63czjnsFLKvBQCu7Tb
X-Gm-Gg: AeBDievlqZ3lg0CpNx7lgEH3ie/Ca7+EcuHI12SCN9x8qsgrSo0bTyZiZwOsF13T3vp
	f+nQsmRC1evojG94NHHvr28XMhDwGpCAnV86okYFdWYQfMNnGaLLW+ErVSERe8gzGnXy9QtXgr9
	9JGB9kfwDtam+4prewRpfukg84odDzjWomu/FPSlpIyaJXHjyY4RYOBQJpWcqIrkDyi77Sw6Jji
	Sz2ID93KnJtmGstYMomwkmI9wAyseuFNNIAQpIYkCww7ncrBSxsEmeaCTuo1eWtOfG8AQzU+kkQ
	QY9m6tYVyYsCMY1Xob+pKOS24bg0iUBmpqqC80PeZ8BEReRikysSIehTBeQ6HKf6W5REPzR9zZ6
	SI3Qwv56Ypg+qJS30pgoNsau00GzsXlhh30cg9v9rl4nXSQgS+Wz6b1t3HfNG2DstMbMNdVEeJx
	SmWHo/y+rjszwc1YrwJ/n2TgKB3z0iC7u3MQG2o1rUZlLWfo++P28RJIm3b1w8duqVXTu8Qe8pz
	25Ve93Mfs7acexioDoERA==
X-Received: by 2002:a05:6000:61e:b0:43d:7b90:fa23 with SMTP id ffacd0b85a97d-44bb65df7c8mr5021767f8f.29.1777731588443;
        Sat, 02 May 2026 07:19:48 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44b638ac434sm8272788f8f.36.2026.05.02.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:19:48 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: daniel.zahka@gmail.com,
	kuba@kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	raeds@nvidia.com,
	kees@kernel.org,
	cratiu@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] psp: strip variable-length PSP header in psp_dev_rcv()
Date: Sat,  2 May 2026 15:19:45 +0100
Message-ID: <20260502141945.14484-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FBCA4B2498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242608-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

psp_dev_rcv() unconditionally removes a fixed PSP_ENCAP_HLEN, even
when psph->hdrlen indicates that the PSP header carries optional
fields. A frame whose PSP header advertises a non-zero VC or any
extension would therefore be silently mis-decapsulated: option bytes
would spill into the inner packet head and downstream parsing would
fail on a corrupted skb.

Compute the full PSP header length from psph->hdrlen, pull the
optional bytes into the linear region, and strip the whole header
when decapsulating. Optional fields (VC, ...) are still ignored,
just discarded with the rest of the header instead of leaking.
crypt_offset and the VIRT flag are intentionally not validated here
- callers know their device's PSP implementation and can decide.

Both in-tree callers gate on hardware-validated PSP, so this is a
correctness fix rather than a reachable corruption path under
current configurations.

Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2 -> v3 (per Daniel Zahka):
  - drop Suggested-by trailer
  - rename psp_hdr_len -> psp_hlen, retype to int, fold onto the
    existing int declaration line to keep the reverse christmas tree
  - drop the (u32) cast on psph->hdrlen
  - no functional change; carry forward Reviewed-by tags from v2

 net/psp/psp_main.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 9508b6c38003..e45549f08eef 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -263,15 +263,16 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
 
 /* Receive handler for PSP packets.
  *
- * Presently it accepts only already-authenticated packets and does not
- * support optional fields, such as virtualization cookies. The caller should
- * ensure that skb->data is pointing to the mac header, and that skb->mac_len
- * is set. This function does not currently adjust skb->csum (CHECKSUM_COMPLETE
- * is not supported).
+ * Accepts only already-authenticated packets. The full PSP header is
+ * stripped according to psph->hdrlen; any optional fields it advertises
+ * (virtualization cookies, etc.) are ignored and discarded along with the
+ * rest of the header. The caller should ensure that skb->data is pointing
+ * to the mac header, and that skb->mac_len is set. This function does not
+ * currently adjust skb->csum (CHECKSUM_COMPLETE is not supported).
  */
 int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 {
-	int l2_hlen = 0, l3_hlen, encap;
+	int l2_hlen = 0, l3_hlen, encap, psp_hlen;
 	struct psp_skb_ext *pse;
 	struct psphdr *psph;
 	struct ethhdr *eth;
@@ -312,18 +313,36 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
 		return -EINVAL;
 
-	pse = skb_ext_add(skb, SKB_EXT_PSP);
-	if (!pse)
+	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
+				 sizeof(struct udphdr));
+
+	/* Strip the full PSP header per psph->hdrlen; VC/options are pulled
+	 * into the linear region only so they can be discarded with the
+	 * rest of the header.
+	 */
+	psp_hlen = (psph->hdrlen + 1) * 8;
+
+	if (unlikely(psp_hlen < sizeof(struct psphdr)))
+		return -EINVAL;
+
+	if (psp_hlen > sizeof(struct psphdr) &&
+	    !pskb_may_pull(skb, l2_hlen + l3_hlen +
+				sizeof(struct udphdr) + psp_hlen))
 		return -EINVAL;
 
 	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
 				 sizeof(struct udphdr));
+
+	pse = skb_ext_add(skb, SKB_EXT_PSP);
+	if (!pse)
+		return -EINVAL;
+
 	pse->spi = psph->spi;
 	pse->dev_id = dev_id;
 	pse->generation = generation;
 	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
 
-	encap = PSP_ENCAP_HLEN;
+	encap = sizeof(struct udphdr) + psp_hlen;
 	encap += strip_icv ? PSP_TRL_SIZE : 0;
 
 	if (proto == htons(ETH_P_IP)) {
@@ -340,8 +359,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
 	}
 
-	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
-	skb_pull(skb, PSP_ENCAP_HLEN);
+	memmove(skb->data + sizeof(struct udphdr) + psp_hlen,
+		skb->data, l2_hlen + l3_hlen);
+	skb_pull(skb, sizeof(struct udphdr) + psp_hlen);
 
 	if (strip_icv)
 		pskb_trim(skb, skb->len - PSP_TRL_SIZE);
-- 
2.53.0


