Return-Path: <stable+bounces-218573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFDyA7JTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407C18F9AE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3490731593D0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327E256C84;
	Wed, 25 Feb 2026 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EfcecpeB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E401D5141;
	Wed, 25 Feb 2026 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983415; cv=none; b=FKRjxVaDLJeAITO+KwuwAHmsgmTSBjgiK1FCJG95TPz5xBKonwKlanB0WiuOd5iARz+frnIeEoO7YGNHvQt4mxNW6qBk0Wxh7dkeqcjWddGIMswBOaoGGAE+bqWOBsG3RIsyvoK0WWNMt9R253OIfNxaufw46wHs+f7Po5JeY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983415; c=relaxed/simple;
	bh=lpGUkWsqdrnYYmpgEnPhlbQ6ptR7CSb+UbRnsi0zpZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYGZWIFkxsK4nWekPqCUvwFv7O38AR3G/sBz8AxP2BqzAN5wA/MXe1YNMTWIKzZDMXuRepquty6NkKpZdZ+uvFpWiUqmzReO6JQZDSVgDaNWrLgb85ITft+v/MkHYzFv12qj41Libfu1lcF5sbnpW2fsLwldYhfXspBDKYTpxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EfcecpeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D47BC116D0;
	Wed, 25 Feb 2026 01:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983415;
	bh=lpGUkWsqdrnYYmpgEnPhlbQ6ptR7CSb+UbRnsi0zpZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfcecpeBXle3V1S9AXoMgUaoaPdu+Dfj7UziG2h44hgBatde4fcjzArlryeg6MUIY
	 jCZnBG3CU8LDeGoQm8+fyM/ktziY/FvgAqjJ012kXJwmTSvhmnSSSu53DgklaLdW7b
	 C9BaYXwKR1oo2Jz8J799lJEsGMLHCj6Lho0FoM6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	George Moussalem <george.moussalem@outlook.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 528/781] clk: qcom: gcc-ipq5018: flag sleep clock as critical
Date: Tue, 24 Feb 2026 17:20:37 -0800
Message-ID: <20260225012412.749671138@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,oss.qualcomm.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218573-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6407C18F9AE
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Moussalem <george.moussalem@outlook.com>

[ Upstream commit 04c4dc1f541135708d90a9b4632af51136f93ac3 ]

The sleep clock never be disabled. To avoid the kernel trying to disable
it and keep it always on, flag it as critical.

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251128-ipq5018-sleep-clk-fix-v1-1-6f4b75ec336c@outlook.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5018.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index dcda2be8c1a51..64792cda06202 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -1340,6 +1340,7 @@ static struct clk_branch gcc_sleep_clk_src = {
 			.name = "gcc_sleep_clk_src",
 			.parent_data = gcc_sleep_clk_data,
 			.num_parents = ARRAY_SIZE(gcc_sleep_clk_data),
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.51.0




