Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB423798FAC
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbjIHTeB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344949AbjIHTdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 15:33:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950D1FE9
        for <stable@vger.kernel.org>; Fri,  8 Sep 2023 12:33:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-273b1ea30beso598210a91.1
        for <stable@vger.kernel.org>; Fri, 08 Sep 2023 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694201565; x=1694806365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q77K6K9aetpUJ+m2swHb4WFutErkMKiXOvu8vLXzv6o=;
        b=StaqAb895JvirYrM90QDqw3si2QNurWg9xqd3bKaTbAzN7xVFEafc8Jmtx+j252e4J
         PhTV5qifegRuBcA97ZQv49pfRjdMBveQTNrD+bx2+ht+z6bitpIsdW+tJeh5SJg10+mZ
         OSMSv4gQXVgunODUUCntC+mPvxH6usivIiSv6xaEzBHoo7KRgkQrJYE4MVXkwppJTgG9
         jKx95J2fNhh0PsWbInAhfDal6KPd0eiCgLL09y3BtTzFaFheJmMZN885Spdk4TbGrgqa
         awKrcAhzAqE3F+aTZEiZ9T3HpVi29zfnSU/G5rNJucsXrCiMQIC/0YiuffFzdgSpbPdx
         fRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694201565; x=1694806365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q77K6K9aetpUJ+m2swHb4WFutErkMKiXOvu8vLXzv6o=;
        b=iA4DCLwYeJ0Rk1DqSxZwE7YDGezI4r28TgaAUf0sbUFWIvcoegIWYfwwiAhFVPPRHH
         Lu0jqarGBRQ4COZmWAN0pmi9d3Fka8TLEpQGn/N3Xo0wP4znw7E69WpgCsXYFb+dVWh/
         cd/0y4F+rGWlglLLQ//fWdB2GUMjOsCRQbKJiN251etbEcCTUflYSDwWmcSyrftZxoKg
         YmQhdMK77eY2L2RYeZ9lHmw7FDTFBC78fy+vfOmTWYNHvkOtln09eYi+DEBB3mkhK4wd
         h92D28iy1ZS2rz5MDgiYyXUzvuZ41VbLLZdUzjxKDO/vRN0+YCEzZhnA+E1SOBVjA79U
         lnHw==
X-Gm-Message-State: AOJu0YxAtZDzNE0Sf/l6uDnGXh87x8sGPHgyxDxrDYz+5DFsovFNKejF
        uI/f0bgWA7wH8yDVc32RdxA1vQ==
X-Google-Smtp-Source: AGHT+IGHLvavStavXlYDVS2UvBAcUd/wa4WruHdVF/uXy7Bs2gkR5oWddVf4pPXi4u1EgSURMVojhg==
X-Received: by 2002:a17:90a:7025:b0:263:730b:f568 with SMTP id f34-20020a17090a702500b00263730bf568mr3401958pjk.3.1694201565361;
        Fri, 08 Sep 2023 12:32:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a030900b002635db431a0sm1766410pje.45.2023.09.08.12.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 12:32:44 -0700 (PDT)
Message-ID: <cd341326-cfaf-4796-8894-2241e7b630d9@kernel.dk>
Date:   Fri, 8 Sep 2023 13:32:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.5 31/36] block: Allow bio_iov_iter_get_pages()
 with bio->bi_bdev unset
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-block@vger.kernel.org
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-31-sashal@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230908192848.3462476-31-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/8/23 1:28 PM, Sasha Levin wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> [ Upstream commit 168145f617d57bf4e474901b7ffa869337a802e6 ]
> 
> bio_iov_iter_get_pages() trims the IO based on the block size of the
> block device the IO will be issued to.
> 
> However, bcachefs is a multi device filesystem; when we're creating the
> bio we don't yet know which block device the bio will be submitted to -
> we have to handle the alignment checks elsewhere.
> 
> Thus this is needed to avoid a null ptr deref.

Please drop this one from -stable, there's no need.

-- 
Jens Axboe

