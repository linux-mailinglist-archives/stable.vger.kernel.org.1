Return-Path: <stable+bounces-114772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A446A30068
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6279E7A17C5
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F301F12E3;
	Tue, 11 Feb 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVXTnJtf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B061F0E5C;
	Tue, 11 Feb 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237459; cv=none; b=WxiJ33Ij9hZO4mUMP8Xt5Z+WGB79KML9T3sm69E6kivJk5UR+kG7tJvlCNwE2p7M7qOseiT2wVq+xFhbKTElKLU5kZ9wxRc9PQuaM90YbQAlS7hj7ZDQ6wr79I21prSSb0+T4Tye08riq2e0IGyqUNItOwutICeWBV/eY2j+I6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237459; c=relaxed/simple;
	bh=iiOkryXmhkldJUUdUWPMeYG3VZWIaMZDxkZthCW/oSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOAX6IKAh/FZKukiMkSIekmnPnd6IEfgHw/Uhh9a7oYM/J+bTeWxycAA8WmaXK2OoFtKNuq7H8PVwNELhBx4UZvSeHr8xwYpkhGkJf/X1NL2Y9FjGCGa6zHyLJEfqF2eM1Y1gAl8+oTslZ25xOFKqb94vnGnZ4cfusWHg9nEqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVXTnJtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526DAC4CEE5;
	Tue, 11 Feb 2025 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237459;
	bh=iiOkryXmhkldJUUdUWPMeYG3VZWIaMZDxkZthCW/oSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVXTnJtfsTKvoyV+RHeDNClQ3w8RwNde29ULIYOxh6NsYt5Ls+YF0N3BrA6vNPopS
	 Jlc5ALyEzhFrvhsnAg1gD89U6YIH8Zj5jEE6xqdbXrT/cdVWwC78QNTiGL6HPQ/SzU
	 8K5Ny/vknXQoOGNRHVwYpyljd4DSJNmdIDMiKb0YRbj1RGEUJbjHKBWJjvQKbLjW4n
	 RjuHvkdkRu+xoMTJwsfr0F2CZlP42AVjrtB/VinFc6HuY3S9ucQfb9MbpEl4QyBHHD
	 OdN6AGM1DD/F2/oj2ffOAgAkRBJMLMZaoQbeI680mHRaRccD5rnoN9Mchyy56GVEWr
	 sUE98RR8Vp+RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chengen Du <chengen.du@canonical.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	konrad@kernel.org
Subject: [PATCH AUTOSEL 6.12 07/19] iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
Date: Mon, 10 Feb 2025 20:30:35 -0500
Message-Id: <20250211013047.4096767-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
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
index 6e9788324fea5..371f24569b3b2 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -310,7 +310,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
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


