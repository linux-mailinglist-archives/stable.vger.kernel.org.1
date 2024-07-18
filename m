Return-Path: <stable+bounces-60577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E00935204
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 21:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D14B2105A
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94D145A1A;
	Thu, 18 Jul 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHmJkA83"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A24145A15
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329354; cv=none; b=rTcuTUvvbuEoL5iCknOy3CjhBCZD/ixNKtn4nNk7fgHYS65UXHXRaoJWHCqukVRLyoK6AILxRbLbqW85j69Pw7d4WyZyVjxNrUC52HGGDgVJ3pkDMGHl9AOo6l04ftjHWjdMh5WetJ91s5rBou+/CTziXm8wIy7gH6BCepYu6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329354; c=relaxed/simple;
	bh=ww6qQONtJZStqms+LWq6iOpNCGMQQmzuptYiSaUtzFw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TAbnZVvgUnsaGs7KV91Ksb/muhy9N7ZP5HmTIciQ0NeQhgPjEe19t/a1DeJS3Tt/cH8PjAl2dvlOqa0VYzIAVB9y2RqU2azxfI4bJXDODe46sojhHxS5u5Gsr2byK9B3BmV5pECoW+aNh4Ct7knDv9dncAmsJ2GlJp4foe0XmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHmJkA83; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65fabcd336fso32507997b3.0
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721329352; x=1721934152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9R8gsfsq0yB/G35OWfVJg7891znOv21k6n7O/XgO+A=;
        b=qHmJkA83FNlPOgsQARHUI7vnDaex5dPniffgoZnSUVrHpoDAGfzx0BqPn4zTYPdLNQ
         6AhYF+ekSr34CDIUrvGnglqrDc7VfIe4LvzrXfIPuwD2C/J0ZswrLKaTNY3g9DTi7wu5
         1iV13VDioUu0ak1E7CGoOrjwY63piS6vWfEnLJcCitYQdO9BvJAR5Wv8H1QbXIDoYqJj
         nKFFXUScDiDS1czrP4549WRkqDUN+/3ZH3Vf9EO+5lfjlvzSQoD19YQPoHtsZzkZpMHi
         kyLSYgpRHYH6e8pH92o4F3xR6lf4H3v8YmY0QHQVfqQrZYrsZzysIDRMtEyrhtKoSDfZ
         Bpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721329352; x=1721934152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9R8gsfsq0yB/G35OWfVJg7891znOv21k6n7O/XgO+A=;
        b=BwBf9BQ6usvirVKUFxJtvmBCs97sTpwNvtEvzOrZmvJn7Tfq1tAlpNBi28F8azDVL+
         aon0YT6NbJFeobpT8anvcYpy8PiwFedJ4MubDa7ZJIkB1fIvQfIvhrUOxHtOItY5fHQ8
         tLsLTB+BT4aCDnZSIG3fQA0HWam6VjpFUPON9R+0sK8+tP8LOa3NQ5G/+gU4VoFm+Sqh
         1ul2zVccRgPkVrlKQnHMOhawEpajQfi1ieoSLPB7E/X+7SEXVDL4I/6F7Ieb9YS2niYc
         rEoPUQobY8O1VE1GsjjL0/9NmUl2V6bvdIcBdm64kRfoz98+tJrkHx/Tyh/nMciwqnI7
         MeyA==
X-Forwarded-Encrypted: i=1; AJvYcCWTgOxta6BuzOUcgCpJj7jjWIwjlk60gjW2+c9DezV1os135T7Gy01GdZTvjaPXh2xE3ANABIOSHuZ5NV6kEspLnLuMUs4r
X-Gm-Message-State: AOJu0YwE7wdeANePfa4ZT3FS865uCGWPh0qIdFlx1F9+TeWwntT52OBI
	FUMDpot6mWjU7RDL20B+ZPeOXvYcqAxjO2C4CxBKu/mnV+gqFFW2VCc0leys60uObCosU3jezY/
	cavLQ+WZIki8tkAPQNEnq4D9FEA==
X-Google-Smtp-Source: AGHT+IFt/ODkK6Zz6XaDieQLKxcWgnHGrTVXxY/TNdU1FzuT0sBAnFjBsx3I9pMmlW4eO+SErUVCKS3lv13K755WN7M=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:566:5def:e0a7:b439])
 (user=pkaligineedi job=sendgmr) by 2002:a05:690c:f0a:b0:62c:ea0b:a44c with
 SMTP id 00721157ae682-666015f061emr960507b3.2.1721329351738; Thu, 18 Jul 2024
 12:02:31 -0700 (PDT)
Date: Thu, 18 Jul 2024 12:02:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240718190221.2219835-1-pkaligineedi@google.com>
Subject: [PATCH net] gve: Fix an edge case for TSO skb validity check
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
descriptors. gve_can_send_tso() performs this check. However,
the current code misses an edge case when a TSO skb has a large
frag that needs to be split into multiple descriptors, causing
the 10 descriptor limit per TSO-segment to be exceeded. This
change fixes the edge case.

Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 0b3cca3fc792..dc39dc481f21 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -866,22 +866,42 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
 	const int header_len = skb_tcp_all_headers(skb);
 	const int gso_size = shinfo->gso_size;
 	int cur_seg_num_bufs;
+	int last_frag_size;
 	int cur_seg_size;
 	int i;
 
 	cur_seg_size = skb_headlen(skb) - header_len;
+	last_frag_size = skb_headlen(skb);
 	cur_seg_num_bufs = cur_seg_size > 0;
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		if (cur_seg_size >= gso_size) {
 			cur_seg_size %= gso_size;
 			cur_seg_num_bufs = cur_seg_size > 0;
+
+			/* If the last buffer is split in the middle of a TSO
+			 * segment, then it will count as two descriptors.
+			 */
+			if (last_frag_size > GVE_TX_MAX_BUF_SIZE_DQO) {
+				int last_frag_remain = last_frag_size %
+					GVE_TX_MAX_BUF_SIZE_DQO;
+
+				/* If the last frag was evenly divisible by
+				 * GVE_TX_MAX_BUF_SIZE_DQO, then it will not be
+				 * split in the current segment.
+				 */
+				if (last_frag_remain &&
+				    cur_seg_size > last_frag_remain) {
+					cur_seg_num_bufs++;
+				}
+			}
 		}
 
 		if (unlikely(++cur_seg_num_bufs > max_bufs_per_seg))
 			return false;
 
-		cur_seg_size += skb_frag_size(&shinfo->frags[i]);
+		last_frag_size = skb_frag_size(&shinfo->frags[i]);
+		cur_seg_size += last_frag_size;
 	}
 
 	return true;
-- 
2.45.2.993.g49e7a77208-goog


