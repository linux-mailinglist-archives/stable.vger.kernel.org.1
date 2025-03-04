Return-Path: <stable+bounces-120200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D8A4D247
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 05:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CED77A8B09
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 04:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6F1155335;
	Tue,  4 Mar 2025 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NpGnhPDU"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AB14830C
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061191; cv=none; b=CWRtuXOijDhcyVhwv2Aa72YjbEbxfXBJOmpPotqOqp2fF4siWXGMhnYUY2TyWOTkb6FTAVZLvdZO8CYkbuVuc4um6rBGFjcgExnODqlStMsDpcx5q/3W//VzpU31uYFq7PGH8Kr23cgyUdaj842M8r2qwHYP2zx6ohH7BdrXMr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061191; c=relaxed/simple;
	bh=d/xqdnAiDKTTeeP4czuGhJW4zsQfWqYQzwFf4e65qoM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=L0qqJNODXtbioJBUD+lnZfljqhMRdkHFguSvU5WXdTbwzF7disNdGeA9j65+Sgg7PCvEuSjsc2o3XN0mGMUhdE2AxQupUZvqehCpekxe4rzt5wnT9wCytYxUXLhiSvViWCRwk/Lv0wp3A5P5UT0VLYjjqJJt02Bkn7z9ozvFZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NpGnhPDU; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741060871;
	bh=E55k4+zqh1RB7s3TGJPflRRpxfwQcK85uLL9WU0qDi0=;
	h=From:To:Cc:Subject:Date;
	b=NpGnhPDUtp9v5z50cZQNuO85iXpRM3N8JARMxVcdlMDxflKFr0Fe9NDrhGpHmTq48
	 4ISQajPql9aXbLapA0PS5aV1hPNE5poQZSq1Vl2itsSuC1vSWvJNkLSuuSE5mvuVXk
	 Oc8M2aixgeFz/vY6xDcrW+PKqUPfjc/GPLGpUHHE=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.6])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 2C9A4BA; Tue, 04 Mar 2025 12:00:44 +0800
X-QQ-mid: xmsmtpt1741060844tkn0mzxc9
Message-ID: <tencent_636B6A9C2718A3062A5AAA1AB18F61C93907@qq.com>
X-QQ-XMAILINFO: NJt1ldX8apYopnkgomcRFt++MTxWIG+O1/XKwuFQJLT9jEE/pXuZRbp6rjoojI
	 eFa8LCRefrz0v4aq+7zeijZ+RQKK7YyGvf9dVxGosDKbVS0P5/lOPffa5PZU9w3n1+hRHmqB6n1L
	 TXvmcKuG2FbaRjKO2Z+Uc9VffQnhkxRonlp1VLYRgrQUyh17ceqlIEURIl4Ce8/ormTst5ZVrLKV
	 v406hIhTEugEdwqNUThJckSbMO9eXtsgoAu1Iw42hFqRdBstgJ3lJAuK4+qgZr2U86LuSY2yxY7b
	 Lt4RD3ijLKBTUo4eqWtLB1sWRJT5icmFiWHQXDcO3dbRkW6tRW+gGpINv//hwHbBQ+KJUVK0uGiC
	 vyiMiMtM55e7T2ZGMX2x4rZg7C7NPFbRgCt7RhoQmRTKU7NrUGzJjN0KMlrya9nFZhLanbDCySyj
	 Z5aJ2tdbV/PA4mKuJpl7XgmvZisjDXspYqPjpJC1ELmy8op6jX7/tSGCjh6jrKO31HnQtdyzmARQ
	 nHPcd3A/OxE5413GUS9gOQ5MVMVcNPd37+Auefo3+1yhyVsnsULXZsrBHh+snU46QeFPxBQ0hivL
	 tEWtBwYm+sF/FMXWqnbqklKrFL+eiVOZ/Q4w6dcKFkmNMHKJaOXbJ1NzRX5FcwECMmxzTJsw+CNO
	 2F5BJG2MA7kVr/KnVbIdZ7V0G/CxJLAOXop/z177wj2dJ830AVSiOXNDtKroNrCwpiZQviuTgirg
	 7HWEhPmUAORW82CrLMn6+9xt6hOxkpNfqCqcSD5jmNEH9AASDho4+PE5MkFkeaQHSBYjXtzQSFyx
	 BzhYrPSRUHYiSGZUoGkmp6oaZEWeVqwRGLjV4frLDjyAFfwlH5adLAc9fZL0Fd96hbbPk3JYucOr
	 3kW91/kAcr+XrwqFy5IAVP4fMfKsEkD+SHbwvS/tHzgzbK5eEdt6RZS2ZVbK67dCeuozfmhmuzYo
	 wf+JrfPLwEzHQRXbk5FwOAKWq/1qB9CenTDpCB6a5MFmQ45l/foebaxCA200T4
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Irui Wang <irui.wang@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Tue,  4 Mar 2025 12:00:39 +0800
X-OQ-MSGID: <20250304040039.1072-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Irui Wang <irui.wang@mediatek.com>

[ Upstream commit 59d438f8e02ca641c58d77e1feffa000ff809e9f ]

Handle an invalid decoder vsi in vpu_dec_init to ensure the decoder vsi
is valid for future use.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[ Replace mtk_vdec_err with mtk_vcodec_err to make it work on 6.1.y ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index df309e8e9379..af3fc89b6cc5 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -213,6 +213,12 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
 	mtk_vcodec_debug(vpu, "vdec_inst=%p", vpu);
 
 	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
+
+	if (IS_ERR_OR_NULL(vpu->vsi)) {
+		mtk_vcodec_err(vpu, "invalid vdec vsi, status=%d", err);
+		return -EINVAL;
+	}
+
 	mtk_vcodec_debug(vpu, "- ret=%d", err);
 	return err;
 }
-- 
2.34.1


