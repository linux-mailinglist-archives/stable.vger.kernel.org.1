Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027AB79AE19
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379619AbjIKWpH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbjIKPEY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:04:24 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11498E50
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:04:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41243a67b62so31954551cf.2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694444658; x=1695049458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72EyxoHPMhyqLAN1Oi5hC6bDHujWPuBTVHMDoLceg0U=;
        b=bk3R1SFO/epukoQ75MuKjnmrswwD/5SkvLSm+8W7/B7UASGOIlBPez2a10Vw0jlyQa
         x1casyYa1t26i6lavx91hGKAyqqI3M/e2gmU2g/QF2xwRD4tqY4T86ydN+prjRSExV7V
         4V3XRDSYHmvsWLcl6406f262NOLploQcQp7qIBK3OOOe7i4ZC209UWJhNyxV39pziav6
         g3RHBB04iqqzIArys0HTp0xdmSG+seUl6uUYhoJ2tHaps/Mdn5LMSKOOZyxCO0D+66Yb
         bk4F75kOIUS/RkBacIPnzhNtT47j39yqFWXFiIHW8GE9RGtS3Upm1stc0jmRse83YGV6
         qnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444658; x=1695049458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72EyxoHPMhyqLAN1Oi5hC6bDHujWPuBTVHMDoLceg0U=;
        b=ZiyiotoId4uUEsHLFMz5mXAXtTgmx7qiPY2d08S8GJVQ7nVWMESv3UG8590w6HF9Eh
         ItlFFLBKagb7b3a+3ftBtT/h4PKYWTZ1nAJIScfmkDIkfygw34LVepzlNXtMIrjUb6WX
         VdPWTkXcx+pdng4pmIu+EeTZSxQvBF8txWMMTifUJl3GUmFSEi/TSU0Q7V3CMCmDPu6y
         ZsigDVA9IYrgN1Ord4MHz6eHIwwGhX5msG5W7hONkUOXt16j8BGH55glNzIhmh1VdJ9M
         NLUV9OVGHKRJBtTxr6GgybENIMx0N11y5RdTT4tQaRfPBYGeFNjhdpyqwa8lOYvxbXMS
         L+eQ==
X-Gm-Message-State: AOJu0YxkBc5E6q7XVo4NK+4G2wYPUNcgtu+e11g4VUu8oLSY8NJvdUKn
        1glh2Gz6Qo3Mb/SaCCgNPcq6k3aLL0LCHPKgn+dv/g==
X-Google-Smtp-Source: AGHT+IEy+PPH0r7bh0RyH/liXMUverdXDjbmX5RZMKLrtXIE9sF+UTS35KMMBa00g3J4ID/JpCvC9ESAIt2ZGXz6O90=
X-Received: by 2002:a0c:b30c:0:b0:64f:4dbe:c675 with SMTP id
 s12-20020a0cb30c000000b0064f4dbec675mr9695545qve.25.1694444657841; Mon, 11
 Sep 2023 08:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230909003715.3579761-25-sashal@kernel.org> <mhng-e2cedb63-0933-4752-bfd8-592e4e1f6e2c@palmer-ri-x1c9>
In-Reply-To: <mhng-e2cedb63-0933-4752-bfd8-592e4e1f6e2c@palmer-ri-x1c9>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 11 Sep 2023 08:03:38 -0700
Message-ID: <CABCJKucm3KjYKgjP9OT4GLe8KZ3QxpRk9GqPD5JgwMaoZumnQQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.4 25/25] riscv: Add CFI error handling
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, keescook@chromium.org,
        Conor Dooley <conor.dooley@microchip.com>, nathan@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ndesaulniers@google.com,
        peterz@infradead.org, ajones@ventanamicro.com, heiko@sntech.de,
        prabhakar.mahadev-lad.rj@bp.renesas.com, liaochang1@huawei.com,
        namcaov@gmail.com, andy.chiu@sifive.com, guoren@kernel.org,
        alexghiti@rivosinc.com, Bjorn Topel <bjorn@rivosinc.com>,
        jeeheng.sia@starfivetech.com, jszhang@kernel.org,
        greentime.hu@sifive.com, masahiroy@kernel.org,
        apatel@ventanamicro.com, mnissler@rivosinc.com,
        coelacanthushex@gmail.com, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 8, 2023 at 8:33=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
> Sami probably understands the dependencies better than I do, but I don't
> think this one is sane to just backport -- there's a whole series here,
> and IIRC we had to set up some clang bits for it to work correctly.

Agreed, it doesn't really make sense to backport this patch.

Sami
