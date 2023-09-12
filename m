Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92B579BFA0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359574AbjIKWRx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbjIKPXM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:23:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD911D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:23:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33673C433C7;
        Mon, 11 Sep 2023 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445787;
        bh=Riiw00nV4Y1esyXa16KOmK2haxKT1kfhPGj3Fm47LPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfLmTswc23VGPfac3xKRUyPb1YRWaROqx9p5PRKMzuq3OIrUpCvM2PhT4qLgv/avO
         c1hXVcObdWq0gtHv24vx4jhZ4Ig9ivXMvRu1/xvT/QXqdIHypeMJUivcU7AHP1Rw7o
         Ly3wm3+cqPeq9xsrZfrRWlerVIbuVk50HnUvV5bU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 454/600] media: cec: core: add adap_unconfigured() callback
Date:   Mon, 11 Sep 2023 15:48:07 +0200
Message-ID: <20230911134647.055775994@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 948a77aaecf202f722cf2264025f9987e5bd5c26 ]

The adap_configured() callback was called with the adap->lock mutex
held if the 'configured' argument was false, and without the adap->lock
mutex held if that argument was true.

That was very confusing, and so split this up in a adap_unconfigured()
callback and a high-level configured() callback.

This also makes it easier to understand when the mutex is held: all
low-level adap_* callbacks are called with the mutex held. All other
callbacks are called without that mutex held.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: f1b57164305d ("media: cec: add optional adap_configured callback")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/core/cec-adap.c | 4 ++--
 include/media/cec.h               | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index aed3e51d6d354..4bc2a705029e6 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1345,7 +1345,7 @@ static void cec_adap_unconfigure(struct cec_adapter *adap)
 	cec_flush(adap);
 	wake_up_interruptible(&adap->kthread_waitq);
 	cec_post_state_event(adap);
-	call_void_op(adap, adap_configured, false);
+	call_void_op(adap, adap_unconfigured);
 }
 
 /*
@@ -1536,7 +1536,7 @@ static int cec_config_thread_func(void *arg)
 	adap->kthread_config = NULL;
 	complete(&adap->config_completion);
 	mutex_unlock(&adap->lock);
-	call_void_op(adap, adap_configured, true);
+	call_void_op(adap, configured);
 	return 0;
 
 unconfigure:
diff --git a/include/media/cec.h b/include/media/cec.h
index 6556cc161dc0a..9c007f83569aa 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -113,12 +113,12 @@ struct cec_fh {
 #define CEC_FREE_TIME_TO_USEC(ft)		((ft) * 2400)
 
 struct cec_adap_ops {
-	/* Low-level callbacks */
+	/* Low-level callbacks, called with adap->lock held */
 	int (*adap_enable)(struct cec_adapter *adap, bool enable);
 	int (*adap_monitor_all_enable)(struct cec_adapter *adap, bool enable);
 	int (*adap_monitor_pin_enable)(struct cec_adapter *adap, bool enable);
 	int (*adap_log_addr)(struct cec_adapter *adap, u8 logical_addr);
-	void (*adap_configured)(struct cec_adapter *adap, bool configured);
+	void (*adap_unconfigured)(struct cec_adapter *adap);
 	int (*adap_transmit)(struct cec_adapter *adap, u8 attempts,
 			     u32 signal_free_time, struct cec_msg *msg);
 	void (*adap_nb_transmit_canceled)(struct cec_adapter *adap,
@@ -131,6 +131,7 @@ struct cec_adap_ops {
 	bool (*error_inj_parse_line)(struct cec_adapter *adap, char *line);
 
 	/* High-level CEC message callback, called without adap->lock held */
+	void (*configured)(struct cec_adapter *adap);
 	int (*received)(struct cec_adapter *adap, struct cec_msg *msg);
 };
 
-- 
2.40.1



