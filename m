Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4093D75B265
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGTPXV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjGTPXK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 11:23:10 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F172699
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 08:23:09 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id ada2fe7eead31-44504b2141bso352400137.2
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tidyhome-info.20221208.gappssmtp.com; s=20221208; t=1689866588; x=1690471388;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X+3k3tBg/Fdkv+dajZP4yN1BR4tLBJUc4WD7mrDhukk=;
        b=0jwzrKlU25rRDqTYzMhBkd67FSkoe20ZP9fzTJau6gQnmzUKSEc0uUF8qz3qUPiveo
         oF6EPl6hxhFtgK8oAAWBFJ8Azsl+5mHGvVp7FeNFiIADbGXVz7opt2xXTxhYuqZ2QBDl
         BVnCP91JfyWanSo9nLbAT5FK1cVFEo1B4oAksSiYLpxRceTlCH78V2n5O8Homt/9+n6v
         nvMdIZkn6qfpm37oqxk8dqm0v3dvORubRNKH4w9qXCDMtLl5AcSEpMYMGujJQ1MjK3iK
         PKPn/ELZAzZgJr6ytSK4GEgYEG+Zn5WVp49rptf8JDuzRPZ6ywNopU8x46RLndcWSuMp
         P2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866588; x=1690471388;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+3k3tBg/Fdkv+dajZP4yN1BR4tLBJUc4WD7mrDhukk=;
        b=e6MEdwkXulIw4YXKvzHqLfHnT9Vcdvwi8+jmJq7GAjzLxcdu1tFvU8iQbPnLOlcObC
         C5f4NFDawSt0JTF3cZgQeheGaGfBADLd0v1HvyJnomIboY6+NTBw/dsn/6QfB7U2lmwS
         dxJDgoO+F48RpJlbLqF1ptwmd9Q5KXct+ekQ15QiF6KgEbYUk++ye//3ufd6EKEWbJlk
         8zINypBH9G27OT0XoxA0dO0+s8pRnkFVt6jU7hqLD3xpMjTKDvLgVru4V/OcdNJFCZOS
         bBg7zhCvUVaSgME1kV7FjuyWlQky0NvshRzg/D9+jIEarhqmgL9ryUEnJ3iAzJvAm2s6
         QcsQ==
X-Gm-Message-State: ABy/qLan8TeFE8OCdoXvR8lEML+BKVhXz3p6RR+MZryQ+L6anm5Sla2L
        ngmQlGkRGZ7I4Zfh/l51YB7pgBpjtv86fgDyKdwDd4VoEIGxXpWN+Yk=
X-Google-Smtp-Source: APBJJlHPdC8uVjvIk3TFgXdfuY93wqxn/yAn/rTUM95ye7hxQwCCgzfMqwIIvCwVWsuO9HLD8d9gkmqkJTYZgcdozP0=
X-Received: by 2002:a67:bb0d:0:b0:443:874b:7d64 with SMTP id
 m13-20020a67bb0d000000b00443874b7d64mr3992126vsn.26.1689866587888; Thu, 20
 Jul 2023 08:23:07 -0700 (PDT)
Received: from 336865953327 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Jul 2023 08:23:07 -0700
MIME-Version: 1.0
From:   Alice Robertson <alice@tidyhome.info>
Date:   Thu, 20 Jul 2023 08:23:07 -0700
Message-ID: <CANoM+0OfAX7NvrBb+S3PYrvbQHTQdf_XiMptcXfr-YGgWjPq6g@mail.gmail.com>
Subject: Would like your feedback
To:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Many people have decided to continue working from home. That means the
makeshift home offices they set up in a hurry as everything was
shutting down during the pandemic are going to need a revamp.

I thought this would be a great time to offer a list of resources
about designing and organizing a home office that optimizes both
comfort and productivity over the long-term.

I=E2=80=99d love to submit my guest post to your site for publication. Woul=
d
you post it if I did?

Thank you for your consideration!
Alice Robertson of tidyhome.info


P.S. If you=E2=80=99d like to propose an alternative topic, please feel fre=
e
to do so. I am more than willing to write on a subject of your
choosing. If you prefer not to receive any further communication from
me in the future, please inform me accordingly.
