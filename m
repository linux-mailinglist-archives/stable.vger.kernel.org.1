Return-Path: <stable+bounces-77581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D4B985EC6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B11B1C24EAC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37EC1D0E3C;
	Wed, 25 Sep 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7X5IaAu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B231D0E34;
	Wed, 25 Sep 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266372; cv=none; b=dY+VOQ9ODdOn3vf+a5TMojUGve2s/PmDbMfvQISEQeYAltNoIMMDd/Ke2LAHiMHpQqEqY5YyFpOSAt/uTEUCBTP4E7fex1oLXeDAuaSsJYvefPEtXzRBnUbwdJ9iFW4d6rfJDn6HyYHibsUFsjQX+/X21XMCK4zfvi0lUjfC+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266372; c=relaxed/simple;
	bh=9IRNg8ZOA1sAvJKuEazEXaenBvmF93GsAjK4zvuSPXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIcE0BHpEm/tsaSwN3GJXGzXuRSeoKyV6NUv1rG/AVoHIjwX6axjH0iUi8MqyydIpKFCEk4D10i03ta07uX2V4eB4YhVY8hkudDqm4Rwz0PghdAba1aVoNgKjw+hJJ1xiRCWQMWIeywZkku6vnsF3sJnetqdHL7sdIyBaGF3qiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7X5IaAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076DCC4CEC7;
	Wed, 25 Sep 2024 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266372;
	bh=9IRNg8ZOA1sAvJKuEazEXaenBvmF93GsAjK4zvuSPXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7X5IaAucKhhoj/NPNMA249mxeoa48dEAOluqUCr+4xCUjb+QqTyzt8loBIBAfYpl
	 pGElcDicS1sd6/ylML5Me20Mm+LLciGN/MWM642P5q4ekSm381R59YJNDg9hKjy4fK
	 p1lVeGh15JYWqI3Ek6pgU0tQ0yV//YrmsEFGrLTJgKoJ2E0gmFgY0ky2Sli4x+dWBd
	 2MV7BpgEmZ6YaE4+XUNB+rz33my81DvRSKmvgw+MVhjOWtSnfGqHH4hRSEeWtblVVZ
	 Fi2gmW5mQJ/v913yAG+XbfyamnwJMjSIBsvSevqx+5jrn9rT6T9dDAjZFmWTX+5mCs
	 7PBGrzU2vUrmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 035/139] bnxt_en: Extend maximum length of version string by 1 byte
Date: Wed, 25 Sep 2024 08:07:35 -0400
Message-ID: <20240925121137.1307574-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit ffff7ee843c351ce71d6e0d52f0f20bea35e18c9 ]

This corrects an out-by-one error in the maximum length of the package
version string. The size argument of snprintf includes space for the
trailing '\0' byte, so there is no need to allow extra space for it by
reducing the value of the size argument by 1.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20240813-bnxt-str-v2-1-872050a157e7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 3c36dd8051485..2e7ddbca9d53b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3021,7 +3021,7 @@ static void bnxt_get_pkgver(struct net_device *dev)
 
 	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
 		len = strlen(bp->fw_ver_str);
-		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
+		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len,
 			 "/pkg %s", buf);
 	}
 }
-- 
2.43.0


