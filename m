Return-Path: <stable+bounces-184968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7DFBD4B64
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575FC4263E3
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7A30FC00;
	Mon, 13 Oct 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hm42WFue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B52FB978;
	Mon, 13 Oct 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368956; cv=none; b=FPrsFBnyFLwJz6g2d25L8sZuhIcNkUJD65AtLHKqfiUdQlEOJCyzyAftPTerXnuKTpLG/gNWEZr/QztiFNFllhHM8ybsl018/I4VFMJAuJ/RbDZUp74OxuiHLOwD/3+tggxMFvZJxvgXJvo/GYmiroxQi4bcbo5wkS8K7DGdd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368956; c=relaxed/simple;
	bh=dMs3zjubW0TKTUTbJUsa2otpMvGP79ZJ+1rwlqh/zkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4TztwZWeX8C2dWEbT3vgOyXHEM/ifH4j9YKe/YYFZv7Bps4Bkt4jqjg7esiEmwHRDX98sxCQ/Y2ZC+dnsCvWRv5liqVeVifUbMPsC8VQ/IyiIT5WD88wvm2Ppwf1QKDbi5yQd9wiW/e6UAFmMEDC9dN4kT0pfOoEM/Q3Vw8Zx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hm42WFue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84AAC4CEE7;
	Mon, 13 Oct 2025 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368956;
	bh=dMs3zjubW0TKTUTbJUsa2otpMvGP79ZJ+1rwlqh/zkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hm42WFueVcU7URy9ABPrmtAYUH2KacswB1OSj3bC3WHiQ3exbd8N2KB89nkNYWlM+
	 vFetITuPW8OJ6cGPoypV1TA00FyKPwmk4aXydeollpwJ1ve4uM7AeZbIayYFXJIzmC
	 scGeFY91R3nFNhgnUoC75He+bkLajnAiANrJfqnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 077/563] regulator: scmi: Use int type to store negative error codes
Date: Mon, 13 Oct 2025 16:38:58 +0200
Message-ID: <20251013144414.081215564@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qianfeng Rong <rongqianfeng@vivo.com>

[ Upstream commit 9d35d068fb138160709e04e3ee97fe29a6f8615b ]

Change the 'ret' variable from u32 to int to store negative error codes or
zero returned by of_property_read_u32().

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Link: https://patch.msgid.link/20250829101411.625214-1-rongqianfeng@vivo.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/scmi-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 9df726f10ad12..6d609c42e4793 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -257,7 +257,8 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 					  struct device_node *np,
 					  struct scmi_regulator_info *rinfo)
 {
-	u32 dom, ret;
+	u32 dom;
+	int ret;
 
 	ret = of_property_read_u32(np, "reg", &dom);
 	if (ret)
-- 
2.51.0




