Return-Path: <stable+bounces-6140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4880D903
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F4F1C21661
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3F851C59;
	Mon, 11 Dec 2023 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1ygOJZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96965102A;
	Mon, 11 Dec 2023 18:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16542C433C8;
	Mon, 11 Dec 2023 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320620;
	bh=WTWnPUGjS4qmHNzolL5kZY0jmk8FoKjS+qWjWCm72KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1ygOJZG+Zj+VYDru/R5RB4GCuVH050hZYuZL+KtqP5pc3Q727Kblgh0bI8aPUiRo
	 BZI31yFNKAb/aG4/L6ppLcePmgpW52/UmoPxQWYzRn6UB4Prhkpp42uggHRbwXJeiA
	 F5lHSugWPX7iYjGd4jdeJOSbq1U+KCyytV647a0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6.1 128/194] arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties
Date: Mon, 11 Dec 2023 19:21:58 +0100
Message-ID: <20231211182042.247322877@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@collabora.com>

commit 74543b303a9abfe4fa253d1fa215281baa05ff3a upstream.

dtbs_check throws a warning at the dsi node:
Warning (avoid_unnecessary_addr_size): /soc/dsi@14014000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Other DTS have a panel child node with a reg, so the parent dtsi
must have the address-cells and size-cells, however this specific DT
has the panel removed, but not the cells, hence the warning above.

If panel is deleted then the cells must also be deleted since they are
tied together, as the child node in this DT does not have a reg.

Cc: stable@vger.kernel.org
Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230814071053.5459-1-eugen.hristev@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -101,6 +101,8 @@
 
 &dsi0 {
 	status = "okay";
+	/delete-property/#size-cells;
+	/delete-property/#address-cells;
 	/delete-node/panel@0;
 	ports {
 		port {



