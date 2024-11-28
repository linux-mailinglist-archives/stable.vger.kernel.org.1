Return-Path: <stable+bounces-95753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD89DBC31
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 19:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A316439E
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA81C1F33;
	Thu, 28 Nov 2024 18:35:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D41C1AD1;
	Thu, 28 Nov 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818932; cv=none; b=Pw3nVIRdDZU0E44DAykzuJGqsad4KRiRwO9CUCKSzqvWieDBSUtxiJdbhBr0019Soxi2Kmbvftqhyi78q3uCAhlbnzL2dH3JDCjoikhNMChwgWhhK+zEu0/1kJYXwRyo14GTu9k/E+YXR0IzcKPhn1OekYCnYI5GWiPCD/xmyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818932; c=relaxed/simple;
	bh=iK5M1/Niyt4Poh1Y/a5sp7IifwhDqAK7SOasFu30Oio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thexddXWDoT0vhk1avwSb/o1ay0QtSWSItuf1vmdAB6usCJIDxURdn8teUVsWPS12/29OiN6wWYhVPUB/G4KWCs+3bGt3Ja+nw+0JXzD+t5z7aLANniTlUuo3nOJNm3RgNdPhpiPcqouOB6HpqZGfeLhx97yK45SWNYd0TeqcUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Nov
 2024 21:35:26 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 28 Nov
 2024 21:35:26 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Boris Pismenny
	<borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.4/5.10/5.15 1/1] net/tls: tls_is_tx_ready() checked list_entry
Date: Thu, 28 Nov 2024 10:35:09 -0800
Message-ID: <20241128183509.23236-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128183509.23236-1-n.zhandarovich@fintech.ru>
References: <20241128183509.23236-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Pietro Borrello <borrello@diag.uniroma1.it>

[ Upstream commit ffe2a22562444720b05bdfeb999c03e810d84cbb ]

tls_is_tx_ready() checks that list_first_entry() does not return NULL.
This condition can never happen. For empty lists, list_first_entry()
returns the list_entry() of the head, which is a type confusion.
Use list_first_entry_or_null() which returns NULL in case of empty
lists.

Fixes: a42055e ("net/tls: Add support for async encryption of records for performance")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
Link: https://lore.kernel.org/r/20230128-list-entry-null-check-tls-v1-1-525bbfe6f0d0@diag.uniroma1.it
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Nikita: since tls_is_tx_ready() exists only as is_tx_ready() in
include/net/tls.h, fix the issue there instead.]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 include/net/tls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 7f220e03ebb2..e6836a5dfb6e 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -427,7 +427,7 @@ static inline bool is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
 
-	rec = list_first_entry(&ctx->tx_list, struct tls_rec, list);
+	rec = list_first_entry_or_null(&ctx->tx_list, struct tls_rec, list);
 	if (!rec)
 		return false;
 
-- 
2.25.1


