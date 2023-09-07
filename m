Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD0796E04
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbjIGAcT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 20:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIGAcS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 20:32:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47E9172E
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 17:32:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1befe39630bso752925ad.0
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 17:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694046732; x=1694651532; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=625ClZrt8oVghGO1W4+HPuYjJ4aHf/zd3aj+bQU6AuY=;
        b=J6ojVrPZ4N4/Cau9bjwD9zbfpBN4ua8vN9JTF0kEzfjEEAb2YfC5RSIrkDlF+1tvpB
         CjOJqsNthfpgzbjLmzri+5WVyITXHpucaGEFwweDspbzS2xiwZndcE7ayoN5lRJy5ooB
         TDTUNKDCdKohF8ySHhx+KmJ4lFg4WeQ8Zj9vlwo/qmB0rme2u6MSeAfgIZ3wpnovpEEN
         F9k2/L9tdPF/YxMVmrk370uXRT8jZLeVZovK9QC+Ghg1y+P23GJ0UvV2KjUjgXWyam+D
         xC4zg1IEMwe6SpaivDZG8KOQBix1NlP3WBoH08XVRHy64b4Cgd5x0824oAiGtrV8h2W3
         4pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694046732; x=1694651532;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=625ClZrt8oVghGO1W4+HPuYjJ4aHf/zd3aj+bQU6AuY=;
        b=LiJWJQGsxCvtuaYPsojzcu3llyBqe40VSC9dgabQF8HRrxGEt3NGsMIwqOATn49wtW
         p4zZe2jR4ldXSRiXBLqRm5jJEFGWCO8JwNsUGRJT11Iio3Ie4U/tG6SljEsvas1cWHeX
         u8p4zIp/pRry7PCiAKbhLgPmA3bXLlqWZZZYeBi8TztjhfSSDYtAcft8yXdmIsYoQIM7
         MzP5z2W6v4gJnARbJSrPPy+tqwyhltNkeqWeOJHbzmTHDDv0swKRn2dUIz0NcwVCd91v
         Xv0zD07aXTWC3sXSJcepIiyDedyKk+uREmZyAgygE7SQFKkZ21qgF7RHCgfh9I38ByWp
         KlyA==
X-Gm-Message-State: AOJu0Yzi40UhPVBCUtrMONlpJpcY5DaRc98wHwg246bPcswet3Tafgx5
        GU09qIOJIeFdgNbcGlk5WLjibjV0BBdqw2jxRPDcTg==
X-Google-Smtp-Source: AGHT+IFsV9n9biDp5ydW69jcMIOskNBBIzwTGR16SirkgRfsIVRoNBAD8QH/R4ALZKQj/TFsoJXfKw==
X-Received: by 2002:a17:902:e74d:b0:1b8:aded:524c with SMTP id p13-20020a170902e74d00b001b8aded524cmr20219413plf.1.1694046732452;
        Wed, 06 Sep 2023 17:32:12 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bde877a7casm11783147pln.264.2023.09.06.17.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 17:32:11 -0700 (PDT)
Message-ID: <7ca1d2ea-b4f4-4284-bc17-6e413f5e12b5@kernel.dk>
Date:   Wed, 6 Sep 2023 18:32:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: 6.4-stable backport request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg / stable team,

Can you queue up this commit:

commit 106397376c0369fcc01c58dd189ff925a2724a57
Author: David Jeffery <djeffery@redhat.com>
Date:   Fri Jul 21 17:57:15 2023 +0800

    sbitmap: fix batching wakeup

for 6.4-stable? It'll cherry pick cleanly.

Thanks,
-- 
Jens Axboe

