Return-Path: <stable+bounces-76511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45697A644
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AA0B22479
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF3158870;
	Mon, 16 Sep 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="igTNmv0e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tW/54+4Y"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCE3BBE3;
	Mon, 16 Sep 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505611; cv=none; b=k1HfUaOzPDCrrt+ur3K7iwhPRVW5QtSz/6eup1k3n+YSZ6UfxyHAe2SmN1Fpi7MwBWuhchjQ8oG2tsrEMZw6ynDEHohg3ljoZX4NsyAR1isLvF/eJVyIyVBnWQ+HqPj0joOEzUF5ng9WD25sQyzUYlCdryHBqsd2R3rtIgJNFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505611; c=relaxed/simple;
	bh=nTnSmO9VlvKKC0VIvRYqcVsu/5jJUIWC8KVuxznwDCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tXgQQ66+3z4NPwRaR4DQubo1wzuPaYTVSv5Dy2GbDBdg3HTuycBf2K/x2Mpc7S7gPzL23L6///2uao8W8pOGn6Xh1umk4/JpeNTMXfxf5iq5g2S+5uQt+DFGtsZ+N8hfGNay9HZ9G0KfFtDcJrwX//CfwsaKGGgNUo0SEggqE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=igTNmv0e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tW/54+4Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726505607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DP9L8R9dfjl9npOnRUoByPj1u4QRso5d4fxqPmGEEkk=;
	b=igTNmv0e5J+V0Urs6oleGqIiLugtfhk3vmo0ox9LxyEBefKn+TTqaq8Ei3rwUe/Pt9Kvju
	B1trXN8tXCbzZOcaO76wBmgmn2KZrr7Slhv+kRiivvC++xZcN88iQC7DZbhmBScdZOmxDP
	rxFeg+ssf0LyW9v3365j8aEK1A1KQiy4TfGNz5I7FnS2shWk4BMffgokPJS6imAXfVnUv3
	ECXwEP++XlTc1Rvjs/psqjVKWqs+ki1R3Vcrn0EyNxeAHqKOJJNcI6QaLJTt6Y6tnWyi/M
	WTpt0l+EVnGgFrVA6L0IKGvxQFKg62GPIvjiXToCN15cU0UYriXG+w/dKB1Wdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726505607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DP9L8R9dfjl9npOnRUoByPj1u4QRso5d4fxqPmGEEkk=;
	b=tW/54+4Ylm1CO10q4FXbIOS1nPnDLqhXSVSd4Gud/LeTzKLkPswsjgy7hRdoIC1G47bCBI
	CkjRS49eT+93q/Ag==
Date: Mon, 16 Sep 2024 18:53:15 +0200
Subject: [PATCH net] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHti6GYC/x3M0QqDIBQA0F+J+5yQbtnqV2JI2LUuyJ2oc4Po3
 5Mez8s5IGEkTDA1B0QslOjDFbJtwO4LbyhorQbVqWc3Si0oFG1i8Mb/8pcZvVhTNnaxOwqlei3
 H4eUevYM6hIiO/vc+A2OG93lerT2mbnIAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726505604; l=1022;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=nTnSmO9VlvKKC0VIvRYqcVsu/5jJUIWC8KVuxznwDCk=;
 b=QHzjF8bsEuc/pKcyoCxlrEioNIvSPRAMHfoMNIu+/4FgawtpdEDmLmozxtMwcq78t1Op+u5Eb
 7yohygmRL62BYHH/eUR0JYXzNY6lZmqcrOeQI5N2Lu2cJ+s2YupLQa3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The rpl sr tunnel code contains calls to dst_cache_*() which are
only present when the dst cache is built.
Select DST_CACHE to build the dst cache, similar to other kconfig
options in the same file.

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Cc: stable@vger.kernel.org
---
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 net/ipv6/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 08d4b7132d4c..1c9c686d9522 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -323,6 +323,7 @@ config IPV6_RPL_LWTUNNEL
 	bool "IPv6: RPL Source Routing Header support"
 	depends on IPV6
 	select LWTUNNEL
+	select DST_CACHE
 	help
 	  Support for RFC6554 RPL Source Routing Header using the lightweight
 	  tunnels mechanism.

---
base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
change-id: 20240916-ipv6_rpl_lwtunnel-dst_cache-22561978f35f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


