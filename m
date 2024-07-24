Return-Path: <stable+bounces-61293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80AD93B2C0
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558DBB22030
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738015AAB1;
	Wed, 24 Jul 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="So5kbOi8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180F15A85A
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831702; cv=none; b=t/LvD3ya8Bf0Sdx9NsvPLeBQOtWxzm95wuIg5IGMgjw9AjH8Ewnn7+cT5ZOzNCIE2i+YKAUI8VMDTT8qNV6o/1do4eMXTHysiG2e8gscaF7i3Q9KoKGEs7PvthdlssU1YCwyYj5t2/F/uSiIkVBS0CI7sGoQwaBGeAsGzSQMKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831702; c=relaxed/simple;
	bh=HSwQeQKexnGgqVLaYYN251oliUuwb76BW3cdQCAHRbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Moz87wC39cTA9vyLwtNPqp9/8rbjo2Fk6p/7ZNrWYbSBQel6x2DsHW4dzGKbKi9skJmhXQWinto+WMkj6sDCVt5T4Pl8h/h2euUswAmQP62n3n1xpnl6EeQ5qdj0fUxuuwSS3pRWvYphKafd4qy8gcPfCOd2pyHwnxzHD8DF2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=So5kbOi8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a5534d58so13440428276.1
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721831698; x=1722436498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeMGXcX1cegB/do4cg9zm1gyDlQ+HaTTsOgplmebNZ0=;
        b=So5kbOi8Xw9mb1ATUIRhCuMyzzh3jPbKVxLJ1i2fOOFqMZLo8oKAAhXeZbS40dPIrh
         ZGnZgVXNmz196OeRHC5XPS7vuBv4474EKGIByVktgYdEI9s6C/T3xx9QAzI5Fvyd22ML
         AzLF2q9QRKKGN3WFcfS9egjnajrV5OBW2FmWt5nh9wcatMS6BR9d59cViWPLt4usP6/E
         NYEQJ0hXC3a5FdAhA/ZVlsfIoQ1PGWBdbmZVlpaEvTLbuLbxHz3OawlCsdnM62fLoDL9
         2D3K1HciD/lEYIV60Imua/lL3KUvoLqs1sQP5Je9OvzLXTCeIVG45pFzfc3aMVPAUDda
         F2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831698; x=1722436498;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeMGXcX1cegB/do4cg9zm1gyDlQ+HaTTsOgplmebNZ0=;
        b=ppGDd2/dI/UhMTBmzU0Oa3BewNxP4WACIw18IzLFjaahAH+a5OpBaBjLl47gcOWccJ
         EO9fcRHuaH8RtSwcZtp5wYpxTTZCm98haqMSwqLppq9uDIiSGCWALN1zKayWIXAVTOPe
         Ec7sb4VWk6KOxtg//4ZylXQt/dBGQSrkklSFsCvqqRLJMWdGPATrb6H6Ugjka8pWHcO1
         n1wYfvDWVM0VFkQeMBNGezbJpxEgrhm16oKBVxxTiCbIhnK7gg8AK9Sia5kSHXqwSCq/
         EHOCKbkTSaqPATS/TVpWtrY86c5XEMet4R25IkkWv1DMt4VCYMrlDhXJEVh7DnEXNCyr
         61kw==
X-Forwarded-Encrypted: i=1; AJvYcCW3PVaQd1HPMW66NXgwHr/hVf9cTshkQI172lFApXW+nJdk6MH6D1GyLFeLrWNQ11WEngyl/XC4uF1JaKxDX3KBP+/YDba5
X-Gm-Message-State: AOJu0Yx/WMtKL9oU6rmB3IqcyqRtx8gNlpMrQLN8NAWpncmZQc7zWjyN
	wzsbC/ts445198R4Qo62P3kn3T0KtI8h0I+9g7miiplIGOX9/Xesw23KGTwyVF/neKoMl4xih/4
	WKkz5oNCxPDhgKdP2547IntHdMw==
X-Google-Smtp-Source: AGHT+IEZuyeGwGKdUoIRK4zF9Zbp4w/oa6ZeROlRlWRSwH9jVrHULIW502Jr9RftRka06FDyoDllerEv4wcOmgjiUTI=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:8273:a55:a06b:2955])
 (user=pkaligineedi job=sendgmr) by 2002:a25:820d:0:b0:e05:f2fc:9a37 with SMTP
 id 3f1490d57ef6-e0b0e3b90aemr3769276.6.1721831698504; Wed, 24 Jul 2024
 07:34:58 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:34:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724143431.3343722-1-pkaligineedi@google.com>
Subject: [PATCH net v2] gve: Fix an edge case for TSO skb validity check
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, shailend@google.com, 
	hramamurthy@google.com, csully@google.com, jfraker@google.com, 
	stable@vger.kernel.org, Bailey Forrest <bcf@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Bailey Forrest <bcf@google.com>

The NIC requires each TSO segment to not span more than 10
descriptors. NIC further requires each descriptor to not exceed
16KB - 1 (GVE_TX_MAX_BUF_SIZE_DQO).

The descriptors for an skb are generated by
gve_tx_add_skb_no_copy_dqo() for DQO RDA queue format.
gve_tx_add_skb_no_copy_dqo() loops through each skb frag and
generates a descriptor for the entire frag if the frag size is
not greater than GVE_TX_MAX_BUF_SIZE_DQO. If the frag size is
greater than GVE_TX_MAX_BUF_SIZE_DQO, it is split into descriptor(s)
of size GVE_TX_MAX_BUF_SIZE_DQO and a descriptor is generated for
the remainder (frag size % GVE_TX_MAX_BUF_SIZE_DQO).

gve_can_send_tso() checks if the descriptors thus generated for an
skb would meet the requirement that each TSO-segment not span more
than 10 descriptors. However, the current code misses an edge case
when a TSO segment spans multiple descriptors within a large frag.
This change fixes the edge case.

gve_can_send_tso() relies on the assumption that max gso size (9728)
is less than GVE_TX_MAX_BUF_SIZE_DQO and therefore within an skb
fragment a TSO segment can never span more than 2 descriptors.

Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
Cc: stable@vger.kernel.org
---
Changes from v1:
 - Added 'stable tag'
 - Added more explanation in the commit message
 - Modified comments to clarify the changes made
 - Changed variable names 'last_frag_size' to 'prev_frag_size' and
   'last_frag_remain' to 'prev_frag_remain'
 - Removed parentheses around single line statement

 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 0b3cca3fc792..f879426cb552 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -866,22 +866,42 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
 	const int header_len = skb_tcp_all_headers(skb);
 	const int gso_size = shinfo->gso_size;
 	int cur_seg_num_bufs;
+	int prev_frag_size;
 	int cur_seg_size;
 	int i;
 
 	cur_seg_size = skb_headlen(skb) - header_len;
+	prev_frag_size = skb_headlen(skb);
 	cur_seg_num_bufs = cur_seg_size > 0;
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		if (cur_seg_size >= gso_size) {
 			cur_seg_size %= gso_size;
 			cur_seg_num_bufs = cur_seg_size > 0;
+
+			if (prev_frag_size > GVE_TX_MAX_BUF_SIZE_DQO) {
+				int prev_frag_remain = prev_frag_size %
+					GVE_TX_MAX_BUF_SIZE_DQO;
+
+				/* If the last descriptor of the previous frag
+				 * is less than cur_seg_size, the segment will
+				 * span two descriptors in the previous frag.
+				 * Since max gso size (9728) is less than
+				 * GVE_TX_MAX_BUF_SIZE_DQO, it is impossible
+				 * for the segment to span more than two
+				 * descriptors.
+				 */
+				if (prev_frag_remain &&
+				    cur_seg_size > prev_frag_remain)
+					cur_seg_num_bufs++;
+			}
 		}
 
 		if (unlikely(++cur_seg_num_bufs > max_bufs_per_seg))
 			return false;
 
-		cur_seg_size += skb_frag_size(&shinfo->frags[i]);
+		prev_frag_size = skb_frag_size(&shinfo->frags[i]);
+		cur_seg_size += prev_frag_size;
 	}
 
 	return true;
-- 
2.45.2.1089.g2a221341d9-goog


