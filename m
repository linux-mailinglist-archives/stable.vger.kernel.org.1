Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A010E737327
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFTRrQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTRrP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 13:47:15 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997F71712
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 10:47:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77acb944bdfso261001339f.0
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687283234; x=1689875234;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15DPaA2yeu/H18i78SGzieR0HTDMni/2Vd4N6ujG6o0=;
        b=aTtRZPZqtgwc5I721QSaypapvp1fmtoxp46lXEwwqeV8Cx3/xu0P4O6+j4nDRwEc9/
         BD5x8UZcbcG4mrc78TEeFneGMaEbVM4XNy0+xR9fMHl7GUBysx2Z1kr35fKxtZmBc7Pk
         x6KPn89pvcNeIOVWS4UiPeetwhGwFkCuObOFPTTxBAC/G5kihLlR1X4t/ZAJRiy+JziZ
         ywBITnZhBjVbyLgCFy5eaqyFXpW/A2wLLhEAGeEHaLCi7uoLpEdDdxTrxbVUKkjK7M+1
         lu7sMrI34wK99BFtGJUUGMyfUdPjVWLkygpREtEs0pPkUamt4Y8N/CH1wMtK1oiOzCGZ
         aDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283234; x=1689875234;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15DPaA2yeu/H18i78SGzieR0HTDMni/2Vd4N6ujG6o0=;
        b=aMvJ1yIEv2IyEyW50wrAAQvY59o/guGozYPgfwKhNH/KDxGx51qyypFOH/NR8Qe79N
         nsuvTyMuDoV+6HL1wnA3zFXyfw8MKxc0nVdIWbFP6CpE6RIvJKQJc9o+YZpGDtLnqWpu
         9DPzRWuOGu7WWpiV8Xe74H3/k/T2gOZAHC5pTiD/M6lOIe+54jrbPjiOcTpnqCkDY2Zl
         fMbQC7TBa2/xBPcL1MmDqZAMO+MzGi33lyf4ou1LtNfTSvrwmXTE/xvSyXuxXK1cGdrZ
         0Ukm2QqMoShpUXZt6CDJ4W8mdTzo3pkqegdeTUMdrAYE452J7brTaxbblOirkhIPsWdG
         BZyw==
X-Gm-Message-State: AC+VfDxwfmGdmuRxaw/2+3D0yE8qixmltTRtzNi3FD38Mde7OnVRlOsI
        JHMV+Eg1HwEN1zKVmW7hav54qg==
X-Google-Smtp-Source: ACHHUZ6rjQwegQvtImo7ns7efOyigl4kEmCwH7fakP/gcU5ynvAfw/nPMtbbEjaQoTtSL3YR71n+bw==
X-Received: by 2002:a92:4b02:0:b0:33a:adaa:d6d1 with SMTP id m2-20020a924b02000000b0033aadaad6d1mr11837316ilg.15.1687283233896;
        Tue, 20 Jun 2023 10:47:13 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l18-20020a656812000000b00514256c05c2sm1561789pgt.7.2023.06.20.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:47:13 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:47:13 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 10:46:34 PDT (-0700)
Subject:     Re: [PATCH 6.3] riscv: Link with '-z norelro'
In-Reply-To: <20230620-6-3-fix-got-relro-error-lld-v1-1-f3e71ec912d1@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, sashal@kernel.org,
        Conor Dooley <conor@kernel.org>, ndesaulniers@google.com,
        nathan@kernel.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org, llvm@lists.linux.dev, lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-70da67b5-db97-4e69-9e0a-041b0b7fe80f@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 20 Jun 2023 10:44:50 PDT (-0700), nathan@kernel.org wrote:
> This patch fixes a stable only patch, so it has no direct upstream
> equivalent.
>
> After a stable only patch to explicitly handle the '.got' section to
> handle an orphan section warning from the linker, certain configurations
> error when linking with ld.lld, which enables relro by default:
>
>   ld.lld: error: section: .got is not contiguous with other relro sections
>
> This has come up with other architectures before, such as arm and arm64
> in commit 0cda9bc15dfc ("ARM: 9038/1: Link with '-z norelro'") and
> commit 3b92fa7485eb ("arm64: link with -z norelro regardless of
> CONFIG_RELOCATABLE"). Additionally, '-z norelro' is used unconditionally
> for RISC-V upstream after commit 26e7aacb83df ("riscv: Allow to
> downgrade paging mode from the command line"), which alluded to this
> issue for the same reason. Bring 6.3 in line with mainline and link with
> '-z norelro', which resolves the above link failure.
>
> Fixes: e6d1562dd4e9 ("riscv: vmlinux.lds.S: Explicitly handle '.got' section")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306192231.DJmWr6BX-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/riscv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index b05e833a022d..d46b6722710f 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -7,7 +7,7 @@
>  #
>
>  OBJCOPYFLAGS    := -O binary
> -LDFLAGS_vmlinux :=
> +LDFLAGS_vmlinux := -z norelro
>  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>  	LDFLAGS_vmlinux := --no-relax
>  	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>
> ---
> base-commit: f2427f9a3730e9a1a11b69f6b767f7f2fad87523
> change-id: 20230620-6-3-fix-got-relro-error-lld-397f3112860b
>
> Best regards,

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
