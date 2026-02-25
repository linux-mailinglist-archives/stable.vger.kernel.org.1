Return-Path: <stable+bounces-218720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMaID1FTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71018F7A7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 192403045D62
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C926AA91;
	Wed, 25 Feb 2026 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HbbrqGe1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C51D5141;
	Wed, 25 Feb 2026 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983582; cv=none; b=smzTnLQUEhwVXoB6cLGXDKIU3Ja9ulj7QroQ0ewa7kTT6h9HKHIT2ATReT/9o5q3Hb79UJ2Xc8zSNOY25KbbTu+9I2BBidlNu7fXgrwqWkKaeFS3mix3CqKR7xUWvDdn9Aw4wBOzB//1xesZxGS0JDCJD8qJq9tsav44R+BGTsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983582; c=relaxed/simple;
	bh=bX5WNbNMLzpg5oGh3e2XeNmAxDOOsK9/DNGQU+FsPN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgndlF35uSOo1nKuX6xNdkfJ0zb2Qri08/11ux8kNh6FjdSoaPYQctVamsbH+zri871DE1RjfzVXsRsWXGzUijIlWrVd8kxtcEHB4G9pi+qMJUVPHQIV7Ok1a0od+8QDroysx0Vp5jXLASrCRwflkChTceKIWGz7xOPjkxTvvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HbbrqGe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE62C116D0;
	Wed, 25 Feb 2026 01:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983582;
	bh=bX5WNbNMLzpg5oGh3e2XeNmAxDOOsK9/DNGQU+FsPN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbbrqGe19+KLCGq7XFfVLO2h4MOXT8K/Asp3boluQtADHFDTWVY0ojEi9mK7FOyK0
	 kiat7KEBepbBKjFvhdRysLf2XVMdFOs5yvLi0iZCfwJrJEFqvN21t3wDjJb7+nnxCw
	 Zx1p9TgR4xOXucNOE3ntbv7mHrwgvoR6KlLhwNco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 682/781] eth: fbnic: Advertise supported XDP features.
Date: Tue, 24 Feb 2026 17:23:11 -0800
Message-ID: <20260225012416.503050544@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218720-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0D71018F7A7
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>

[ Upstream commit e977fcb3a318b53b47f23b44ac237fceb1b731fe ]

Drivers are supposed to advertise the XDP features they support. This was
missed while adding XDP support.

Before:
$ ynl --family netdev --dump dev-get
...
 {'ifindex': 3,
  'xdp-features': set(),
  'xdp-rx-metadata-features': set(),
  'xsk-features': set()},
...

After:
$ ynl --family netdev --dump dev-get
...
 {'ifindex': 3,
  'xdp-features': {'basic', 'rx-sg'},
  'xdp-rx-metadata-features': set(),
  'xsk-features': set()},
...

Fixes: 168deb7b31b2 ("eth: fbnic: Add support for XDP_TX action")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260218030620.3329608-1-dimitri.daskalakis1@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e3ca5fcfabef3..b4b396ca9bce3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -805,6 +805,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->hw_enc_features |= netdev->features;
 	netdev->features |= NETIF_F_NTUPLE;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RX_SG;
+
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
 
-- 
2.51.0




