Return-Path: <stable+bounces-220651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKuOM1E9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC761C6A4B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30BA4312C8A1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FEE48BD2F;
	Sat, 28 Feb 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntqXrEwL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33D3EEEC6;
	Sat, 28 Feb 2026 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300532; cv=none; b=bP+WBfWUtzJt0dH3qlS/uTctrnEOlD0tqgBZBOt/jjOuik49FJt/NqhZH7h3BcCDEzjnLi+YqFDEocPFw7N7j9rNatxyv0Swvi661tL+460E7CTjmMgXaqOAjFR+55Wsm2Vqa3WHk1Vhgmz6dMUdlnkdGAHKOVE9zau8Fxr+Lng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300532; c=relaxed/simple;
	bh=dsRGnfj4WmFvhxIQVRCBtspoV4yLgLut1kN03RfXVo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/vKtQMIT0osluTg+UCO6C2qljARfri9zrNHELcWFVcIOD+oz69FXTyyFH+Jd5Kq5kdaiDKqDflCxPR38Xps9+vPIdCORnPdQBeKFgZGnbyZwBVwEL3elBq/C0mONpfiiNpTG3HW0QPCDnInHJqb764C8kWHtIJ4n0uCyoDH/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntqXrEwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D3C19425;
	Sat, 28 Feb 2026 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300532;
	bh=dsRGnfj4WmFvhxIQVRCBtspoV4yLgLut1kN03RfXVo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntqXrEwLjirl4OfI1kjiFBjyBQYMP2VR9IbAgIVUzZpccGbJBBDoVJu0REmhGxNyv
	 V24uElV4zA8gy93Ml4hMIBsB5Hu/wv75tuS6KJYO5H1N5oPcYIc8NKl9c45AzZ+DBm
	 +Gppr4v3W2Py42T3lNj7spk/2xYV5w/GOfWAm1VUfRC7Vc5hTpQZGlJ/JGv0F/soek
	 LJwW3L7j+zYkIybxkrYu2dOEaeUM94jX7NhgVfN9WGyJLqq49pPpo7sF0R4bDHXxgq
	 1vSRsTUxXv+X57cu/sjbVBQqRnoAhRxuyOWyZEyMjhkkXu6NQEELx5Gf7IoZ8aV7S1
	 dJu7M85ZjuSvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 572/844] media: cx23885: Add missing unmap in snd_cx23885_hw_params()
Date: Sat, 28 Feb 2026 12:28:05 -0500
Message-ID: <20260228173244.1509663-573-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220651-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 3FC761C6A4B
X-Rspamd-Action: no action

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit 141c81849fab2ad4d6e3fdaff7cbaa873e8b5eb2 ]

In error path, add cx23885_alsa_dma_unmap() to release the
resource acquired by cx23885_alsa_dma_map().

Fixes: 9529a4b0cf49 ("[media] cx23885: drop videobuf abuse in cx23885-alsa")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-alsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx23885/cx23885-alsa.c b/drivers/media/pci/cx23885/cx23885-alsa.c
index 25dc8d4dc5b73..717fc6c9ef21f 100644
--- a/drivers/media/pci/cx23885/cx23885-alsa.c
+++ b/drivers/media/pci/cx23885/cx23885-alsa.c
@@ -392,8 +392,10 @@ static int snd_cx23885_hw_params(struct snd_pcm_substream *substream,
 
 	ret = cx23885_risc_databuffer(chip->pci, &buf->risc, buf->sglist,
 				   chip->period_size, chip->num_periods, 1);
-	if (ret < 0)
+	if (ret < 0) {
+		cx23885_alsa_dma_unmap(chip);
 		goto error;
+	}
 
 	/* Loop back to start of program */
 	buf->risc.jmp[0] = cpu_to_le32(RISC_JUMP|RISC_IRQ1|RISC_CNT_INC);
-- 
2.51.0


