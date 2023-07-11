Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107BD74EBD4
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 12:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGKKim (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGKKig (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 06:38:36 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF40E67
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:38:35 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3142498c2e3so1211085f8f.0
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689071914; x=1691663914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jLuvBCwpZhjHb8c0OtiKBU3wmleHqEXLz7xRVOhp4TcvaZV02oDEPHx9s2mFhAwI9C
         QzVrRc2r3rYoy8n3fpjONLDTkduI0NjEMV2nYr+fZQy2Yu46D0+yEdPIinpxT0ZEHTlN
         gAbMugyJFqxHz1MsHodISAi6oTHUdBVxbAqX7H6nKGXhVhQqtbETwIFCP+MLqTVSo/T3
         94upW148deumqcPesJywpP/zQ955UP13n/WjWCfqdiTlnmppfxijVdVsJZJ+1Zy2bsH2
         ErVZcCG73or/s2uH+q4ksy1NwXGSyLwOI5KgNSS31lFzeQP0HxSnk9o0k0HI/GqLxCqr
         LozQ==
X-Gm-Message-State: ABy/qLYHICPdkEttapM8xFE/c9PTG5Cii5NqdcxAPhOXS/pVe+8RCY28
        2ZTk6ZEdRPGyIaFwGGm9XEqY27m6wY4=
X-Google-Smtp-Source: APBJJlFFs9XqqYORhWsk2APEGGk+VSzShkQ+i3uE78roAxfWx6F7jAI4ik45PxlK2gnQBGy2uCLYmw==
X-Received: by 2002:a05:6000:11c2:b0:30a:f103:1f55 with SMTP id i2-20020a05600011c200b0030af1031f55mr14033907wrx.0.1689071913750;
        Tue, 11 Jul 2023 03:38:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm1850004wrv.108.2023.07.11.03.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:38:33 -0700 (PDT)
Message-ID: <992bfec5-5997-6e5e-f8fd-096f8eeaa551@grimberg.me>
Date:   Tue, 11 Jul 2023 13:38:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 2/3] nvme-tcp: fix potential unbalanced freeze &
 unfreeze
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230711094041.1819102-1-ming.lei@redhat.com>
 <20230711094041.1819102-3-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230711094041.1819102-3-ming.lei@redhat.com>
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
