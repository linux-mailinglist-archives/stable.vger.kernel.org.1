Return-Path: <stable+bounces-171460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43921B2AA77
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BD6E1EDB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DAB3218CB;
	Mon, 18 Aug 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SRSQsyjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBC3218B2;
	Mon, 18 Aug 2025 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525998; cv=none; b=Vi5jjhhbG4vnSyqyz2zBm+7soOWYKAZFoEbgQ+Nk9LCCKa2Yznb3N6ThJt33sEeqJdcLXWiIQnAjEVo4YIa/C6GS6VKfXwfL3EiYvLZ84QjhvtX5w3rBqavitDDtOACQPe3shfioN85PPG5K77qmXuEp488T+WLOEqcqBPz1gTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525998; c=relaxed/simple;
	bh=sLjCnFa7DMctnpia6Kw7wlKToDYKRURPeoGNBKtIgJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPlHGCCu2HIcS66FA7cgnxON14rAP4epYUONql7qhyFKPhuLEOWBZapj22Hgjwc8OotIJhINYY5XYtVzVrndnmr8MHJIoPc3ZxUk2bZ4Hzt/+2jo0KjL6a2kSMcS6J4N9RlgW0mBu9Cxu9sZrkUxoJItxuwKr4gAC4CO1TYl0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SRSQsyjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57493C4CEEB;
	Mon, 18 Aug 2025 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525997;
	bh=sLjCnFa7DMctnpia6Kw7wlKToDYKRURPeoGNBKtIgJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRSQsyjUhoMWcnw4HOgyGQyHOSVN3zvRaOYSoiOQIql51HzuP4tOhBN8l2UROuCKf
	 hchWW4kKrpjNuJBx7/2fASveBBhePu94F58jc80tdaNKm+nXbRhlJg3z4jfharFJlS
	 agKtoBSl3cL9ffIY+0q2+4hJ8zCbQF8fGSZzDuww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jorge Marques <jorge.marques@analog.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 429/570] i3c: master: Initialize ret in i3c_i2c_notifier_call()
Date: Mon, 18 Aug 2025 14:46:56 +0200
Message-ID: <20250818124522.362270129@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jorge Marques <jorge.marques@analog.com>

[ Upstream commit 290ce8b2d0745e45a3155268184523a8c75996f1 ]

Set ret to -EINVAL if i3c_i2c_notifier_call() receives an invalid
action, resolving uninitialized warning.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250622-i3c-master-ret-uninitialized-v1-1-aabb5625c932@analog.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index e53c69d24873..dfa0bad991cf 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2467,6 +2467,8 @@ static int i3c_i2c_notifier_call(struct notifier_block *nb, unsigned long action
 	case BUS_NOTIFY_DEL_DEVICE:
 		ret = i3c_master_i2c_detach(adap, client);
 		break;
+	default:
+		ret = -EINVAL;
 	}
 	i3c_bus_maintenance_unlock(&master->bus);
 
-- 
2.39.5




