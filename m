Return-Path: <stable+bounces-153960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97308ADD731
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903FF17ECA4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9D2ECEAE;
	Tue, 17 Jun 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ltukC43R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EA23AE84;
	Tue, 17 Jun 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177652; cv=none; b=DdbJHnALV40oBXwrQZ1gzg+uPZWeWefErtPu5K9NBbbxtk/HfEJUD7QBwjNiBL7iNTSGk+49PyffGi6kwv5XqBMcaXkkw6K/m+lV82NK12grOrm1kcJptHrA9y/kneK1EYsF5yAxh5z2v4hBtgMaYG1ILQ4igWyju5hapcLg7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177652; c=relaxed/simple;
	bh=vz/b1Tp2Cl0vEByRCgvN9CVhUtETJrP/eomC5tTox6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/DXz9jFVA6/FV+AnxF3D/oLv/aDXIcm9y80OxTaHivSQzOfon/bUjRTG4Pq6F7leZyR5Tlq/A9K66q5Z8uqh0LIOq90fbf1btQOiItp62R+VM1jXN05Nbd9vPSWT6tmDA1jsmcFS06w1q7F35cqO8pWRbBa/ewHP6JUgMMDnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ltukC43R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD00C4CEE3;
	Tue, 17 Jun 2025 16:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177652;
	bh=vz/b1Tp2Cl0vEByRCgvN9CVhUtETJrP/eomC5tTox6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltukC43RsZNBQgzkqVKidWz0mtkUASniQ2dMmR0+Cq5KJ8kZI64NMhiEaQvPvrqIN
	 LJtAOPrCVKfUs3rpKwUoAXOi6kjd+Pwl1ykb2C84krIVHeO6kKD5Lr5o1IIcpS29Bf
	 BB5NbTcKgrVigyDyG+qCBxUC/+rFAw+eBEUylr6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Kettenis <kettenis@openbsd.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 341/780] arm64: dts: qcom: x1e80100: Mark usb_2 as dma-coherent
Date: Tue, 17 Jun 2025 17:20:49 +0200
Message-ID: <20250617152505.343054251@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Kettenis <kettenis@openbsd.org>

[ Upstream commit 45bd6ff900cfe5038e2718a900f153ded3fa5392 ]

Make this USB controller consistent with the others on this platform.

Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250109205232.92336-1-kettenis@openbsd.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5aeecf711340d..607d32f68c340 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4815,6 +4815,8 @@
 				snps,dis-u1-entry-quirk;
 				snps,dis-u2-entry-quirk;
 
+				dma-coherent;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.39.5




