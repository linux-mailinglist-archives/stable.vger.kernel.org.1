Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0577466B
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjHHS4J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHHSzp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:55:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373351C109
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 10:14:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f1240a22so5709378b3a.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514863; x=1692119663;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=frvcjSHU9+qDHY4YZC4he2fEZsvOzbP34ouHk5d60vI=;
        b=NB9H+GX92YeuwyZJ58ROuShbqGEm1bGu0GUZgEKjexgIt/naZdzXEH8ACRIdJuzZof
         WK8jU7TzDVtgtb4xweizjg4lulRQOxs7vmpBIAGRT8PESzz0l6XiJLP9tgEmY5F4fp98
         jDEgyGecoJHSnlSEa6Xo4lwc8BaEbKQaIvyNLjpgnB35gH9tjAvRiDwTC4G8/oyetjAF
         oacMYcWXrDGVjefEHwRUjZqAxmHAw628BorfTlWlWyPU2ozSv2eDP0ngZPi4CfQ6bGvn
         0v9eXRZXIA7/lX4/aYLzyacL70PJhcyl+3anfIiHbkI39KROfCoWE4z3syjiWBxOPXDC
         wFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514863; x=1692119663;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frvcjSHU9+qDHY4YZC4he2fEZsvOzbP34ouHk5d60vI=;
        b=iuqJhNkipB8BCy8DCMAHhDYLzPntYDCU0QP3JlTXwBddokLQvYbpAUqiMzCoYgHHuH
         3PHY+O9HiEQ7AeOlWMP4rIfTantKLyeOvw8yyCiPP476Nn6DS6EH+0hnDfky0N+wk0Xn
         PWS+cHjd9JCK96KTeZEpKUaZzzcDjyK8+j0IPjqgaQ/gqmzAwxAcpne8tnF9+yoSUJ00
         22tjBYAIiAOrvYkQLaDgb+NTj6kfNTRUn2tIy+Z/pp/dgcI0nO2HXNKqdt4V9C6TgNAa
         sq8hCJxb60j247KKOX5YEwKtraki6BAmLbW4N1glPPLbNlAtYbBRiz+qhL9SB/b6pzyH
         UK1Q==
X-Gm-Message-State: AOJu0YxHXrgT5rPqrzXyDktR/AbIr1t/BMiGip4vvbfuHdEX+t9d+sQl
        2Jz+phQp+VJaaRbXULsW676+iJ7LEQs6/UkcBWdakm0ASBbI7xPtfP8=
X-Google-Smtp-Source: AGHT+IEmrwbdceoImr/R1pVLTPPsMVZl7KMGyvlgjYP7+OdE6wTnFjB1sGC91Ej10qjfVOUgq8HfN0LbTnuvsAMOdpw=
X-Received: by 2002:a05:6102:3172:b0:445:202:d278 with SMTP id
 l18-20020a056102317200b004450202d278mr4303132vsm.32.1691472461928; Mon, 07
 Aug 2023 22:27:41 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Aug 2023 10:57:30 +0530
Message-ID: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
Subject: stable-rc: 6.1: gcc-plugins: Reorganize gimple includes for GCC 13
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

LKFT build plans updated with toolchain gcc-13 and here is the report.

Stable rc 6.1 arm64 builds with gcc-13 failed and the bisection is pointing
to this as first bad commit,

# first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
   gcc-plugins: Reorganize gimple includes for GCC 13

Thanks Anders for bisecting this problem against Linux 6.2-rc6.

Build errors:
---------------
In file included from /builds/linux/scripts/gcc-plugins/gcc-common.h:75,
                 from /builds/linux/scripts/gcc-plugins/stackleak_plugin.c:30:
/usr/lib/gcc-cross/aarch64-linux-gnu/13/plugin/include/gimple-fold.h:72:32:
error: use of enum 'gsi_iterator_update' without previous declaration
   72 |                           enum gsi_iterator_update,
      |                                ^~~~~~~~~~~~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Links:
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.43-111-g565bca90c30e/testrun/18861637/suite/build/test/gcc-13-lkftconfig-kselftest-kernel/details/
 -  https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.43-111-g565bca90c30e/testrun/18861637/suite/build/test/gcc-13-lkftconfig-kselftest-kernel/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.43-111-g565bca90c30e/testrun/18861637/suite/build/test/gcc-13-lkftconfig-kselftest-kernel/history/

--
Linaro LKFT
https://lkft.linaro.org
