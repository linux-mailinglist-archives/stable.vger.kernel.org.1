Return-Path: <stable+bounces-54733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F031910ADC
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CD5B21D20
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4731B1435;
	Thu, 20 Jun 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I3r9Sdp9"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D81ABCBF;
	Thu, 20 Jun 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899253; cv=none; b=jXIyBiQi5nHMDGzKwzT3thKO8pq2OFmepGMWZEYFiKAGuDTf5MEyuQZaqIYM18nZbkHnuVuLjZVV9cxGrlDqS/aakEchH7jTyWDxBz8FG4a54QxOfCEn6EXe8n3/nseWTGgfChd9w+qmEs4hW6Pq3qZLLtW7cz3rxc9gHslaZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899253; c=relaxed/simple;
	bh=rJM+D5PH3kqPic0ADY5loNOYTxEPv/8iwGbPEq8sfeA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DXRsd1WEDicC9HiHbYB+GprYtcvZyapgEO0AUOLJ6esnkQ96YVyMGJ3+Kxwnjg10IocOZq/NKPzXr6zoMe9+7NgM9Bdmq6JBKkzlEMb7vigFcx6FlglkGcLZGzNxyrC/3PTAQMMWzBTQRS8AXSgPIT1gWY/Mv7cy8JeOubPpzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I3r9Sdp9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718899248;
	bh=rJM+D5PH3kqPic0ADY5loNOYTxEPv/8iwGbPEq8sfeA=;
	h=From:Subject:Date:To:Cc:From;
	b=I3r9Sdp9qSW2ec7GEGgz5FtnuiePScpM6q34VzHBp0dyGRefoMm7a7F5WOHPci28e
	 EJ04G49KDHiCVNeqYUYWbz5f5XZ8+eydTRJm5SfT1nibRAtsvmjCY94qCtE9ohnCgV
	 f1xNcM5OMQ7jPvBXnPJVPqMEGillhsSyQ2T1vycE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] nvmem: core: one fix and several cleanups for sysfs
 code
Date: Thu, 20 Jun 2024 18:00:32 +0200
Message-Id: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACBSdGYC/x3MTQqAIBBA4avErBswsR+7SrSQmmoWamhIIN49a
 fkt3ssQKTBFmJsMgRJH9q6iaxvYLuNOQt6rQQqpxCAFumTJ4ubtbR50xhKOWo2KJiP6QUPt7kA
 Hv/9zWUv5ANqs06hjAAAA
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718899247; l=898;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rJM+D5PH3kqPic0ADY5loNOYTxEPv/8iwGbPEq8sfeA=;
 b=ISvcnr/LjNAVapn0AS4+jf0UQVqHRaYoAjAjgQjNJuRDO7almwYiRuvsBUQ6aNOPs7unchN2+
 YbC54ZaFY4IDRsc7xmRK6Ox+6tgLJoU2/7QhPMX+sbs5ovSYQbbvpuS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Patch 1 is a bugfix.
All other patches are small cleanups.

Hint about another nvmem bugfix at [0].

[0] https://lore.kernel.org/lkml/20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      nvmem: core: only change name to fram for current attribute
      nvmem: core: mark bin_attr_nvmem_eeprom_compat as const
      nvmem: core: add single sysfs group
      nvmem: core: remove global nvmem_cells_group
      nvmem: core: drop unnecessary range checks in sysfs callbacks

 drivers/nvmem/core.c | 52 +++++++++++++---------------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)
---
base-commit: e5b3efbe1ab1793bb49ae07d56d0973267e65112
change-id: 20240620-nvmem-compat-name-79474e8a0569

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


