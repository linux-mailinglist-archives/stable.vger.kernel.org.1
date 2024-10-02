Return-Path: <stable+bounces-79527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC198D8EC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B09B226AD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3AA1D1504;
	Wed,  2 Oct 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s++Y/FTw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66201D14F6;
	Wed,  2 Oct 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877712; cv=none; b=TT+Fzr8bdHoRK0ebj2wtOsryQ7gJwmAhUFGz4YaTRXpwDzeq9EA6uHXcpXb816Ou0Y1+TL1u/7MObMJVNwQGOwCk8BBRRH6wbDnsBE0Sr/K2LXsUCyzWBESBLaYNQZ94qHYZ0DHHeD6625xgrBdfx9okFl5zJbe/1wlLzmQj2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877712; c=relaxed/simple;
	bh=FuXekBt8NFQ3mBbuZSOe7k5FmzwKAmA1XlbCjRATY0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l35J0/9A9MnYwxhYJnCwxdQEuAV7bsC9v3ciJ1Rfi3YU+CgiwZhr4z/7fEAGE47LlEWVdxtlRub6DrP2SCZanlE2MstydilJgV7RH0KSe6inIpS2m92vbKTlsF3nBEsrED71KfLO6Cp5PItUe9gE/YnDOmrhPkI/FThPvLo8o1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s++Y/FTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB5AC4CECE;
	Wed,  2 Oct 2024 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877712;
	bh=FuXekBt8NFQ3mBbuZSOe7k5FmzwKAmA1XlbCjRATY0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s++Y/FTwYIL/gH29w3/Rxr5v90ifeg4iubMqs8SdRxhjmwaZ9F2NbDj4VaijrN4p+
	 aIwW40CcHD4jKQX29T43hzIWYs8aX91jwOOovwSLAqpPXKByiPlmgA84uIV9nKMxRR
	 uPia9016Rccrs3DDKC58TibozfZs76IJqdogJmrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 137/634] arm64: dts: ti: k3-am654-idk: Fix dtbs_check warning in ICSSG dmas
Date: Wed,  2 Oct 2024 14:53:57 +0200
Message-ID: <20241002125816.516323357@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: MD Danish Anwar <danishanwar@ti.com>

[ Upstream commit 2bea7920da8001172f54359395700616269ccb70 ]

ICSSG doesn't use mgmnt rsp dmas. But these are added in the dmas for
icssg1-eth and icssg0-eth node.

These mgmnt rsp dmas result in below dtbs_check warnings.

/workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg1-eth: dmas: [[39, 49664], [39, 49665], [39, 49666], [39, 49667], [39, 49668], [39, 49669], [39, 49670], [39, 49671], [39, 16896], [39, 16897], [39, 16898], [39, 16899]] is too long
	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
/workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg0-eth: dmas: [[39, 49408], [39, 49409], [39, 49410], [39, 49411], [39, 49412], [39, 49413], [39, 49414], [39, 49415], [39, 16640], [39, 16641], [39, 16642], [39, 16643]] is too long
	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#

Fix these warnings by removing mgmnt rsp dmas from icssg1-eth and
icssg0-eth nodes.

Fixes: a4d5bc3214eb ("arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet ports")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20240830111000.232028-1-danishanwar@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index 8bdb87fcbde00..1674ad564be1f 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -58,9 +58,7 @@
 		       <&main_udmap 0xc107>, /* egress slice 1 */
 
 		       <&main_udmap 0x4100>, /* ingress slice 0 */
-		       <&main_udmap 0x4101>, /* ingress slice 1 */
-		       <&main_udmap 0x4102>, /* mgmnt rsp slice 0 */
-		       <&main_udmap 0x4103>; /* mgmnt rsp slice 1 */
+		       <&main_udmap 0x4101>; /* ingress slice 1 */
 		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
 			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
 			    "rx0", "rx1";
@@ -126,9 +124,7 @@
 		       <&main_udmap 0xc207>, /* egress slice 1 */
 
 		       <&main_udmap 0x4200>, /* ingress slice 0 */
-		       <&main_udmap 0x4201>, /* ingress slice 1 */
-		       <&main_udmap 0x4202>, /* mgmnt rsp slice 0 */
-		       <&main_udmap 0x4203>; /* mgmnt rsp slice 1 */
+		       <&main_udmap 0x4201>; /* ingress slice 1 */
 		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
 			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
 			    "rx0", "rx1";
-- 
2.43.0




