Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7367B8327
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJDPEb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjJDPEa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 11:04:30 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBDBD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 08:04:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a229ac185aso26632197b3.1
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bizlibraries-com.20230601.gappssmtp.com; s=20230601; t=1696431867; x=1697036667; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LixL85EGKjZ0SM0APnrtawO3yBsSUoEgqhQptyLcfS4=;
        b=LdFdkl8opWxNb8QVTFUWBYkAYyYbUnUmmggYTksOX0PxBhl4bmJJpjgHya2r1x8pRM
         bjoxqcCfabO7faRIcP9BLEZqbK5ytgRTsx6IiClNsoD6S/XlfcK57USJLfQGWCP2CJvn
         t6GHwpLkyWtDTijqlgQQnR4icWaBXPUoDPgwRzLyMSPQWxDDVVeINtYNqwFn0tcEz+Vm
         Kr1F6QnaYAa+n5Kh6ez/1wiVVUS9t7HHZwz/cE3KU53vl7bodygtr6fTG2fz2aTj6NTT
         jw5QinxQQGnjdB62IPKcCj50VrwrPeXN/crrCdSsZsqbCKYAeDoCX1LNRZbkjdYdsYPA
         lAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696431867; x=1697036667;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LixL85EGKjZ0SM0APnrtawO3yBsSUoEgqhQptyLcfS4=;
        b=iccEyUjAUAGDrOMdUGjLB7uevln6oEkrLiiSjV14edTuuRSUBH5niDyrbQ8mMRH5Cp
         jgEoT7+hKcaV176ZOos4qNlqXpBwPcDd+KhpEnZgA4CVQBibqsp065Xn/a9wznm696M+
         AZkGav6RpBOdP2efJeRz1XwJc7X+kxHivKoOB+r5JIEx3Y4KTrgv0deEfzjxZ/GEI9td
         tzD41KMRGUI3qVF1atXXzt7QEzP5/h91TD8V4VxZeNtBIU0k0wheF65PAVWCyglHQVNv
         cIhyqAck4sE079neVMk4pJUABlxUoRzaXUNkf7lfwkM/sNIlEvKTdLc+t5IcopT/qOmn
         kumQ==
X-Gm-Message-State: AOJu0Yzwu8sm3i4Ztmnfyum4cfwETWHRAzncxM2m9nbcSFo+k7kdztYt
        H+c1iARXjhz1bwmVG9VjqifJmKvqo4OEoRThHn4+Jw==
X-Google-Smtp-Source: AGHT+IFrl6QKvzHt52oIIxsspfzWCVMhki6M80BeBRSwOTs9rPwXRnh16f+yxO0rmy6IPGP7Wx1qM2U6XIRICRmZesc=
X-Received: by 2002:a81:72c4:0:b0:5a4:ed60:37c1 with SMTP id
 n187-20020a8172c4000000b005a4ed6037c1mr2701543ywc.37.1696431866881; Wed, 04
 Oct 2023 08:04:26 -0700 (PDT)
MIME-Version: 1.0
From:   Mary Liyana <mary@bizlibraries.com>
Date:   Wed, 4 Oct 2023 10:04:14 -0500
Message-ID: <CADgBp9NmQpZGXzu0pYzT-Sj5QgSYuQ5hmqdKxyGhCm9LCEt=Cg@mail.gmail.com>
Subject: RE: Money20/20 USA in Las Vegas Attendees Data-List 2023
To:     Mary Liyana <mary@bizlibraries.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Would you be interested in acquiring Money20/20 USA Email List?

Number of Contacts: 11,542
Cost: $ 1,687

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Mary Liyana
Marketing Coordinator
