Return-Path: <stable+bounces-191086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE18C10FCD
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F8D188D58C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6132143F;
	Mon, 27 Oct 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNUkEp5a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145C32C943
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592970; cv=none; b=lEbej1bAoLLIvzOR/wqeYHMu4D3Qo6fexohinpC3tHB94ABayhAlHSnurKCPYwr+aov4AK95/9lSD5g3dvVJtavAqItKH8DaHytgKreSlSaKb7mltpi6nlMbvejykmlLjfOrF0XqZAMwd7LYUyqxRU8LY/cbZY+RUi591iKxng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592970; c=relaxed/simple;
	bh=XERnRwQl1P2r2tF0oWy7ADIeN5UJ9UoPQBNndXbndKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+6X9S/wn6Gj9zczS6k2+lyjYbhvPFUINgGLBgqratLrtiHlt2lRUVzgdSc3eakh6Fqe3W+1UaxIPb7hg38nvNpCv9EaHdLDdjjym370OCuOqnUzjA2cy6Z8vJNH87x6hIndMVc4K10DRPfPP4foTgu6sSJZ7IjsBfNzTi0YfpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNUkEp5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E46BC4CEFD;
	Mon, 27 Oct 2025 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592969;
	bh=XERnRwQl1P2r2tF0oWy7ADIeN5UJ9UoPQBNndXbndKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNUkEp5axAibVsjLGTsIvX9a2yT+SXU1huyKmTxAXM0m3AjnpXymJgIDVbDSrJ/ZK
	 OBIjFMwvXTEgOFCVsT983cEGbJxiNOGvqoANIXJIB5YB+thciU/p88lp/DEkV2cuk/
	 PaI+gfhagI811JsAObi8EEpXvCeG+oOKqv6sdghwaBOg2NNyB6aNcNCVZpy+KtMmGS
	 S8LEQ0vB7QYLBQQiXURUbCRuIrTHsmddaOQnqv/8T81h2vv1HGLqJAttnYTuuu8cI+
	 X2sxZ5QbtTZxcySuHviDXvSUEkdZPdjWiipAlpYYLURNF0SKCt+WAfma4h4TeVB5nw
	 +CG3UE/SWDzug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 3/3] serial: 8250_dw: handle reset control deassert error
Date: Mon, 27 Oct 2025 15:22:45 -0400
Message-ID: <20251027192245.660757-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027192245.660757-1-sashal@kernel.org>
References: <2025102701-scabby-entrust-a162@gregkh>
 <20251027192245.660757-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <a.shimko.dev@gmail.com>

[ Upstream commit daeb4037adf7d3349b4a1fb792f4bc9824686a4b ]

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
Cc: stable <stable@kernel.org>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
Link: https://patch.msgid.link/20251019095131.252848-1-a.shimko.dev@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 56506668a10c8..1521a743cc906 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -523,7 +523,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.51.0


