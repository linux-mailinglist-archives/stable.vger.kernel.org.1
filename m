Return-Path: <stable+bounces-14807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B256B838353
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386FBB24E5A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D155EE66;
	Tue, 23 Jan 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGQqybZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117B5EE61;
	Tue, 23 Jan 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974404; cv=none; b=Mp682IMKF3KrwXfW+tc5eTFrxGmEY1pHXsXwZEIREEJSgMlMEVePWINUJfOmMDAeQFgKdQJ4e3vW8ebpqL4Jxk6R9pgHoQKWCkFjfjsypAXjv0a2B9OUxHY7L84KTvMGQqMGfpgCHfJds1KMJxm1M6zLrXczdwgWRggnq1J6u+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974404; c=relaxed/simple;
	bh=dI7GnipMvdB0WbtAKu+NwBqFRq5VtrH/Z4qtR6tanfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBih/XG1sHn98Yr6MxisMe0omrJCz/4qNjud/UV8Be40JnDWfNdLRgVNKPi/m+90vUB4IVgXUsOusKrZCuHecGGbbrvoYeZiaq9Qx3pKxvCDat1u39MMs79POXxl/Qm9P0xn4JITiQTjPDs5zKhN9zjnQqYlb94Xy16sj9jmFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGQqybZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1683C433C7;
	Tue, 23 Jan 2024 01:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974404;
	bh=dI7GnipMvdB0WbtAKu+NwBqFRq5VtrH/Z4qtR6tanfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGQqybZEUpQObpTT9QHCEXiVgEM25fGpa2u+QbA00JnJhJ5feqeS+sCK38bTUABw5
	 8LldJNNVn4KePq/v0KeViqIUXqngDLPrg19sJ7wodXcZUzopaVZ0bIIO8fOLzn0wIX
	 YzWBTCY+hE2hQvidDn+NT2UCQz90gDzxZ34ezoa4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 212/374] dt-bindings: clock: Update the videocc resets for sm8150
Date: Mon, 22 Jan 2024 15:57:48 -0800
Message-ID: <20240122235752.011043514@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

[ Upstream commit 3185f96968eedd117ec72ee7b87ead44b6d1bbbd ]

Add all the available resets for the video clock controller
on sm8150.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231201-videocc-8150-v3-1-56bec3a5e443@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 1fd9a939db24 ("clk: qcom: videocc-sm8150: Update the videocc resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/clock/qcom,videocc-sm8150.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,videocc-sm8150.h b/include/dt-bindings/clock/qcom,videocc-sm8150.h
index e24ee840cfdb..c557b78dc572 100644
--- a/include/dt-bindings/clock/qcom,videocc-sm8150.h
+++ b/include/dt-bindings/clock/qcom,videocc-sm8150.h
@@ -16,6 +16,10 @@
 
 /* VIDEO_CC Resets */
 #define VIDEO_CC_MVSC_CORE_CLK_BCR	0
+#define VIDEO_CC_INTERFACE_BCR		1
+#define VIDEO_CC_MVS0_BCR		2
+#define VIDEO_CC_MVS1_BCR		3
+#define VIDEO_CC_MVSC_BCR		4
 
 /* VIDEO_CC GDSCRs */
 #define VENUS_GDSC			0
-- 
2.43.0




