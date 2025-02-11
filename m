Return-Path: <stable+bounces-114823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4074BA300F1
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F84163BB5
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1075E1D514A;
	Tue, 11 Feb 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD6GRDKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1861253B74;
	Tue, 11 Feb 2025 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237575; cv=none; b=VfCM6N1jy0xzA55pptfAuwa15ivBNelyv+3ifkYnTcJ84vHqiSHoXJxFmCjpa88M+QMkWNe3J2WUvXK2w22HrQ5nmi3WzJB/NnqG8Hnclx1dkh44Zei2TFFaaKFDSVWdwrgEy78CGzq/GTbV6OZNGVjKkVAljz8qltathX9AOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237575; c=relaxed/simple;
	bh=KufTdAMR8pZA9otpNfJUJB9G7SALCvrPjOzcgNOR4RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/ViI7322yrkMA2RVBI32FrFN/APmhgPx9lanYasA0YFio6LFbx5k/rSBCc0N3BepG1sfog1Pwvk9T0e7HYurpFt0RUpQdfoGfBrKyOPqxOIUVhmfRbm5ZZOT/zr1L2ItASsJ0Cc16cwF0smUOl4UpGCN9o6gbyN1kM5H4S7FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD6GRDKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0A8C4CEE7;
	Tue, 11 Feb 2025 01:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237575;
	bh=KufTdAMR8pZA9otpNfJUJB9G7SALCvrPjOzcgNOR4RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MD6GRDKdH6SmddAeIfvHEcJH/i52nFJX906idXj5Bys7Fo4DQmEy6pEnktmTzVx3W
	 kLynXFka86e/63M6Td/1QNNf4pkXZCTWBQypXXAoCdjpisSTdBDti5sZ7tMeUVksSu
	 yFNkC1/SGXcNhdf/xnognwrg4Zu+zEpm+/QouLiUwIp9iMxm/X1hRTlZGR4uXVRJIm
	 XINnLANGhiUWrIe+WoF7joB87O3Hj3bL47/6HVnxiJZhXhiovPRBNcKFx1eSs5Ajxe
	 hT+L6Oxa9lihMer9vpnQNRnD2Lm2QkereydYMQ51v+WTDda9WryLevfT+SXyu+HoXA
	 ANSmGgoakDBgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chengen Du <chengen.du@canonical.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	konrad@kernel.org
Subject: [PATCH AUTOSEL 5.10 4/8] iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
Date: Mon, 10 Feb 2025 20:32:44 -0500
Message-Id: <20250211013248.4098848-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013248.4098848-1-sashal@kernel.org>
References: <20250211013248.4098848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Chengen Du <chengen.du@canonical.com>

[ Upstream commit 07e0d99a2f701123ad3104c0f1a1e66bce74d6e5 ]

When performing an iSCSI boot using IPv6, iscsistart still reads the
/sys/firmware/ibft/ethernetX/subnet-mask entry. Since the IPv6 prefix
length is 64, this causes the shift exponent to become negative,
triggering a UBSAN warning. As the concept of a subnet mask does not
apply to IPv6, the value is set to ~0 to suppress the warning message.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/iscsi_ibft.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 7127a04bca195..0d96dbbba74e6 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -312,7 +312,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
 		str += sprintf_ipaddr(str, nic->ip_addr);
 		break;
 	case ISCSI_BOOT_ETH_SUBNET_MASK:
-		val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
+		if (nic->subnet_mask_prefix > 32)
+			val = cpu_to_be32(~0);
+		else
+			val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
 		str += sprintf(str, "%pI4", &val);
 		break;
 	case ISCSI_BOOT_ETH_PREFIX_LEN:
-- 
2.39.5


