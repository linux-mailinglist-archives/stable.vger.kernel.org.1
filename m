Return-Path: <stable+bounces-44842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A78C54A3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FEB1C23289
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C1612DD87;
	Tue, 14 May 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xGLeNECc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301781736;
	Tue, 14 May 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687334; cv=none; b=u9VB8R4Ho/9xG7MqHPX9UYxzf0IwVeE3+vqrriHhTOfzHYkqamH2xueWGl7IrioyVbpl/N0HzzSMU/RfAi4aiVvvTvoxVt0csKsd6tnnfHW6kwGHybd+0Q8prt/ZYorLGzdpzktJKoiv9K0JxZtp0EzmLKEgy7Iv7/Zdeagygsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687334; c=relaxed/simple;
	bh=ul2o3YBXmh8zRe6WpbsmXBAehj6VV2/eITwF4wnQDpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwUT8brqMfGSOKMq+TZPSrhq0ewX7eL7gfcFDVwUeDTiOf4BcUPFB0nd+1hNME8GUg+iuMHjT8exUtaZHT1aYukDBgdibOTro4uJkZAcvV0NBCaAudG7qsHEqDauOCBsCG+SY0feWIjEcNbgGN+W97JIi4yj+vsLgWjvmckJ3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xGLeNECc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC5DC2BD10;
	Tue, 14 May 2024 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687334;
	bh=ul2o3YBXmh8zRe6WpbsmXBAehj6VV2/eITwF4wnQDpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xGLeNECc6abDlOp1oXfYgsURUitQm2n96CdACpnwUrTmJ5wn4Xnv4x282pevqvzzb
	 jTubKJpC6peNXcJ4hTOHBtnQ5hB+rlrh4fnAxZSz1JIlBfjhdTX8z88EmaKCKFdzyJ
	 RPnVyKzyo81HaKKahdSF7Irln9dY6HGABJT2cgkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 029/111] net: qede: use return from qede_parse_flow_attr() for flow_spec
Date: Tue, 14 May 2024 12:19:27 +0200
Message-ID: <20240514100958.234203952@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

[ Upstream commit 27b44414a34b108c5a37cd5b4894f606061d86e7 ]

In qede_flow_spec_to_rule(), when calling
qede_parse_flow_attr() then the return code
was only used for a non-zero check, and then
-EINVAL was returned.

qede_parse_flow_attr() can currently fail with:
* -EINVAL
* -EOPNOTSUPP
* -EPROTONOSUPPORT

This patch changes the code to use the actual
return code, not just return -EINVAL.

The blaimed commit introduced qede_flow_spec_to_rule(),
and this call to qede_parse_flow_attr(), it looks
like it just duplicated how it was already used.

Only compile tested.

Fixes: 37c5d3efd7f8 ("qede: use ethtool_rx_flow_rule() to remove duplicated parser code")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 413e8331a0ce6..6e2913f2a791a 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -2011,10 +2011,9 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	if (qede_parse_flow_attr(edev, proto, flow->rule, t)) {
-		err = -EINVAL;
+	err = qede_parse_flow_attr(edev, proto, flow->rule, t);
+	if (err)
 		goto err_out;
-	}
 
 	/* Make sure location is valid and filter isn't already set */
 	err = qede_flow_spec_validate(edev, &flow->rule->action, t,
-- 
2.43.0




