Return-Path: <stable+bounces-135139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01755A96E3B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3ACA188B7E8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92F284B51;
	Tue, 22 Apr 2025 14:21:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CD283C87;
	Tue, 22 Apr 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331712; cv=none; b=MZzUlXQI864wJjhneHyrXE5W5id23XaJWgmxGA3txlNckf2nKG88gp8CDeLcJMis9i3L8P5k00J9GHd3PLkBRBgfs1bGOr9T017KBMnKwbta40jhaJXw63JxPvVZj1UYdGd1jiDYomGxIYPoedAG9fZqGTgyhuNx6/ltKMF/Z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331712; c=relaxed/simple;
	bh=g5xB4UqWKbc+aaRLpSWtpbb8zpdO0C59mGSdnrVCRm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dVFS8T1UZRGmlsn10WB4l0jpCP0LT/jUhmaY+Mz6lZEkxkgDt1w7klbskRHD8YKVHpUdCirBKrHWPfNZlllYdvlkrR4gbsFP2rmZp4/L5bJqU5xih43x+tPyu34H6iAoQypNeyAIZBkhxPR3mbKUj6fZbELCyJbb4ElOLN7RjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE33E438C1;
	Tue, 22 Apr 2025 14:21:46 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peko@dell.be.48ers.dk>)
	id 1u7EVN-009vHX-2k;
	Tue, 22 Apr 2025 16:21:45 +0200
From: Peter Korsgaard <peter@korsgaard.com>
To: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Kalyani Akula <kalyani.akula@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Korsgaard <peter@korsgaard.com>,
	stable@vger.kernel.org,
	Kalyani Akula <Kalyani.akula@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmem: zynqmp_nvmem: unbreak driver after cleanup
Date: Tue, 22 Apr 2025 16:21:12 +0200
Message-Id: <20250422142112.2364822-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefrvghtvghrucfmohhrshhgrggrrhguuceophgvthgvrheskhhorhhsghgrrghrugdrtghomheqnecuggftrfgrthhtvghrnhepveeiveethfelteelueelvdffieevgfdvtdeivdetuefgffdtvdeuffevheegffdunecukfhppedujeekrdduudelrddurddufeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudejkedrudduledruddrudefjedphhgvlhhopeguvghllhdrsggvrdegkegvrhhsrdgukhdpmhgrihhlfhhrohhmpehpvghkoheskhhorhhsghgrrghrugdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepshhrihhniheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepphgvthgvrheskhhorhhsghgrrghrugdrtghomhdprhgtphhtthhopehprhgrvhgvvghnrdhtvghjrgdrkhhunhgurghnrghlrgesrghmugdrtghomhdprhgtphhtthhopehkrghlhigrnhhirdgrkhhulhgrsegrmhgurdgtohhmpdhrtghpt
 hhtohepmhhitghhrghlrdhsihhmvghksegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: peter@korsgaard.com

Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
changed the driver to expect the device pointer to be passed as the
"context", but in nvmem the context parameter comes from nvmem_config.priv
which is never set - Leading to null pointer exceptions when the device is
accessed.

Fixes: 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
Changes since v1:
- Cc stable

 drivers/nvmem/zynqmp_nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 8682adaacd692..7da717d6c7faf 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -213,6 +213,7 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 	econfig.word_size = 1;
 	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
+	econfig.priv = dev;
 	econfig.add_legacy_fixed_of_cells = true;
 	econfig.reg_read = zynqmp_nvmem_read;
 	econfig.reg_write = zynqmp_nvmem_write;
-- 
2.39.5


