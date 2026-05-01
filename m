Return-Path: <stable+bounces-242424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PSFAAqk9GlKDAIAu9opvQ
	(envelope-from <stable+bounces-242424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B04AC863
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1978C3019913
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751CD1E5702;
	Fri,  1 May 2026 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ1AB4fb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174626299
	for <stable@vger.kernel.org>; Fri,  1 May 2026 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640453; cv=none; b=VGlIIcNhuhcG48rg0cTqAyDYWmYzzmaxrQZ8xbl6gPQRWXMm7vAO5KYIeGT69p+4a6h8pDKryb24KzXv/0g22g+/qHoRhkvk+nwNCeTbmjwSk7cLCJ4cMIGybs7EQuMrQIq9aDPtPbYk6xWNyuxZwr9cLM6JD8f/Q/KxXj0xypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640453; c=relaxed/simple;
	bh=qyIkRHi6oV5U2SmgdqpjVI5pwMUbK8zwy66lyVzRAGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6DlggM1hbhNNtsMD64VL0Ms2+DJXMqb4998Qs8t5UHsQOI3VPdJIuCdCq2FgzwN08BW0OjKUxfSIcJ5jgVfmLSiclzSbQn40z8q/UOSlPQ/B1Niy9jJH43Ypik8y6hRk2iVdkucL1fVZ+I0LEKO02rbFu2Eg2tHSj4e5iBszBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ1AB4fb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so27985785e9.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777640450; x=1778245250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqhRiAzIyiH2+fYeG1xj4sXrzPXGhw3STHTuHrGU/qY=;
        b=UZ1AB4fbwLpo6HsO5504KHdSFb29QYDc7E9RPsNsQXNwn1llm38Mm00ylSnEkk3kFs
         //0wgOBBzxVAKP8E1WFS4qczuW7LIAyTxG3czvlhOPIxqQPVr6TFBWap9n9RdzzzYa9D
         O4trE/rFYCUfMIRbulzv8as9ze6FDTqcs9Cgk40an/HrUlb8B2CT5+pOAECM7mTzLl3w
         a7GJmHiVS297Ig0fQ0p5LboCPAQV7lcvMRGWp/PMUrKwN6qD5Wf2NxoAEE6V/8+9UrcK
         DxSBEHyAolyaUdq04mSsbqyoPMNw7wafaDMf8o3ZmJHEQqIQsUJmEsD+9L4kyStiQC3C
         wxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777640450; x=1778245250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqhRiAzIyiH2+fYeG1xj4sXrzPXGhw3STHTuHrGU/qY=;
        b=FPVlewcqJ83CE48QcT8QLOH10WEwZMD5d82IcvgBWJGsLEyu8APjo+92HValS6F4Qt
         82MERyEgPfet4xPvGyguU451mJooUt4IGfhf4OsYMwxW5s327XvnRh2SBr/+1DFFt+sB
         nh7VsIqh9WE5a9sFwa+ZYF8ef4tq2pSzzvhEXTYtlhg1MBr0GlKL+nGP8/IhslAV1ul1
         Iewgh6qsuBXZMxYZbUp+6IrNEfHu1WUQ+mXlZCaWbD25CV4qsOZ4ITK/zE4ciYgN9yZ/
         /VOIdhD7e3sMTh8PrDYolOU1IUYB8DaqDdn6IuHHsK+e9dqEdG10C6z9dL2SFNDG3wMk
         tksw==
X-Forwarded-Encrypted: i=1; AFNElJ95IlYMQU1k7sf/fuaiew88dnHcv62vsQxyYh8fkdGn+XAicFuMGKU65NQbxKrAP3cyuqozqzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZ1jOTuWChIMF/VfwODpxSWQjXX9jAEsX6LAk2F+u2yYRYfqa
	lIQi0HeRqC/Nh9WTLkiBrLgqn1zDeIsLK9eJF4c20QzJvGTDUjKKnsVp
X-Gm-Gg: AeBDiesVAoFc3M3xKEl+0+9rdaE2KKPMucydsOE8F/SFTRnZBaPQ1d88hUETqWvl9sr
	kTqo0fnD3f7Kl+EaA4yzUG6EUoalSxa0xjDE4Dnpqp+PZkFsRZSnYRpOSXJorkuJfJiBMHlBP35
	fDaFzg3tRdR1ABxGE2eR1dl4otunp3HsnpyR/pKWCIXDOi8HY0zrGfSYh+fJdBaY6HFwow5tpyJ
	FLhi/1BZvuIh4WcoSEFJqeX0gri0sqVXImD6c1sfHzdibv5y4RaUic1DB2KeNKTcdLF0zoeKvXK
	Tb+yfJsTQJ7+YkGdCm2qHp363gKXtQwopIl5VJDgeQsWcryDFsb0CAgAnHUZiq4C65dxMNjZAEj
	Tp6yPqXfv4HtwUTZ5J8LNYBwxLQYBOQJJGGLrnWiIsMjxY2gSz1TcaAxP6AyBWKYt7uMRvJQMTR
	RmS0IMv7HUHTh6jMl/UO7dg2YKYcLiqnOCUeoxMZCB7DKX74WMjQ7Aya3sQAoDXbJ2zInK03Igz
	1YjNBGX+Wf3hgcEQ8lvXg==
X-Received: by 2002:a05:600c:1f10:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-48a8445b91cmr118213405e9.22.1777640449917;
        Fri, 01 May 2026 06:00:49 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm151465915e9.11.2026.05.01.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:00:49 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH net v2] psp: strip variable-length PSP header in psp_dev_rcv()
Date: Fri,  1 May 2026 14:00:46 +0100
Message-ID: <20260501130046.16008-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430062033.20428-1-devnexen@gmail.com>
References: <20260430062033.20428-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 550B04AC863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
Suggested-by: Daniel Zahka <daniel.zahka@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v1 -> v2 (per Daniel Zahka):
  - strip the variable-length PSP header (psph->hdrlen) instead of
    rejecting opt-bearing frames; VC/options are ignored, not refused
  - drop the crypt_offset and PSPHDR_VERFL_VIRT checks
  - refresh kerneldoc above psp_dev_rcv()
  - retarget at net (was net-next)

 net/psp/psp_main.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 9508b6c38003..b040345d7273 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -263,15 +263,17 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
 
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
 	int l2_hlen = 0, l3_hlen, encap;
+	u32 psp_hdr_len;
 	struct psp_skb_ext *pse;
 	struct psphdr *psph;
 	struct ethhdr *eth;
@@ -312,18 +314,36 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
+	psp_hdr_len = ((u32)psph->hdrlen + 1) * 8;
+
+	if (unlikely(psp_hdr_len < sizeof(struct psphdr)))
+		return -EINVAL;
+
+	if (psp_hdr_len > sizeof(struct psphdr) &&
+	    !pskb_may_pull(skb, l2_hlen + l3_hlen +
+				sizeof(struct udphdr) + psp_hdr_len))
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
+	encap = sizeof(struct udphdr) + psp_hdr_len;
 	encap += strip_icv ? PSP_TRL_SIZE : 0;
 
 	if (proto == htons(ETH_P_IP)) {
@@ -340,8 +360,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
 	}
 
-	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
-	skb_pull(skb, PSP_ENCAP_HLEN);
+	memmove(skb->data + sizeof(struct udphdr) + psp_hdr_len,
+		skb->data, l2_hlen + l3_hlen);
+	skb_pull(skb, sizeof(struct udphdr) + psp_hdr_len);
 
 	if (strip_icv)
 		pskb_trim(skb, skb->len - PSP_TRL_SIZE);
-- 
2.53.0


