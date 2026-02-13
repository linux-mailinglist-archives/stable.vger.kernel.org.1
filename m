Return-Path: <stable+bounces-216277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJx7BX9Xj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:55:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C311386AB
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02167300BB96
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136C34FF41;
	Fri, 13 Feb 2026 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCdtsMkt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60406299A87
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001724; cv=none; b=bN8M+xJPCU6k2ohJBsNceBBopBl/mEWDQ6OACdRp6oI7mlG3TvS9OvbTDATvgD6SVgN9RQ11kz+MHZI3q7rNKjh3BeEBSyPZtKB8z/TxVowVMtIUIZ7lD3U/LNCHbrEcz4qxGixw3B9YgEGlwuXB3eXuqjCLVmufqWyeT6NfbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001724; c=relaxed/simple;
	bh=RD0u0t5zLEK6pLa3+Sqhn6/3CXcPdDtMjzVXUFAB/+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwBEM/70LQr4xFI1tA+vSy1oDKTS3YrUTrT3t/HEfnLUYs4OKagB2kZlYuWV57JG6gfv8RIv04dHM5CMN9/0GX6E2RGr6C1XzTlNJnDptSYYIwUE5Jiy5fhqu0E8Ub6axwjC3JHro0li9C+DPyK0JfBN0Onm5wxoREJjq86XBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCdtsMkt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43768aa6ab2so94543f8f.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771001722; x=1771606522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ptauGZZMWrMiDu6t9/L2OG0QlvSuTICYS6yevNbRDk=;
        b=aCdtsMktH4bwzf5FmL9w24nAGB2+Wwf3iPBV7MgFUWcf7Qv7CvwpEArVLGCHYVYpi4
         TpQJrINBlfgAlIgzY/jJM/mnCxpFdKJUJKPeOdXZUCNRaim7n6UcOkOhzicTYrstyBAp
         ZBe4vfCk5GzaE64bnLuJk6z2dBTMUH2IaRN0j8r9gT6e7qC4EdWjdh+rlttSqjMhsXSX
         OEF/bAnFDdPC3xyaK6REnQj4QEBsXE9hIi0H25urPUw7KnVLgsld6r/e1lofi5Ztsauz
         xWkHuBbwc4LZLr1+YUpx8KXFdMtI7HCTdLyJcxEd3ili6hzMdBCPRY0TeW7T+XMl7dbv
         JKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771001722; x=1771606522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ptauGZZMWrMiDu6t9/L2OG0QlvSuTICYS6yevNbRDk=;
        b=iXs7qNjBlx03cDY1xEJBb317+5oLZQFoQ+pARPumsjRSw3MD2cV5Chtp4UW9yC2/Wf
         gAJEOlGBvs3EN1Ot/QN/gJEEPe1Ys1xqfic3wmQHLoCorlPQney7F2z4gkz/v547vwMK
         vtaDMp6R5wr8XrlP1WNdU3Lv0whtxce2kFMRYIFqlEZgw2GHjIyPf/5ll3zziqU8Jur+
         85uS4Q9tGMSJwupxr5/uZ/uRctH3lMrzDhDA7jw260YmfF5PkcTDydY7rIhphObsT/eS
         l2CzNCWQpfcHuWxuSCVg8pRQMSQtTthinDtAFpm5UDOe8NJO6NNTKShbwAQihhI6iu3b
         NgBA==
X-Forwarded-Encrypted: i=1; AJvYcCWfwJHDdCgHrfYmTdj8icfkzoARMH2vlevASBtX2dObwfnT1HKApyII3uxW5krrtatiVn1/OKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eABdFSd/6x582I5TgdrGe+kjh6nNrgVIAu30+Q5zoegAfXKD
	xpTEM/srKRrcL1tkSNl8Kqczn111X+LsP5KZ9PvBxHhAHvJ/Lug7QR+f
X-Gm-Gg: AZuq6aKKgrqzKZw6v0ZiLbSjYdk5dhFapOXjcT2WqbMgbX7vwQ5gz+x8y9C7ylxWAjh
	YtdLcT+ekPSBdiJf/3PQbU/vzUEw+pCoUFdUMgKFLAf2qXHUdO2ebXOm3wJiWOGENlp1SyIPtSE
	7iJcDevHuN0IRaZQ5g9mJqzR3rdOJlpE/MTg5e7OyI6RMxg77BaZL9pNjq7JnsKTM1nRUVRYpxm
	9xkdsHeHZt+NK3QSjYVLTtCmKWRec+STRjkaiDMN93pCTv92f5PbaZg169OBJeiaDhMVQIyMw82
	faL0GYhwzflsaFilxd1MT4eYgld8vDtvybQF+uA4OMSzbGC/4TfRucdUVRspyZVNUoXoii9frCu
	oJPbkuImcrhzxk7+aqrxfY7NSf7LjGu8BghSvamFLggEKBSBr4npjCe3WRs3bII9riKbWOpp5g9
	siHhnQ0rhn7e36z015dNkNAyZVDSu4vwx2tj0AtmfYYskjVYYj87m3nFjgsbVmW1ayNkxRoOgTT
	bdSu1dAGyuUIHWxwA+N
X-Received: by 2002:a05:600c:8b2e:b0:477:a478:3f94 with SMTP id 5b1f17b1804b1-4837105119cmr29305325e9.5.1771001721721;
        Fri, 13 Feb 2026 08:55:21 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-204.paris.inria.fr. [128.93.82.204])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48371a298ebsm24537975e9.13.2026.02.13.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:55:21 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Dariusz Marcinkiewicz <reksio@newterm.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle
Date: Fri, 13 Feb 2026 17:43:39 +0100
Message-ID: <20260213164340.77272-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-216277-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,newterm.pl,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4C311386AB
X-Rspamd-Action: no action

dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
the dma handle. This would lead to improper unmapping of the buffer.

Change the dma handle to priv->rx_buf.alloc_phys.

Fixes: 6af55ff52b02 ("Driver for Beckhoff CX5020 EtherCAT master module.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/ec_bhf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index 67275aa4f65b..0c86cbb0313c 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -423,7 +423,7 @@ static int ec_bhf_open(struct net_device *net_dev)
 
 error_rx_free:
 	dma_free_coherent(dev, priv->rx_buf.alloc_len, priv->rx_buf.alloc,
-			  priv->rx_buf.alloc_len);
+			  priv->rx_buf.alloc_phys);
 out:
 	return err;
 }
-- 
2.43.0


