Return-Path: <stable+bounces-139785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9EAA9F81
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55DB3AA045
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA96284676;
	Mon,  5 May 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr6oRBb4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45B279358;
	Mon,  5 May 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483332; cv=none; b=QP6HpJw8z4PRAxOs/EopfRi9GFeAesDO6K1HBImoTJDZ7K9NAzlOTIXnJSaw10tr/ygjM5fhMPONzF/R/5sxovm/nGe88q76jKUoPQGegpCJx1OUFcFsaGXeuIdeCqoc02OwIKFwlvrdzl/D4AIzk4kjRlBhfywpZuHIVMuGt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483332; c=relaxed/simple;
	bh=VyHl2/k893g41M784F8ipECbATSeSfXZgCi/sJEuRbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nyCBbgT6y6CFNwTspPXHuLrKbNhG4L8nYR0DF/8bdCOHOnqKjiSxwCYj9+Okm0G8cXTVemEzXz4vDok6XI6uW3E6s6Hs+FtCfWQilokvG8tzLw0lOy+n/7d3sftOgNJaj2Vk/9SDhAFwsIGYhCKq404C3VkqkgygfET+rj+75OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr6oRBb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CE3C4CEE4;
	Mon,  5 May 2025 22:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483332;
	bh=VyHl2/k893g41M784F8ipECbATSeSfXZgCi/sJEuRbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kr6oRBb4fKPC4ukw1D8HH0RfEYYdgGhSCilAcQ9EZdMiVOrbrJDGSGlvPXajxoXqY
	 6pGIPeAwQ3fdv/Sua90nHz4K2ZYPVqAX9XDET+gqtdWW8VeyRWE+YUUAHLtB8G6lc3
	 ou9o+3BqjX8nXWQWVU5Y4BkFtVTpVaExy34zuhLc57V0CtqUPDi3vxab1z5AQHgBOX
	 11r9eRc9Z+hpmz101QEIMX2I5tCBqtan2mJsmRjQBNt+iSoUdtL5SLOxVott9us+JS
	 skpjZ+YYcmdBoiwUCtSB+wyUwtDo5wOZpM4vY5WnpFu+bm2a6+78lXRbjyWXdjIDXn
	 gYI+YZkPqq29Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Hsu <d486250@gmail.com>,
	Daniel Hsu <Daniel-Hsu@quantatw.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 038/642] mctp: Fix incorrect tx flow invalidation condition in mctp-i2c
Date: Mon,  5 May 2025 18:04:14 -0400
Message-Id: <20250505221419.2672473-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Daniel Hsu <d486250@gmail.com>

[ Upstream commit 70facbf978ac90c6da17a3de2a8dd111b06f1bac ]

Previously, the condition for invalidating the tx flow in
mctp_i2c_invalidate_tx_flow() checked if `rc` was nonzero.
However, this could incorrectly trigger the invalidation
even when `rc > 0` was returned as a success status.

This patch updates the condition to explicitly check for `rc < 0`,
ensuring that only error cases trigger the invalidation.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mctp/mctp-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index d74d47dd6e04d..f782d93f826ef 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -537,7 +537,7 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		rc = __i2c_transfer(midev->adapter, &msg, 1);
 
 		/* on tx errors, the flow can no longer be considered valid */
-		if (rc)
+		if (rc < 0)
 			mctp_i2c_invalidate_tx_flow(midev, skb);
 
 		break;
-- 
2.39.5


