Return-Path: <stable+bounces-122778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38927A5A130
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DCE3A4BA9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D422D7A6;
	Mon, 10 Mar 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z2mL5rIN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E91C4A24;
	Mon, 10 Mar 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629473; cv=none; b=LY8GXKuEoFdT9z8RObYN10xjy5uwOUzHF/PhublzfRttL3u/Cpd7wePucWhczM2ZPao6UJRuXZMndejy7h1J6ErRTSSUWlAiURuL2YTwV7Gd7EZ+IncB36Kuc6kGn0nmZov99nD5iEITaxB/SY6pyFUEQSrWzllabtX0YF67k/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629473; c=relaxed/simple;
	bh=4LvZGxKKh8IWjOccrn3+GsxytJY1We92YwNp3QqlRFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZAQ3buLBME+k/KaG98xgUNjjir+amnHGYTI+z9juGBImiyNhYQigZ01clgq+v7eCXQyFTNovYGd4+keOsf5wHIMYHy2S1txNwSN437T6nGQHMbL+IgIGhKqFVwBL1gqjUoTkHtswVU0tlROnTbRPBYJw/iFgjxX7pF1iul7D+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z2mL5rIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002FAC4CEE5;
	Mon, 10 Mar 2025 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629473;
	bh=4LvZGxKKh8IWjOccrn3+GsxytJY1We92YwNp3QqlRFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z2mL5rINl3tQUYnndtq4Q597y/NsvZdbjeMTmaBY6X7/rivu44D7vXaCG1Ev/5syZ
	 juKuSMO/DdJXuSlAQMyADKSmka/fFUGczgg2Qsh45sU58Sdu4gz974AtA/FJ4L3UwZ
	 h5RoK4Kx+d5wyUFPeAgz+fKmlUGn2RFtNzg/xW9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.15 306/620] soc: qcom: smem_state: fix missing of_node_put in error path
Date: Mon, 10 Mar 2025 18:02:32 +0100
Message-ID: <20250310170557.698288179@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 70096b4990848229d0784c5e51dc3c7c072f1111 upstream.

If of_parse_phandle_with_args() succeeds, the OF node reference should
be dropped, regardless of number of phandle arguments.

Cc: stable@vger.kernel.org
Fixes: 9460ae2ff308 ("soc: qcom: Introduce common SMEM state machine code")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240822164853.231087-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/smem_state.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/soc/qcom/smem_state.c
+++ b/drivers/soc/qcom/smem_state.c
@@ -116,7 +116,8 @@ struct qcom_smem_state *qcom_smem_state_
 
 	if (args.args_count != 1) {
 		dev_err(dev, "invalid #qcom,smem-state-cells\n");
-		return ERR_PTR(-EINVAL);
+		state = ERR_PTR(-EINVAL);
+		goto put;
 	}
 
 	state = of_node_to_state(args.np);



