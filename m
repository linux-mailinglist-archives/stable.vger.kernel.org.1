Return-Path: <stable+bounces-112968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7313A28F5B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794533A66BF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32515696E;
	Wed,  5 Feb 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvfiJFQT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174C155A30;
	Wed,  5 Feb 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765370; cv=none; b=a+hi073bEINpZTQK6JlvW7syrQ2frs2i9aw6QkH05n9leIljMx8BhyX1Mqp02AJVRdiH9Yn53Z4B4qskvHoEQw8kuylMZnc04WQk9JfNvC337/G4YwUxbh66lLEw+6DpsSLhjKMh/i/tRczw1QJmHaxQE/LUj4CqSFNiQdWoIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765370; c=relaxed/simple;
	bh=pQkT87eykZB5+Lo2TZyLY+d8wMya631JOGSy1vfUPVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8sst2E/s/1oA+Od7r/Ztq/gFuTJ9Wwd9slYcP+n/Pt99lYIX3C68TiAhKrt1YoAAel5v99jxCShhdSBsnrtQYX2UW0+epmmyr2VTxMo+GlqKzd/1Of0NhzUOvm0ckpZcbsdpkAYlQJri75hzTJYe9MJNAniOmQhWBZ1g4J/7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvfiJFQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1156C4CED1;
	Wed,  5 Feb 2025 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765370;
	bh=pQkT87eykZB5+Lo2TZyLY+d8wMya631JOGSy1vfUPVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvfiJFQT+56nF1rYgScO7xnNrNlkgFi3Td/KiI8amqEKKdz68KkH/6PKW+cUHRSG9
	 gGmfrxO3ycWYM+TzIfUGUI4CFkW5YyrnqRIa2N5VDybNtGILnJo35uy+OgZtlBj9Ma
	 +2oyJ9FxVB6ILUOD7HokD2Hn68QYnuHQ0FiQwlyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 172/623] clk: ralink: mtmips: remove duplicated xtal clock for Ralink SoC RT3883
Date: Wed,  5 Feb 2025 14:38:34 +0100
Message-ID: <20250205134502.815773396@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

[ Upstream commit 830d8062d25581cf0beaa334486eea06834044da ]

Ralink SoC RT3883 has already 'xtal' defined as a base clock so there is no
need to redefine it again in fixed clocks section. Hence, remove the duplicate
one from there.

Fixes: d34db686a3d7 ("clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20250108093636.265033-1-sergio.paracuellos@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ralink/clk-mtmips.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 97b8ca0f91816..19d433034884a 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -266,7 +266,6 @@ static int mtmips_register_pherip_clocks(struct device_node *np,
 	}
 
 static struct mtmips_clk_fixed rt3883_fixed_clocks[] = {
-	CLK_FIXED("xtal", NULL, 40000000),
 	CLK_FIXED("periph", "xtal", 40000000)
 };
 
-- 
2.39.5




