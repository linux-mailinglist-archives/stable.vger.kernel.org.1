Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191BC7A5326
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 21:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjIRTet (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 15:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIRTet (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 15:34:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF310E
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 12:34:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso642245366b.3
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695065682; x=1695670482; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2JyPo7jaUiq0wJr1OF6TcXlU8z+VRIh1LsJzTpMsTwI=;
        b=CTmV8TwHI2KeYmqEjpprDWvElyKW7PBYGzilKUCiXf/nbLsGtq5xkRY979bk3s5Wv1
         lluSYFo8Xp5MD4442ZvRrfk1gC5tjttDePnNtSOGiPCJE0qxrJ1aHcggdoQFr2gFgm+X
         09NEoH7YiR1A/dNgXaH8v5ZtaioZ2rYJLDzVtSH1ew7KzgU8LRWnaWVqWxtZifcjY2AU
         FB/GKYa9oqGA8o6t0MpNMJ8UbtGcpvSW46qFcGGIXRyO7kDOpNqJpJNjCwMRsdC/hl/T
         UE02/orLnZK/XJ/Dae9T03k5pdXdBGArZP8eWlp6aARyueFX9ZYaQsjmlCcmd0+BvtoG
         UUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695065682; x=1695670482;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JyPo7jaUiq0wJr1OF6TcXlU8z+VRIh1LsJzTpMsTwI=;
        b=JFDw4AyPUCCZHhxfc0/KkdZ7sqKrJtl7Lces6u3aVIDH5jQuhBcfwLLTM+RmJITlHk
         ezVyCxnefP92mvguwl0jWr4UD00UmGWOmLhZ5qbTrYpMnoXng/xZ872glDdEKcb1W6fj
         rrwMH1MtYMZ1x30uTmJd98lS0NAhZXdsl6DJz9j0YCad73gcpVJPLCn8Q30B+3O8TUf+
         ec9xlhbvHl25U2xK2dnnhqt6sEJt1786nYcMb+fLiLTjIaeMgRdECKWDaozIXzYf9q9J
         N25cy6w6bSQg9cTxEOr9ZlnsF19yI+hhDR3dpvHHHuQ1poBnAmV5mjPIIfc5ja58Lhdr
         efFQ==
X-Gm-Message-State: AOJu0YwhSX7YnV+RtsYXn+TXUbtLwODyKFEWxJcrB3QvxOOEq5pd4Cbk
        jURb5T2DHETWMVUsEvGdtksj5dkCobJ2AWwU+GQ=
X-Google-Smtp-Source: AGHT+IEEsHDVkz8G+dSha8966949Nc7O95mJuj/515LLyysCGAQEV7Stbc1+bN7AyvGGs4di35u48F66vfbUdv2B1mk=
X-Received: by 2002:a17:906:846b:b0:9a1:eb67:c0cc with SMTP id
 hx11-20020a170906846b00b009a1eb67c0ccmr8801684ejc.34.1695065682117; Mon, 18
 Sep 2023 12:34:42 -0700 (PDT)
MIME-Version: 1.0
From:   Kris jenner <krisj8863@gmail.com>
Date:   Mon, 18 Sep 2023 14:34:29 -0500
Message-ID: <CAH2n4g92ydksRJoj2k4o9afGVkYCw5h0CvbmZ8M+ERPkiaH+wg@mail.gmail.com>
Subject: RE: HIMSS Global Health Conference Attendees List 2023
To:     Kris jenner <krisj8863@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Would you be interested in acquiring the Healthcare Information and
Management Systems Society Attendees List 2023?

Number of Contacts: 45,789
Cost: $ 2,175

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Kris jenner
Marketing Coordinator
