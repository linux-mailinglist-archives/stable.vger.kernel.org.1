Return-Path: <stable+bounces-137800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958EDAA14F8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FF51694AB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A1D24113C;
	Tue, 29 Apr 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmmOxHar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493321ABDB;
	Tue, 29 Apr 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947166; cv=none; b=JxDnY+Fszz0/9O3OCzKKeXPuFtKiXvj6BrLY/s5t/1Zg9FVIQUZz2XWPgr05UQI+HlAYrpHOnfbdsmImYsA8r+5MIbIDhDFcu3dqYS5ZuJhJPtjg5+4Yzwo032BOfR0pCPrHYBwULFUn4ciqkH3ajMyg83NEoek/OMKl9LEC1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947166; c=relaxed/simple;
	bh=qYpHFr2l5P2mIz7Zi0kpcaPEiRoCiUw7Dr8t3T5O4l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKgYD3O9iJ3LKgEqNAEwoKo8qO9DcOCV4lFQAN3Gxstlcc82fkSalZYJeAr1CKYGCeUgQXAGf2V6zNoRx2dkVYpOOuR7ViFGDZAVhEQbOlNU9ZwkDT2vTkm2UIWdWMFp5oWC8iiYvy4uImaioo21gUy2AAwrZEzq+tcbwF1hDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmmOxHar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3BAC4CEE3;
	Tue, 29 Apr 2025 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947166;
	bh=qYpHFr2l5P2mIz7Zi0kpcaPEiRoCiUw7Dr8t3T5O4l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmmOxHarmsz5BDImgiYvMcpOXw7SOytyG+DzAloTMugP9BDIM4TvdYmClvimBDC0E
	 P/7pJ+R+himJu39JWNDhDI/AXdeYkaCE2lAdA35RGAxWlcB5Nnu3DraTbuqCPFXAXY
	 5cO4RUfilWFUMHi0kgM1BWzpH2J/LzWATdTESsvQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Feng Liu <Feng.Liu3@windriver.com>,
	He Zhe <Zhe.He@windriver.com>
Subject: [PATCH 5.10 192/286] pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
Date: Tue, 29 Apr 2025 18:41:36 +0200
Message-ID: <20250429161115.865681539@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

From: Kunwu Chan <chentao@kylinos.cn>

commit 5d7f58ee08434a33340f75ac7ac5071eea9673b3 upstream.

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118054257.200814-1-chentao@kylinos.cn
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/ti/omap_prm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -381,6 +381,8 @@ static int omap_prm_domain_init(struct d
 	data = prm->data;
 	name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
 			      data->name);
+	if (!name)
+		return -ENOMEM;
 
 	prmd->dev = dev;
 	prmd->prm = prm;



