Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8395714F5E
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjE2SZm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjE2SZl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 14:25:41 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C486AC4
        for <stable@vger.kernel.org>; Mon, 29 May 2023 11:25:39 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-625a9e2bf6bso17638976d6.3
        for <stable@vger.kernel.org>; Mon, 29 May 2023 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685384739; x=1687976739;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMa20DRTZSpdgpwCs9juShVIUPKIhPaDT7vhd/uJb7g=;
        b=fLic0RNkMugPbCUbha5xaVXcqtqXBGfRz4Mv92P3bdhk65c2lI5EDsWJNzTyxXHOSq
         yxDcp+98ViqgrDbYfH8L7mAL3k7obiu+YWLHSG7RH/AFOCMoED9SSi+zjUs5FdBI3UB9
         FehG14gHaRrktiQ+kNXg2vLqaFhghqfxPQBfYccLf8GikH9dy4VQl//fKCjT8HVVXG9T
         kMvNqUuZ0bSzG7xJS5hr7CbvBop6Kz7x6vqs8mEdB6k9ts5lec2VZYwQaujnP/1i13Bk
         p1YHdj00SsCMTg+kVFKpyINHsH1aJFAQpnz4GWh9zc6mr1YeRt6VmjeXj1zD76/ADUWS
         pX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685384739; x=1687976739;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMa20DRTZSpdgpwCs9juShVIUPKIhPaDT7vhd/uJb7g=;
        b=HYUypZUPu6UIb06Q3Yd2L8ZKx9BlNJNTfBjLAmirrg8GyAm3mamvrLyVd4XjpWxJK/
         EwWUzV72aSm5lHV9MvehPm3klLOGt/bYjbB5G0yhuWjj8VW3uCdvhnONHesiH6WKuBmz
         PJVF2YDqB7uDmfm1+KvcD09OMR9/26y3KkA9SirIp9dlH2pm6tZE3Ok16HtaosUriHCr
         TkEOUmQeIopFBdvqSL/dyUw70ZEx77CdLmw2lyW3OIL5SEkQJNd+avCUO/DEK1vvLGeG
         zjHEkPfP9FXoNnEjX6fmGaD8vcabs+IgnnmTjrnGr5sQUm4qkf3gP8XMRbK/Xbn/0ZuK
         Wo9A==
X-Gm-Message-State: AC+VfDx1EUURH0ew/wmRq3kIE6/K3qXK4ohm/EPElov8wzu4KMJ6Mbip
        uDvOXfUVIUDuF/q3uJsknDYNPVbIt3Whxi8W5yw=
X-Google-Smtp-Source: ACHHUZ5CmWDW1OpYsjmqF6XrpuJ1vYiL1F+4bjzXRC5tYx2P3C+ogCibqDPQDPlYZErtXguuXP7kUFnHPgkGkHUaMi4=
X-Received: by 2002:a05:6214:ac6:b0:626:273e:c36c with SMTP id
 g6-20020a0562140ac600b00626273ec36cmr3966656qvi.8.1685384738909; Mon, 29 May
 2023 11:25:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:a80a:0:b0:623:58c3:2bdf with HTTP; Mon, 29 May 2023
 11:25:38 -0700 (PDT)
Reply-To: peacemaurice47@gmail.com
From:   Peace Maurice <jeanamavi89@gmail.com>
Date:   Mon, 29 May 2023 18:25:38 +0000
Message-ID: <CAEXPVZjmaM+dLLz59UwQ1biD_WW9yhxhmKh_SQ7jdrqR7zCvFA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2a listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [peacemaurice47[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jeanamavi89[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jeanamavi89[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I wrote to you before, but you didn't respond to me.

Regards
Peace Maurice
