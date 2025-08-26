Return-Path: <stable+bounces-173965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14DB360AC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9448C3BD604
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916A1F1538;
	Tue, 26 Aug 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QdpBjleK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1B1C860B;
	Tue, 26 Aug 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213132; cv=none; b=QXybZd+7fnwM6nVyn8wN/dwiHp7BEZdss6LcHfYDMEgiyFTmj1p5n/rFQKouOgaIVzIaBhGhSaCPiMaVxAUBGJwUexrZhJ2NRNLio2Aa9cKmNkQmp2ANFOtBNC75RduMag17lepuEGl+UxE4hi6H6s7au/Kd0BofwDARKGN2X2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213132; c=relaxed/simple;
	bh=FJ0axlwM966oBZQhpwT2TmO/35Dzqxq5O6TpY49YVC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA8C66jHMINd47WoMiBFRlwrO2WdQFILISUpvJ4mcxEqPnZy9n5qs8cICcOCnOAGkqy2k8hhvG1r+UZx938GuTrM23WLabrU5560nuIB3YmSUjjz2dc+y2TCkdREe5Sad3f6oVfyFFWWY49bdPoOPUbEWL80Fr9AIaaLp/YRH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QdpBjleK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26323C4CEF1;
	Tue, 26 Aug 2025 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213132;
	bh=FJ0axlwM966oBZQhpwT2TmO/35Dzqxq5O6TpY49YVC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdpBjleKjLZOr/75u1KRZLoJg5h2mmMdOUu5EM6nXYxJc9Lb0U5LzwYOjCun7/Y9O
	 SS5K3U2d3qfK//sjv+jD+JY7iI46T+K3xE7YhPNlH0eNdfZJsTApRUoEnS8L9igggn
	 CvE3GgGjnUXkhoV6TjsQnSGvgvxrA2J8ncveA/BY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	jackysliu <1972843537@qq.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 234/587] scsi: bfa: Double-free fix
Date: Tue, 26 Aug 2025 13:06:23 +0200
Message-ID: <20250826110958.885962637@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: jackysliu <1972843537@qq.com>

[ Upstream commit add4c4850363d7c1b72e8fce9ccb21fdd2cf5dc9 ]

When the bfad_im_probe() function fails during initialization, the memory
pointed to by bfad->im is freed without setting bfad->im to NULL.

Subsequently, during driver uninstallation, when the state machine enters
the bfad_sm_stopping state and calls the bfad_im_probe_undo() function,
it attempts to free the memory pointed to by bfad->im again, thereby
triggering a double-free vulnerability.

Set bfad->im to NULL if probing fails.

Signed-off-by: jackysliu <1972843537@qq.com>
Link: https://lore.kernel.org/r/tencent_3BB950D6D2D470976F55FC879206DE0B9A09@qq.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bfa/bfad_im.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index a9d3d8562d3c..0ec76d1cb6fb 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -706,6 +706,7 @@ bfad_im_probe(struct bfad_s *bfad)
 
 	if (bfad_thread_workq(bfad) != BFA_STATUS_OK) {
 		kfree(im);
+		bfad->im = NULL;
 		return BFA_STATUS_FAILED;
 	}
 
-- 
2.39.5




