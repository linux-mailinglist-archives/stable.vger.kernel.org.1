Return-Path: <stable+bounces-61573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B79FD93C4F9
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C061F23150
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45D013C816;
	Thu, 25 Jul 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XcvUgmxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193963D0;
	Thu, 25 Jul 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918750; cv=none; b=S14prDlw4wkE4pQ7StD6H8a45jWOrgZ/FqDHy39MVty+9FkhI1pVYkm4rEuECYw7P2XHRSYo+RxNhhTyJu6VjcnEcfdGHMjRGZSS1VJo2qLycZfC2pkS5elHpsvrdJRttrtv8Yhl6EWjT6NKlLOyRwqR/oEtfsCniEDcCQkfbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918750; c=relaxed/simple;
	bh=ONSpxmslQQofRCRi2CPKIXeAtZ8RKnXdIJACevoKeyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uon4pJ2A9W1AVLr2AJVtnLeQ0mHaAJcKlu3Ut3T4igivA9dp9sBqoJg/is0Qc2+yB2cTNCzm/utcSMbMG0UYCxOMIQmZ4T6xAXaYcHxDrgOhHRU+yKNNI+QnpVxU8IzWXwRPJU7KXIsHErATq07MOfghHsg+Fpz2XreqW96qwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XcvUgmxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187D0C32782;
	Thu, 25 Jul 2024 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918750;
	bh=ONSpxmslQQofRCRi2CPKIXeAtZ8RKnXdIJACevoKeyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcvUgmxkP2oUTwwsFwVPwZmQ+Jr41nqw0BBPef3vzjvimhDE3dBQBNFbNcDDeUftP
	 g5AyniijLQKwVhwIRPTNcjy7TfT5b4AjkFMTYYTNW57e4c3/bIdcYyGQgYxtyuBcXa
	 2Nc2bC0ttaTjrBUjJbhLPHlf7WBlMcvsyVBtttjU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.6 11/16] arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for USB
Date: Thu, 25 Jul 2024 16:37:24 +0200
Message-ID: <20240725142729.328449390@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
References: <20240725142728.905379352@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krishna Kurapati <quic_kriskura@quicinc.com>

commit c5d57eb7d06df16c07037cea5dacfd74d49d1833 upstream.

For Gen-1 targets like SM6350, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for SM6350 to mitigate this issue.

Cc: stable@vger.kernel.org
Fixes: 23737b9557fe ("arm64: dts: qcom: sm6350: Add USB1 nodes")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240704152848.3380602-7-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1864,6 +1864,7 @@
 				snps,dis_enblslpm_quirk;
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};



