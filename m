Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7836379F183
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjIMS6N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjIMS6N (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 14:58:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A351985
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 11:58:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-501b9f27eb2so1583996e87.0
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1694631487; x=1695236287; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zBj6p++Qh8jXWGI/WFi0CSgU27ebTJ4j3bK1DZUl5Kw=;
        b=Se/tZ84Q0N0eL+xp/i7O6m19c1QPQO+FBK2xyuRgJUPjoOy541XaQwOkkVRe0StyXo
         AoFOc9Ugy/ESlpabLNH3tXLwnMTJnCUlJNRokWLl47mLLmgTNtqCrdyK0/s3F4BGXE3n
         uqFbWteCM0sRE69O4SZeZ8ayQY89DcIJYnOL8yLojnOj61dXhqISnA4VDdYesfdQ+irq
         dWfkMcj3bbwGT364k46daIC9S8p8Z6IMe7T6SqO4u/mQ+8OAj/x4pIxpM9UisWpzBcHx
         nStXlRO/iELaAiryJsrQEGuobKj7TfsdhiszdIfVZ59Dr+2rOpylQ+qV07ALtsWtnT85
         GWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631487; x=1695236287;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBj6p++Qh8jXWGI/WFi0CSgU27ebTJ4j3bK1DZUl5Kw=;
        b=GNifskwp2YMjSDZbU/DKQI3DiWEy9sLbzKvC5EmooOawgzPxRbtZbkO6y37Lvso3q8
         RSH6j6d7GXUeWH32OeTOslsKqIcvH6x+thLlzvhT2TquUvrh6EJGrq3HOLFB/qOeZ+cV
         mbfsi1T+8IshAR3z+CVunUHp9OoxWvY3tSSC/Uq/OyOnpmpoJoiiSWs+uYXZWnxUbPps
         dprrVZTBwm3DcBTRuCDprP/Vkd1FqoFO8JKXr3P65zP2s6i/JFMWTZjdQHOhzOP3XN3a
         B73aNK0YOdo04NF3WF+lyyM6urvXF8QOZQiLTOWs5wHNH85zZ5WQ9yYJIJyPp91uKaBs
         shTg==
X-Gm-Message-State: AOJu0YyLs+GpQmsVAUZ+qCj0BELfBj/I0Z1+sUMTPGKpitbaBbSmLPuy
        6LzwmYXrOqngKwfeLcQxj2v9EDUGm7gop68KxJOw30MDDnr6Vifk9MN9
X-Google-Smtp-Source: AGHT+IGZ+D5kl00YHI2JJ6DcumX3Ia4Gk29qvxttKtG/Wae63pJv2LYrUq6RpLrHoCOwUoT3JNfEYF4H7ja4ubEBAAU=
X-Received: by 2002:a05:6512:159e:b0:500:af82:7ddc with SMTP id
 bp30-20020a056512159e00b00500af827ddcmr2618766lfb.28.1694631487079; Wed, 13
 Sep 2023 11:58:07 -0700 (PDT)
MIME-Version: 1.0
From:   Da Xue <da@libre.computer>
Date:   Wed, 13 Sep 2023 14:57:55 -0400
Message-ID: <CACqvRUb_X14pjaxA0Q7bQf53TAFmk5rjQOSWqx3Tvi4g+vcNMw@mail.gmail.com>
Subject: linux-stable 6.1.53 kernel crash on COLOR_ID_MULTI handling change
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Pavel,

We have running systems that use COLOR_ID_MULTI. The GPIO toggles
between two colors and we have used the identifier. RGB is not a good
fit since it is not a RGB LED. Please provide guidance.

This patch causes the system to not start: f741121a2251 leds: Fix
BUG_ON check for LED_COLOR_ID_MULTI that is always false

It was also backported to stable causing previously booting systems to
no longer boot.

Best,
Da Xue
