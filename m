Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A61B7F07A7
	for <lists+stable@lfdr.de>; Sun, 19 Nov 2023 17:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjKSQyB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 19 Nov 2023 11:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjKSQyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 19 Nov 2023 11:54:01 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AAE11D
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 08:53:56 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35ab17957c3so13769405ab.3
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700412835; x=1701017635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUS1v3wNMMoGJxYMVaBxxhfLYqoOUIyNu6oyB8+7CoY=;
        b=wbzQOQcXZjPccipsqkggz9I7/TGZ7HrYMG6u5StgQPR/7lrAu0oK1CDxNdjYo4dFNM
         yz1XWPaVCXhAXfPE1QRk8aGqqtYvJXdDpWNvt6l6hRjXt0jEadYcIhFqmRL6t8VsdsJD
         7uglHbQUC4YRD3y9WUKVp2ePcZIMB5oVH2mNNXegVVj9JRGCXFjO3v5qAlZ+XCI+45a9
         ZeRAJsEo/YP/l0XJm7xCjt7z0U/8IsYwGvSN0zUMXGnUmXPGR1AANwHwFOrWt0GcJ5LC
         CInrVPuCDy0PcjfaTcOfVaXtit6hmJl+SBVckbveiuZor29rZfzKAtGLq0FiS/a/VkA7
         dwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700412835; x=1701017635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUS1v3wNMMoGJxYMVaBxxhfLYqoOUIyNu6oyB8+7CoY=;
        b=lzFhoP09y8xW6DrGLw8WsD8FWidYGwThKVSpchUWLfrrhf+dgCqgBn/q8HgINZmIzi
         dXHJwWDeg/6A5YubRJVB+4nL1UZwgoHXkpzu4Mw+z/rvixUZ51vrP6pPQAPeI3BupfQX
         dHS95eZfwtiID26Xc6aF6AQ5LKMtuozSPl+LPlgixrHxQWuacdERMlfU7Cqa45BszVS+
         c4YED0Vol1FimpGCy325tcAbG3K1tJ8WqX00GQWah2h28fCWawQq6OyvEocLW0/qTZv5
         spwlDHmq3fJdZSLXbGd4edYNIgV20e4DjN+/WiWznExcunMo9JVXP5/AJKGWpsw0MCtV
         oFfA==
X-Gm-Message-State: AOJu0YyzPBxYVTjxRPVtKGpJX88tfJNF5z3FNs0oNfWZKJzv/qqMKFvz
        QOitA0QUSVtM1j+ZtUM8HaSQFQ==
X-Google-Smtp-Source: AGHT+IGZk8yR7OXDxLijh8akMDnL2tiCC7udbApOFmoHTqjULbw6221/2olHGvdVIKe0x5tKMk3c7w==
X-Received: by 2002:a05:6e02:154f:b0:357:6bd2:b2ad with SMTP id j15-20020a056e02154f00b003576bd2b2admr7366973ilu.22.1700412835617;
        Sun, 19 Nov 2023 08:53:55 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id fh6-20020a056a00390600b0069343e474bcsm4537415pfb.104.2023.11.19.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:53:55 -0800 (PST)
Date:   Sun, 19 Nov 2023 08:53:53 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH net,v5, 3/3] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231119085353.757792c1@hermes.local>
In-Reply-To: <1700411023-14317-4-git-send-email-haiyangz@microsoft.com>
References: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
        <1700411023-14317-4-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, 19 Nov 2023 08:23:43 -0800
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> From: Long Li <longli@microsoft.com>
> 
> When a VF is being exposed form the kernel, it should be marked as "slave"
> before exposing to the user-mode. The VF is not usable without netvsc
> running as master. The user-mode should never see a VF without the "slave"
> flag.
> 
> This commit moves the code of setting the slave flag to the time before
> VF is exposed to user-mode.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
> Signed-off-by: Long Li <longli@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>


