Return-Path: <stable+bounces-218444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFgYNQ1Tnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B618F683
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C03873157B3B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423520C012;
	Wed, 25 Feb 2026 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/JuuUJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DE18B0A;
	Wed, 25 Feb 2026 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983266; cv=none; b=pK/UkF9uENJ/D5w8dW9NTB4W4Ze6iY1mqyyvDxWDS47QnFkCJyBLXsokZcksdWrpnnh48+k9M0hkKr5gb6vVjbILq8llaZWMxdeXVHbrb/uL5rhil3qeoZn4/MHnK+Dd/OaR3Kknnborr4aa29Yxal5+scEzOWXrWMjcpS3bDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983266; c=relaxed/simple;
	bh=CDacgpqD0BUmR1eX36E5LL6bCrGXC0sVYkeEym346yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJPF1KgUCk8r4Dp1cgloE5ajbUcFIECAUFlNMACGtCYWLQ7f1s6kvYeaVJEM0TFxGmXrINDY8S32JyqXwEWxjzn/yp5RU2OxxNJlVXLHgp8Whc5Pm+F+TkfqOfPGxiPFAmqtNGu3u90zi56oWVO4WOOO1W3hQcNSREaiHW/mMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/JuuUJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A57C116D0;
	Wed, 25 Feb 2026 01:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983266;
	bh=CDacgpqD0BUmR1eX36E5LL6bCrGXC0sVYkeEym346yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/JuuUJgDa27tFd+4+i6RYjoOQkFYWMYzxNDlA5mEl38tU27WYqSPuhlruqT2giGj
	 2UHYHT4XwddcADCQJ/zGuWx41umTHYSbCqqaHOywbgJrI4Q/NXX4VPoxj0jumbiTNu
	 6FxWrEaWuPSxKActTWofWzXTvEps2Krpw02lWDnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 407/781] amd-xgbe: do not select NET_SELFTESTS when INET is disabled
Date: Tue, 24 Feb 2026 17:18:36 -0800
Message-ID: <20260225012409.686629845@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218444-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 715B618F683
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit ee9241524b4682a34ed4b66d8c68c33304810b93 ]

AMD_XGBE currently selects NET_SELFTESTS unconditionally. Since select
does not honor dependencies, this can force-enable NET_SELFTESTS even
when INET is disabled (e.g. INET=n randconfig builds).

Fixes build issue when INET is disabled.

Fixes: 862a64c83faf ("amd-xgbe: introduce support ethtool selftest")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602030920.SWN7cwzT-lkp@intel.com/
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Link: https://patch.msgid.link/20260204150020.883639-1-Raju.Rangoju@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index d54dca3074eb6..45e8d698781c1 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -165,7 +165,7 @@ config AMD_XGBE
 	select CRC32
 	select PHYLIB
 	select AMD_XGBE_HAVE_ECC if X86
-	select NET_SELFTESTS
+	imply NET_SELFTESTS
 	help
 	  This driver supports the AMD 10GbE Ethernet device found on an
 	  AMD SoC.
-- 
2.51.0




