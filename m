Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A27B0127
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjI0J61 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjI0J60 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 05:58:26 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70501E6
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 02:58:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c17d8745b6so35184361fa.1
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695808703; x=1696413503; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82XOa7q/kbH+exs+CFXiE7rt/QuUvHY6szgIZll4i8A=;
        b=UvF7/aOxbbfIpJEkKBGAtVoBk0gc8V3PQ4rG0DF8AXKRmGRFyYaVO1uql8sPmEwPZM
         nic2fYVuC2tftP4ijZeRdfsyY5Y49UbScgQx6C2RQYt+AIR2Q6tnmeAm921G77vCvWJK
         IfX4iCtTNW3CxviWUgMXFKrhGK8UXM4978inZmK0T/nA8J4iEaONgQIt7p2Vadds7Z1M
         OXZGKVXMkMm+gosKUnLHAMvMnFB5hzVNme6kpmRRLXZ3f9mbdlZj+p9LOi1Iq/TI4d8X
         HNBQw+xQUJIZoJnf5l3SVzNi2ohe0EbTlBuLskvgmbEG15eB15kx0+3jpnSriMshTN47
         g19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695808703; x=1696413503;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82XOa7q/kbH+exs+CFXiE7rt/QuUvHY6szgIZll4i8A=;
        b=Zyy8xfKY0/sg5vLXRSVxVynFSv+W36Hzo5kSKuXLs0YRmQvLF9y7sOleKKCVfNi75J
         sltE/qHgqKgH7qg8+tAuBzmrFYxOlnSikuuf1hzmSzQ2n3kH15ThasKOY2XROJbzhXtK
         l1xEdQuqvL7W6rPCSrsViJWJkKbzLlfEk4Ha+HJF0n4RYFu0VhgxZKLDVvVhYd5XqsV/
         gbWHTxGhb0lzfZzhHxNjRHYrMCwokwGs96dSxu18JKmJeJ9fEX7KVcPdlTxjfgR5BYuS
         9ERoOT2VPMJWoejVzv/aYbHr5QKAuBR6+paqhQqWQxNS6YRV5IvYv7DJe8uzEL+01mjS
         1O7A==
X-Gm-Message-State: AOJu0YwyEPAZCY1QqOizxCAnaoAjGq3XajpZbm4SwXV3T6K6PRG4Lmft
        3L8vMrrSTkY8qw+epwu9fE6tC1iZNe3tp74h5bc=
X-Google-Smtp-Source: AGHT+IGiFL62X0pmvOaeYX8pR9IP20wneiLNTKUIFgWLN/Ff5oAXdeuT3z7C4iybBaJj5XthnBJBKzcy2V0KYhnKctI=
X-Received: by 2002:a05:6512:711:b0:4fe:7dcc:3dc1 with SMTP id
 b17-20020a056512071100b004fe7dcc3dc1mr1145737lfs.44.1695808703310; Wed, 27
 Sep 2023 02:58:23 -0700 (PDT)
MIME-Version: 1.0
Sender: julianterry39@gmail.com
Received: by 2002:a05:6022:34e:b0:47:872e:b33e with HTTP; Wed, 27 Sep 2023
 02:58:22 -0700 (PDT)
From:   "Mrs. Angela Juanni Marcus" <juanniangela@gmail.com>
Date:   Wed, 27 Sep 2023 02:58:22 -0700
X-Google-Sender-Auth: 3H7jzWEXOJ_fzYZwupsy3J172ZM
Message-ID: <CA+Kqa7dySMcW4K7Q3KY602tHFPi0eK8mwtM8F9ayRMD3f6e-gw@mail.gmail.com>
Subject: PROJECT PROPOSAL....
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greeting my beloved,

I sent you a Humanitarian Gesture Project Proposal, please did you receive it?

From Mrs. Angela Juanni Marcus.
