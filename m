Return-Path: <stable+bounces-148983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C724AACAF93
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE927A1E60
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E7221734;
	Mon,  2 Jun 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MGZ1f4fx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16E2C3247;
	Mon,  2 Jun 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872160; cv=none; b=hJ7jf6fxS8s5i60UJclusp23YvdhtXNW6qm/7xmaJql6ZgFj1sYmWkMu08cX7/AotTZeOXyQ2WHug3oEEvRlr5+4aBiB6TWW37/kf+9R7OuvDX7JuE9K1QILTTR1OTVf/86HOqZMwGHa8dP5qvcNxeCdY7N0iyGiWp/7rU+a0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872160; c=relaxed/simple;
	bh=Bg/TzFxg+k3NNiAbFRHVRS/gD7AePoDhKk9VQjrGTZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEj3FibReTDGx+A6efqHR9w+0ZqpaDWL4DrjJwhppER+KBVDUnGS6jn6YAL56ywTGZs6LERhSyV/7IkE3BVrhH3bsw0Q5RnpoF6JmVJfBO2ibgJQ7LZLOh/MkvoyZGCZUDe80UgtDX2iFq02hjpULqqn/dyd1NmGmPRlXHpghUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MGZ1f4fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836E0C4CEEB;
	Mon,  2 Jun 2025 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872156;
	bh=Bg/TzFxg+k3NNiAbFRHVRS/gD7AePoDhKk9VQjrGTZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGZ1f4fxf/NMYbzTflIx4/y9s1UHvybSKEUiCoP6Up9pp8mlGDGs+wEf86+8Bm77f
	 RL3okz/sfCvUMk3CSItNTPJJQqZguVFyOUdQW/qmnEcdbMNHiH/kWUt5jbBJrT+jTS
	 B/SG8jVvCSwxVF68gHF2tuLJ6NxvUM9K6Vd0YbPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Karthik Sanagavarapu <quic_kartsana@quicinc.com>,
	Ling Xu <quic_lxu5@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.15 07/49] arm64: dts: qcom: sa8775p: Remove cdsp compute-cb@10
Date: Mon,  2 Jun 2025 15:46:59 +0200
Message-ID: <20250602134238.232289649@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
References: <20250602134237.940995114@linuxfoundation.org>
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

From: Karthik Sanagavarapu <quic_kartsana@quicinc.com>

commit d180c2bd3b43d55f30c9b99de68bc6bb8420d1c1 upstream.

Remove the context bank compute-cb@10 because these SMMU ids are S2-only
which is not used for S1 transaction.

Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
Cc: stable@kernel.org
Signed-off-by: Karthik Sanagavarapu <quic_kartsana@quicinc.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Link: https://lore.kernel.org/r/4c9de858fda7848b77ea8c528c9b9d53600ad21a.1739260973.git.quic_lxu5@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4973,14 +4973,6 @@
 						dma-coherent;
 					};
 
-					compute-cb@10 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <10>;
-						iommus = <&apps_smmu 0x214a 0x04a0>,
-							 <&apps_smmu 0x218a 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <11>;



