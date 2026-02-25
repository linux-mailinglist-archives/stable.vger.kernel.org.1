Return-Path: <stable+bounces-218641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKflLDZUnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D0118FC2B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F0431A6E6F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA225EF9C;
	Wed, 25 Feb 2026 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1yqbQNT8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11461E2834;
	Wed, 25 Feb 2026 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983491; cv=none; b=WD4m/njwNhwLo0dyF0wXvlXc7UAtBEtyl8RXARyEULP+4tEwrUgAt7nKYzh2i1sVkdPCIVB9gl4QGltdcyIMmBFIawhTsFxAfWpxRLKpE8riFjYdbJ1QjiJoIKylaqdMs2jU9AvfM4he/RtQvnyyy9Lrs/5SsERTdIdAcQiFR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983491; c=relaxed/simple;
	bh=yXbyKBw5kMcxWZXl3IL36c06mTezPJIwQXyT2k5AQxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtU6x6u2NebN5nq6dzlyi8TQ4cl5p3UmF39AJQC1AhslwQQwYpYonmFLpvLaUyojJP8tENLIiQc9kM8XRnmwaO79edo447atrHvohNx0AADddeKec+tlf/+r5P3t2D0vaHL/XqSLHg62mDRI1eRl+FAxoCBfLSghdrvzukWKS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1yqbQNT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBDCC116D0;
	Wed, 25 Feb 2026 01:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983490;
	bh=yXbyKBw5kMcxWZXl3IL36c06mTezPJIwQXyT2k5AQxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1yqbQNT8UyKrQ9qCSUxFdBIUJKqxN3UhvyAhPYHf4d3lvdHivqmRBIjckp+yL3cY8
	 Q5vGxn3AUnUpJo9t+j9Znm3MET0GHzvc59KAkgZaU6ve5O3J9DeNrSiaICYQW9nTx6
	 AD9Opacs3LAMAGBzxxq3ZebUFSLtbqC1qM3JhLGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 602/781] pinctrl: qcom: sm8250-lpass-lpi: Fix i2s2_data_groups definition
Date: Tue, 24 Feb 2026 17:21:51 -0800
Message-ID: <20260225012414.561196924@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218641-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:email,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 37D0118FC2B
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit eabf273c8466af3f033473c2d2267a6ea7946d57 ]

The i2s2_data function is available on both gpio12 and gpio13. Fix the
groups definition.

Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
index 64494a86490e2..c27452eece3e6 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
@@ -73,7 +73,7 @@ static const char * const i2s1_ws_groups[] = { "gpio7" };
 static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
 static const char * const wsa_swr_clk_groups[] = { "gpio10" };
 static const char * const wsa_swr_data_groups[] = { "gpio11" };
-static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
+static const char * const i2s2_data_groups[] = { "gpio12", "gpio13" };
 
 static const struct lpi_pingroup sm8250_groups[] = {
 	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
-- 
2.51.0




