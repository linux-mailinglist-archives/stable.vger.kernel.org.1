Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120377F17FE
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjKTP7J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjKTP7I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:59:08 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00996ED
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:59:04 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so34054939f.0
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700495944; x=1701100744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBubMyXeMdXPmziILbLDJOUb23evjUP9zHHjc1m1UWU=;
        b=kgmA+AVf1bqHdCcIeq04xHRa7SIKk9mZkp0aX9jE6fjDInfjNh1/bkr4ZQjGRs0Vuf
         4WbKUfFUmZyPkW9eoVSTQSKXSBNoEvzfelmquMgjfcr5iIIurskd2j8ZOdrF+CZd/YJJ
         Nvudq3O7pGhAdLOwDFqOJB9KNEuV9NvBiRR/2MB431cqmVUh1X+mKutocpRWzejItpxJ
         fhqqF3zCpc53p8zABT0vvsjSmi1WyT5t8n9KN4NLr0zWEGMw7klF1Uba+bZL0+lzV3gd
         sCes9BBdz54oAMT3xwZJPPRCfAJw0es3VTVVtp0yzGhWLPkQ1qRWWz55ZajBwCg3E34v
         9rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495944; x=1701100744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBubMyXeMdXPmziILbLDJOUb23evjUP9zHHjc1m1UWU=;
        b=Lu8MJYu6/MJPlNOneKy8Z206mso3GcA10YiYlJ0zkEl+AhjYJ5IE0BTiEjvMVWTGTB
         1l9E/9eDtUfpZB42ydKMX1hF+a5g9eo7DSzNmh6IhSBVcyAR6YfkJ6+kyhfDBgvI+1UM
         kgS9XORAzExhgVRUoe0NokcC3u7wkgsPoZtHWNaIZNCDuBqy5VXTUadwikEvELVOl8t9
         2zRaSfoERYPkTvSpC7fNnI6odoRNlJZcSgl1qOKPL86E/uQSv7eGts3TEO8TOCYGTSdG
         LI0+SwyUa64/WR/Xfir+C6UmuYJSmI8jyzL6m/JSHuT5Lg7JBrBErdPwCx7Q112/Klgx
         Puvg==
X-Gm-Message-State: AOJu0YxguC0SolIf35xJ2wroaqfoKIRKU8UmEv9cxRzPoPAeUOY8ZsyD
        uBkS0q0yI9o0TfO3Z747T8vMjQ==
X-Google-Smtp-Source: AGHT+IE5IFdCpMdxEiBvnNeLaVyJT3YUK2ggFvrK9aO4Q45E4aJI5sPQZ8IpJpBfrP5cXZo9/UGbnw==
X-Received: by 2002:a92:dc81:0:b0:35b:cd8:7785 with SMTP id c1-20020a92dc81000000b0035b0cd87785mr997896iln.1.1700495944338;
        Mon, 20 Nov 2023 07:59:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v10-20020a056e0213ca00b003593297c253sm2522408ilj.75.2023.11.20.07.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 07:59:03 -0800 (PST)
Message-ID: <8818a183-84a3-4460-a8ca-73a366ae6153@kernel.dk>
Date:   Mon, 20 Nov 2023 08:59:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/fs: consider link->flags when getting path for
 LINKAT
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        stable@vger.kernel.org
References: <20231120105545.1209530-1-cmirabil@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231120105545.1209530-1-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/20/23 3:55 AM, Charles Mirabile wrote:
> In order for `AT_EMPTY_PATH` to work as expected, the fact
> that the user wants that behavior needs to make it to `getname_flags`
> or it will return ENOENT.

Looks good - do you have a liburing test case for this too?

-- 
Jens Axboe


