Return-Path: <stable+bounces-202818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D3CC7B9A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81887300BBA4
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FC34DCE2;
	Wed, 17 Dec 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ0PqQuO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98D34DB6A
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975681; cv=none; b=IqHO0/tDG229JXb3A4NOfSThRfCk6jnkf6z1E8/ySzoYCvFQ8oi73Oo88ypTc7LZedQoDjSY2tWq0pMzg0mXj2q6Fshi3Is6e1im3pOUNX3SKYunuRGnV5fIPqpJR+SPBNZPZQvYm9dUnX7ObLBhZ5Jy5+71MnvoSiE7WHBgjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975681; c=relaxed/simple;
	bh=CloEhhB+uejblLuhuXn8n5zkfy2FIPc3okx6zsJmi1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rp/gVqr3IaE45obIYjalc3TKVZCmOK1NzyGqZHo0b5UsMkVQt87Ouzu2Uf0hEGGNYIERLY/GT3XzR8AIIeP6tTIgAUjt+TjZtinCNeFUXkVCj8KF8jmuCQM20Z/vt/oBDZ+++ukhNMaX8rQH+YHcO1VWMB3e+xrPaYEFh76OV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ0PqQuO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0f3d2e503so5844445ad.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765975679; x=1766580479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdG/M5hQwjEekQuQim1OPFLT3tKylIxu+drVZWp4rT8=;
        b=SJ0PqQuOT8SqXAGLb9+o/DM6zUMldgQqK8bCYMo81spEUwNHXWAy8D6qTjwNtVWmqj
         cw+Y4GKOxZb1vf06pfAG1GxUhj2co9p5cyG8X+NCr5YEtE99KVKPKzv/qO/6zHpeS/wG
         aGogedoWZ4g8HvboRop60nSZxClakXLAlQOWR5WiXpqgozGM+OYFTjcyoda07s98S/7U
         3teP6soWWe+HBIXBIiPaduK70tgqWVqRDNR0UtMUSMKDPVqxJ4PLbTFxymN/HVOZPu9A
         Q7e6s41f+F52HExeyYgtBlZ/IaxHJtNfNlZI8r3u40kuhi7MrgHCaYuls6g34F2zr1jP
         Jh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765975679; x=1766580479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdG/M5hQwjEekQuQim1OPFLT3tKylIxu+drVZWp4rT8=;
        b=YNcuAJ+Wx5ihgA7qijqg6a5blKCadR5NmlSAcnIaUb4j/wv+u/2IIzAA0TmD3a44dc
         0OgF3qZLTuGaqTgMNb2QL8QAKhY0jOqRzBBtCi0TFDEa3e8xsCIQ2ZiwOoDClkDatZ87
         OoT5m5DdKm1oopPZQw8TxqnS7S7lMvL9bG0avIac8I/sqVwYtFaKl+y98eMBjSKhqfzU
         BzdzWS1Qiw4GoLa71pA+whNRwLD0j8dISjZNWfeueB+Cnp7HaYUPMLiIaiocogLYBKys
         e4uzS4UjOSzpClcTUVjx0I3Y9vPjAZoTD1mRDSWQbc11QjETaQG5J1naIhH7jpe2VXS+
         /jYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCbqCgnV6cyt4xu/umBQwfjaElPRD//zksjT1wIw0e/SwXSE/5spgD3urunE3ISwXCGVwUHQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBAukg9ulBgSvuHwdGqf4TiLEZL2DJSO66+Jx4ABk7ZmtQ9XT
	VxFGJX6uAEjeeE7enGkL/MO0whtN9CcbI1Dj1N4YgW7Aid0u/OT72PRx
X-Gm-Gg: AY/fxX5HwwlbBNQX4ZjMSJDjEMwPbuaty+3z5c/hDV3M39sgod3e4PSxgxdtrfvh4Px
	WDA6hx+jHjPr96w8/F4wxACXWQXt4ziqIiOZqK0U5b8ch/huRewbJvykYmTQD6G70ObmMOY0sCI
	dtjVAXUPCl0xPBRjdlC5ooYXfv2hVztQMkmcoYl8Zyx5VCa4e1SAWXAwqMonQJLRG1oldH5lcq2
	D/NE7filSvPQyAPqrBa7rzOsjZqv8Zg/wf6cX+trvsve/sX9VW6gT2+k/iYrpdnFGTsdwEk0YfX
	+kYl1PA6KFd9N2E6pD/ljAp7tthifJrfvT0MAtuMc6zj0TLzif7/b+Zv9RQnidZbfvjpa63wpo4
	5EHwKswPoUyAF7FwhYuNck5+1S2FmyvKWLndkSS8/4O8ZZCnd/tO8GP70jLEFjpZcOmODfRAY/8
	4tfLMqWzdtMmFJM8H3Ybz18i9bjjcLb8FjRGRrQI6zZHQXc22mwy1uw+xnYT8/tbTMHQaWGsPH
X-Google-Smtp-Source: AGHT+IGAXhwbqTK5yKjjJjEQNH9nBsZ0/MaiWTq2DcL4eJq8GaPME1nJ9eOJPHG9ddGopCMjl+fKkQ==
X-Received: by 2002:a17:902:d48b:b0:295:70b1:edd6 with SMTP id d9443c01a7336-29f23b36299mr135474865ad.3.1765975679523;
        Wed, 17 Dec 2025 04:47:59 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0e96df1c9sm98306795ad.39.2025.12.17.04.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:47:59 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: linux-nfc@lists.01.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 2/2] nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()
Date: Wed, 17 Dec 2025 21:46:59 +0900
Message-Id: <20251217124659.19274-3-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217124659.19274-1-pioooooooooip@gmail.com>
References: <20251217124659.19274-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_hdlc(), the LLCP_CLOSED branch releases the socket lock and
drops the reference, but the function continues to operate on llcp_sock/sk and
later runs release_sock() and nfc_llcp_sock_put() again on the common exit path.

Return immediately after the CLOSED cleanup to avoid refcount/lock imbalance and
to avoid using the socket after dropping the reference.

Fixes: d646960f7986fefb460a2b062d5ccc8ccfeacc3a ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index ed37604ed..f6c1d79f9 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1089,6 +1089,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
-- 
2.34.1


