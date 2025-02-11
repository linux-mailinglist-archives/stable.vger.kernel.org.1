Return-Path: <stable+bounces-114830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A34A30108
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49445163DDF
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67D26B661;
	Tue, 11 Feb 2025 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiXmBsMq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089D1E9B29;
	Tue, 11 Feb 2025 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237592; cv=none; b=ley83Z36CLCx5yvpkhBRYBW8CcTg8R06EPVLD+wezs7RWd3R3RWCV5vIqbW8oG723NZClqNc0dR66AZ7Rbk+fuzQUxAEnrKqu+Ffo9W2h0oGjhZ9OxX+JITarOGjv6isgk9E6iB8ohDO/O9OkUpa+u9YFRUra+IzXQNTVP9llhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237592; c=relaxed/simple;
	bh=X1yG2wX+sPgEdWK1lugPk+XbQ2R+bxTE+OF1Ph/SMeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tw2zUE7qEHdhqlxmY3qUUtbEzuUAWiIxIiKylvCsxF9TuDY+e+N729qLal1iluhOyktYW42lpU64utO61Vtg/JCYt0XO/6dKpQDOgmA1DMF3uuz8S4e0CwSvtZzYoK32Bu4RCcX3G5Yp9FVm1lUbQldN5S6/n93vz+ci5Cgn6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiXmBsMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6F3C4CEE5;
	Tue, 11 Feb 2025 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237591;
	bh=X1yG2wX+sPgEdWK1lugPk+XbQ2R+bxTE+OF1Ph/SMeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiXmBsMqxlJIpsYOdrcXKypZTpBjrA4FztVowHpHUQRe+Us+DSWXHBRlBEsbSMxQR
	 AxoRWqcdOfKeLhoW1FmpFDzXHPSP6GyTzcNNopKFcuPQeY1+6IgMCr75WW7y4Zwzq1
	 n/YCU6koj2FFQeAXDkvxdTt9mbnGMWH2zAnehk0xHeCRUBB/CubK3DeoLKAEY0DWwf
	 K23kjmtDTKmjDLWDZNcEGJWaZhbKPrUfToL8PIm0SnycPM1nB3hATHJuhDn60JY8Zv
	 bNajwG+HgGlQzUvbHzulV0VWtZuDXy2ixSZGf7pNwqe5sok+dmAeI4mTuctE7CBqAm
	 slB9aUxMnPYZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chengen Du <chengen.du@canonical.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	konrad@kernel.org
Subject: [PATCH AUTOSEL 5.4 4/6] iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
Date: Mon, 10 Feb 2025 20:33:03 -0500
Message-Id: <20250211013305.4099014-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013305.4099014-1-sashal@kernel.org>
References: <20250211013305.4099014-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index 7e12cbdf957cc..daf42b5319e89 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -311,7 +311,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
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


