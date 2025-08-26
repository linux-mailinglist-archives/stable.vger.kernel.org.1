Return-Path: <stable+bounces-175567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217FB368BE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D7C1C81D80
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2FD34166C;
	Tue, 26 Aug 2025 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyZGZWxG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65621D3F2;
	Tue, 26 Aug 2025 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217385; cv=none; b=sYtSlE7g8Tocoyda9OLd47PbR15Uu9a8vt9+Wfmmi0WxfqzN2zPw7dsucaRZbrUXPJwNtkB4lR/n9KRiz56sRzfNVCI8ngtTDrNf1gv3d2UG1rwFp6mZy2FMdDK2XncXYOT3OK5nLPet/LztliZLgtc+sZMI1zkEQmprg0zO+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217385; c=relaxed/simple;
	bh=ODWWMA8sZCLZXEH/rE+EZ2CBuWxunC349OKk4vldwLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N78hyf0LrEexk6gucimqm6Lg5tfv7LqOSO9BsBfdNW8lb6mPIhA+JC+V5AZLWu4EriZj3QhxavVTu8fc6ucnJpVb3tRKed6KnJo3to+xR2cgZ9hAiV9cU5N0iL5dx/Or4M8cSOgrPGDbsmJKhk3CLbfkh0iHN4kjSRqPVpK+a14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyZGZWxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B4DC4CEF1;
	Tue, 26 Aug 2025 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217385;
	bh=ODWWMA8sZCLZXEH/rE+EZ2CBuWxunC349OKk4vldwLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyZGZWxGbt3ZXbjiotuI2CKXzrrGbHaBk5oA2eQoGE4bzLALujLEk9ilJ94dC3Uh3
	 /8p5/6hGCqbS0QuQGsUv+dYHm0QCd+gNzKFlQceKAyZ/obhxDDLgLmR9eGWPrsea67
	 gtTsYOEKM7toztE2OmQF03IoV0tHulFnw/UoFGvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	David Lechner <david@lechnology.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 123/523] clk: davinci: Add NULL check in davinci_lpsc_clk_register()
Date: Tue, 26 Aug 2025 13:05:33 +0200
Message-ID: <20250826110927.548755369@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit 13de464f445d42738fe18c9a28bab056ba3a290a ]

devm_kasprintf() returns NULL when memory allocation fails. Currently,
davinci_lpsc_clk_register() does not check for this case, which results
in a NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue and ensuring
no resources are left allocated.

Fixes: c6ed4d734bc7 ("clk: davinci: New driver for davinci PSC clocks")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Link: https://lore.kernel.org/r/20250401131341.26800-1-bsdhenrymartin@gmail.com
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/davinci/psc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 7387e7f6276e..4e1abfc1e564 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -278,6 +278,11 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
 
 	lpsc->pm_domain.name = devm_kasprintf(dev, GFP_KERNEL, "%s: %s",
 					      best_dev_name(dev), name);
+	if (!lpsc->pm_domain.name) {
+		clk_hw_unregister(&lpsc->hw);
+		kfree(lpsc);
+		return ERR_PTR(-ENOMEM);
+	}
 	lpsc->pm_domain.attach_dev = davinci_psc_genpd_attach_dev;
 	lpsc->pm_domain.detach_dev = davinci_psc_genpd_detach_dev;
 	lpsc->pm_domain.flags = GENPD_FLAG_PM_CLK;
-- 
2.39.5




