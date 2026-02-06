Return-Path: <stable+bounces-214588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I/qLTNfhWmfAgQAu9opvQ
	(envelope-from <stable+bounces-214588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 04:25:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3AFF9B84
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 04:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16AD5303CA73
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5732F766;
	Fri,  6 Feb 2026 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJfYJ2vE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041E30E827
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348072; cv=none; b=S+HDh0rnRyiJf1tJtrfaSW8UPfTDDB0dCWJgMyT+G7zM2Sw1m9W4VKenUUMPhp7NLf1TAo6kYSer5195YEx20ZccMdkWlwrDbKjTFTO6EWAw/KEgVWGM9xMmzED7FuNov/tQzKLbgcqqKSSOyz13CpZvfO33Hc6dlA0iPGkTKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348072; c=relaxed/simple;
	bh=+4JrAqDQmP9veLgwI7O2JrBeM/2llqAoqV6R4Fcs/Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hFZJq+ayMzqzeJ8kyvUvkkZJ0i4O+vbBDsIzlLMnVSOm1sdPG8EHeL0TYVgkWujFV4taOI8IFNK9n/CIO5tpBkHcysgMrDHq9w0Bdk3kX1ksRg+2ARXZIa4Rx3ONdG2Jw/sxt5wckngma8CG3Ed2Ah7KCyywiVP9Od+Fh3iCWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJfYJ2vE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88fca7bce90so19796766d6.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 19:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770348071; x=1770952871; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVj2UxZYs+OgmoKfmy83dBmS2UcHn5JNr1hYSfwf9oc=;
        b=cJfYJ2vEnQx5RyfDx3j5kqUkuII22spIXqqb/ptSBTRIhg2wtjPQEatD3ebzkvLvjC
         eDcBks7n8ciDGSRhpoBNoc81IJjh8UPo1uG0WGD+vO5PbOxzeZ7BCuzxk05GKJHqv7Mt
         Hv7yW4mcUGJc95nPb8D4fJx3dLA2Xz/P4DbZEbbRKGPNbxqtxiQgmrRaRZHBLDU9zMgE
         wt6V/ae13SApm+xdPpTZIH8RgU/tF4LvJcrD0mnB0GmbJ4SWPJaJA3LWycnmsKff0EdJ
         1iRDO8YTZGCBckvpyPbes3HQvkfXlUUPD1S70htqZUw5PzBGRFxl3Ud0of5yr7Pt5pbw
         TeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770348071; x=1770952871;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVj2UxZYs+OgmoKfmy83dBmS2UcHn5JNr1hYSfwf9oc=;
        b=r7eTpDh3j6ut4e+dQ30IeUQNXU+zPY1Qbsdm8IWZACIFgYdQ1vFKqZYT6EBxGyF3I8
         FAUob8sGofpNdU5ANmYkJZHLOE7I6jBZnZD9jmSBPzWma6CevEChpsvcfsOATQy8tXXx
         mdY5BsuFli4rmMQIzc6Wuv4UTkhwdVWAii7G5kyX4bLSQ99qbXb8Mvzmv9D0wAqrQn+w
         Gkvgm/lkgEzk/XwhXirfH6izdEbJnLQxoqrSl+9Tc6noxTwOE+OgwnLHPmfv/rLXkQiT
         KlaG7DpyWaq+gvwk+B1YMj34pVPdDOamCJSYC0NsvTJqRDxO93D6q5BJFH5j+JwFNbga
         VXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5rm0juLQRKNWAStt9E1QtatUWJS/tucCl0J87hipA7xYSikdmOyhfvkR/GOCwGLUbPyMSRhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJnivL/LLNTtWY4kl3YI32bZtWekuIaPLVcYCuH6/UaRpuVIg
	gi9FnubDy/WEPF7iarUd7VP+zrHkiGoJqOhwD8LG+ZzFkSJ0Z1Fgzngi
X-Gm-Gg: AZuq6aL4tpDNy7MgWV+49tPMzsYdwV0Gb8uE2b4p//rZDEETuxPjVXIEVxcl6EHoW2l
	Ju/UBhL/17GlVldTcI5ScODPjQRzAVlJaz2TsxnLZw26WRsCFyk06gVUX8kgxsHRwog+mwAAVUv
	R5HUBBO9VHNH8pjyhSW5H3RQj0v6kFb4YeNZ7S8S1neKD05b1XvkBPGyx1PZEW/Mq0fl3+eeMAz
	WT4ZQ841GOodCgBgraOoQwocMtHsL9H4bdUCDP7WbH2Z888K4bRqcywel2fneiO7t+/TXGvRbF5
	g39LU12an+oTZURzS2MBgxknKuvo+6TFShPMYiZ3y0OgIPmhLiqHWfw+0ahoQI53UPbdADT22kU
	+au4e5WQdgC0N92x9Jr7f0vIMLnbYf3xBHmTZ+Vq2lyKdoeDHiTf6mVt2SPm5FNn5WvblpFWM39
	PmP4vVOcoXCmdm+JQMit09fKuMLleZwIg=
X-Received: by 2002:a05:6214:414:b0:7e3:cc6e:3c89 with SMTP id 6a1803df08f44-8953cfa19d9mr20809166d6.56.1770348070960;
        Thu, 05 Feb 2026 19:21:10 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf56a69sm9414296d6.20.2026.02.05.19.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 19:21:10 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 06 Feb 2026 11:20:56 +0800
Subject: [PATCH net v2] net: ti: icssg-prueth: Add optional dependency on
 HSR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-icssg-dep-v2-1-9dae19b19e6d@gmail.com>
X-B4-Tracking: v=1; b=H4sIABdehWkC/22MywrDIBBFfyXMuhYffdCu8h8lCzWjGWg0aJCW4
 L9XXHd57j2cAzImwgzP4YCEhTLF0ECeBrCLDh4ZzY1BcnnjkitGNmfPZtyYebi7s9KgEAjN3xI
 6+vTWCwLuMLVxobzH9O39Ivr1J1UEE8xoq91VqoszavSrpvfZxhWmWusPZybSjKcAAAA=
X-Change-ID: 20260203-icssg-dep-b9f7fc2be11e
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Roger Quadros <rogerq@ti.com>, Mohan Reddy Putluru <pmohan@couthit.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214588-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,couthit.com,arndb.de,pengutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,lunn.ch:email,ti.com:email,arndb.de:email]
X-Rspamd-Queue-Id: 1C3AFF9B84
X-Rspamd-Action: no action

Commit 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame
forward offload") introduced support for offloading HSR frame forwarding,
which relies on functions such as is_hsr_master() provided by the HSR
module. Although HSR provides stubs for configurations with HSR
disabled, this driver still requires an optional dependency on HSR.
Otherwise, build failures will occur when icssg-prueth is built-in
while HSR is configured as a module.
  ld.lld: error: undefined symbol: is_hsr_master
  >>> referenced by icssg_prueth.c:710 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:710)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:681 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:681)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:1812 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:1812)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(prueth_netdevice_event) in archive vmlinux.a

  ld.lld: error: undefined symbol: hsr_get_port_ndev
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/etherneteth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:683 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:683)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced 1 more times

Fixes: 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame forward offload")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Mohan Reddy Putluru <pmohan@couthit.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v2:
- Switch to the optional dependency as recommended by Jakub.

- Link to v1: https://lore.kernel.org/r/20260203-icssg-dep-v1-1-bacaf5234fb3@gmail.com
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index fe5b2926d8ab060d83f5a58d91e749a45c6cea18..ade43c921c71daca930df5e890ca00b3ccf600c4 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on HSR if HSR
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.

---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260203-icssg-dep-b9f7fc2be11e

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


