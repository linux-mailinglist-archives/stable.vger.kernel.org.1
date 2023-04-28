Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B36F1A33
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjD1OHv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 10:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbjD1OHs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 10:07:48 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D446A0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:07:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso9576366a12.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682690854; x=1685282854;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+bC/uq7BLLftq48XdJ3Jz7d3/KkKfWfX2mH+ebE1SLA=;
        b=DAxLIDcco9TKxLDtHjEEzYznViLXHGJAW7/xOUliBBH96oS20Mg/LYGp+aSJkR1srU
         ddY7YG6VZ8iFfu2L6hpuZJTSq9fkdVjpTmuwSQ2k7Wmwdd4huqhGJfr877jc8icHJzX2
         qrgdBEXmMmOZxSQq6Huacn1QlhttSuC/lMXYiCpvUhdUXty5GMKU26vO1QC1Xe2kolWJ
         HZFNawdf8uZMLQIp+HiJZ0OoX6U9XwbdaUzs1r7pxIW/L9eedy3R/DWn5o6hV5YhbBhC
         FLVih4f3HvKt/pYGn7ZqLLi0/p/qd70kBGNSm7EEB53umlpAl+0l6ip0YDZV/E1QDxHe
         C0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682690854; x=1685282854;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bC/uq7BLLftq48XdJ3Jz7d3/KkKfWfX2mH+ebE1SLA=;
        b=T11QUkB1FbyJrC2qK9ft1lZMhISt4qWRu/RmKVSZEz+1fgaP9GASDP04yb0eiCiCIg
         eWMNkHqkjyMB4X3iCJEmay/rBFuO4k2xkRB+2c/loRUKqzOaGopD8BycgRJD5jXUb0WZ
         EGqqOq1IvPs/FsA0hvq2b52C/g6mxR7uzoQ9JdCxj9Z20K0iFl+llY/PdFZ+lftSEQIO
         /uz9AZ3Sznq0HthntaP8Yu7acAc/B5ARuRFUMCvqy41qfaZQRB/zsSAA9j9ot2BD7oNV
         nVr52OfFZMkKFchapFJAILVPYIbhuiTlnQPV52g09GrTlSq/5ZZC/dJ24qQmzA0YVnAS
         z2hg==
X-Gm-Message-State: AC+VfDwRfC3Twl89m5QebV0IvQB+nEgkc/fSzemcnIEKx7V+5UdM4hcD
        WKiWnLNxDBJP3q5QDTsdb7ZUo69HPBM=
X-Google-Smtp-Source: ACHHUZ6uE2Cg8KK1eomKenfHOEnS8zixIufedz4rv0o8rp4MWAl2NM/Q8oS3FhUaS5SVgAlpJla0kA==
X-Received: by 2002:a17:90a:2fca:b0:247:6be7:8cc0 with SMTP id n10-20020a17090a2fca00b002476be78cc0mr5646636pjm.35.1682690853759;
        Fri, 28 Apr 2023 07:07:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b001a19438336esm13371855plb.67.2023.04.28.07.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 07:07:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <06c93e9e-4fdf-55f2-123d-f5cc8208f3d5@roeck-us.net>
Date:   Fri, 28 Apr 2023 07:07:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Please apply commit d08c84e01afa ("perf sched: Cast PTHREAD_STACK_MIN
 to int ...") to v5.10.y and older
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

Observed with Ubuntu-22.04:

In v5.10.y and older kernels, perf may fail to compile with the following error.

In file included from util/evlist.h:6,
                  from builtin-sched.c:6:
builtin-sched.c: In function ‘create_tasks’:
tools/include/linux/kernel.h:45:17: error: comparison of distinct pointer types lacks a cast [-Werror]
    45 |  (void) (&_max1 == &_max2);  \
       |                 ^~
builtin-sched.c:662:13: note: in expansion of macro ‘max’
   662 |    (size_t) max(16 * 1024, PTHREAD_STACK_MIN));

The problem is fixed upstream with commit d08c84e01afa ("perf sched: Cast PTHREAD_STACK_MIN
to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)". Please apply this commit
to v5.10.y and older kernel branches.

Thanks,
Guenter
