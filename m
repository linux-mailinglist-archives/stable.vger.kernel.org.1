Return-Path: <stable+bounces-194207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC84C4AE8F
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D06C18981B4
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C933FE17;
	Tue, 11 Nov 2025 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LHExqxRD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65E26D4DE;
	Tue, 11 Nov 2025 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825056; cv=none; b=YATvPtCHRBTpZwsAPgeTBBv5t+irOCzBemg6VmDPHnD00OiKBB39dxoXicS7FxvZHkVPfv7jvfqHGVDgtFn7dFLmu/K42rwF+PyvxX6+XPCIsTI7gyonRYNciwoEzXsEjjB5bm58vOevAt8t1H9KduDizqrM2j6ZTCUsxsQ+Bek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825056; c=relaxed/simple;
	bh=Cx9Dge65hJhnHJKG569+pXuaeLO0Qi+SoKWWs5vKC2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHuvnNoUNc5xSfHFlLvydP6jqkJL9nPkWdNiUdSru1Y8SsLkHpKc89tU5Gyhi6HAwCJluasZq+B3bVPnZnTabVXfU2xixb8JtAzCbWtpprw6N4skP+C8IgwlerjEg6uqPNL9e9qujjnEk6CRaiBPRpiezCNOp4oOuFbodCokBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LHExqxRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E71C19424;
	Tue, 11 Nov 2025 01:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762825056;
	bh=Cx9Dge65hJhnHJKG569+pXuaeLO0Qi+SoKWWs5vKC2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHExqxRD4VhYizIXkASxXFSH+FMXTD4X1d1JZmVDCzr54UcHvTUt7dAyxZx79E3Zj
	 mXmVdbS6AZLFRJpFMhWCdmUU1cQtoTbnxJgHx0xnoZVBd1OJluz2p0BDJ6/xJetiTW
	 CjDNOdAcx69I03xeUusY/rpbHRkrTfB5cGTnD+ho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Yusuke Goda <yusuke.goda.sx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 642/849] ASoC: renesas: msiof: tidyup DMAC stop timing
Date: Tue, 11 Nov 2025 09:43:32 +0900
Message-ID: <20251111004551.952204787@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 25aa058b5c83a3c455a2a288bb3295c0b234f093 ]

Current DMAC is stopped before HW stop, but it might be cause of
sync error. Stop HW first.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Link: https://patch.msgid.link/878qi3yuu0.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/renesas/rcar/msiof.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
index 3a1a6496637dd..555fdd4fb2513 100644
--- a/sound/soc/renesas/rcar/msiof.c
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -222,9 +222,6 @@ static int msiof_hw_stop(struct snd_soc_component *component,
 		val = SIIER_RDREQE | SIIER_RDMAE | SISTR_ERR_RX;
 	msiof_update(priv, SIIER, val, 0);
 
-	/* Stop DMAC */
-	snd_dmaengine_pcm_trigger(substream, cmd);
-
 	/* SICTR */
 	if (is_play)
 		val = SICTR_TXE;
@@ -232,6 +229,9 @@ static int msiof_hw_stop(struct snd_soc_component *component,
 		val = SICTR_RXE;
 	msiof_update_and_wait(priv, SICTR, val, 0, 0);
 
+	/* Stop DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
 	/* indicate error status if exist */
 	if (priv->err_syc[substream->stream] ||
 	    priv->err_ovf[substream->stream] ||
-- 
2.51.0




