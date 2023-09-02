Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7220879097B
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjIBUUn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjIBUUm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 16:20:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A0CD6
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 13:20:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a42d06d02so128681b3a.0
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693686039; x=1694290839; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJG4Fbd4u57q10EH/XnH8VDwsn8D+1qRD6SbZ6z/dUU=;
        b=cDA0JKrOGscMAzFHvuKiy6YZp9hI/BciIoC8JIC7bt8v5NpD0EowULV3KcpEqudx1U
         7/YNdGTSdgfX+VR6scS89vjYK73IHU3i5rjG9jdvQrGMkKrJ4FRCV7CTXL4FOgo9+ZEQ
         FL1pj2AClcj0gIh9LX/gS7L+QWoTLlbZ/6eWUJfg+EvP15ZqDR+qmb94WrOYYSbOHDmA
         WjR0ih/Mg5zLGwBZd59uC9S5qNM6hIUrLJiYzPyXtV+PcUFFXAtj/QawgprRbEOsy/L/
         ivBK+XzWqHCU6l3F4PU7V0wNW8CdgbQFNFtKxnDeOh0PqYzJl4ZePq6dUlY2lJgkjGNf
         lZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693686039; x=1694290839;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJG4Fbd4u57q10EH/XnH8VDwsn8D+1qRD6SbZ6z/dUU=;
        b=PUAWMDJkZXBu0FLYWxtCDUA0UKaAB43czTw5TNpf94yBVofImxiKAxlZV+vy1nfcBD
         mB5txsUnwy2+Fzusxc3mAtkO6k1m/NGjSsrehLTH2DwgvaD9wFq/43QDos1rEYrxyJD0
         sj33HVgF1oSxbJkhsmhSV7TraZY4Pw/Ka501/9Q7BuvFOeuCkqyZeJqfwCKg6+zMPYCD
         8Iyw3KXQw/9nA0ttmiW0V+8vzVHLLp6nMdzywVeL0kO2BDnKowX45IpY9lu7krg/orN2
         TkbUTYNeG/ZaY0AhyTrwN1upY5TeAOvIMVNNkXx3Oyd/j9vV6Fq6KlGIfUgtCHVUyOHr
         443Q==
X-Gm-Message-State: AOJu0Yz/lxtLUGXLPxrsmHF9yPTJ+iqBPMIs0WPu9/ui8WiPFaqcbGHu
        9NCfZw9i/usaAfZfyLsdEM1c1AHAS79Y4U3I
X-Google-Smtp-Source: AGHT+IH8QxbKgWfELkzRqBhnAClSLe3KmrOt0CLKbCm4BVdLpfHPizo0Va7EjKcyrXnGCLQM47AdeQ==
X-Received: by 2002:a05:6a20:3246:b0:137:57fc:4f9d with SMTP id hm6-20020a056a20324600b0013757fc4f9dmr4863054pzc.10.1693686038787;
        Sat, 02 Sep 2023 13:20:38 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001bdd7579b5dsm4962874plb.240.2023.09.02.13.20.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 13:20:38 -0700 (PDT)
Date:   Sat, 2 Sep 2023 13:20:36 -0700
From:   Kyle Zeng <zengyhkyle@gmail.com>
To:     stable@vger.kernel.org
Subject: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <ZPOZFHHA0abVmGx+@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit c42dd069be8dfc9b2239a5c89e73bbd08ab35de0 upstream.
Backporting the patch to stable-v5.10.y to avoid race condition between configfs_dir_lseek and
configfs_lookup since they both operate ->s_childre and configfs_lookup
forgets to obtain the lock.
The patch deviates from the original patch because of code change.
The idea is to hold the configfs_dirent_lock when traversing
->s_children, which follows the core idea of the original patch.


Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
---
 fs/configfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 12388ed4faa5..0b7e9ab517d5 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -479,6 +479,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	if (!configfs_dirent_is_ready(parent_sd))
 		goto out;
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
 			const unsigned char * name = configfs_get_name(sd);
@@ -491,6 +492,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 			break;
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	if (!found) {
 		/*
-- 
2.34.1

