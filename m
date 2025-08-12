Return-Path: <stable+bounces-169085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E53FB23818
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED17B1B673E6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644D21ABD0;
	Tue, 12 Aug 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUienhcJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3231F37A1;
	Tue, 12 Aug 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026327; cv=none; b=Asj+LbhWKyRBcS0kNl+njG4Z3rYjNpQZ9gPVUviaVVEvOMd/6241AuKXo8G+ovFuoc6pEC3sjL1/058iS1PnIpIL+uWkpqFYXxh4sYAAqROgicpO4HK9S4YmEWcYh6Ns9F0GhJ1g7tidoJhO7k/8BsgdkMg/FzLowWsy8n89PYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026327; c=relaxed/simple;
	bh=lHTWw81mUyEuSblEd+CZD6Aclu7wsq+MZb5HkMKKI9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1d7Cu4uu8d7OEVmHhCH2kWDrfTzGSc9MQjQpqq18eDCBT4p8sshBV3py7NTqV4+IFegoJT6VBF9TYHDbqRu7g9u3VKlnz691PoNzuqDWDQ6UvsTZWOVATWCyZb1mH79liz7RzJxa1tXDkKIbToCmt4nS18lcFp0z9hbS98JOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUienhcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FC8C4CEF0;
	Tue, 12 Aug 2025 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026327;
	bh=lHTWw81mUyEuSblEd+CZD6Aclu7wsq+MZb5HkMKKI9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUienhcJKc4xbFhj48leTiE6VUaqMG6xMe+VknsF3/xPOnMIDQ/xq7dp79DUS1pk2
	 9biCT1XWCV9Ptq9HFICmwFLpzsw/XZzZ9DkBtZ0yoHB+1nnoilrK8BPVmh+C00kuEu
	 PJEyPPFOFiCTosI5njI3vezk2nA3wzlSiRK2W+OA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 305/480] mfd: tps65219: Update TPS65214 MFD cells GPIO compatible string
Date: Tue, 12 Aug 2025 19:48:33 +0200
Message-ID: <20250812174410.012153524@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

From: Shree Ramamoorthy <s-ramamoorthy@ti.com>

[ Upstream commit 6f27d26e363a41fc651be852094823ce47a43243 ]

This patch reflects the change made to move TPS65215 from 1 GPO and 1 GPIO
to 2 GPOs and 1 GPIO. TPS65215 and TPS65219 both have 2 GPOs and 1 GPIO.
TPS65214 has 1 GPO and 1 GPIO. TPS65215 will reuse the TPS65219 GPIO
compatible string.

TPS65214 TRM: https://www.ti.com/lit/pdf/slvud30
TPS65215 TRM: https://www.ti.com/lit/pdf/slvucw5/

Fixes: 7947219ab1a2 ("mfd: tps65219: Add support for TI TPS65214 PMIC")
Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Link: https://lore.kernel.org/r/20250527190455.169772-2-s-ramamoorthy@ti.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index fd390600fbf0..297511025dd4 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -190,7 +190,7 @@ static const struct resource tps65219_regulator_resources[] = {
 
 static const struct mfd_cell tps65214_cells[] = {
 	MFD_CELL_RES("tps65214-regulator", tps65214_regulator_resources),
-	MFD_CELL_NAME("tps65215-gpio"),
+	MFD_CELL_NAME("tps65214-gpio"),
 };
 
 static const struct mfd_cell tps65215_cells[] = {
-- 
2.39.5




