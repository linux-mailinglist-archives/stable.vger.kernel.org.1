Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADD79E557
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbjIMKxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbjIMKxg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 06:53:36 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DE2CA
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 03:53:32 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso19415705e9.1
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 03:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602411; x=1695207211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=eDXgptOhP+mbfAknWAgtu9itsI/5sFwmgt93+jJQ+0WaP7Sg5tsQZrEoq9NFuJU+aP
         3h0x83O5c/wVN6WzQTQlSaseARTHFT/kY7K9A7IuL7kBt33RDYiU+50DE9EJMph+LJ2r
         ilGjblh1dBvriJh+41hL5I6GZq92vLbKutvhyRo8sMjDrXT6Mw1xDgHP00oGIWBHSn/K
         mZVrcuGwaPC9z/I+y1lgs+69xPz2wjfZh/xCjSnA/tHgWdyiP0iv4Y1ABa9uYSBX0IU9
         8YQ5hRpeT72uf1JMhKkKkonYHq7nMfQGX2s6dwZoN13+zB+xIhW6adXZgSWhMfBvCkBf
         hp8w==
X-Gm-Message-State: AOJu0YxIimG9I+G2ku4sSrlUMcEv8YCZIMmICh7yi+pxYZo+SoHkg4ig
        KDxkNSmp3iGGYH0p5QmsLhw=
X-Google-Smtp-Source: AGHT+IGkRmZ0CR9beBwyh+hHjwDKmORDBKF9RFFeEpqhNR6GfLzRqzTJfhasbDBEewaLGoLOBgC4QA==
X-Received: by 2002:a05:600c:1c0f:b0:403:334:fb0d with SMTP id j15-20020a05600c1c0f00b004030334fb0dmr1712660wms.4.1694602410675;
        Wed, 13 Sep 2023 03:53:30 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l16-20020adfa390000000b0031c5e9c2ed7sm4528013wrb.92.2023.09.13.03.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:53:30 -0700 (PDT)
Message-ID: <917e2f75-ce0c-f631-11f6-0dd86ab114a1@grimberg.me>
Date:   Wed, 13 Sep 2023 13:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        hch@lst.de
Cc:     Keith Busch <kbusch@kernel.org>,
        =?UTF-8?Q?Cl=c3=a1udio_Sampaio?= <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>, stable@vger.kernel.org
References: <20230912214733.3178956-1-kbusch@meta.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230912214733.3178956-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
