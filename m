Return-Path: <stable+bounces-33151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6571891810
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629481F22D64
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E36A348;
	Fri, 29 Mar 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="vQ406YD5"
X-Original-To: stable@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691E6A343;
	Fri, 29 Mar 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712657; cv=none; b=Q8yG0f5Ll5W563uEJbqG5vE4rO/ykXAclNCT0MDB9nz8xQ+P1ChUCDpgr3wcah92O40h7i/Jm8HWswP+ngEj/7j4OSUB7m5FsJmjy9zRIAWHB/j0h5Z3bxNn7t1xuSUW9YaW17Nn6StNepVBAV50hLrPTsRpEUG2fQBpNSdfBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712657; c=relaxed/simple;
	bh=5xYzgrg/uPq/rvZgkI/v6SA6CZd70/vkOHfDQfIzP3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAGFuJ3IYJTpEe9ImWz7MzIZcp1KA9D/4GhN5TdPKJYgMgLaceHUjTVuPwwnduGOoJZ9dSSwrx+0LqUodLf0TrhKXCK5zJKzoVEH2LnSjRNLy6SHQvrmrIRX6Oi7EbcyQ3JbOkNF4US5NhGXhPeq9283PjIWOhobwyTa5tKkHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=vQ406YD5; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id BC7D1100002;
	Fri, 29 Mar 2024 14:43:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711712635; bh=wdVxSPQEBkR0oOYU2qOnB3/ffvbMHadiH4+XGFTLIzg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=vQ406YD51iTxGDJmG+iKpIVcwzQ7audAyDMRaMKeKh7CZDKf/J+Z+iF5KrNgRZbMv
	 TLLKwqN2ZUi3MGTT9k+FHQnuZt+Ob4VAa7w12aRbHZ4tFnGP6/es7exB5mkvFpxEtF
	 qlWmjrNnJf/uP0/NA74reazJdlcUl9mJg0KfXuWygH2ACrrDLTEeFndAhP/TG+G1dT
	 tJSzNGnWn94SrIJXl+rUMDPgfqhaShZh5aDgN9+5mMFHTAooLld7FoeH9p9eyoo49M
	 f1bJvpKKtNeLShgRyB+Xf+OHesrnoXtzQ1rSLZpeob5IIGUWvaL72HTUlVEKCFRIUT
	 EGfFLfD0S8JHg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 29 Mar 2024 14:42:38 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 29 Mar
 2024 14:41:43 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 6.1 1/1] octeontx2-af: Add validation of lmac
Date: Fri, 29 Mar 2024 14:41:33 +0300
Message-ID: <20240329114133.45456-2-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240329114133.45456-1-amishin@t-argos.ru>
References: <20240329114133.45456-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184490 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/29 10:56:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/29 08:22:00 #24505801
X-KSMG-AntiVirus-Status: Clean, skipped

From: Hariprasad Kelam <hkelam@marvell.com>

commit 2f387525d484c0eca841b71842e1cd672220c20c upstream.

With the addition of new MAC blocks like CN10K RPM and CN10KB
RPM_USX, LMACs are noncontiguous. Though in most of the functions,
lmac validation checks exist but in few functions they are missing.
This patch adds the same.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index e6fe599f7bf3..93bc4c43c6e7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -247,6 +247,9 @@ int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr)
 	int index, id;
 	u64 cfg;
 
+	if (!lmac)
+		return -ENODEV;
+
 	/* access mac_ops to know csr_offset */
 	mac_ops = cgx_dev->mac_ops;
 
@@ -564,15 +567,16 @@ void cgx_lmac_promisc_config(int cgx_id, int lmac_id, bool enable)
 {
 	struct cgx *cgx = cgx_get_pdata(cgx_id);
 	struct lmac *lmac = lmac_pdata(lmac_id, cgx);
-	u16 max_dmac = lmac->mac_to_index_bmap.max;
 	struct mac_ops *mac_ops;
+	u16 max_dmac;
 	int index, i;
 	u64 cfg = 0;
 	int id;
 
-	if (!cgx)
+	if (!cgx || !lmac)
 		return;
 
+	max_dmac = lmac->mac_to_index_bmap.max;
 	id = get_sequence_id_of_lmac(cgx, lmac_id);
 
 	mac_ops = cgx->mac_ops;
@@ -745,7 +749,7 @@ int cgx_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 	int corr_reg, uncorr_reg;
 	struct cgx *cgx = cgxd;
 
-	if (!cgx || lmac_id >= cgx->lmac_count)
+	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
 	fec_stats_count =
 		cgx_set_fec_stats_count(&cgx->lmac_idmap[lmac_id]->link_info);
-- 
2.30.2


