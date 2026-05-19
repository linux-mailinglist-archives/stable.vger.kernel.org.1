Return-Path: <stable+bounces-249696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FzSEZ3JDGrAlwUAu9opvQ
	(envelope-from <stable+bounces-249696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 22:35:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCED584C15
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 22:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55809304D9D4
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B43BCD15;
	Tue, 19 May 2026 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syds0zMU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F76369D67
	for <stable@vger.kernel.org>; Tue, 19 May 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222937; cv=none; b=fCWKkVvVokgcuRt3U4dSVIDdIeCwtLu2ouLtvI7glVYqpxWjtPUOkhKFWSq0BRjHW8NY3eV6xCZuQlT1XRKe8x6duXnY2mBlTyRgQBB7lCGNMsSIPW+lCwyeuquyoQveeeBmoqGLOcb7jLBrgS33HbDqbEyFEzwVCMIz/E3xfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222937; c=relaxed/simple;
	bh=5nJqDD/dXtl9IILNdZwN304brhy7+urj60vJWRhs4Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXNjbnUxe88PJFlXShqt5kObKizR3VnscO+kLPM6g9K4WmmQZvYS53nGOqNInF331INHODl1/P6CiAQo/XeY/RVbQQBnhLA0Eq18cbbbygn0Zc6iHk4h7IInkUeR7zwoGND6Ga+EHKDPsIYqFOaTtW1EiX1jR6YV7nJ6cTijYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syds0zMU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so33838155e9.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779222934; x=1779827734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2iG1hz81YAuxXAiaPdaZ3OGfdkiju2FjT0lpwqJRqQ=;
        b=Syds0zMUNLUQH1tYRXypJNoepH1zZksTSknTM4XtDa9kmqg87iNHufLDAJIy/a9xxx
         lsegPg/0b2LYqktvO6Unryvegju0ik3q49nvfnTwsUTEZMfqnbm0t5Kn+c/gTmvOAjfL
         A9OZ8cx8ykCfAIWwtCTzxAI9WJPTmWBhpOLn/D7yOeYB3wOC0y9p6at61my2c4PPkhXr
         kklHwscHjEu5G+eOLdRYUO7oJcJuivtJnh3sP3Ve+SYbMVGQ9TQQzeKssET+t2186nKN
         OfnOpTWHI0iy2RWpevHB4Ir5ra+MObQobOhb8tbTkWLrtCKdK3qDNgwZ6+PNDaTAar1K
         V1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222934; x=1779827734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2iG1hz81YAuxXAiaPdaZ3OGfdkiju2FjT0lpwqJRqQ=;
        b=UErzIEBUAcLuLHGYvNrBgkao9vMEZo2JmZJP/FcsXelHHXoMQTxHguPNFWTmYkW070
         0dGcQdroYeXujJLkdqMPlFv5hfyE3PXn8Suva40n4bq/vy8eSrP3KV5atlpXyU9zJ7ds
         PE+FdUpYA9gz06WVpL0CZz5/bc1/D1O61xrUg9L15lHF2LcRZrbM1dGVRjt3c43ybeYc
         7eFxssTE9HM2dIXSN9lTNxSrQHwTGKIJHQrULcPBuXdVjl6LdELXjZ3gj+KPjwP8sah3
         ESmVQc8rdDp5zM+p+Z4U17IKN7Y6OkUf4au+yBWHeffUHDW5a3bobPAvZXXNQpRvbqNI
         iPPA==
X-Gm-Message-State: AOJu0YztuLgDN8IAMvPPYm2RxQdPNrR4F1Ckg3hIqpbBYgSHoEAaOuHJ
	1GlKh8fRBH+Q7KqJZ6pYXu+619Ml/QMKs86ARuPiVqx9xNF+7ExXV0tO
X-Gm-Gg: Acq92OGEPWThyZ1tJAc2WAeO9na+adRE3PlhEPchC3SvZ3WGV74V4JuMt50UZ8PWJgd
	UnZsVt3c97n0DDNHLXI8vjMU4xpqaLo7zLAsoAsh8QQUbyBXbmSVnUXebA05VoC/LLwomfo2uQA
	/MiNjwZOPsdC699Mbus/hYQXDFAZdY1qvb6EwIifNG7K7GjlRqO+sMUwrNpa6YlMZX0+rLTs/Gn
	69cI7WEfN/YKCtAv8VcbIE6A2+6LEx0+mdAh8kiFiFDVb6a8QjfZ2dBTd85BkJ0bs3vDWBBQUdg
	xD6+MVZXfnClu9UsHo4+K5htmXRiTWOrIUwgGm7PPwiADZwH2+DqDQ4bmycRd750BAEenSWPCyj
	D2vouqfvP5ND6083RW4+n/LgMmKBUYU0CK9tjM2n6fn9BFxSvoUlTJaNQNbD25D86kHrO5S1zaP
	rtwjYU8U4qvU8PhcqywwMShTf2r983A1ZlJGnWckJEsjCZLFmBBgbJyKYT4taYZurST+Vy97LG9
	aDpt14CE44=
X-Received: by 2002:a05:600c:5298:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48fe60e51d1mr328374555e9.2.1779222934041;
        Tue, 19 May 2026 13:35:34 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm177738225e9.3.2026.05.19.13.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:35:33 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	sdf.kernel@gmail.com,
	kaiyuanz@google.com,
	almasrymina@google.com,
	bobbyeshleman@gmail.com,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2] net: devmem: reject dma-buf bind with non-page-aligned size or SG length
Date: Tue, 19 May 2026 21:35:30 +0100
Message-ID: <20260519203530.66310-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-249696-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DFCED584C15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
PAGE_SIZE multiples without checking:

  - tx_vec is sized dmabuf->size / PAGE_SIZE, and
    net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->size
    before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =
    N*PAGE_SIZE + r (1 <= r < PAGE_SIZE), sendmsg() at iov_base =
    N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.

  - owner->area.num_niovs = len / PAGE_SIZE while gen_pool_add_owner()
    covers the full byte len, so a non-page-multiple non-final sg
    desyncs num_niovs from the gen_pool region for every later sg, on
    both RX and TX.

dma-buf does not require page-aligned sizes, so the bind path has to
enforce what its own indexing assumes. Reject both with -EINVAL.

The size check is TX-only (only tx_vec is sized off dmabuf->size); the
SG-length check covers both directions.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v2:
  - Reframe commit message around the kernel-side OOB instead of
    "real exporters already page-align", which read as the OOB being
    unreachable and undercut Cc: stable (Stanislav Fomichev).
  - Hoist the SG-length check out of the if (TX) branch so it covers
    RX too; RX has the same num_niovs / gen_pool desync on a
    contract-violating exporter, just without an OOB. Keep the
    size-multiple check TX-only (Stanislav Fomichev).
  - Drop bool todevice; compare direction == DMA_TO_DEVICE inline to
    match the existing call site at the tx_vec[] assignment
    (Bobby Eshleman).

 net/core/devmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 468344739db2..4f71de44c0fb 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	if (direction == DMA_TO_DEVICE) {
+		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
+			goto err_unmap;
+		}
 		binding->tx_vec = kvmalloc_objs(struct net_iov *,
 						dmabuf->size / PAGE_SIZE);
 		if (!binding->tx_vec) {
@@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		size_t len = sg_dma_len(sg);
 		struct net_iov *niov;
 
+		if (!IS_ALIGNED(len, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
+			goto err_free_chunks;
+		}
+
 		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
 				     dev_to_node(&dev->dev));
 		if (!owner) {
-- 
2.53.0


