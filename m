Return-Path: <stable+bounces-36517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F089C030
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB96286342
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CC757FF;
	Mon,  8 Apr 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xbEUwm4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440870CDA;
	Mon,  8 Apr 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581556; cv=none; b=HQxi4NrOphKKn6Dq8Ah7McXHGMMs36LK30d7PzgFRG6cVUrEHgQu8Vyvzj24O5HiEgSSvZgIU8R8E6FF/6AOVpcrsO1u1NndyPtgQQxKvSN5FMmBtpSqkbR+slEBXjQTEAA7RyB37MXxM0OieSkICEMliP3MNTexwDPQohUQBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581556; c=relaxed/simple;
	bh=hPfvbC79unM+71FSeN1o1dJVocmzPPavMBHn7CRKMFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxrcMRZD6v0D+xr1vDWSgG4KXaDhwXkT12OH4FtozSkIuzFTPwseKT/wTiwzieJJInIpImvD7omVZtzXIWZMjOp8DwEP2tPt2rb71WY6palXb9Fheoyaq93e0mvoDSZ7uAvMq2tsnK91DhqKgT4yMaICfsHMP7RWp6kxFtiRBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xbEUwm4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A12C433F1;
	Mon,  8 Apr 2024 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581556;
	bh=hPfvbC79unM+71FSeN1o1dJVocmzPPavMBHn7CRKMFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xbEUwm4Ccj2Lcz306IJeIbCrnWJqY0pK9ZlcaZxNXE4RHPY+mqgGOIW2wbQ+d7U6q
	 hi8HQ55avFWx9Mp55JDent1KApaczGOYFi/Pl/iTEL8nAI33V1Wdv+d/ajwk4g9b2Q
	 CxXFCZcYIq1MofgdXFnpOTVHjTuHbdo4v7LvFmIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.6 018/252] ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()
Date: Mon,  8 Apr 2024 14:55:17 +0200
Message-ID: <20240408125307.214783621@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

[ Upstream commit aec806fb4afba5fe80b09e29351379a4292baa43 ]

Change kzalloc() flags used in ixgbe_ipsec_vf_add_sa() to GFP_ATOMIC, to
avoid sleeping in IRQ context.

Dan Carpenter, with the help of Smatch, has found following issue:
The patch eda0333ac293: "ixgbe: add VF IPsec management" from Aug 13,
2018 (linux-next), leads to the following Smatch static checker
warning: drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:917 ixgbe_ipsec_vf_add_sa()
	warn: sleeping in IRQ context

The call tree that Smatch is worried about is:
ixgbe_msix_other() <- IRQ handler
-> ixgbe_msg_task()
   -> ixgbe_rcv_msg_from_vf()
      -> ixgbe_ipsec_vf_add_sa()

Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/intel-wired-lan/db31a0b0-4d9f-4e6b-aed8-88266eb5665c@moroto.mountain
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 13a6fca31004a..866024f2b9eeb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -914,7 +914,13 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		goto err_out;
 	}
 
-	xs = kzalloc(sizeof(*xs), GFP_KERNEL);
+	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
+	if (unlikely(!algo)) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	xs = kzalloc(sizeof(*xs), GFP_ATOMIC);
 	if (unlikely(!xs)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -930,14 +936,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		memcpy(&xs->id.daddr.a4, sam->addr, sizeof(xs->id.daddr.a4));
 	xs->xso.dev = adapter->netdev;
 
-	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
-	if (unlikely(!algo)) {
-		err = -ENOENT;
-		goto err_xs;
-	}
-
 	aead_len = sizeof(*xs->aead) + IXGBE_IPSEC_KEY_BITS / 8;
-	xs->aead = kzalloc(aead_len, GFP_KERNEL);
+	xs->aead = kzalloc(aead_len, GFP_ATOMIC);
 	if (unlikely(!xs->aead)) {
 		err = -ENOMEM;
 		goto err_xs;
-- 
2.43.0




