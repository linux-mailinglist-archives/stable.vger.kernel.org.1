Return-Path: <stable+bounces-5984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553C80D82B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04821F21760
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB851036;
	Mon, 11 Dec 2023 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtSJ+SlR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7101FC06;
	Mon, 11 Dec 2023 18:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE29C433C7;
	Mon, 11 Dec 2023 18:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320198;
	bh=iag247i25e/DlP8GtbCYcH/fZRRdbCXB2kYBU+QonXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtSJ+SlRCebcwemM+yiqs0fzZgjQnDTfyiOnGzYCkjwYhAtGq+R9cjGA2qgNNDhT5
	 +bNQt4997ajUk80lA5bx1U1yzYrwc+SKF9sIYwKqXeSg0RBU8mCCxE11y2iS3S4i94
	 w+EBF5cUDd0cx2Pi5XPB9YYcCHa66Ybcl62mZT7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5.4 41/67] arm64: dts: mediatek: mt7622: fix memory node warning check
Date: Mon, 11 Dec 2023 19:22:25 +0100
Message-ID: <20231211182016.806760186@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@collabora.com>

commit 8e6ecbfd44b5542a7598c1c5fc9c6dcb5d367f2a upstream.

dtbs_check throws a warning at the memory node:
Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

fix by adding the address into the node name.

Cc: stable@vger.kernel.org
Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230814065042.4973-1-eugen.hristev@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts |    2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -69,7 +69,7 @@
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -55,7 +55,7 @@
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
 	};
 



