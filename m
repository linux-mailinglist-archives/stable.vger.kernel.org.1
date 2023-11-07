Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234E77E372F
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjKGJIT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 04:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjKGJIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 04:08:13 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4AD57
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 01:08:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afa071d100so110228497b3.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 01:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348087; x=1699952887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0xSdaRDzh/HWjDSjU83VJSZR2dGM+ZjfBD2HxHt7ZI=;
        b=BbNkTzxZWz0YduPK4IftJRKjr2zYeAxzsyTF9qKkG3/LYecbzvK+NKMdfVqkRSQ/09
         BtCsFQPw1AnhkvHNe3CAKvMi/6CuYfVGpWwo0++py3n1CP9S6f+0Gy+YzudqTFGMVMNY
         kuyBBvWMVAZFEzw8SQOZ43E/nyyZWckG5dvLU+BGCPowDLYVeorMCu1mDqZSBHKopA3B
         6g9DYj3ZRSA021JMeMjbEyRJ8VcE7BUh7VaDYfA/QB0Oqt17RtQXQ87by/A+lxQTeM8c
         cazAVQ/vR9I2ta6AnwABeADTT5sWYaZaaoxMbJo7TqnWnM9k39Y0+vGA9AFPMK0MJ5Ic
         4Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348087; x=1699952887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0xSdaRDzh/HWjDSjU83VJSZR2dGM+ZjfBD2HxHt7ZI=;
        b=awWxTZ1E2NfK9zt+6/oj5J2Zfjyxv+X60QftuzGZObUzNOJpeCH6DP4kFEzwxFR2ok
         Yam4oVd/yUAOZ7u3Fb+o53j4OVznxcu0nMI7aWDLQwrbL2XSFnix0N8HSnpm6hM73Jj5
         VxZF8q9OR23J0G1FTkNG+UWN/JKXiksbad87nHIpEAuK7y5ai59IJ+tX5m9DXM1XakmX
         YF3ixp43qwWcklvvqSeHk8JdneHIJejJUT5dt1ePBTHRY4oiOLzDfFS70hKN02aReMYl
         9TcG0Cb3x5ykdcztrZuztEimJnb5N1xGKkCx1cw9XyZfXBv4TYsRI8zYNx45ib2QGebu
         +5Bw==
X-Gm-Message-State: AOJu0Yx8V39qLybr0yjGrF6JqlYeMVuvFYI/JRl1Uyx+iVdr+5Tn8iFJ
        iBRsJKsbILko82AYpi3FLipV+P2Tp5Blzsw=
X-Google-Smtp-Source: AGHT+IHXKXnhXPv/Q69NZBg+Vkn6rXOrn4LecOP4SXQYcWiZ72hlMV4lR6teAz3b+xL5tls4wqeSNLiqkEwHA2g=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:6907:0:b0:d9a:cbf9:1c8d with SMTP id
 e7-20020a256907000000b00d9acbf91c8dmr570322ybc.12.1699348087479; Tue, 07 Nov
 2023 01:08:07 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:05 +0000
In-Reply-To: <20231102185934.773885-6-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-6-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090805.257105-1-aliceryhl@google.com>
Subject: Re: [PATCH 05/21] binder: fix trivial typo of binder_free_buf_locked()
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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
> Fix minor misspelling of the function in the comment section.
> 
> No functional changes in this patch.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0f966cba95c7 ("binder: add flag to clear buffer on txn complete")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

It's a bit confusing that the pair of methods binder_alloc_free_buf and
binder_free_buf_locked are inconsistent in whether they user the alloc_
prefix. It might be worth it to change them to be consistent?

Either way, this change LGTM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
