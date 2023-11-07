Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF2F7E3731
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 10:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjKGJI2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 04:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjKGJIQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 04:08:16 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2556125
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 01:08:11 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c6ed6f7146so53109481fa.0
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 01:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348090; x=1699952890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExLWl0QolSWqz2kjE3GKDzaYL2afXshZrJ9QzMMJhas=;
        b=3dKIdNHbGXOllTwEl7/L3hn8z5rKYVKoCsr0t1vjngotqv7cVUCw+5ro4OlNUVggS8
         8A9F6OjV/uRZ7LLwai8Yswh3WbPMNxecVRYa71RhJe5bd0La7N3YoNxD8JOictleqyqa
         JhOdRzDI9AsGWiSZp7Px50fdg1je0yhSDZV/2jKlqi9l25BA+oXVFC9d/SJGkQR47kaX
         1N5782BoGggOV25qH99U6a7zdHnF/Ag0v34RjaGcqhLl4NG0TbDaHDT5TI17JafRu6ad
         aCYxv/PzLcVpJA9YXVZV+8hezw26A76Sh806y6BsX5LnfvZHpml2TCcgPN/9IrxIPBCf
         Tvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348090; x=1699952890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExLWl0QolSWqz2kjE3GKDzaYL2afXshZrJ9QzMMJhas=;
        b=M85SrqA27y4g6SgPtP9Ro3u06BCpyGqLP9lNRNOIUzxGF2Frp3S3AJY0hthXom7uPj
         t1T1yLt0eW6vhHf5NUCEuK9jwEZzXksAj9ufH2l2NpmpvMis2lUzy9gGXX8mIe0ZUVx+
         sgxkhfJ+V4z4utBFMVZQridFEYmB2iXMoxPnC/wygONJ8+us8F48woI8LbZbs/aA7f3C
         Baxb/UqV6m4nbVA+542aPQopYdr7Jvt8TB+l7b2mb5M6ixkpHuz3zdoJwpM3OTmJuvjI
         BTlODGgehGuL8DCA9ZMPN64ydOH1369GOD0CpkFUf95wOmccD4kxe09WReJ2DgBdAniw
         W8gw==
X-Gm-Message-State: AOJu0Yzc/zbwnf78mtXzXTKP0e5JjPzzM7EHMZA3WRIQP4/OosRIwn/I
        rUqlZxBNGDY991ca0hXMc7VKn9EAA9k3mi8=
X-Google-Smtp-Source: AGHT+IEXePoTNrrGBqRaAguAqJHnXRfz2BaO8/JFEw/7ppQAkX17kYko29BpRG8TuvhHB/gS/tF8HKO5yJdcWY0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b0c3:0:b0:2bc:d607:4d1a with SMTP id
 g3-20020a2eb0c3000000b002bcd6074d1amr358802ljl.7.1699348090222; Tue, 07 Nov
 2023 01:08:10 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:07 +0000
In-Reply-To: <20231102185934.773885-7-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-7-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090807.257402-1-aliceryhl@google.com>
Subject: Re: [PATCH 06/21] binder: fix comment on binder_alloc_new_buf()
 return value
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, stable@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> Update the comments of binder_alloc_new_buf() to reflect that the return
> value of the function is now ERR_PTR(-errno) on failure.
> 
> No functional changes in this patch.
> 
> Cc: stable@vger.kernel.org
> Fixes: 57ada2fb2250 ("binder: add log information for binder transaction failures")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
