Return-Path: <stable+bounces-151820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C8FAD0CBD
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC8E1895250
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203E20A5F2;
	Sat,  7 Jun 2025 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Fkr3QsN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F121D58F;
	Sat,  7 Jun 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749291085; cv=none; b=YsJjnV27AFs6ahFQKGoz3WYSD5WZJltc+m185sD7CGjilrApDyaksDZJMwbXyJ45q/HpwSNNOjEMcAe7gHECVMBO1piFMW0qrzV41jmSLwEutgLvukrnIDLuTLGGgurhJ4AZ13pJ9XsWmgBg0tyl83r+6LkVbFhcOjKfBMc5YgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749291085; c=relaxed/simple;
	bh=MW/3oTeCkItIV+IcbwE5uKclLAw4nccfLFURd5hKIgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0hBI1s6teG8LXMWREzRRNFi+nIfTjFNnDNqj2S7IuV2+1TuG63aFBP7tpzTL4EWuYXbhr9s7ADmdAxVrXkpOP0rEtqZxclBNss2W7YdkEOgF5JsZHrxvT/13QJHXSzdjFHh7C8jaMoSdyZkjXOESEgXcauWCXjU+hhATsUZfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Fkr3QsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB9CC4CEE4;
	Sat,  7 Jun 2025 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749291084;
	bh=MW/3oTeCkItIV+IcbwE5uKclLAw4nccfLFURd5hKIgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Fkr3QsNtNgyAgwD8+jdb9Gu+T18RoJs3DOgGPBIV5UpS/jikerhnZestWYF8c1/Y
	 pPSqC+tSC8BxzUFdq2XgjDmejDjOa70uJnmK3B4ma25A3mTxhC1wAX5YfDgqb70KW7
	 WMNqYrPkCY4B6s0vGLDmych1ApWDalOL624EQdAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.15 31/34] dt-bindings: remoteproc: qcom,sm8150-pas: Add missing SC8180X compatible
Date: Sat,  7 Jun 2025 12:08:12 +0200
Message-ID: <20250607100720.934419813@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
References: <20250607100719.711372213@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit b278981b5ac109e6f6986b20a5cb19654aba8f68 upstream.

Commit 4b4ab93ddc5f ("dt-bindings: remoteproc: Consolidate SC8180X and
SM8150 PAS files") moved SC8180X bindings from separate file into this
one, but it forgot to add actual compatibles in top-level properties
section making the entire binding un-selectable (no-op) for SC8180X PAS.

Fixes: 4b4ab93ddc5f ("dt-bindings: remoteproc: Consolidate SC8180X and SM8150 PAS files")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250428075243.44256-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
index 56ff6386534d..5dcc2a32c080 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -16,6 +16,9 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,sc8180x-adsp-pas
+      - qcom,sc8180x-cdsp-pas
+      - qcom,sc8180x-slpi-pas
       - qcom,sm8150-adsp-pas
       - qcom,sm8150-cdsp-pas
       - qcom,sm8150-mpss-pas
-- 
2.49.0




