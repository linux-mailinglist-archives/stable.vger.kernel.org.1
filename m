Return-Path: <stable+bounces-141298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27814AAB6A2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88947B0FAD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115ED3375B0;
	Tue,  6 May 2025 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a37VC0Xm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D682D7ACE;
	Mon,  5 May 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485718; cv=none; b=YNqqV9Rhpk5g9auvbiPPJ7LALjP1OHfux+4HSZs+yS7hS3LMR0yh8jgV2+mvT1jW633bWZewk6p6ZA5amCPs6UjVxr36WooCVJngRj9H0DFJ35zEPYKcQ15EwUXuDtQkGkWEfqq/acLY1c1YDehIiJK8u3+M3wSjIx2xFxgCEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485718; c=relaxed/simple;
	bh=UXvFLmfs8bghKD7VvTkhQY/+NiuR/G8Dw2o10m91Zjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZzsRV1R9Wp6kYXm0eawoAw8SFdWACIt5mbIo+7iooWdSwS4aZsSH4cTImtSBfwdCt366s4xVsJwshLPCZb2Jeaf+Ijp+vt+1PWaZWglKf5phF/eazvgf8Hd1prlpnx1oibk3bKG9THTDTBFvJgc8YpgUyPo4ecn8mpxJRrqRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a37VC0Xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AF2C4CEEE;
	Mon,  5 May 2025 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485717;
	bh=UXvFLmfs8bghKD7VvTkhQY/+NiuR/G8Dw2o10m91Zjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a37VC0XmD75qWICE+gq3kV+q2tynHCkXYCa9++RXMK+K+Z57WkMQuCtRGKFDEX+bz
	 S/3zdlf4wEdHzJtuj611x0CduMlQSduwPzGvXiQnUO45jZn82ZxH0bb2Jr2ffVYIUj
	 2auNjxosrjKYvvNT1JPsi3N+vxf92S1/bZR+8I5T3+7i1FEWtDKRvYrIygJj+V9vl4
	 QlLOT98irQ4hMMkFSmZDY1RJcg6VWzbS9SyEcD3wv0RD67DmOEjkuLHNqRqy/u/P1L
	 TKeOQIwB4oun6g82OoeR1WVSwyrI9McvP8Z0zAvqtH544W58fz5TNya5hleMhDrTUB
	 bwMYaP2oIRGVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	mlevitsk@redhat.com,
	peterz@infradead.org,
	ernis@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 440/486] net/mana: fix warning in the writer of client oob
Date: Mon,  5 May 2025 18:38:36 -0400
Message-Id: <20250505223922.2682012-440-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Konstantin Taranov <kotaranov@microsoft.com>

[ Upstream commit 5ec7e1c86c441c46a374577bccd9488abea30037 ]

Do not warn on missing pad_data when oob is in sgl.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://patch.msgid.link/1737394039-28772-9-git-send-email-kotaranov@linux.microsoft.com
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 36802e0a8b570..9bac4083d8a09 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1044,7 +1044,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 	header->inline_oob_size_div4 = client_oob_size / sizeof(u32);
 
 	if (oob_in_sgl) {
-		WARN_ON_ONCE(!pad_data || wqe_req->num_sge < 2);
+		WARN_ON_ONCE(wqe_req->num_sge < 2);
 
 		header->client_oob_in_sgl = 1;
 
-- 
2.39.5


