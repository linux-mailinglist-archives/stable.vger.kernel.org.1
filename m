Return-Path: <stable+bounces-6001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37180D840
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15807281403
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643651036;
	Mon, 11 Dec 2023 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XxxPbM2+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6FFC06;
	Mon, 11 Dec 2023 18:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEF3C433C9;
	Mon, 11 Dec 2023 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320245;
	bh=piXqMfp9pOV4IsDMyhlrGZiNIJ2L5mVFYocCaZHCXKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxxPbM2+iq7LgVljzJwctEzkMoo1VOiBwm7gAGyKTq51UczIcfPxyHUEYz8TOCM1i
	 7oMus1il4W4SKkzJWAlsEkzs3NTzd0YC6+bZHaq/4nQOqtd5M/la0Ejr8nTIER99LX
	 qWvO8V1fz8CbCRu4sQT+5ktawLxCLFWiNK9sOFPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 29/67] ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate
Date: Mon, 11 Dec 2023 19:22:13 +0100
Message-ID: <20231211182016.314192131@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 29046a78a3c0a1f8fa0427f164caa222f003cf5b ]

When wm_adsp_buffer_read() fails, we should free buf->regions.
Otherwise, the callers of wm_adsp_buffer_populate() will
directly free buf on failure, which makes buf->regions a leaked
memory.

Fixes: a792af69b08f ("ASoC: wm_adsp: Refactor compress stream initialisation")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231204074158.12026-1-dinghao.liu@zju.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index aedfa6b2895bd..8df5f3bc6e974 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3649,12 +3649,12 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
 					  &region->base_addr);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
 					  &offset);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		region->cumulative_size = offset;
 
@@ -3665,6 +3665,10 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 	}
 
 	return 0;
+
+err:
+	kfree(buf->regions);
+	return ret;
 }
 
 static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
-- 
2.42.0




