Return-Path: <stable+bounces-213207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPC+DMrtgWkFMAMAu9opvQ
	(envelope-from <stable+bounces-213207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:44:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC0D936C
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 430D5303E391
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB613451BB;
	Tue,  3 Feb 2026 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeez7ONV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1837342CBD
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122615; cv=none; b=l9ilt4my4d/azVisdJ+cs3tv6DyOq+93bG6kSlnxJ2o1DdazzxjEQ70CpSTCNO2bxR+tv1Iz9ThCCaWXORRCPbUR5dL0nZDYH6U4PR3Dt709OQ6f6336BbZQwJLmAEFD3+NYw6cY/DSxen1EFnD2mno6+dffbfWyyx6AxvuZ/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122615; c=relaxed/simple;
	bh=WBJJb48LvNCLB7eCJx4qgCbJuGlWDejCj8VJq/6cvn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YAHSnw8Qxy+wss9E0rF2o29nEcFUVhHKs05TiMgcwjmL7EEGXsmFPRW8Jorp/WwlIgCk8dNK8/uZM4llenx4WPIX5J7ElNQd+kzqNgbs/u2m2Og/SH8u0F+Xi2XHAoq+mHInb8WTxER4s3O57piccWwxCohbHP23+JKdAZKhSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeez7ONV; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89461ccc46eso98318096d6.2
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770122613; x=1770727413; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7TZeF/N6S3YuCMvZLz08GHYLrlP/fgxIlS8hkF8ABw=;
        b=eeez7ONVYl9c2/NukjBvLCMLM5WKEchJ/7DjA8HalN56S3UDgcBQCO+ecrdMWrrkBO
         +kGDSmrKayQhIL5UPz8epQKk5nbhoGarvKXpWVJZ1piQ65im1CxE0eO+Eko59C0bXzij
         HohPYo0g7+VVaPpIiUdepDJhqG3mTwfibiGTzY+W1fv/sr5RfI8qOUgaCIhW1DOU+d4S
         41nWR0Co0M+ANepxZCughXdcVm45YcQIQ50GjK8Ny8TYF7Y/I+DrheJGvyUSGSjmeo5/
         Xcz1boQcRzIex1LJtH30x/ko46+8dWnWe5QFakAB+hlJWqToFU27F/0b/LBIiyptw6m1
         E4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122613; x=1770727413;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7TZeF/N6S3YuCMvZLz08GHYLrlP/fgxIlS8hkF8ABw=;
        b=Q692Q3lDE6ZzE/LrbOtMtv7lAkpyrLLGEMJcfYcOe5rxOGeRDiK+kLTHt4C9uG19FT
         2mjiXsujiWvVKAFQjkr/cG/RzFhB+GXPIRoFRds/RkUXi1AzVScKFx7MegkxTJto11u7
         ikYiPaADOwWS1KUrv6SHApjq83nCLg+kS+AlxkKc73TSyCdrlttOqZ4vvFIUUaZxwhul
         WYkluSYqFGcBrV9eQ3arV0IyTsypeuUO7F58TKoJ8iAX6tss0ZsfAXixh9tbT/M4uuFU
         r49p0RtJLiN/bAMoMRWmk22QCTjMcKLRagQ17uuET0S4akdZoYD2d9+tk9dLgsWPkHHZ
         w8UA==
X-Forwarded-Encrypted: i=1; AJvYcCWWcOrxQQAFEzS4gEDKOM381xUYFndEQ+GRVQ5oulOgNdE8y2A73X/t3NmqsatMHYK9XWnYmv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqHxC8R05bGCLKHDNOwzDHGZeTtnwUAEUSMG2rbPRiyC85eVG6
	ZsGwTy1ep4Q88LZETGjP0z4zikzcy0oxOBM9z4DREpNU81R7W+jD6il4
X-Gm-Gg: AZuq6aKYIqDNkqaRDSdxDKsPPujUtlH8J7b/j6f3fjDKMOQWenmgAjItoGQ6f6PRZON
	QN4ke/++l8Vo6WBND97bsxW7AvfAeFTV0k9bOKNsgg+sp5ImZjlPVeJozi96BtqMw0D7awcLO/O
	vEKAURptctQY1JOxZsx/tCT8qoXsBtkc1XlVUxB/yPlDnZfhldr0rNuqh/PPUwruObL8ZjvE/5g
	mvogUkDDKKpag8QzFWVM+nv4t8ryihBqc2xj14ed1iIvo8hG4dEK2GEMTM02kBuKJVQ/F+51zFA
	EYOwMRq7EtGe4XYhzXvbGvG7tD0wFFG2vBs9xA8QRMJufS7VE8ujN8q2plvGvWlLDxc6jVQorqy
	t619c8/LxrLC1krk60OiOuSQyyYKj0GxgPY9mSfL7G8z/oEDggMPGyo/+JtpIFqBB/paVvnnqx6
	OFK50HuzB7muyKy2ije0t9
X-Received: by 2002:ad4:5dee:0:b0:894:2d44:509e with SMTP id 6a1803df08f44-894e9f85e2emr227219146d6.23.1770122612794;
        Tue, 03 Feb 2026 04:43:32 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c85b9sm132915776d6.24.2026.02.03.04.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:43:32 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 03 Feb 2026 20:43:08 +0800
Subject: [PATCH net] net: ti: icssg-prueth: Add dependency on HSR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-icssg-dep-v1-1-bacaf5234fb3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFvtgWkC/x3MQQqAIBBG4avErBPUoKirRIu035qNiRMRSHdPW
 n7weIUEmSE0NYUybhY+Y4VpG/LHGnco3qrJattrqzvFXmRXG5JyYxiCtw7GgGqfMgI//2umiIu
 W9/0Akv5yk2AAAAA=
X-Change-ID: 20260203-icssg-dep-b9f7fc2be11e
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213207-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,lunn.ch:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEBC0D936C
X-Rspamd-Action: no action

Commit 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame
forward offload") introduces support for offloading HSR frame forwarding,
which relies on functions such as is_hsr_master() provided by the HSR
module. Therefore, a dependency on HSR should be added for this driver.
Otherwise, the following build failures will occur when icssg-prueth is
built-in while HSR is configured as a module:
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
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index fe5b2926d8ab060d83f5a58d91e749a45c6cea18..48aa3457fd6d7fd99147e4fb1148559d6fcba082 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on HSR
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.

---
base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
change-id: 20260203-icssg-dep-b9f7fc2be11e

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


