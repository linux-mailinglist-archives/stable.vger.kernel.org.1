Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12BF6FA62F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEHKRO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjEHKRE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CE33513E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DCC5624B6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C72EC4339C;
        Mon,  8 May 2023 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541021;
        bh=kbfSuyAVn2SuyuFdrBDNCPwhfJaP8kGqgu+w4R3o/3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFPOGWuVYoJio/c7wPf3tzC+hn9S41uN5USjv8hY8VZ3XKI/3Z9eP19mA2VCdyKK0
         jxmsoMvVq26y7skgWLe81MEZTc7iILGixx9Wlq7Q+TJTT4+AE/O++5sixEplTnipUW
         ZRBRPCAkcfT8j/Qn04+IAxe1uibfhfcVuKPibC0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yifan Li <yifan2.li@intel.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 555/611] PM: hibernate: Do not get block device exclusively in test_resume mode
Date:   Mon,  8 May 2023 11:46:37 +0200
Message-Id: <20230508094440.030519443@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 5904de0d735bbb3b4afe9375c5b4f9748f882945 ]

The system refused to do a test_resume because it found that the
swap device has already been taken by someone else. Specifically,
the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
do this check.

Steps to reproduce:
 dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
       awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
 mkswap /swapfile
 swapon /swapfile
 swap-offset /swapfile
 echo 34816 > /sys/power/resume_offset
 echo test_resume > /sys/power/disk
 echo disk > /sys/power/state

 PM: Using 3 thread(s) for compression
 PM: Compressing and saving image data (293150 pages)...
 PM: Image saving progress:   0%
 PM: Image saving progress:  10%
 ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 ata1.00: configured for UDMA/100
 ata2: SATA link down (SStatus 0 SControl 300)
 ata5: SATA link down (SStatus 0 SControl 300)
 ata6: SATA link down (SStatus 0 SControl 300)
 ata3: SATA link down (SStatus 0 SControl 300)
 ata4: SATA link down (SStatus 0 SControl 300)
 PM: Image saving progress:  20%
 PM: Image saving progress:  30%
 PM: Image saving progress:  40%
 PM: Image saving progress:  50%
 pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
 PM: Image saving progress:  60%
 PM: Image saving progress:  70%
 PM: Image saving progress:  80%
 PM: Image saving progress:  90%
 PM: Image saving done
 PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
 PM: S|
 PM: hibernation: Basic memory bitmaps freed
 PM: Image not found (code -16)

This is because when using the swapfile as the hibernation storage,
the block device where the swapfile is located has already been mounted
by the OS distribution(usually mounted as the rootfs). This is not
an issue for normal hibernation, because software_resume()->swsusp_check()
happens before the block device(rootfs) mount. But it is a problem for the
test_resume mode. Because when test_resume happens, the block device has
been mounted already.

Thus remove the FMODE_EXCL for test_resume mode. This would not be a
problem because in test_resume stage, the processes have already been
frozen, and the race condition described in
Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
is unlikely to happen.

Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
Reported-by: Yifan Li <yifan2.li@intel.com>
Suggested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Tested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/hibernate.c | 8 ++++++--
 kernel/power/swap.c      | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index aa551b093c3f6..30d1274f03f62 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -688,18 +688,22 @@ static int load_image_and_restore(void)
 {
 	int error;
 	unsigned int flags;
+	fmode_t mode = FMODE_READ;
+
+	if (snapshot_test)
+		mode |= FMODE_EXCL;
 
 	pm_pr_dbg("Loading hibernation image.\n");
 
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
 	if (error) {
-		swsusp_close(FMODE_READ | FMODE_EXCL);
+		swsusp_close(mode);
 		goto Unlock;
 	}
 
 	error = swsusp_read(&flags);
-	swsusp_close(FMODE_READ | FMODE_EXCL);
+	swsusp_close(mode);
 	if (!error)
 		error = hibernation_restore(flags & SF_PLATFORM_MODE);
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 277434b6c0bfd..cc44c37699de6 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1518,9 +1518,13 @@ int swsusp_check(void)
 {
 	int error;
 	void *holder;
+	fmode_t mode = FMODE_READ;
+
+	if (snapshot_test)
+		mode |= FMODE_EXCL;
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    FMODE_READ | FMODE_EXCL, &holder);
+					    mode, &holder);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
@@ -1547,7 +1551,7 @@ int swsusp_check(void)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
+			blkdev_put(hib_resume_bdev, mode);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-- 
2.39.2



