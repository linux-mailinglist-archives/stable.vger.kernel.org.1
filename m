Return-Path: <stable+bounces-158535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D9BAE8233
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178B75A44A6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93E25DCE2;
	Wed, 25 Jun 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="quS6p1z9";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="bp4AjYu9"
X-Original-To: stable@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1E25DAFF;
	Wed, 25 Jun 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852500; cv=none; b=UdjOTLiYzUCE8wyiwXAhOcSax4DyPlf4iamXduM0N5sv1Sj84P1G6FNQ9cJDv5PKFUSBBOn4qn/f3nc3Y6gKqOYSSQhwTiTT8ztjkSOKczZDe5VDacaRQJgFbLr/cI7pAujg+VYoXl/jc/ITOSUQzAUMVukLx6LQNr+3C+DkpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852500; c=relaxed/simple;
	bh=jiudyTm6de+eb570mlyoWFRyNxgO4jOMKOdAxyojKDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UmjenSU1eTB8xOTKl0OYx2Jn/sq1V4tkKcngAq6wU1P6jjB1ZkGkaM9llgxE0Xr99Z9i+iOACJSyvdhVnq3aLw87oQZf042F/DgM6569A8i7YecMLQVxuUirEBmVSdGV2x7Mi4NoQt86yL2LCnBYh4dJ3Juyl6Vt1AKxA3YbRSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=quS6p1z9; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=bp4AjYu9; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-03.yadro.com (localhost [127.0.0.1])
	by mta-03.yadro.com (Postfix) with ESMTP id D538BE000A;
	Wed, 25 Jun 2025 14:45:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com D538BE000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1750851950; bh=qPYba+iSHjLpzCbKcEcctCJst/76kJf0E4zmJ6khlis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=quS6p1z9nzv2AI795fRB+i2jcuVO/J6gkA+U2SR9Cr0PWgDrSs263CWnZ0EV00hLS
	 4e7DbkZ3/lghLuit6VhQlH/c9OYVso4Go7D2xchnk0kuaIk5von4WX2JqwLb9QaTpG
	 C6lzRtPGE2zydzBbjNp8VnfcCOyw1mXzjnEGqzKpGI5W/+1WY7oHwHMl6mf9jVOZ+h
	 HKimiK8XWcyh2HpLX6myW8f4+FYyZJmMTGz9fzRYeDhpbUa/AkixCyvj4VhBio/f0i
	 c234wrsovJwQMaVDfNjALD/5qCI2c6SjpMN0frJ7+iZh4lHFd1W7BTC2lk9RitNzLb
	 Dcugq4l8DtcuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1750851950; bh=qPYba+iSHjLpzCbKcEcctCJst/76kJf0E4zmJ6khlis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=bp4AjYu9Cts8L+B6z093nYPksiTjJlUjxOFu0MYG5ymyv37WkdCryvznK6VfqXIm1
	 PZo5j47ThNNUCmez2NCOxqdNMu4m3koTUveHqystqDxNeacb/jfa5KYom1/PCPh+lY
	 W/72P2J/lAAj97YP/5w+6UCFThhrogxfX+td/fRXMIKUpiQD0NlVtcCTJz4Rvkugsj
	 m9OScW59evQVoGaV9FxA20oLv587O9WpgMw+yC6iDJKDZSmk7ufgdWFGFj4gOij61I
	 th6aPzVFtRKsZBuxXEuCoD2oiL0j9yUw/0hDC2tga71ddoRV+0l5uoxngewgQjFTaL
	 QcfdA1ukor8Wg==
Received: from T-EXCH-10.corp.yadro.com (T-EXCH-10.corp.yadro.com [172.17.11.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-03.yadro.com (Postfix) with ESMTPS;
	Wed, 25 Jun 2025 14:45:49 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (172.17.11.143) by
 T-EXCH-10.corp.yadro.com (172.17.11.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 25 Jun 2025 14:45:48 +0300
Received: from NB-591.corp.yadro.com (172.17.34.54) by
 T-EXCH-12.corp.yadro.com (172.17.11.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 25 Jun 2025 14:45:48 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux@yadro.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] nvmet: fix memory leak of bio integrity
Date: Wed, 25 Jun 2025 14:45:33 +0300
Message-ID: <20250625114533.24041-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTM-EXCH-03.corp.yadro.com (10.34.9.203) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/06/25 10:41:00 #27589862
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2025/06/25 11:16:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

If nvmet receives commands with metadata there is a continuous memory leak
of kmalloc-128 slab or more precisely bio->bi_integrity.

Since that [1] patch series the integrity is not get free at bio_end_io
for submitter owned integrity. It has to free explicitly.

After commit bf4c89fc8797  ("block: don't call bio_uninit from bio_endio")
each user of bio_init has to use bio_uninit as well. Otherwise the bio
integrity is not getting free. Nvmet uses bio_init for inline bios.

Uninit the inline bio to complete deallocation of integrity in bio.

[1] https://lore.kernel.org/all/20240702151047.1746127-1-hch@lst.de/

Cc: stable@vger.kernel.org # 6.11
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/nvmet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index df69a9dee71c..51df72f5e89b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -867,6 +867,8 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 {
 	if (bio != &req->b.inline_bio)
 		bio_put(bio);
+	else
+		bio_uninit(bio);
 }
 
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
-- 
2.25.1


