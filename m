Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634BE7E0AE4
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 22:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjKCV56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 17:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKCV56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 17:57:58 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E5133
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1699048669; x=1699307869;
        bh=MANW3D6TqgNkVYCMd/NoUkNriWaWU+H+nc2+2VuQmOE=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=X949eL7efWFcsyJP4s+wdZAPKlZS6yAnov2iqg80tAti2X6HozTIVR9Mcb9VpDu5B
         cdifaTghgVqqD1ZhDzI242zi5lkjyOYGXMV/UoD1QxPyszpDKOKdfRrCU9q1o90J9f
         BB0H+H0ZAFTcvegwsdne6YjDXV5GHH0CDF8BHKLS11MavRRvPalSFFDrdvOejMnUAh
         Ix+8xXA3OFdt/KanaTwWc6tgaA5iMekv7oSzIamYiJShW+i5fpTYiGfzYs2B8iwUy3
         UKnhCxJnji0YnXe0VK6NyvYHlzU1Mvc3FCSCwhJ2MyhDnYCl6tPzjaf0odJOASt7E4
         G/rLIIJSyA28Q==
Date:   Fri, 03 Nov 2023 21:57:46 +0000
To:     stable@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Gary Guo <gary@garyguo.net>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org
Subject: backport 0b4e3b6f6b79 and 35cad617df2e
Message-ID: <1760daa6-7245-4d01-bb89-388c472ec5ed@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

I noticed that without commit 0b4e3b6f6b79 ("rust: types: make `Opaque`
be `!Unpin`") the `Opaque` type has an unsound API:
The `Opaque` type is designed to wrap C types, hence it is often used to
convert raw pointers to references in Rust. Normally `&mut` references
are unique, but for `&mut Opaque<T>` this is should not be the case,
since C also has pointers to the object. The way to disable the
uniqueness guarantee for `&mut` in Rust is to make the type `!Unpin`.
This is accomplished by the given commit above. At the time of creating
that patch however, we did not consider this unsoundness issue.

For this reason I propose to backport the commit 0b4e3b6f6b79.
The only affected version is 6.5. No earlier version is affected, since
the `Opaque` type does not exist in 6.1. Newer versions are also
unaffected, since the patch is present in 6.6.

Additionally I also propose to backport commit 35cad617df2e ("rust: make
`UnsafeCell` the outer type in `Opaque`") to 6.5, as this is a
prerequisite of 0b4e3b6f6b79.

--=20
Cheers,
Benno

