Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF544740AE4
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjF1IMf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:12:35 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38237 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjF1IK3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:10:29 -0400
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3140d798bb4so74900f8f.1
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939828; x=1690531828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QS97xmi1vEecs82Kfk+Ki1RDui9M0JEtFa2BEWHsmM=;
        b=S8nKfqTPzaLIhOEvWP1uWbK2HfWsyrLUKp5RL+yVdwg8nIV8p6WWiHMrLVEVhp6+0M
         kGMJH9a+D4+l/+BPvBCQ30pGoN+t3uNUAZ/8mOECfiMN+GN+gBDA4421SZxT2zCatYoc
         bAOWNZbSQbna1rKcrQhkZKyIkjb6xU3s75UGNWqCCR4ZQS7wt/nWuAr1YXlP6xoR3cbE
         T6D77Gxh+SMa4m7+1VWN4YKMnn0BoufF45KJmIwva4gT7lT8oMTXScDf/UcXVQMv7yts
         Nnf/W0RBKnFxARlRrn+9zJox8shXC2QFxjPt0yPqjkUrKYMQvzTxeTqsBIeqPD0lSc1g
         HDGA==
X-Gm-Message-State: AC+VfDw1D30vX4l8L2XL3vO4w4FFtj2IgJc26hemArj4tOLVr93VQ3u+
        79NpyrisIGG2rhdgMd31oog=
X-Google-Smtp-Source: ACHHUZ6WphTYtFO6n/MMjfQ+R5+eshjhLAvMJfXmqpi5oScovqSjW9WB+SOZLiYg+zaRdOe2hjgN0g==
X-Received: by 2002:a5d:4605:0:b0:314:f14:c24f with SMTP id t5-20020a5d4605000000b003140f14c24fmr466020wrq.0.1687939828364;
        Wed, 28 Jun 2023 01:10:28 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d6986000000b0031130b9b173sm12581658wru.34.2023.06.28.01.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 01:10:27 -0700 (PDT)
Message-ID: <c571727c-9bcf-ce16-cce8-b38ecfc078a6@grimberg.me>
Date:   Wed, 28 Jun 2023 11:10:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <20230628073957.GB25314@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230628073957.GB25314@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


>> @@ -4055,7 +4056,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   	 * removing the namespaces' disks; fail all the queues now to avoid
>>   	 * potentially having to clean up the failed sync later.
>>   	 */
>> -	if (ctrl->state == NVME_CTRL_DEAD) {
>> +	if (ctrl->state == NVME_CTRL_DEAD ||
>> +			ctrl->old_state != NVME_CTRL_LIVE) {
> 
> Style nitpick: this is really nasty to read, pleas align things
> properly:
> 
> 	if (ctrl->state == NVME_CTRL_DEAD ||
> 	    ctrl->old_state != NVME_CTRL_LIVE) {
> 
> But I'm really worried about this completely uncodumented and fragile
> magic here.  The existing magic NVME_CTRL_DEAD is bad enough, but
> backtracking to the previous state just makes this worse.

Agree.

> I think a big problem is that the call to nvme_mark_namespaces_dead
> and nvme_unquiesce_io_queues is hidden inside of
> nvme_remove_namespaces, and I think there's no good way around
> us unwinding the currently unpair quiesce calls and fixing this
> for real.

My suggestion initially was to add a ctrl interface to say if the
transport can accept I/O: ctrl.ops.io_capable() and mark dead_unquiesce
based on that instead of the state. But I'm not sure it is better.
