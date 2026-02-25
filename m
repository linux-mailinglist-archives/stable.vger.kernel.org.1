Return-Path: <stable+bounces-218475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDNzK+5RnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631F18F131
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422C73069D26
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5DD248886;
	Wed, 25 Feb 2026 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ntdbHuEf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1818B0A;
	Wed, 25 Feb 2026 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983302; cv=none; b=DO0oH8RBgKX1hFCMCi664spFJSFHNBy2fJRPBPo3civBpSCa1V2DkgKZLCjgPV8fvVGVRAUC7ko2SmsNqFGCnYS/07qeCKKJlMkQUVWe1gJvrjVaLg73YZt0qGmREY6ktZQe4kqsO3KWke3qWrweU/ySAyOSaOchMSbvH/H2IEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983302; c=relaxed/simple;
	bh=Bdt5ihuaehjst7qSe0NfhtTr+l5Lt3dsm8e1+BKuoQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2y0+2/Q4LzT0+ctL+/RHusfCZLE1yBV6bW+Qi0CP91KgFnbF1AydIY2z6hkNvL6VdBCCkwLnmIZ07BI8mYsIVLFbBVaPbbOo2iDbnMVcQU406P0ZoaEg5q9al71o7cV1pdOf7g1zyuiy4jb5TlolfIQeCHBqHcGfP3LOQl723E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntdbHuEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E82C116D0;
	Wed, 25 Feb 2026 01:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983302;
	bh=Bdt5ihuaehjst7qSe0NfhtTr+l5Lt3dsm8e1+BKuoQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntdbHuEfomZr+Sx28C36gJ42kfI8U5XiKpXBiCcLfNk03GsSYrVff9bzL6NM/mMCB
	 YrQiMy3RqAFBB9pm4W2rulQab4RiF+fyvdrZrFUnCBlklx06PYooVVs6n+yGd08aMh
	 XBvOkfLbarpgAJOoTpLHQ+CACUEy63WXImIk734w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Joyner <eric.joyner@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 435/781] ionic: Rate limit unknown xcvr type messages
Date: Tue, 24 Feb 2026 17:19:04 -0800
Message-ID: <20260225012410.374080436@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218475-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3631F18F131
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Joyner <eric.joyner@amd.com>

[ Upstream commit cdb1634de3bf197c0d86487d1fb84c128a79cc7c ]

Running ethtool repeatedly with a transceiver unknown to the driver or
firmware will cause the driver to spam the kernel logs with "unknown
xcvr type" messages which can distract from real issues; and this isn't
interesting information outside of debugging. Fix this by rate limiting
the output so that there are still notifications but not so many that
they flood the log.

Using dev_dbg_once() would reduce the number of messages further, but
this would miss the case where a different unknown transceiver type is
plugged in, and its status is requested.

Fixes: 4d03e00a2140 ("ionic: Add initial ethtool support")
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Link: https://patch.msgid.link/20260206224651.1491-1-eric.joyner@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 2d9efadb5d2ae..347b0aff100b9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -263,9 +263,10 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
 		/* This means there's no module plugged in */
 		break;
 	default:
-		dev_info(lif->ionic->dev, "unknown xcvr type pid=%d / 0x%x\n",
-			 idev->port_info->status.xcvr.pid,
-			 idev->port_info->status.xcvr.pid);
+		dev_dbg_ratelimited(lif->ionic->dev,
+				    "unknown xcvr type pid=%d / 0x%x\n",
+				    idev->port_info->status.xcvr.pid,
+				    idev->port_info->status.xcvr.pid);
 		break;
 	}
 
-- 
2.51.0




