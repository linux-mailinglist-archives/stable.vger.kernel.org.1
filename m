Return-Path: <stable+bounces-235012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IlyMcCp1mlmHAgAu9opvQ
	(envelope-from <stable+bounces-235012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:17:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3A3C2B19
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958D63187DFD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E550355F30;
	Wed,  8 Apr 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cceq2X/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBD25A321;
	Wed,  8 Apr 2026 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674343; cv=none; b=NJkncYPDH1W7AhoLFtIaNlyj8DnlueOaU2DwZugQ4svLxMVmA53ciro6+JHBQQ0qvfMxWgilwG/WmS0bzBGjwNW7CeYQNJrGTd2+dCyGfBqTXLdohkdRajMWnIChCH2xIQbMxNic+hZYx9mClYKeyH0allVo7bOqzGPFW404wOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674343; c=relaxed/simple;
	bh=6HVBG/WMXA4gklELJGU4Ao5kPlajjugelbjUbMQLClo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDz4BbiscqDvfmTj60h8yYV9vi2ksUZvaLn9uKe+q6sXG5PzQ4yQEtnjufedFnlw/jVXMNE2g/BJWl7+rBVS+rYRKvO3Kw9mnIbbxJMTuLp/OLgt6wQCQuXlw2eBIALccYT/hHHuKQJGcCJ1DivM2MeHHHckOUcaKhhjwFPZTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cceq2X/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8E7C19421;
	Wed,  8 Apr 2026 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674342;
	bh=6HVBG/WMXA4gklELJGU4Ao5kPlajjugelbjUbMQLClo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cceq2X/39/J5ITc9IErMcouh4JhFAvNCgR7yl03X1562/HixxQSZ0o0WWNp0VY0uy
	 Y4PM5pjWI24Ww/1g0xER8QnwBAsD1r+opRd9G0TbNzlDGUsmJqLKf27rOr0WxA9kZM
	 HmbP4djljPoaZXWh2a8v9mJLINdb+U9yAKY4RWMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 060/311] net: enetc: do not allow VF to configure the RSS key
Date: Wed,  8 Apr 2026 20:01:00 +0200
Message-ID: <20260408175941.656456057@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235012-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,nxp.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FE3A3C2B19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit a142d139168cce8d5776245b5494c7f7f5d7fb7d ]

VFs do not have privilege to configure the RSS key because the registers
are owned by the PF. Currently, if VF attempts to configure the RSS key,
enetc_set_rxfh() simply skips the configuration and does not generate a
warning, which may mislead users into thinking the feature is supported.
To improve this situation, add a check to reject RSS key configuration
on VFs.

Fixes: d382563f541b ("enetc: Add RFS and RSS support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Link: https://patch.msgid.link/20260326075233.3628047-3-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index a393647e6062c..7c17acaf7a380 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -800,8 +800,12 @@ static int enetc_set_rxfh(struct net_device *ndev,
 		return -EOPNOTSUPP;
 
 	/* set hash key, if PF */
-	if (rxfh->key && enetc_si_is_pf(si))
+	if (rxfh->key) {
+		if (!enetc_si_is_pf(si))
+			return -EOPNOTSUPP;
+
 		enetc_set_rss_key(si, rxfh->key);
+	}
 
 	/* set RSS table */
 	if (rxfh->indir)
-- 
2.53.0




