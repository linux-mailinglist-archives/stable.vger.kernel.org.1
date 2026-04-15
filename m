Return-Path: <stable+bounces-238186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOZFLsTb32muZgAAu9opvQ
	(envelope-from <stable+bounces-238186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:41:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6C407273
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52CC930C98E9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFB2383C76;
	Wed, 15 Apr 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgfbSy/N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC56317160
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278445; cv=none; b=PEQPJsUAScG3WmexM5BhgxAPwJJ7uZeb8AEIuUdj+pW+5jYJfY1rEcmiwytk4J4XilbygUvRUcSe0d3yPyPSynljf+reLebBgLeGvcQ5OHGeetYCUIFpXnEdI2m8M1853v9CJsXDNt0Yi11cAL9wWbubEBYTGVocSIBBA2tjFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278445; c=relaxed/simple;
	bh=QTClQs6mmg0+2IOvek0wnn6CLbm5OoS03YkOeSOb5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGzzHrdmgIWtpScEJsX/dh13Wr/By0xLzviYklW5fltG9+GqPf2FlJZIJtevBzJAAVSM9hMiBTg+/2Xfm8P48q0elupLyNsggj+g+y9z8CoGgo54+FqShyXkWtrACLVVhrUcYEl2R0RtRZRDdEfDv+2Z3KKhU2PIoSj31/+2adM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgfbSy/N; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b23fcf90b2so67654525ad.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278443; x=1776883243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QuK475K92RErA2NVtS79BUBslHILtmYa6Vn0sllo80U=;
        b=VgfbSy/N14OjPL7MYzhlnX/7++SZ7c3zbRvb+D1n2vysOJ9UjlPBswCNXyFmr+QzmC
         L1XDwQJTanqkGs0Jivjmmi7vhqDIH4m77df630eghFmZXlNqRtwCiyECHGqPLMRPb4Bx
         d5hRwYA30xcnGaKZ5YiS6EX6sdeVT3b6MSnaT4ZqQaseQaAjelinu/OKjxIG5ow5Y7W6
         yVN84FhLbiVGQQqQxVdml7qDuEV5Tv0b8bmBz+pMRSjqcJAwVuau6CK2zlRBei6uc341
         1IgwZGBR4+4/O+Kn3F5hV2kv9sYg7zE3n6S+Wpvh73Wpp6MBTXVmr/gUXiyV39LsUX+r
         abSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278443; x=1776883243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuK475K92RErA2NVtS79BUBslHILtmYa6Vn0sllo80U=;
        b=iPuoMKvWlrQfAjslHfdiUrFT0kz1OJrmGWp4a6dw8r6aTe9KiWeRcZTTzL0bHpY7Fi
         3DffJRBz4PvU6SPusyZMuavkB4rn9ruDNiLnTVYcd0UV5IM8PuUKcQ11fFOX1DiYN6Zo
         Q/W87oN7m8drVV6IgRxa2/Q+qqPqEgkoX3fIschbTRn7L4p3tOk2PEtUvSsPJ+D/+lNi
         k514XqVkrTAgloG0kY4ju/gmj86uUTdCoA5TxLpGtIVInq6LdiPUm38nRS1jEvSbsF5y
         xhaTEUsd3sgluGv4uoqwlYLULE+LpMQ9x/GBxJZDt4I+TXBei2LWrU9pUVuwdNJNY+9Y
         cmuQ==
X-Gm-Message-State: AOJu0YwOUTuyOOewHCIcCkwHhU58DJu9zBHdR4TbvRMJ2wlOkbe00hNG
	TAYxLTvYg27e8tHfJS3kmsbhHolWspIxWPezIAtR27QNJaTV/ekNd8LV
X-Gm-Gg: AeBDietOa4CDF662L9c5TosVUZA7Om8K5YMekTSFnjoMhYHAnGoruF4fWKhbiJIE/Tr
	g1QZlkzeLrZu0ia5/gANwjwK77svaHZR0VlQct5tvQAB51tbpCuaeQY0SySaVB1kYEUBm0nTCoR
	JTPkQs/Leue6KS9escGU1/4Ppylgsuh/sdZbGoscNxfxzngzMtyEh34sZ0pFiKYLYFVhoLvF/Ow
	dZgfd16Dbwt8ySM+XHz55YSKbudeADq2psXZzzfqJjLjoN4Bqi3cxTwUoPr/+0huSivCyqwh+uA
	MILbsXuQnAiUIlyrfjB2chyrHsxiV4Zt2qr7xChllv29EaFso3GDZKsw+8dY39oxwj8WtjgnPYZ
	edJyY7DmBfVUtpeFtca3GWPInLZbjBX8TmHnP9RRvKshDH5/J7Ar9NSOUMqsIVTbGMSH4PwUX+s
	InfUL8r7yyy6HeA20/FiH/3MxNpvN2Oq0O0oc=
X-Received: by 2002:a17:903:985:b0:2b0:ac1e:973a with SMTP id d9443c01a7336-2b2d5a64770mr229004475ad.39.1776278443284;
        Wed, 15 Apr 2026 11:40:43 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef736sm38289825ad.8.2026.04.15.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:40:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Paul B Schroeder <pschroeder@uplogix.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_exar_st16c554: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:40:31 +0800
Message-ID: <20260415184032.3776292-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238186-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,uplogix.com,osdl.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 59C6C407273
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in exar_init(), the embedded
struct device in exar_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  exar_init()
    -> platform_device_register(&exar_device)
       -> device_initialize(&exar_device.dev)
       -> setup_pdev_dma_masks(&exar_device)
       -> platform_device_add(&exar_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: e0980dafa329d ("[PATCH] Exar quad port serial")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_exar_st16c554.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar_st16c554.c b/drivers/tty/serial/8250/8250_exar_st16c554.c
index 933811ebfaac..b2c37f0c52aa 100644
--- a/drivers/tty/serial/8250/8250_exar_st16c554.c
+++ b/drivers/tty/serial/8250/8250_exar_st16c554.c
@@ -30,7 +30,13 @@ static struct platform_device exar_device = {
 
 static int __init exar_init(void)
 {
-	return platform_device_register(&exar_device);
+	int ret;
+
+	ret = platform_device_register(&exar_device);
+	if (ret)
+		platform_device_put(&exar_device);
+
+	return ret;
 }
 
 module_init(exar_init);
-- 
2.43.0


