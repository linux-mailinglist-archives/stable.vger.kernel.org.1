Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FFC74D167
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGJJ2N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjGJJ1o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 05:27:44 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D4114
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 02:27:35 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso10386725e9.0
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 02:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981253; x=1691573253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+i6a+oHavZa+PsLQK+2pw+D8M7+9tF/7o7b0gNDpAs=;
        b=WVUD9ZTNwGX2amAu3g2C58HoWEHH57G1Axtim972yaf8RAyB9Z3xN5mYNeUKTYDsyy
         rzut2S3b9TnyrLLBYkbw9bcR37Ct3w3bWCE37n04f3mlBn4LA64kSE/M2N/6tpdaI0JN
         yuyJs4jlWQJMocYvQ8Zbcszw9Sc7BntwBcqyeSqDRNEpOSDmotg35UvZkMa+KtGeGInm
         Hvo2A4s0mVDh1u4hj7PTB36uvG5ex8a2UCNxDQK2uP800Jfw3oDK5MolmMpwU+27yYrq
         7oU4yh5IfMuAEJ21GiCi5/O6oTC0yIa315P1l+Gq5uiC6VerKtMmChMIslZ2/6Hu4w16
         mcZw==
X-Gm-Message-State: ABy/qLajUSzP8u0aT7Kl6R0cZK5aCYIgTfYKqjC50LN9MmsiuWSJNgf3
        1aEc/bg2gqAY8d4YawfYJDE=
X-Google-Smtp-Source: APBJJlELioq8M99i38IRzTh6fQ6NH2kEfqBStiEAcRTSiAObC1OcB0HKFfLHvrKMWvWq7CJpLBTW8w==
X-Received: by 2002:a05:600c:43c5:b0:3fa:9587:8fc1 with SMTP id f5-20020a05600c43c500b003fa95878fc1mr11142215wmn.1.1688981253151;
        Mon, 10 Jul 2023 02:27:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h13-20020a1ccc0d000000b003fbaa2903f4sm9682193wmb.19.2023.07.10.02.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:27:32 -0700 (PDT)
Message-ID: <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
Date:   Mon, 10 Jul 2023 12:27:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


>>>>> I still want your patches for tcp/rdma that move the freeze.
>>>>> If you are not planning to send them, I swear I will :)
>>>>
>>>> Ming, can you please send the tcp/rdma patches that move the
>>>> freeze? As I said before, it addresses an existing issue with
>>>> requests unnecessarily blocked on a frozen queue instead of
>>>> failing over.
>>>
>>> Any chance to fix the current issue in one easy(backportable) way[1] first?
>>
>> There is, you suggested one. And I'm requesting you to send a patch for
>> it.
> 
> The patch is the one pointed by link [1], and it still can be applied on current
> linus tree.
> 
> https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/

This is separate from what I am talking about.

>>> All previous discussions on delay freeze[2] are generic, which apply on all
>>> nvme drivers, not mention this error handling difference causes extra maintain
>>> burden. I still suggest to convert all drivers in same way, and will work
>>> along the approach[1] aiming for v6.6.
>>
>> But we obviously hit a difference in expectations from different
>> drivers. In tcp/rdma there is currently an _existing_ bug, where
>> we freeze the queue on error recovery, and unfreeze only after we
>> reconnect. In the meantime, requests can be blocked on the frozen
>> request queue and not failover like they should.
>>
>> In fabrics the delta between error recovery and reconnect can (and
>> often will be) minutes or more. Hence I request that we solve _this_
>> issue which is addressed by moving the freeze to the reconnect path.
>>
>> I personally think that pci should do this as well, and at least
>> dual-ported multipath pci devices would prefer instant failover
>> than after a full reset cycle. But Keith disagrees and I am not going to
>> push for it.
>>
>> Regardless of anything we do in pci, the tcp/rdma transport
>> freeze-blocking-failover _must_ be addressed.
> 
> It is one generic issue, freeze/unfreeze has to be paired strictly
> for every driver.
> 
> For any nvme driver, the inbalance can happen when error handling
> is involved, that is why I suggest to fix the issue in one generic
> way.

Ming, you are ignoring what I'm saying. I don't care if the
freeze/unfreeze is 100% balanced or not (for the sake of this
discussion).

I'm talking about a _separate_ issue where a queue
is frozen for potentially many minutes blocking requests that
could otherwise failover.

>> So can you please submit a patch for each? Please phrase it as what
>> it is, a bug fix, so stable kernels can pick it up. And try to keep
>> it isolated to _only_ the freeze change so that it is easily
>> backportable.
> 
> The patch of "[PATCH V2] nvme: mark ctrl as DEAD if removing from error
> recovery" can fix them all(include nvme tcp/fc's issue), and can be backported.

Ming, this is completely separate from what I'm talking about. This one
is addressing when the controller is removed, while I'm talking about
the error-recovery and failover, which is ages before the controller is
removed.

> But as we discussed, we still want to call freeze/unfreeze in pair, and
> I also suggest the following approach[2], which isn't good to backport:
> 
> 	1) moving freeze into reset
> 	
> 	2) during resetting
> 	
> 	- freeze NS queues
> 	- unquiesce NS queues
> 	- nvme_wait_freeze()
> 	- update_nr_hw_queues
> 	- unfreeze NS queues
> 	
> 	3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
> 	
> 	- if the request is FS IO with data, re-submit all bios of this request, and free the request
> 	
> 	- otherwise, fail the request
> 
> 
> [2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc

Ming, please read again what my concern is. I'm talking about error 
recovery freezing a queue, and unfreezing only after we reconnect,
blocking requests that should failover.

The controller removal when the request queue is frozen is a separate
issue, which we should address, but separately.

What I am requesting is that you send two patches, one for tcp and
one for rdma that are identical to what you did in:
[PATCH 2/2] nvme: don't freeze/unfreeze queues from different contexts

rdma.c patch:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..354cce8853c1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct 
nvme_rdma_ctrl *ctrl, bool new)
  		goto out_cleanup_tagset;

  	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
  		nvme_unquiesce_io_queues(&ctrl->ctrl);
  		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
  			/*
@@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct 
nvme_rdma_ctrl *ctrl, bool new)
  			 * to be safe.
  			 */
  			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
  			goto out_wait_freeze_timed_out;
  		}
  		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -975,7 +977,6 @@ static void nvme_rdma_teardown_io_queues(struct 
nvme_rdma_ctrl *ctrl,
  		bool remove)
  {
  	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
  		nvme_quiesce_io_queues(&ctrl->ctrl);
  		nvme_sync_io_queues(&ctrl->ctrl);
  		nvme_rdma_stop_io_queues(ctrl);
--

tcp.c patch:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..5ae08e9cb16d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1909,6 +1909,7 @@ static int nvme_tcp_configure_io_queues(struct 
nvme_ctrl *ctrl, bool new)
  		goto out_cleanup_connect_q;

  	if (!new) {
+		nvme_start_freeze(ctrl);
  		nvme_unquiesce_io_queues(ctrl);
  		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
  			/*
@@ -1917,6 +1918,7 @@ static int nvme_tcp_configure_io_queues(struct 
nvme_ctrl *ctrl, bool new)
  			 * to be safe.
  			 */
  			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
  			goto out_wait_freeze_timed_out;
  		}
  		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -2021,7 +2023,6 @@ static void nvme_tcp_teardown_io_queues(struct 
nvme_ctrl *ctrl,
  	if (ctrl->queue_count <= 1)
  		return;
  	nvme_quiesce_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
  	nvme_quiesce_io_queues(ctrl);
  	nvme_sync_io_queues(ctrl);
  	nvme_tcp_stop_io_queues(ctrl);
--

Nothing more.
