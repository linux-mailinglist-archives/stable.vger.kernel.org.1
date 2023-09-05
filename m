Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909F279244F
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjIEP6p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354227AbjIEKM2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 06:12:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2A18D
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 03:12:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52c9f1bd05dso3344499a12.3
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693908742; x=1694513542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e86Wy3ATT/OU246cW5x4ED89M09p8uuT794yspAsqs0=;
        b=q7g300DHyOJ4TuiF4Masc0kdl9J7bRU8aQD5W59NiRLDS3ESHRi6dUMLqC/rRqiFam
         +UQ5oYoxxrnqmrrh7VR3P2hpe0QizU5p3NViZw832D6Us8xVW4ieg7UegrnIhafUzpEm
         nUGOzZ8K23bdxfeTqvQZPcE+1BJTnwnsisWQKLfONIHenhPnWSH0wlOkqHCONpMj2EQ0
         k6TubCN4rX9bxjqRagCSL6UOShCf9ne/CORJIq4V5JCrimXVlS8sDmzy6e+lP/+rGDqw
         2zzeU6rDGA431oCD0aWefS5d9nNGB48bX2U1uetpBqGODDfQINu/uEYUNWolGEdeaBdH
         vw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693908742; x=1694513542;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e86Wy3ATT/OU246cW5x4ED89M09p8uuT794yspAsqs0=;
        b=C3/2qMuWWHDlRMruCu3E78HRUIwa+EO+3eCOfyDynFa5ZZvBQD0lrBe2oYa5pOuFeZ
         pD/g/q7uIX1jF5ZH5LpIZJ6oexa5C3rge94icTfLoez3GK/MCtY0se4ayMPEJSuZfebw
         WNZ2Hm9eIg6K/z4fGXOkmP6VixObpAMSMnGnWja0LpIGfd4KKd+kgxhB+woK2lMDe1VP
         Ko6fKNj/wj8Q+bL3kuyZ/UWIEHsSNQ5PAGtR1Ynqjh0m1zJ8wd1P2jBHjyzmFtYKtQa1
         0lB5sX16YUYxSumr+OKRpcwgxl859edtv54CNnGPjquQYFXZ204PjFmNpyc66Cc6mCsu
         ymEg==
X-Gm-Message-State: AOJu0YwZJ1mkiYUFqMbUG/AQUsnbdlrwaDYxlxpVZWI9qdCJvmcloV0L
        hC7/BF6saOg264tcGiONFi9k7OPzxXYUQXQ0vQk=
X-Google-Smtp-Source: AGHT+IFtEs9mWFBpsEix5UrjaXNdwrMvnwAb1slyKTXl/nh9oMhqDvJ0A0+iT+S2hQ1QIcGFmai0uRh3p878HQXM3/A=
X-Received: by 2002:a17:906:3185:b0:9a1:c00e:60c5 with SMTP id
 5-20020a170906318500b009a1c00e60c5mr9033774ejy.48.1693908742368; Tue, 05 Sep
 2023 03:12:22 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 5 Sep 2023 12:12:11 +0200
Message-ID: <CAKXUXMzR4830pmUfWnwVjGk94inpQ0iz_uXiOnrE2kyV7SUPpg@mail.gmail.com>
Subject: Include bac7a1fff792 ("lib/ubsan: remove returns-nonnull-attribute
 checks") into linux-4.14.y
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, llvm@lists.linux.dev,
        linux- stable <stable@vger.kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        eb-gft-team@globallogic.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear Andrey, dear Nick, dear Greg, dear Sasha,


Compiling the kernel with UBSAN enabled and with gcc-8 and later fails when:

  commit 1e1b6d63d634 ("lib/string.c: implement stpcpy") is applied, and
  commit bac7a1fff792 ("lib/ubsan: remove returns-nonnull-attribute checks") is
  not applied.

To reproduce, run:

  tuxmake -r docker -a arm64 -t gcc-13 -k allnoconfig --kconfig-add
CONFIG_UBSAN=y

It then fails with:

  aarch64-linux-gnu-ld: lib/string.o: in function `stpcpy':
  string.c:(.text+0x694): undefined reference to
`__ubsan_handle_nonnull_return_v1'
  string.c:(.text+0x694): relocation truncated to fit:
R_AARCH64_CALL26 against undefined symbol
`__ubsan_handle_nonnull_return_v1'

Below you find a complete list of architectures, compiler versions and kernel
versions that I have tested with.

As commit bac7a1fff792 ("lib/ubsan: remove returns-nonnull-attribute checks") is
included in v4.16, and commit 1e1b6d63d634 ("lib/string.c: implement stpcpy") is
included in v5.9, this is not an issue that can happen on any mainline release
or the stable releases v4.19.y and later.

In the v4.14.y branch, however, commit 1e1b6d63d634 ("lib/string.c: implement
stpcpy") was included with v4.14.200 as commit b6d38137c19f and commit
bac7a1fff792 ("lib/ubsan: remove returns-nonnull-attribute checks") from
mainline was not included yet. Hence, this reported failure with UBSAN can be
observed on v4.14.y with recent gcc versions.

Greg, once checked and confirmed by Andrey or Nick, could you please include
commit bac7a1fff792 ("lib/ubsan: remove returns-nonnull-attribute checks") into
the linux-4.14.y branch?

The commit applies directly, without any change, on v4.14.200 to v4.14.325.

With that, future versions of v4.14.y will have a working UBSAN with the recent
gcc compiler versions.

Note: For any users, intending to run UBSAN on versions 4.14.200 to v4.14.325,
e.g., for bisecting UBSAN-detected kernel bugs on the linux-4.14.y branch, they
would simply need to apply commit bac7a1fff792 on those release versions.


Appendix of my full testing record:

For arm64 and x86-64 architecture, I tested this whole matrix of combinations of
building v4.14.200, i.e., the first version that failed with the reported build
failure and v4.14.325, i.e., the latest v4.14 release version at the time of
writing.

On v4.14.200 and on v4.14.325:

  x86_64:
    gcc-7:     unsupported configuration (according to tuxmake)
    gcc-8:     affected and resolved by cherry-picking bac7a1fff792
    gcc-9:     affected and resolved by cherry-picking bac7a1fff792
    gcc-10:    affected and resolved by cherry-picking bac7a1fff792
    gcc-11:
      v4.14.200 fails with an unrelated build error on this compiler and arch
      v4.14.325 affected and resolved by cherry-picking bac7a1fff792
    gcc-12:
      v4.14.200 fails with an unrelated build error on this compiler and arch
      v4.14.325 affected and resolved by cherry-picking bac7a1fff792
    gcc-13:
      v4.14.200 fails with an unrelated build error on this compiler and arch
      v4.14.325 affected and resolved by cherry-picking bac7a1fff792
    clang-9:   unsupported configuration (according to tuxmake)
    clang-10:  not affected, builds with and without cherry-picking bac7a1fff792
    clang-17:  not affected, builds with and without cherry-picking bac7a1fff792

  arm64:
    gcc-7:     unsupported configuration (according to tuxmake)
    gcc-8:     affected and resolved by cherry-picking bac7a1fff792
    gcc-9:     affected and resolved by cherry-picking bac7a1fff792
    gcc-10:    affected and resolved by cherry-picking bac7a1fff792
    gcc-11:    affected and resolved by cherry-picking bac7a1fff792
    gcc-12:    affected and resolved by cherry-picking bac7a1fff792
    gcc-13:    affected and resolved by cherry-picking bac7a1fff792
    clang-9:   unsupported configuration (according to tuxmake)
    clang-10:  not affected, builds with and without cherry-picking bac7a1fff792
    clang-17:  not affected, builds with and without cherry-picking bac7a1fff792


Best regards,

Lukas
