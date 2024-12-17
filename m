Return-Path: <stable+bounces-104636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508579F5246
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611981891D31
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB21F76D6;
	Tue, 17 Dec 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mb3s0tbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24451F7562;
	Tue, 17 Dec 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455651; cv=none; b=CvEljqND2gQ4Lcz0xEy7H4PgotJNlbXUxSpYmYQ9Ce36vMyHyvNEQSExAr04UBu2kRbcBmd1q7skbei7lAmk5BdfUVYXCQRJnCkaW4ppwn0cuJZ1YKQLUcHmiqu05cyZ+GT7QrCXabG6SxaUFdnYfgPAx0R5dqd6PYt231T8KiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455651; c=relaxed/simple;
	bh=USf4Ky6Ll0xxEWnIzxu3mMoWSWwVQmi9TrUwkl0D4R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBBKbPtxmvF1dl65ChjZV+3z55R3hNVbeuXANCPD1/uphVo07VJMAroo9NVVDxf/UYESWAefkDCsIj5awRGDFNBmWdyBFWLwOZctkLDwiAky7lnEyIC81rWxv8/TXqeQaNYkQJGDjLQ8GPwH92DIjfm7C5wPXk9FF4nz6G3LXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mb3s0tbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F4CC4CED7;
	Tue, 17 Dec 2024 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455649;
	bh=USf4Ky6Ll0xxEWnIzxu3mMoWSWwVQmi9TrUwkl0D4R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mb3s0tbAM+qExC3FjsjsoHUihLnR98QbVMiEU3l9rIHSQqq8zCnYYwb9RDFgZTl7W
	 /Sns/9hwuXyV05SVIzbyS/ciaHu7UbsIoVTwdU8F111sotZ0JtTY+YCaHMHQ8eWwRx
	 jNsYgdKItjDnRciegpffFPdoIGVVWAcuuYmyikhI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 37/51] team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
Date: Tue, 17 Dec 2024 18:07:30 +0100
Message-ID: <20241217170521.938088199@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.301972474@linuxfoundation.org>
References: <20241217170520.301972474@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 98712844589e06d9aa305b5077169942139fd75c ]

Similar to bonding driver, add NETIF_F_GSO_ENCAP_ALL to TEAM_VLAN_FEATURES
in order to support slave devices which propagate NETIF_F_GSO_UDP_TUNNEL &
NETIF_F_GSO_UDP_TUNNEL_CSUM as vlan_features.

Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20241210141245.327886-5-daniel@iogearbox.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 8edfc8984e2c..5e5af71a85ac 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -979,7 +979,8 @@ static void team_port_disable(struct team *team,
 
 #define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
 			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-			    NETIF_F_HIGHDMA | NETIF_F_LRO)
+			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
+			    NETIF_F_GSO_ENCAP_ALL)
 
 #define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
-- 
2.39.5




