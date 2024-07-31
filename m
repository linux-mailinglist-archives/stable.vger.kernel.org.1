Return-Path: <stable+bounces-64882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B44943B72
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07812842F9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27315187FFD;
	Thu,  1 Aug 2024 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZv2f3KF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CF187FFA;
	Thu,  1 Aug 2024 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471282; cv=none; b=UV9buH5F0+pYhVvvff7MWBlcJF0Lnd23Rr+W3d25Z7F3ffp+jCrUAnGlFpHwooTJverfvkzqLQQpdEZZc81Ykp+N1DwdHcjjzeVybkP1m55ZM9QBtyvremPA6IQRJRWK6E7G11vJ3lZOSmwdR3xmg1ysHuRL2mOkvq/WTKZA7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471282; c=relaxed/simple;
	bh=Bc5Taipso1fqVciO7ePiE9y5gkfK5eXG07pjnUEMhwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY9VsZJAsnPLi68W6yLCkEoZKq820dblDO0uFgU981myAtEgdIROpzB7gqlH/VlVPxKuBOHbZ9OgTaAg9QE+YPAEgXZC8C9DsG1na+8ThnvlEHLnjtCPzJM73fH0RDGZdr0eWtwketR/NRNaqTLqo1gHa4PateViyGAR/3CJ97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZv2f3KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4107BC32786;
	Thu,  1 Aug 2024 00:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471282;
	bh=Bc5Taipso1fqVciO7ePiE9y5gkfK5eXG07pjnUEMhwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZv2f3KFRNBeDj4j/w0+aNq5NywyEiivFO1MRFkIwEtw+mrc+3GmaWNnpbsAXh3Re
	 pO+VVMIZM7ySj69/IAXJDlaDViFjdym0KZaZHFzivJLoax13d+lz+wQq59yD3/yjXp
	 wLW6JLLRu1WRk+6hI+hDoLUltLMd/UmbGrw76cGyo83SaT1mcA8DD1ZWuSXklAUk50
	 t5EHLUpn8MB5LKVVfUPcAdYHuhg7FxNIpUQkLGFWeoEhZNRNG0e8dNGqYPjsGA84di
	 NJI8F6m533aFC4UVcFs9Zo47XWkuK8LuqMozRkiZ3Lnka5MCK6w8TgMuX0CVSFcjEw
	 MV8EbhopnecFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	andersson@kernel.org,
	matthias.bgg@gmail.com,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 057/121] remoteproc: mediatek: Zero out only remaining bytes of IPI buffer
Date: Wed, 31 Jul 2024 19:59:55 -0400
Message-ID: <20240801000834.3930818-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 9dbd9962cfe56d210be5232349851420b5f9c8f6 ]

In scp_ipi_handler(), instead of zeroing out the entire shared
buffer, which may be as large as 600 bytes, overwrite it with the
received data, then zero out only the remaining bytes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240520112724.139945-1-angelogioacchino.delregno@collabora.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/mtk_scp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index b8498772dba17..b885a9a041e48 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -117,8 +117,8 @@ static void scp_ipi_handler(struct mtk_scp *scp)
 		return;
 	}
 
-	memset(scp->share_buf, 0, scp_sizes->ipi_share_buffer_size);
 	memcpy_fromio(scp->share_buf, &rcv_obj->share_buf, len);
+	memset(&scp->share_buf[len], 0, scp_sizes->ipi_share_buffer_size - len);
 	handler(scp->share_buf, len, ipi_desc[id].priv);
 	scp_ipi_unlock(scp, id);
 
-- 
2.43.0


