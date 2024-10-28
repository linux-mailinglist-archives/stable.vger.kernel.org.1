Return-Path: <stable+bounces-88974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297689B29B1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 09:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B48F1C21B43
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8C1D8E01;
	Mon, 28 Oct 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="OKlHK97i"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C731917DB
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102064; cv=none; b=ladT2K/VbZ7/rrAw/wdMH3IMFJrOsF5pjUYzQLCQP8XHfwd64jbWCBLbl/LuJeyju9AHNavF6ePvFcTRf/7U0WkKEmTHWfX6AVKNDHRD9pmJM5mOxmZ+B0ro+Ixix0SSVOV5tGqpQsvMud2x7Z07auQpoo6EWU7lpUbGodTNwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102064; c=relaxed/simple;
	bh=kVf3IA1poJPqUwEjAIROUVVBuxnvjiVvAmCvtg9YrE8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CTQL3xedJQD5Nvph7E4OosMotKHEsHwqf2HLlo+hlGvWQKC+5OYUDlEGXeHPSClT8EmDse15Kjw+tyzH1u4SbTauRw3Q64PKnRN46lJ8E5n/ee9RkX6xO76A5VLcQxrdViOIvRLKA8nzcEB4nFUpYcBlvWzBkUODaHCCb7W1qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=OKlHK97i; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 49S6AEZQ3686139; Mon, 28 Oct 2024 15:10:23 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1730095789;x=1731305389;bh=kVf3IA1poJPqUwEjAIROUVVBuxnvjiVvAmCvtg9YrE8=;b=OKl
	HK97i8geI0dltQSP5IC5DsMTR6m65nuHzRjdvj0jrvU+1NpMaPKm5IePvO1BXPPhWypSWeuJiKrxE
	YA6KowFLQ2iclajgFqySt1kLVYVoxvlRPIk0G75QXDUJfSPpFCJ24/giOrQ+ZGrf5yGTlX003wB2K
	7GIaWck2ez4yvFPy4F78Sjv0gswdJZUS6VStS0v94gVO+r8qrZ80QDYZNfQKuRZEcqHvRWAZCaJ5O
	fIQE2/AwDQmI2Q7c0+8UMIpnNmzGFKNoYC5Oj8DYTipWA3xYWBjWsKE5TRM/oJEDtW9Sj+haQLn2i
	xcpAeMs0fd3f5sbh5aSQ+E7RkEDlx3w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 49S69mVb3039683; Mon, 28 Oct 2024 15:09:48 +0900
X-Iguazu-Qid: 2rWgUXum6klPp0qBfc
X-Iguazu-QSIG: v=2; s=0; t=1730095788; q=2rWgUXum6klPp0qBfc; m=ok8mubXbqriqvzOIEqU3Ahubd1WpeePqrWr4zX1Sghk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 49S69kur1263442
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 15:09:46 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>, Jakub Kicinski <kuba@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 4.19.y] bonding (gcc13): synchronize bond_{a,t}lb_xmit() types
Date: Mon, 28 Oct 2024 15:09:34 +0900
X-TSB-HOP2: ON
Message-Id: <1730095774-12100-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

commit 777fa87c7682228e155cf0892ba61cb2ab1fe3ae upstream.

Both bond_alb_xmit() and bond_tlb_xmit() produce a valid warning with
gcc-13:
  drivers/net/bonding/bond_alb.c:1409:13: error: conflicting types for 'bond_tlb_xmit' due to enum/integer mismatch; have 'netdev_tx_t(struct sk_buff *, struct net_device *)' ...
  include/net/bond_alb.h:160:5: note: previous declaration of 'bond_tlb_xmit' with type 'int(struct sk_buff *, struct net_device *)'

  drivers/net/bonding/bond_alb.c:1523:13: error: conflicting types for 'bond_alb_xmit' due to enum/integer mismatch; have 'netdev_tx_t(struct sk_buff *, struct net_device *)' ...
  include/net/bond_alb.h:159:5: note: previous declaration of 'bond_alb_xmit' with type 'int(struct sk_buff *, struct net_device *)'

I.e. the return type of the declaration is int, while the definitions
spell netdev_tx_t. Synchronize both of them to the latter.

Cc: Martin Liska <mliska@suse.cz>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Veaceslav Falico <vfalico@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20221031114409.10417-1-jirislaby@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[iwamatsu: adjust context]
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 include/net/bond_alb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 3a6c932b6dcaff..52467d0b4677c9 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -172,8 +172,8 @@ int bond_alb_init_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link);
 void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave);
-int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
-int bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
 void bond_alb_monitor(struct work_struct *);
 int bond_alb_set_mac_address(struct net_device *bond_dev, void *addr);
 void bond_alb_clear_vlan(struct bonding *bond, unsigned short vlan_id);
-- 
2.45.2



