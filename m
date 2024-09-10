Return-Path: <stable+bounces-74635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CC597305F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46A61C249D6
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DE188A28;
	Tue, 10 Sep 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MGXccNRw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4518C35F;
	Tue, 10 Sep 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962378; cv=none; b=u8DtzRxy2OWE1j4S6WMVYapHZHSNSPcgU4qrXruJSmzi6TJ3JOY7MecnhZOnCo86KqEcSze3Elm64LkB21O5vMNYlfMtoWMzYMGA7WuSquuIy6R3FMt8rB9w74flRpOFjQBlZGa+EkVnBA8MnHoSrBDiRwX7LvDwq5BagZ85spU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962378; c=relaxed/simple;
	bh=s7K0ZvOhzvG8y3YWXvRYdhlXTzpWIpndfu5LfePIJhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMoZ/FRQPXoqRcKs/ig8q4yAYTktueh48DG3EGKJzZPGk/AB6tWuXQai7YJpqhX4iKJZmWFjnXW3Hfk6B38++LjUFeJsL1NvRd+k5ftfw5Usgd4PJGRaXpSrU4DHXIYdyuD4+4jZT4Tvtan5lY5u08oSzKIcayv/wjvzlJbDwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MGXccNRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A2C4CED4;
	Tue, 10 Sep 2024 09:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962377;
	bh=s7K0ZvOhzvG8y3YWXvRYdhlXTzpWIpndfu5LfePIJhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGXccNRwIaFoCCgnUHqkDBVxDSmO6avndbF2X1yVpK4uh9EKuw/BbM96Iyadow581
	 CpTQxoptcNgtf9LoF7ZgqkAiuJYMAzLswq3NyjMO7GQwu4ix256dWEV2A20+02SlBR
	 EzjcKrS+x1KBgg7btczV3Qonvrtj8R+CREXwgLfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/121] ionic: fix potential irq name truncation
Date: Tue, 10 Sep 2024 11:31:29 +0200
Message-ID: <20240910092546.426265960@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 3eb76e71b16e8ba5277bf97617aef51f5e64dbe4 ]

Address a warning about potential string truncation based on the
string buffer sizes.  We can add some hints to the string format
specifier to set limits on the resulting possible string to
squelch the complaints.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Link: https://lore.kernel.org/r/20240529000259.25775-2-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7adad91617d8..20e5e0406c88 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -143,7 +143,7 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		name = dev_name(dev);
 
 	snprintf(intr->name, sizeof(intr->name),
-		 "%s-%s-%s", IONIC_DRV_NAME, name, q->name);
+		 "%.5s-%.16s-%.8s", IONIC_DRV_NAME, name, q->name);
 
 	return devm_request_irq(dev, intr->vector, ionic_isr,
 				0, intr->name, &qcq->napi);
-- 
2.43.0




