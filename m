Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B31479BF34
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbjIKWAu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbjIKOtQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37546E50
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c0efe0c4acso7711925ad.0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694443750; x=1695048550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iJsESSuU7Ts5Oil2ykQBK67O/WeLrj7vPZsQQjd8Fs=;
        b=xTfq6p00l0wHoQbsneka5Bk2QlbyO1YIJbWBsYtLByNSPdIMJ9JZyoFzsGB3fK212U
         kRrKijNbNNNlkyFuU90CunydfOWBQC1Lz9o38Hqg/nATBRX49V+ufcmUvZTLICR+TQMY
         j2+GwugkrFAzbOuVxqqoyYC9SugJTdFnxvgvkqxzTYpzRsMvI8kysWJJQusDNev/ZhWT
         7d1bx6qLfr9n9cnPbBIV39/+0A4kEY7mZ5OiA4O52kmDyEQ+3Espuq79pQAkIfdrpSqC
         hZkcMUlIgxjfpttHow+MwYMJU2yqSUX0qAbsb4JqdeyIXqJq4GnE9VyrXTI92V9QEKfb
         2lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694443750; x=1695048550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iJsESSuU7Ts5Oil2ykQBK67O/WeLrj7vPZsQQjd8Fs=;
        b=Dq89J2H0bxkK2xBRRBNlYBL+ODeXkCd6CVonNhHs7lhmhqU3eK7SNn1v76C5sqwVeA
         Gv4uVLuIaMbBcIHXoU/ylLNSjZp+krsCDptmt0fyDVuVO6WFwunuUqL/C0bWu9Hw9wys
         7/aCRmcnMuWteGs9yEfT6mSMSmVMi2DY8YkYsKm6dxp7i4u0jUTnkqcuH2/aq1HGG0cM
         95qwTxH7kNox3KIxMfHHG3Alo9mzK5TuiepUaK4ovM/GinEURFkIitI9f6CORaJb4/yA
         B5GPc5YRnCSOTBGDfohuEpa5eDa00IUz3AGGqQfAHRNy+yh3BACYuUArAP00KZPYL5Bj
         BpWQ==
X-Gm-Message-State: AOJu0YwRAzeEbivRZZZtlZgSrxw7PbRYBIWec2WFDjro/WWz7xWisQRW
        FgXj5W9+7BMFJukFp8OJItCMEg==
X-Google-Smtp-Source: AGHT+IGsy1y15Q6FtOKzYtVRKGuN7gtN9wa4mn3zZEF9viobIPQ1wKcox4B/MIyz/XZeJg913A4YYQ==
X-Received: by 2002:a17:902:ec8b:b0:1c0:cbaf:6939 with SMTP id x11-20020a170902ec8b00b001c0cbaf6939mr12330570plg.3.1694443750498;
        Mon, 11 Sep 2023 07:49:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm6567339plg.22.2023.09.11.07.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 07:49:09 -0700 (PDT)
Message-ID: <0dd1d0f7-1114-4fea-bc50-250a33ce7200@kernel.dk>
Date:   Mon, 11 Sep 2023 08:49:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: break iopolling on signal"
 failed to apply to 5.4-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, asml.silence@gmail.com
Cc:     stable@vger.kernel.org
References: <2023090939-bunkmate-clutch-4fc1@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023090939-bunkmate-clutch-4fc1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/9/23 6:52 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This isn't needed for the 5.4-stable tree.

-- 
Jens Axboe

