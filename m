Return-Path: <stable+bounces-146425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520BAC4AE1
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 10:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52359189E43C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E524DCEB;
	Tue, 27 May 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mikaelkw.online header.i=@mikaelkw.online header.b="AY6F70ne"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D324A066;
	Tue, 27 May 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336294; cv=none; b=dwpPVceh3uKiTPBDaK/b5KCqQGHeN53FiixaejTDz9p/P4W9LR1k3A+tgV/DNS5oqt9DZGRgVwYr9jgl6GbVZHLDZZgieH3fmg4qh5A+QKzmzgmnddSjc+YieXm4AShlKuPL2huIzm64b0pwUtpXq31Ov0rzCBi6DqEchXOghoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336294; c=relaxed/simple;
	bh=fIznW0zf7tRzozO0jQVRIS3oEoNRlp1hVjIZ4iMGIJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHowdOlpAaDkDajYFfEKMJFaFv1a+4EmiwwOfaDteqK2fHr8mrixOpiwV0XvAzX6Kx4pE9cfnn5w/3xKJQ00KTQNusJ7bIdFhdJ2EGTJ0Rz3LHAD9J92a8/NBGajNmOA3E/KcpDlHVaIDk2I33J1IuZ9lus23hyFuP6l8lCJM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mikaelkw.online; spf=pass smtp.mailfrom=mikaelkw.online; dkim=pass (2048-bit key) header.d=mikaelkw.online header.i=@mikaelkw.online header.b=AY6F70ne; arc=none smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mikaelkw.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikaelkw.online
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3DFB9345840;
	Tue, 27 May 2025 08:58:11 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.70.45.136])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0E706600B8;
	Tue, 27 May 2025 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikaelkw.online;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=pp-selector; bh=FfwiLz0qMLCe8pRJ2Xqblg8YMQN3QxXuQ0AQptgDjjY=;
 b=AY6F70neblY6M/62p9wx6POO9G2QYcyS2bxwQpTmGOCDMKMUGK01krhicplC+C8WC2C0sj0zi+t+RUN/cpVyYd+Kl5UuHs4zcLevmaxw734KQLTsuFDPgnMLODFCE6rJNG+B29C9jDIcH8yXpZ9SJZvaJxCCmGXB1t3/HxSLRxrhke6I6dMHEfY7qyJ/SAQiuJtcIYPupuTRJzLqJ7/SVvzia3VERwN5eiDLj92l6IJqqDhMAreURoswcrKRI2H+ZR8XQOlAvpdR0/BfPVX+Zk74iHxHQubJGiclCbwc+mBvxVFmjwZdTxAHKHyFQRgqV4pOn/qn9mqpkcpuf7sSLg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from test-ubuntu-rev3.. (78-26-16-15.network.trollfjord.no [78.26.16.15])
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5454DB00056;
	Tue, 27 May 2025 08:58:01 +0000 (UTC)
From: Mikael Wessel <post@mikaelkw.online>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	torvalds@linuxfoundation.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	security@kernel.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Mikael Wessel <post@mikaelkw.online>
Subject: [PATCH v2 1/1] e1000e: fix heap overflow in e1000_set_eeprom()
Date: Tue, 27 May 2025 10:56:12 +0200
Message-ID: <20250527085612.11354-2-post@mikaelkw.online>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527085612.11354-1-post@mikaelkw.online>
References: <20250527085612.11354-1-post@mikaelkw.online>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1748336282-23qMi_kDexex
X-PPE-STACK: {"stack":"eu1"}
X-MDID-O:
 eu1;fra;1748336282;23qMi_kDexex;<post@mikaelkw.online>;7544ea0f74a3697a45f5192d6efff48c
X-PPE-TRUSTED: V=1;DIR=OUT;

The ETHTOOL_SETEEPROM ioctl copies user data into a kmalloc'ed buffer
without validating eeprom->len and eeprom->offset.  A CAP_NET_ADMIN
user can overflow the heap and crash the kernel or gain code execution.

Validate length and offset before memcpy().

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Reported-by: Mikael Wessel <post@mikaelkw.online>
Signed-off-by: Mikael Wessel <post@mikaelkw.online>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..98e541e39730 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -596,6 +596,9 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	for (i = 0; i < last_word - first_word + 1; i++)
 		le16_to_cpus(&eeprom_buff[i]);
 
+        if (eeprom->len > max_len ||
+            eeprom->offset > max_len - eeprom->len)
+                return -EINVAL;
 	memcpy(ptr, bytes, eeprom->len);
 
 	for (i = 0; i < last_word - first_word + 1; i++)
-- 
2.48.1


