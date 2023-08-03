Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5424F76EB1C
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjHCNso (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 09:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjHCNsa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 09:48:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2022F4EEE
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 06:47:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40398ccdaeeso5981891cf.3
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691070431; x=1691675231;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zseKbfLWs9zIg2+xdp7ES4ETCzu69tRL4V7rUgw0H3Y=;
        b=Sw0639MSAk8jSMAWoUbOCvuuwlprlFFIwILnK8nMJIr7fjke0eE2uzyioICdlB3Wtn
         jmNqo2HuAJVzU64K3aodygWYW/vEZW+89SLFFB8BCrfKkeYvTgSuuPgdmi/NSm5yKW+J
         YYezAwUIL4WDpZsT+8rCP1Vr/fHETBTgKHP5yYj5vpGQbkEjcJ2OFvjIRZSaMNAcMnEd
         aaj4QJSK/rmUqcyxyFrEGfO5E3Y74SZ5sQNSjBE2xZUmtoqUsIUqFb4LIpsrzelHyU4J
         VK6RbxuteeoJtI1OFH7na73lxKicXjlUOmEEmN+sXeSIfZQOfiXdVk7X1lmdXcPaSmVT
         +Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070431; x=1691675231;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zseKbfLWs9zIg2+xdp7ES4ETCzu69tRL4V7rUgw0H3Y=;
        b=BQtCGQee8C1lqNSB7Frzj1raPX7xT4RXBZMV1WEisS/iUDYG2Zkg6ItSX/sQSYMnmf
         UTbBsgIqt5Xh3HbztsWklRm/ksmLy09Jx77ubYl+ko+z6a52+CCGzgC1vwH6lj21BeEd
         AhImliBL7tmUPgRL7QcZcshbUHti0beYqUA8Ts5RKbl0h+kutPSkA7XWeiWNsIandfMO
         F2xiXvviTXkcN16l/EiAs8aXjrMkpoSGgHfGl4rs9Ibps//GIR1yaF5GyXXTjncSMbPr
         AlqpAlNNcZQlIO+6qHe4dglI5OOW2kZTSracl+9MJ1TLimiHEWnhOgD42NWDUzJujnqy
         2Q+Q==
X-Gm-Message-State: ABy/qLYhGcm7mI5j81PlSKBOXw7rYenkt6R7lmD4bGf898iuMa2c87qw
        YN4/2fzmQaogsX47xhNZ9Z1MJRyxI30mgNqon8Q=
X-Google-Smtp-Source: APBJJlEVu7ZrkjGRwma4PuGfEhkoQMx5CRBc2i9iv50Ha9jBrr1GqTbSrH8wUBzxhl9fHJnOqnpELQ==
X-Received: by 2002:a05:622a:1d5:b0:40f:da66:4da with SMTP id t21-20020a05622a01d500b0040fda6604damr7930401qtw.20.1691070430857;
        Thu, 03 Aug 2023 06:47:10 -0700 (PDT)
Received: from ?IPV6:2803:2a00:8:bf18:c5cb:dc8d:dae6:5e27? ([2803:2a00:8:bf18:c5cb:dc8d:dae6:5e27])
        by smtp.gmail.com with ESMTPSA id pa2-20020a05620a830200b00767e1c593acsm5880575qkn.79.2023.08.03.06.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:47:10 -0700 (PDT)
Message-ID: <1ff785e1-479e-a822-73dc-cd713a2781c5@gmail.com>
Date:   Thu, 3 Aug 2023 09:47:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, admin@linuxmint.com,
        root@linuxmint.com
From:   Misty Plianca <thepalpatinelives@gmail.com>
Subject: YouTube Broken Since Last Update(s)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,

Since installing the latest updates for Linux Mint yesterday or this 
morning, YouTube is acting super goofy via Brave Browser. I cannot 
search for anything at all. Nothing happens. Secondly, it is 
occasionally reporting that it is disconnected from the internet and to 
try again. Firefox works fine, however. I reported the issue to Brave, 
and have now communicated this with you to be certain everyone is aware.

I have some other stuff to discuss with you when you are available. I 
have information that you may find helpful and disturbing regarding 
Linux security. If you would like to discuss this, please reply.

My System:

Kernel: 5.4.0-155-generic x86_64 bits: 64 compiler: gcc v: 9.4.0
Desktop: Cinnamon 5.2.7 wm: muffin dm: LightDM Distro: Linux Mint 20.3 Una
base: Ubuntu 20.04 focal


Regards,

Misty Plianca

