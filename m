Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4887B46F3
	for <lists+stable@lfdr.de>; Sun,  1 Oct 2023 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjJAKiL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 1 Oct 2023 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjJAKiL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Oct 2023 06:38:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D595BD
        for <stable@vger.kernel.org>; Sun,  1 Oct 2023 03:38:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so2155579166b.3
        for <stable@vger.kernel.org>; Sun, 01 Oct 2023 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696156687; x=1696761487; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRa+yaZNNeSC0dtIiq1mnAm+SzWisYsiE91qACAa9U4=;
        b=NQXDFDUntofjQuqEWGcSi6hxEJlm6/+27W6ItTJKIub1tMA5F9MlKnQ9uFe712rS9y
         pDihT48SYJrB2pm+7FydwYNFj8/Fe5aScc4G3AWFUNMlh5ytA1EaFQkM3dPS/UVNxwz4
         GMhtn6Z1f7b67gZdTq51Ztz4OtzmnOSOqNsg8czSef9Z7X6yos7ssZ/hdxLcgxrhtCdf
         0uCM3IEsaORXlvaE8wA+YIv2j4bJ9FF6YApGymiiU8X8yVeSYwJakxdCzXBptUkR7YqV
         r9Z/zr9j28dWEIajomSoKoS72F7RoRkU59tAG6SFfW2DUdBYMsuWFWE/HPNujNLw0VlD
         q4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696156687; x=1696761487;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRa+yaZNNeSC0dtIiq1mnAm+SzWisYsiE91qACAa9U4=;
        b=ihsMLzw6iAflv0CjQlJue8hdD+uBrRnIdwvcMjGT+FXUsR1mdngEKJHJ0KbRSZhMDc
         YExi+mTMmawoirdvhV2D9b0ELP2KJjIFke8YzerA9rRtH8zZrw13tjbSLchiO4GDJX+9
         Dw99t8zRDwYjsfBS/wAXl4WVbQFjykxcjtNTV7kHXBTA66ibYBqlov3B721qM8ySsDj9
         dAk5YAeGVJ13vc4fR5kbver6TwooIRKfdLnQKxChZklQJRqIcYXskXPnEuU8AywnroSf
         58B1rA8HGqHx90kaOhKJDgE06cniMai7zFYhraZ/uKRtnS5TDMtsoQftv2CXnQYkYHck
         g0PA==
X-Gm-Message-State: AOJu0YygcTCzAKOI0K76XdOzLq+I0cW206AbH/lvjQ1p6NvYYCcoGs9x
        Ed1DAdWvY73sxVXIdsOnkDav5OGDki88G3NhTu8=
X-Google-Smtp-Source: AGHT+IEcsVPOhj5eoAZfLNrnFQN3cKwTydF6ADfGwEE/nXTlgZc++e6wrLaaQNbK/DMf89o8LvC3a+1MYrUotJepzdA=
X-Received: by 2002:a17:906:530b:b0:9ad:7d5b:ba68 with SMTP id
 h11-20020a170906530b00b009ad7d5bba68mr8125806ejo.32.1696156687121; Sun, 01
 Oct 2023 03:38:07 -0700 (PDT)
MIME-Version: 1.0
Sender: justicethomson1@gmail.com
Received: by 2002:a05:6f02:c252:b0:5b:e7cf:1540 with HTTP; Sun, 1 Oct 2023
 03:38:06 -0700 (PDT)
From:   "Dr. Thomsom Jack." <jackthomsom7@gmail.com>
Date:   Sun, 1 Oct 2023 12:38:06 +0200
X-Google-Sender-Auth: uiH7eZWIk0Y0tHtLK9eBmw95ge0
Message-ID: <CAH0Xq2+j91A68bW3XTUt3dUMxMyMwMKcj90Ee8mg8Mp3h-Z+OQ@mail.gmail.com>
Subject: I NEEDS YOUR URGENT RESPONSE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

I have a good news for you.Please contact me for more details. Sorry
if
you received this letter in your spam, Due to recent connection error
here in my country.a

Looking forward for your immediate response to me through my private

e-mail id: (jackthomsom7@gmail.com)


Best Regards,

Regards,
Dr. Thomsom Jack.
My Telephone number
+226-67 -44 - 42- 36
