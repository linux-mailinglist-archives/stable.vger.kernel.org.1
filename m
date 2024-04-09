Return-Path: <stable+bounces-37900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD289E259
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 20:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A72285A04
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27BE156C5F;
	Tue,  9 Apr 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=my.msu.ru header.i=@my.msu.ru header.b="gTDZkm4X"
X-Original-To: stable@vger.kernel.org
Received: from forward203c.mail.yandex.net (forward203c.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121715697F
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686468; cv=none; b=EOyPtrzC6jWP/cAATj/YSu7VbMN2LsYkGKBHzJODYV2odB+tgoK+ndsskozZeRQeMc+QSfxbfFb0E/JZILCIApnebV5LywLGRBdxs9cUBRYRk30Py/oUp0X9yZshEQvTjfzuGM1Kk81rBtbx2P+8jc0V5qBYxPNHZfMQiWMNR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686468; c=relaxed/simple;
	bh=SUDDbVFs86K85xanfN0pq/5n+zHOlS3lGHeNNVRyyo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kQ6bgL87ykSYrvl9Src5pu6xptPEiV4ouh8Skl4xU9Msc5TfGYDOzvYSqBeV0r6EkYk2YTCrxN4xl4/D7lGcup0QBFpN5LxfY5HPVC045SzUMFNnz3g6utaYaCNNydHvlN3kv9Q9nmNWeDu8//pDaEidMb3XTxa8RgE2w3BrqIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=my.msu.ru; spf=pass smtp.mailfrom=my.msu.ru; dkim=pass (1024-bit key) header.d=my.msu.ru header.i=@my.msu.ru header.b=gTDZkm4X; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=my.msu.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=my.msu.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward203c.mail.yandex.net (Yandex) with ESMTPS id 3999166639
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 21:06:54 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:a33:0:640:d837:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 7B9B3608E5;
	Tue,  9 Apr 2024 21:06:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id i6euFi3ZsGk0-N1PGzwU9;
	Tue, 09 Apr 2024 21:06:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=my.msu.ru; s=mail;
	t=1712686005; bh=rQUd9+3FoeHc/2WWp86KCL0DXvf3PRrHSiOkwAV3YCs=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=gTDZkm4XY+LgPeL07hHjdF1r/TSsLlmqLewT7iTI4wr9McuVrYmP743pjwziksFlI
	 HFRGz8VsD36hRtIWhKrOog05Bcbdz+Kqi0jJmL98mQbi42ym9VvV89QdnjpeC/jjp2
	 r+MPg1hvmW1hFmPjzqslr9XaSjKNjKOsj9sKxXjU=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@my.msu.ru
From: Elizaveta Gorina <gorinaes@my.msu.ru>
To: Elizaveta Gorina <s02220065@gse.cs.msu.ru>
Cc: stable@vger.kernel.org
Subject: [PATCH] memory: tegra210-emc: processing the null pointer of the nominal EMC table.
Date: Tue,  9 Apr 2024 21:06:43 +0300
Message-Id: <20240409180643.29652-1-gorinaes@my.msu.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elizaveta Gorina <s02220065@gse.cs.msu.ru>

If the device is unavailable, of_reserved_mem_device_init_by_name 
returns 0, and emc->nominal is not initialized and the null pointer 
is dereferenced.

Make a return from the tegra210_emc_probe function when emc->nominal 
is equal to the null pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0553d7b204ef ("memory: tegra: Support derated timings on Tegra210")
Cc: stable@vger.kernel.org
Signed-off-by: Elizaveta Gorina <s02220065@gse.cs.msu.ru>
---
 drivers/memory/tegra/tegra210-emc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index 78ca1d6c0977..a49a5e36ba34 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -1865,6 +1865,9 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 						    emc->num_timings);
 		if (err < 0)
 			goto release;
+	} else {
+		err = -ENODEV;
+		goto release;
 	}
 
 	if (emc->derated) {
-- 
2.25.1


