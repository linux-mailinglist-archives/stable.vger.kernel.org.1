Return-Path: <stable+bounces-170822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982CB2A65A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE121B61D1C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A64322535;
	Mon, 18 Aug 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PxXDj6JB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82E321F59;
	Mon, 18 Aug 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523908; cv=none; b=f5Sg8HMXeHcK2zooJXEy31WuFKRZRIxB429DfdY4pWhXeHVp/v2MrAF56UOYWsjZpdVhXcIQ9o3ZBJg2k/5cdzxvQpB9D4TgH4qK1zyag28QQrhMZ8gb8oY7LEvQGjAt0t6OXfC7YC1B1Fnm+zMC4WFrpe0TI18mTmc68VXMn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523908; c=relaxed/simple;
	bh=WRS0GIm1JDt6825izcPW4tkH5t+3YLUfJgR1nV7ne7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyrwfdAuVQTTTTlFPI9I11vMAd8VHAzy1rshsxbzQ+srpCsXhxtAOUX4Hkyt98+oGkTYHZpLYztnxZWfq0duqtr8Tb2Dxozgmi+1mVGHb/GX+xXtBbKEBMX1LALZ7O2d+PTnPJcVkNh7ERLmBxoz7SHUyyLMZMemsZhMnmNDIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PxXDj6JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C0C4CEF1;
	Mon, 18 Aug 2025 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755523908;
	bh=WRS0GIm1JDt6825izcPW4tkH5t+3YLUfJgR1nV7ne7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxXDj6JBWTFw8Epn5f/BaBeT+7/jL4jmFXLnDzleT89iwASe/br92XMUDWI+OvHlR
	 fhTQgrsICJRkYH0VSpINe0XMhLNjVy2ST2XuU1jrqrgHwwGNfbItmdx3J+bP9ZRmjo
	 d9/M2YXy6BEIsDw5+xW/WXOTulAnLF/S5SYED/ps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 309/515] ptp: Use ratelimite for freerun error message
Date: Mon, 18 Aug 2025 14:44:55 +0200
Message-ID: <20250818124510.331933593@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit e9a7795e75b78b56997fb0070c18d6e1057b6462 ]

Replace pr_err() with pr_err_ratelimited() in ptp_clock_settime() to
prevent log flooding when the physical clock is free running, which
happens on some of my hosts. This ensures error messages are
rate-limited and improves kernel log readability.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250613-ptp-v1-1-ee44260ce9e2@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 36f57d7b4a66..1cc06b7cb17e 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -96,7 +96,7 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 
 	if (ptp_clock_freerun(ptp)) {
-		pr_err("ptp: physical clock is free running\n");
+		pr_err_ratelimited("ptp: physical clock is free running\n");
 		return -EBUSY;
 	}
 
-- 
2.39.5




