Return-Path: <stable+bounces-178507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50DB47EF3
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D81B20A10
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7015C158;
	Sun,  7 Sep 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gBm6YgC2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBBF18DF89;
	Sun,  7 Sep 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277058; cv=none; b=JAOpUDtwPDnc6BSWClLOkyWFshDKEtfTR34RIyT6t1kV2wIou+VGqfner1z8hzb4+09Fhx3HTttxaSOQ51BwBez797WlnjwhS8sV2siQBiBt61a8N5srcQgNiDMBbriaHTWBPjSVrgRPlXcFvoGiemUfnb9mD+IAPpWGfj71tbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277058; c=relaxed/simple;
	bh=PCuhmKA0LlT/6zo9ae6hHj8VEFYIkcIX9IeEqgPSfnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYPu9ISzIRDzs3BPQybH5SSqDqtkCX5LTmPENBUa54OR94sQUSxwqaaTaeGI7dUUMY82y87H1j4xDFpnJ/WaZbYp1ME8vDVTOK7I9ezWc8/P8kHKvTCSCk5sWXsK4zFu3M1chfLTMfPY0L4K7eFyggc9pS+BDpPeCeKscQoJG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gBm6YgC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A364C4CEF9;
	Sun,  7 Sep 2025 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277057;
	bh=PCuhmKA0LlT/6zo9ae6hHj8VEFYIkcIX9IeEqgPSfnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBm6YgC2l4cor+6d75mc94L+UxBsnJmqFhJs2724raNwhwEhEzrSNlvsqkLZ+9EkO
	 rFq08+Gyp6Pjuj0/2WwRMWk9BtLKlRpJjT+NyyuCCH/uuJtWx6HLBBJZ+nop4gxh+0
	 Suo6Pi5E7nUjkK/jue5HXgYISWIJLM1bf/99Frxg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 070/175] net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
Date: Sun,  7 Sep 2025 21:57:45 +0200
Message-ID: <20250907195616.492966002@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit 03483dbde80d102146a61ec09b9e90cfc4bb8be0 ]

Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
reasons are introduced in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1f5d2fd1ca04 ("vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 60eb95a06d551..e1173ae134284 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1712,7 +1712,7 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 		vxlan_xmit_one(skb, vxlan->dev, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
 
 	return NETDEV_TX_OK;
 }
-- 
2.50.1




