Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549A2740BE0
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjF1Ixd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:53:33 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:38389 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjF1Ij1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:39:27 -0400
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fb87828386so420418e87.1
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687941566; x=1690533566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pZbFxIcZMSIDGAB65+74vd6qFZmRBObj/WnklXfrb8=;
        b=UXF89aZGFZeSF7vbFfKisfHpwEgK1EPoJx3QaUDbG4D0zG3VdmCYCW1M6jFsrw40bL
         brrc7XjMF+ehAbipQlX8jNC4RbKhpKq97j6a6dOjV8Hnfs7zD/sSSiZA0jfjZW3xWjCK
         RCUKcsHJvSxEuhnfNaVpmg5rqBCT5n5uq+FsyB36Zk+50I94l9D7g0fSZZFFvZ4JtbSE
         7l331klWHxqY9mGS1Tx7ObPs0CM2TXcEHTHeGg4TpclvszPfLbCQhm+v58R3eu+yYa1a
         5RFuiMYd9ef8ch2bdqp2HlcsAxxJFYlBoOtYMBr/iXsW8NnNs/FoCtPaaCNBSuojDBYI
         KV+A==
X-Gm-Message-State: AC+VfDyI4v4IzFpYf++Id8lP4uZ9vrmFllNDbT6szEBDaGGMhAI6LE4G
        GbAUYuRhg7f+JBdTJ/poR/0Xt+cUuuA=
X-Google-Smtp-Source: ACHHUZ51mLFVptgVLuS8G/S4W7bTQGVCBD2vo+fQonFZNX7WnhyX548DdNPJEq1uJDaC2rQnv6Pq0w==
X-Received: by 2002:a05:6402:520d:b0:516:463d:8a10 with SMTP id s13-20020a056402520d00b00516463d8a10mr3397057edd.3.1687934681205;
        Tue, 27 Jun 2023 23:44:41 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003f42158288dsm15773817wmk.20.2023.06.27.23.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 23:44:40 -0700 (PDT)
Message-ID: <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
Date:   Wed, 28 Jun 2023 09:44:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230628031234.1916897-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


> namespace's request queue is frozen and quiesced during error recovering,
> writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <- del_gendisk()
> can't move on, and causes IO hang. Removal could be from sysfs, hard
> unplug or error handling.
> 
> Fix this kind of issue by marking controller as DEAD if removal breaks
> error recovery.
> 
> This ways is reasonable too, because controller can't be recovered any
> more after being removed.

This looks fine to me Ming,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


I still want your patches for tcp/rdma that move the freeze.
If you are not planning to send them, I swear I will :)
