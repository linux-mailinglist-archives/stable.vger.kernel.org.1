Return-Path: <stable+bounces-198360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD752C9F87E
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C338930012CA
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C626314A8E;
	Wed,  3 Dec 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XiJBIE6f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85E314A91;
	Wed,  3 Dec 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776283; cv=none; b=ZWzt73fBKRRcuY1vxPCvzPaKPm9ZkuputDTWPFZlDtekla196JLLJ69UTihVP//JFaGyTK91TSlNRcbCXJ9BWr3rSeV5zszprsP1JSscac3p8DxzSoqliykQ/XtyPJZvyIwrlS58SYaBoPbMpeYVHwYUAAYHf8PAfV8b4eMXKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776283; c=relaxed/simple;
	bh=d62e1N6QbNaeNeH8lqjqymYAeHGizwqZb/7ed4Bfx7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ecfb87/oGB6TPE+h2cTth2EqTT82JOkRBlFYdZPV4aXTXDMbNSm+R1r+AFxkb+v6gSy60U1OeWf9fLtzvpaqPl0VBu7s3vyQ4wgMElVgJa2uTC+rec42JyaWAyG0ASB7BFJH+OkKRh2zroTOGajm3fTfG4AYDhOiAuEwVCc9+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XiJBIE6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44249C4CEF5;
	Wed,  3 Dec 2025 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776282;
	bh=d62e1N6QbNaeNeH8lqjqymYAeHGizwqZb/7ed4Bfx7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiJBIE6fUH3ekYWJfKiFMfcJAQaRP0+vFBGyo2+739YTstfVXqftVC/P6EV3s7Knp
	 gHp+HdIZyiJ9sslNvas4rshmpbgfvH/r89H3p1RjPJAvvJv0MoOjgbugkgb0WkiXKI
	 8O90iRtgSg4gAdq7UrGo3cn+7AxC3vazG2yAI5qk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Haibing <yuehaibing@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 103/300] ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled
Date: Wed,  3 Dec 2025 16:25:07 +0100
Message-ID: <20251203152404.440639792@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit 3d95261eeb74958cd496e1875684827dc5d028cc ]

In ipv6_rpl_srh_rcv() we use min(net->ipv6.devconf_all->rpl_seg_enabled,
idev->cnf.rpl_seg_enabled) is intended to return 0 when either value is
zero, but if one of the values is negative it will in fact return non-zero.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Link: https://patch.msgid.link/20250901123726.1972881-3-yuehaibing@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d38d15ccc7501..ced20abf4ef8e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6978,7 +6978,9 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.rpl_seg_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
 	},
 	{
 		/* sentinel */
-- 
2.51.0




