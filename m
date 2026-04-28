Return-Path: <stable+bounces-241468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CK4AtIk8GnvOwEAu9opvQ
	(envelope-from <stable+bounces-241468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 05:09:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F8447D03D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 05:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006053019F04
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBA3195E4;
	Tue, 28 Apr 2026 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/USccQc"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9013148DA
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345728; cv=none; b=aCIPUTZwF8U2Th5Eo7jtKb7CZ5p9r7dSorsAxrMcpkwB2RZAjSsoLsmB9zv2wwX9MD+EPfEtPAh4Oqx1j9skoWsRvLm7QHD8O3hed2b/q4q8TaMLiI4LHWxntR64a6d5sj8NKG1/YTKEq1vq14yk2L7n7ZIM3BwRAZJHH3Qvvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345728; c=relaxed/simple;
	bh=58/SxyygshXwr02hHK/RwB8HspCENne0hR9jOMX8ceE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeXzNKKNNrbKV4HkBv0G1/tjQBF9YEMokRuyjwIOHU2j+032j9dtVDrNPwAez7UygGFVpc3q+2WRLtseT+rMKq0bbvSRIGQ2IpKnnt7kRipH7JV+1UafpgqJ3aKV7TlMzMrOw6pqe5dG+4GcgepJIk5mVXt5jqdKc/XjfXA2CaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/USccQc; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12c6df0b9bbso2019893c88.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777345726; x=1777950526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFKsY0zkP8TQm+0BNdc4CTwtYvq4U2UiY8lkQgxP8es=;
        b=m/USccQcC4ufknC1/lT1zZSAVOA4i8qOS4W6Lw2pxfE9fro4Df9tjs7UUsoWmmJRB0
         becUZqlg3UT9EgoTmAcXOMd/7KSLJQmAX/mvKk8Da7CAb6zGNGAkB5JsBHsFhSl/KeZs
         a3iZ4K/8fzK6nKRisdL4v9ZDXHDrOhuzwX145EEV0mFpTlearp0S9D+lmOO7D4683h7h
         tMQ6MNtOmx73ABXpcFuFi6UAdeaTXTGuOS65iYj7Vp2Gpy+2vgrssfGBLCNzXC0jhVrz
         yneeVnIZL9B3w10jBrtAiybqzJZa9iHcsRTXoOmssQ9F1790c3lfUcSj4u0Mhb1unPNw
         op+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777345726; x=1777950526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFKsY0zkP8TQm+0BNdc4CTwtYvq4U2UiY8lkQgxP8es=;
        b=Xb4ToZ+mFptnyMjQHnk+ACpdGfAQI8mcoFYNFxWSov9dgUhKh/KDWb28LqRgbFB1kt
         zV9WN1V+3rUSCsmoF095RKNT7Km4mB4mEWT+xnw3aIfwN+oMwtwCmo/FWPTieXc/YGci
         R1r4JfzYpSAcgDeNFiS4HkMKzMVBFKDMNm207uz8EOUVWQ1Mip0XwWA0ueVudptbXz7y
         gj12pJk8x+DQSjegvyMt+UoHMt5YQ+sY9dBB6Kd7MXtQkf/aSQx361Ob//9XDWUJsoz5
         A5aQu2I53gtaXJDyECu1ECNxs5hDNfZX3UwJVRpda60lCUN8HK2ZhVmyyzXhqV6S+3i5
         O77Q==
X-Forwarded-Encrypted: i=1; AFNElJ8pjwYHCFDDj+xjYDpzCKnqLRlyota26XPei9gI17rDKZTGHQqaqrCtIt+CbOMLHyAS2NuFVoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9LlYE3JTjN8R8rC/f9VkigQf/d3D4bB2+RKd7sUVzYM2ri7J
	m/BJvUniLDhyd0ptFwBXUt8XizYzdjhqCz0w9w8aCOeV46wNlJaBUnHE
X-Gm-Gg: AeBDieuUZuWca6lrIq1/Dob5Kh3uKk0WRr31DWXAhznubY90h/0jdaiUMDsC+6SKacp
	lApmIjnYC43aGN2bujJkWCO5SPwkAHZ2sJM7pkPRyMkMi5cxZzWgM4ZGjLpOTxahFluRLDNwnek
	FRgc1u2gm1nLUAuOVjmwhW1xlP3gDcwEO5qeKiuizcujaRBLqZRmC3V8NF27c5IncGElrlD3Pms
	yu8TRpoXABI98G3yjo4d8/vfW/G9xY1ZH/t2zD0XpjFjfAIW+3gFsjTY6vjZI78KfB/U89+h+zE
	0E1fwYatQSx8FqSJYs+OR0QMPeB14J8pP2A0zfQ197ajyeuEu05qcNdkVbc5fnvhC86gQB29oKL
	yUu5G7jxKgnsmWFlLZT5ofQsXSSRA4FCnf8GWgwgfey8eQhTOs8HlgcoBIwCiQECoyigblI/ox0
	GwcqMGvL8wy7pvWkFzdaJp0Im8C2zd8y9FRoHxtyqDIhDjknqBMWA5tNG60QXwqB0eB0KLqNR/+
	iRWC/iWoyldnZFAKegxDy+pHH1/LR44IYvekwHDGlcEvMqfDQ/DwY9+ny2jyhbsP+zT8kuW9C4r
	tO9JlHJFzfb5u87ZOqbhbO+QQGYp
X-Received: by 2002:a05:7022:f94:b0:12d:c9b6:bbba with SMTP id a92af1059eb24-12ddd984193mr789914c88.8.1777345725911;
        Mon, 27 Apr 2026 20:08:45 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd8951edsm1256362c88.0.2026.04.27.20.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:08:45 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Yibo Dong <dong100@mucse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH v2] net: ethernet: rnpgbe: mark nonfunctional incomplete driver as BROKEN
Date: Mon, 27 Apr 2026 20:08:25 -0700
Message-ID: <20260428030826.47509-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9F8447D03D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,mucse.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241468-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The rnpgbe driver as currently shipped in the kernel is incomplete and
has no useful functionality. It will bind to a PCI device and create a
network device, but that device does not function (its .ndo_start_xmit
callback, rnpgbe_xmit_frame, just drops all packets). This situation
means that users could enable this driver and have it load and attach
to their device but not transfer any data. To remove the potential for
user confusion, mark the driver as broken until it is completed and
explain why this was done.

Fixes: ee61c10cd482 ("net: rnpgbe: Add build support for rnpgbe")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1: Do not mark vendor section as BROKEN
 drivers/net/ethernet/mucse/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 0b3e853d625f..810fc1230d97 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -16,12 +16,14 @@ config NET_VENDOR_MUCSE
 
 if NET_VENDOR_MUCSE
 
+# This driver is marked as broken because it is incomplete; this avoids users
+# enabling it and expecting it to work.
 config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
-	depends on PCI
+	depends on PCI && BROKEN
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
-	  adapters.
+	  adapters. It is incomplete and currently has no useful functionality.
 
 	  More specific information on configuring the driver is in
 	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
-- 
2.43.0


