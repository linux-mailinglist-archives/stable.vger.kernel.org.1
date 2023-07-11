Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52374EBD5
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGKKir (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 06:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGKKio (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 06:38:44 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5C910FD
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:38:41 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso8211225e9.1
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689071919; x=1691663919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=MILh/KiIkVkSzDQ6BhSpSikfBjOVKHrExnJcKlTrEQF1e62So7kPKRovgk4UlDgRDA
         ApY0MmU6iauGgfhCrXx5uI9w3gZ+A0ur8UgVTczUhix4TtE5Ar7nebbs1ea3ybF2yyDY
         xodeI6phh4Ev9izPOCJkQSL5hcTVqEJ2RVn6qgcyr8RXEmbYUwlyWW5NitleUEAPabvr
         A+VnOgnAcXPHExPQMAK7kXr92vX+U4mZLTNUtRC8/rC/9gBgJh/kiilF7I7y293R1vDz
         g6lCASSgIo9dMEhrESeMam3eU7TRyPWMvUrk6J4P6GcqmXsWQBlSpDTFlCzemKd41sxY
         ugMg==
X-Gm-Message-State: ABy/qLbHxluxNlJxIWHIxzYvqPboxo6GhwqPP8jMqbIaXOkUDzPIkG2P
        AnCdj3gxg8ZNsBYlsVozVpc=
X-Google-Smtp-Source: APBJJlHv5XjfzBkov98wBLAfDvgbpZPRWEOgg45lWt+wMlb3vVDWKD/SJxDLe7KALXGDWkxhJp2D6A==
X-Received: by 2002:a05:600c:43c5:b0:3fa:9587:8fc1 with SMTP id f5-20020a05600c43c500b003fa95878fc1mr14371116wmn.1.1689071919431;
        Tue, 11 Jul 2023 03:38:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id hn32-20020a05600ca3a000b003fbdd5d0758sm2177467wmb.22.2023.07.11.03.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:38:38 -0700 (PDT)
Message-ID: <8c548c75-7980-9b19-c46a-7ff8a75d0aeb@grimberg.me>
Date:   Tue, 11 Jul 2023 13:38:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 3/3] nvme-rdma: fix potential unbalanced freeze &
 unfreeze
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230711094041.1819102-1-ming.lei@redhat.com>
 <20230711094041.1819102-4-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230711094041.1819102-4-ming.lei@redhat.com>
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
