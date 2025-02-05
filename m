Return-Path: <stable+bounces-113446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C049A29231
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373BC16A81F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31441FE461;
	Wed,  5 Feb 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urEWjm4q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE40155A30;
	Wed,  5 Feb 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766990; cv=none; b=k0wfK/fEMKlLzc3hT4WRGIyOuUDbWLO5WHgjIaMTFJEXs8/jC/OCGbH+J1pjZQD09fF9fIhRf1wM367tNkTab6MgZcj4uPYuQ1gI4UEZwiTgImqEqbsAKu3FAcyLIkMX4EZ4QKDAHJAau7EBvtyHPqTstSp23LxvkG5+dH+7Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766990; c=relaxed/simple;
	bh=7EhkkRIbHzPC9tnADS+3utLHhBtV1e02ZNq/5kuLzHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwNlBXcD+T0x3ItARC6jjPO5GjnbJpjbQX0jX/s4zZx5zeiQ2+MZ4ncFoUsoDF/7VX+KdY+RZ7uqOCE+7Zv/+5uWuxu0gNWj3i69AnZDY/vQlaxYN31gSfz+sX44nW+lwR4qKW/WCX0axQ17cu+OIYxVhQKkcISH8RFhWiN6fvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urEWjm4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C51C4CEDD;
	Wed,  5 Feb 2025 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766990;
	bh=7EhkkRIbHzPC9tnADS+3utLHhBtV1e02ZNq/5kuLzHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urEWjm4qfMvvP5OkLDYMenbZAJVhjlLcdtHHmxk+UW69M4W89smRzcN6hCjx6wdO9
	 S/MMZnxnopYOxoHOI4O9JYp9JiVtoDqFQOREdDlUbZJvVAL3fJWf5e+MU30o7dn+4t
	 OVVj6QmocNsww3VuCCBLWMsXLZAILaxL940DLhPA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@packett.cool>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 338/623] arm64: dts: mediatek: mt8516: reserve 192 KiB for TF-A
Date: Wed,  5 Feb 2025 14:41:20 +0100
Message-ID: <20250205134509.158883324@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Val Packett <val@packett.cool>

[ Upstream commit 2561c7d5d497b988deccc36fe5eac7fd50b937f8 ]

The Android DTB for the related MT8167 reserves 0x30000. This is likely
correct for MT8516 Android devices as well, and there's never any harm
in reserving 64KiB more.

Fixes: 5236347bde42 ("arm64: dts: mediatek: add dtsi for MT8516")
Signed-off-by: Val Packett <val@packett.cool>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20241204190524.21862-5-val@packett.cool
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index dd17d8a88c190..e30623ebac0e1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -144,10 +144,10 @@
 		#size-cells = <2>;
 		ranges;
 
-		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
+		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
 		bl31_secmon_reserved: secmon@43000000 {
 			no-map;
-			reg = <0 0x43000000 0 0x20000>;
+			reg = <0 0x43000000 0 0x30000>;
 		};
 	};
 
-- 
2.39.5




