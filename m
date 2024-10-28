Return-Path: <stable+bounces-88826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9E9B27AA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18A6B21034
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF5918E35B;
	Mon, 28 Oct 2024 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LyetqP+N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3392AF07;
	Mon, 28 Oct 2024 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098209; cv=none; b=u1TvgaXJA4IoMOXhvhfDBEy0Jm3RiDE9JhkblONFUUJ3V0S/SXHIi5lsTYZgzXa7QEhiN1rIhVx9xKXpze7nKTQKDp+Qd4/hiXnbclfd8OFtbeonrOBIfzYV6+Apiz7u7/sj3RHRDokmv38i//LVCR8Msz6AYUGEISrHPe4vgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098209; c=relaxed/simple;
	bh=N0BK6ePbJwpjQ4fFsgeI1AEXNjXKzqu0sAnXswzcfkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI6+3oDdERo/iySoVC5pVw8fI9qN56q5ezr41pfE1ewEe6hdaI/NvsBrCHFSmp/NcmI8QhsnTmGaUCYtqbEnWNqAScSenc8+LAp/cYmZ9VeBIGX1/kl1atF3FBjA/DO5SqskyL7T3yp6IdIf/igJVLQZ4nO6T8SA8xRCBZauFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LyetqP+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F5C4CEC3;
	Mon, 28 Oct 2024 06:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098209;
	bh=N0BK6ePbJwpjQ4fFsgeI1AEXNjXKzqu0sAnXswzcfkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LyetqP+NvugWnli6WnUySQDpBSl25jfqFdcPW7Fc4Ktc+PcUXR/wvuGz/lUXg/paU
	 dUJThdei2AKt0dJP8Ybt599FoVtvcnyNMsIlDTmHF8dCTDPAmXte2XrGAsf5Nk6Lvc
	 JAcx3QQgVkXWJmJJHYBE/3jOVam+//Gh7M8SSiTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 125/261] ASoC: fsl_sai: Enable FIFO continue on error FCONT bit
Date: Mon, 28 Oct 2024 07:24:27 +0100
Message-ID: <20241028062315.169029245@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 72455e33173c1a00c0ce93d2b0198eb45d5f4195 ]

FCONT=1 means On FIFO error, the SAI will continue from the
same word that caused the FIFO error to set after the FIFO
warning flag has been cleared.

Set FCONT bit in control register to avoid the channel swap
issue after SAI xrun.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/1727676508-22830-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 5 ++++-
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d03b0172b8ad2..a1f03c97b7bb8 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -613,6 +613,9 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
 
+	/* Set to avoid channel swap */
+	val_cr4 |= FSL_SAI_CR4_FCONT;
+
 	/* Set to output mode to avoid tri-stated data pins */
 	if (tx)
 		val_cr4 |= FSL_SAI_CR4_CHMOD;
@@ -699,7 +702,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
-			   FSL_SAI_CR4_CHMOD_MASK,
+			   FSL_SAI_CR4_CHMOD_MASK | FSL_SAI_CR4_FCONT_MASK,
 			   val_cr4);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
 			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index dadbd16ee3945..9c4d19fe22c65 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -137,6 +137,7 @@
 
 /* SAI Transmit and Receive Configuration 4 Register */
 
+#define FSL_SAI_CR4_FCONT_MASK	BIT(28)
 #define FSL_SAI_CR4_FCONT	BIT(28)
 #define FSL_SAI_CR4_FCOMB_SHIFT BIT(26)
 #define FSL_SAI_CR4_FCOMB_SOFT  BIT(27)
-- 
2.43.0




