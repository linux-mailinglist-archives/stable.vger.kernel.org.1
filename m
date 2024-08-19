Return-Path: <stable+bounces-69457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F595650F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C2AB22930
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4F15AD83;
	Mon, 19 Aug 2024 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Qe0QhUeE"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8115AAB1;
	Mon, 19 Aug 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054083; cv=none; b=JctXAqzmO3Vd9Gd0+dhQXiG/OpM3gOkTpzyZpncr9/zfDhQ5pIIgC0CEts9HYQ11Qq/0Rc1BrqOhOE/f49BvQHFgIpnXWasCM65XmIpG3gsD298z9z13xusbSmkUH0M4q4Ws57h1CwN1+6spuqhD5mfKTWNEPHeDv/wsP01691w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054083; c=relaxed/simple;
	bh=Tz6zhJqrkiXmYBOuhOMdTTUN30OczbcwT5/Bmwip71E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lk8VA2nBTYfwCeeYzsJP+o91OVgeKmGP+K1mRyaY6344rAuLNH8cXTkN/CqvSSwqgeh1MiK2J6OuCb3UZEpQ9BKIOPlz95c6kh8spEDcvFckcN7YsPFIWyvTcbcxPSgmtzcen+0hR4+aQHorelZh5Un6iYmnyQdFbwNekXQSBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Qe0QhUeE; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7C40860CF5;
	Mon, 19 Aug 2024 10:54:28 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:a411::1:16])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id MsG0Nr3IWmI0-UvhOWPYn;
	Mon, 19 Aug 2024 10:54:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1724054067;
	bh=mR59kDa39T2CrMpsJrUAK8Rv/tzywGTEs2gymkli9HE=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=Qe0QhUeEmAXV1rsP6rqopCg9RzadWDbatIgr3EwK+oBcDoxBOue+VOxK/OIlVLy7h
	 Qky6L07Tnusm8kpVkPTgBki6HIrdmvb4wc3K2iBMgZv3yfCYRSRJrUJy+9/VU9Sjpb
	 eNSAOmELqQjo+5hyhCTCm/nd/sRemvXXGTlgnc3c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Kumar Sanghvi <kumaras@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH v2] cxgb4: add forgotten u64 ivlan cast before shift
Date: Mon, 19 Aug 2024 10:54:08 +0300
Message-Id: <20240819075408.92378-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is done everywhere in cxgb4 code, e.g. in is_filter_exact_match()
There is no reason it should not be done here

Found by Linux Verification Center (linuxtesting.org) with SVACE

Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org
Fixes: 12b276fbf6e0 ("cxgb4: add support to create hash filters")
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: Wrap line to 80 characters

 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 786ceae34488..dd9e68465e69 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -1244,7 +1244,8 @@ static u64 hash_filter_ntuple(struct ch_filter_specification *fs,
 	 * in the Compressed Filter Tuple.
 	 */
 	if (tp->vlan_shift >= 0 && fs->mask.ivlan)
-		ntuple |= (FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
+		ntuple |= (u64)(FT_VLAN_VLD_F |
+				fs->val.ivlan) << tp->vlan_shift;
 
 	if (tp->port_shift >= 0 && fs->mask.iport)
 		ntuple |= (u64)fs->val.iport << tp->port_shift;
-- 
2.34.1


