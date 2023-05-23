Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA87070E4F6
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEWS4O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjEWS4K (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 14:56:10 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BAE91
        for <stable@vger.kernel.org>; Tue, 23 May 2023 11:56:06 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6238da9c235so59269006d6.3
        for <stable@vger.kernel.org>; Tue, 23 May 2023 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684868165; x=1687460165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Torc+RRBwrMl/4jmZLvvQbAFAwY2zQuLJ8o+xlyegK0=;
        b=JrayKQAx+iq3P4KuA15TeG0bbOwSpOariGIARcODSsUXAyBzU33fkgohgX6e6qfBB5
         /t4eU5Tb198lbjYnvO4kmYxyWk/TWoArF/Jl2TJdthKl9hjVBfqGiqqoQVxt05FWsyzW
         l50niMQ62caEcgvj+pyuKXy31K3l95kdx+/XisAxLS5LEyJkG5KDtm60dnhwlwO5QD2I
         u76jyWiaEfQFf36wNpMHVhmeRE4EQXiOV+oVcIVY7Wgq30C4PahFCvI6c7s2n24iF4Od
         guUMOzeJmPf36AFn7ydYRY+0/wBthIWsZhfFHmhW7UOfsaheu/PzBVx9t+F9+tUhR5R7
         vN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684868165; x=1687460165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Torc+RRBwrMl/4jmZLvvQbAFAwY2zQuLJ8o+xlyegK0=;
        b=KUCEmh7rtG5yXsWnWG4Wkrpz2ORjLxwOn86p2zYt/RX97OWWEO4USPJ6VJdv88JoLQ
         9yZFxKLPFOu9BG9vWYvT/3dLtAV9S7/nOi5Gp7ePhUKUfKgwxfcpcxZVc+enwedyIovc
         ye5DrOaV+VB+kUxbCIUtghLSO19mz4RzpFO3+HI1oCE7tB8sS9spHrryaSS52ErVJVOT
         Wa0ONjdBIVwT49JHI5wY1RE8BnnJowAriaErGzJBfE8tFwhYR7oMyaZidYbgv9owgS74
         AOqSht8lJTVKBo370OT0OQSjoKyxLA+tAn00fnGHXRoAL+V1eHrJbBj6Kdb9BCkx/Pdt
         miiw==
X-Gm-Message-State: AC+VfDzbj+FWROuSHRF5hFbD/E+P4KCOMZHy01LkdGleuR3bEaOkexqJ
        vI2IoWbmvR/JzN9g+1x/JdBwWrdDgHDQHx9moT5pUw==
X-Google-Smtp-Source: ACHHUZ4FgHH+PZualQxKJX5p0MwAh/JwSqTCFPxfJIDo5xYTpik7c1LA2wKLgB+VLN4ieuO3ZyTppIOXrmot6W+ZGr0=
X-Received: by 2002:a05:6214:c2e:b0:621:8ca6:2ac8 with SMTP id
 a14-20020a0562140c2e00b006218ca62ac8mr23562201qvd.16.1684868165161; Tue, 23
 May 2023 11:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <202305210504.yw7qgOom-lkp@intel.com> <MW4PR84MB19703614A2DB230AD0BAF63CA8409@MW4PR84MB1970.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB19703614A2DB230AD0BAF63CA8409@MW4PR84MB1970.NAMPRD84.PROD.OUTLOOK.COM>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 May 2023 11:55:54 -0700
Message-ID: <CAKwvOdnjXD4K6284znWQ7FdshZFYdqNUTN4U79h1pA+xPJ6vCA@mail.gmail.com>
Subject: Re: [linux-stable-rc:queue/5.15 105/106] drivers/platform/x86/hp/hp-wmi.c:342:24:
 warning: cast to smaller integer type 'enum hp_wmi_radio' from 'void *'
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 11:31=E2=80=AFAM Lopez, Jorge A (Security)
<jorge.lopez2@hp.com> wrote:
>
> I investigate the compile failure and appears the latest patch reverted t=
he code to an older version.
> The latest code shows the proper implementation and compiling the code do=
es not report any failures.
>
>             enum hp_wmi_radio r =3D (long)data;
>
> instead of
>
>                enum hp_wmi_radio r =3D (enum hp_wmi_radio) data;

Looks like
commit ce95010ef62d ("platform/x86: hp-wmi: Fix cast to smaller
integer type warning")

is the fixup necessary for 5.15.y.

Dear stable kernel maintainers, please consider cherry-picking the
above commit to linux-5.15.y to avoid the new compiler diagnostic
introduced by
commit 6e9b8992b122 ("platform/x86: Move existing HP drivers to a new
hp subdir")

Hans, thanks for the fix.  You may need to additionally add Fixes tag
to such commits to help out automation for stable. (or perhaps
ce95010ef62d failed to apply to linux-5.15.y? I think an email gets
sent when that's the case).


>
>
>
> Regards,
>
> Jorge Lopez
>
>
> Regards,
>
> Jorge Lopez
> HP Inc
>
> "Once you stop learning, you start dying"
> Albert Einstein
>
> From: kernel test robot <lkp@intel.com>
> Sent: Saturday, May 20, 2023 4:30 PM
> To: Lopez, Jorge A (Security) <jorge.lopez2@hp.com>
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; Sasha Levin <sas=
hal@kernel.org>; Hans de Goede <hdegoede@redhat.com>
> Subject: [linux-stable-rc:queue/5.15 105/106] drivers/platform/x86/hp/hp-=
wmi.c:342:24: warning: cast to smaller integer type 'enum hp_wmi_radio' fro=
m 'void *'
>
> CAUTION: External Email
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git queue/5.15
> head: 632aeb02f8e831197a9a01b1e93cb00b4363be05
> commit: 8d6ed410e942fa6f60e434729e1cbbc9ce0ccd54 [105/106] platform/x86: =
Move existing HP drivers to a new hp subdir
> config: x86_64-randconfig-x052
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c=
006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=3D1 build):
> wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.c=
ross -O ~/bin/make.cross
> chmod +x ~/bin/make.cross
> # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/commit/?id=3D8d6ed410e942fa6f60e434729e1cbbc9ce0ccd54
> git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kerne=
l/git/stable/linux-stable-rc.git
> git fetch --no-tags linux-stable-rc queue/5.15
> git checkout 8d6ed410e942fa6f60e434729e1cbbc9ce0ccd54
> # save the config file
> mkdir build_dir && cp config build_dir/.config
> COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D1 O=3D=
build_dir ARCH=3Dx86_64 olddefconfig
> COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D1 O=3D=
build_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/platform/x86/hp/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <mailto:lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305210504.yw7qgOom-lkp=
@intel.com
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/platform/x86/hp/hp-wmi.c:342:24: warning: cast to smaller inte=
ger type 'enum hp_wmi_radio' from 'void *' [-Wvoid-pointer-to-enum-cast]
> enum hp_wmi_radio r =3D (enum hp_wmi_radio) data;
> ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
>
> vim +342 drivers/platform/x86/hp/hp-wmi.c
>
> f82bdd0d77b6bf drivers/platform/x86/hp-wmi.c Kyle Evans 2014-06-09 339
> 19d337dff95cbf drivers/platform/x86/hp-wmi.c Johannes Berg 2009-06-02 340=
 static int hp_wmi_set_block(void *data, bool blocked)
> 62ec30d45ecbb8 drivers/misc/hp-wmi.c Matthew Garrett 2008-07-25 341 {
> e5fbba85a7acc2 drivers/platform/x86/hp-wmi.c Alan Jenkins 2009-07-21 @342=
 enum hp_wmi_radio r =3D (enum hp_wmi_radio) data;
> e5fbba85a7acc2 drivers/platform/x86/hp-wmi.c Alan Jenkins 2009-07-21 343 =
int query =3D BIT(r + 8) | ((!blocked) << r);
> 6d96e00cef3503 drivers/platform/x86/hp-wmi.c Thomas Renninger 2010-05-21 =
344 int ret;
> 62ec30d45ecbb8 drivers/misc/hp-wmi.c Matthew Garrett 2008-07-25 345
> d8193cff33906e drivers/platform/x86/hp-wmi.c Darren Hart (VMware 2017-04-=
19 346) ret =3D hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_WRITE,
> c3021ea1beeeb1 drivers/platform/x86/hp-wmi.c Anssi Hannula 2011-02-20 347=
 &query, sizeof(query), 0);
> 527376c89caf59 drivers/platform/x86/hp-wmi.c Darren Hart (VMware 2017-04-=
19 348)
> 527376c89caf59 drivers/platform/x86/hp-wmi.c Darren Hart (VMware 2017-04-=
19 349) return ret <=3D 0 ? ret : -EINVAL;
> 62ec30d45ecbb8 drivers/misc/hp-wmi.c Matthew Garrett 2008-07-25 350 }
> 62ec30d45ecbb8 drivers/misc/hp-wmi.c Matthew Garrett 2008-07-25 351
>
> :::::: The code at line 342 was first introduced by commit
> :::::: e5fbba85a7acc2626d4fe14501816811d702f3e9 hp-wmi: improve rfkill su=
pport
>
> :::::: TO: Alan Jenkins <mailto:alan-jenkins@tuffmail.co.uk>
> :::::: CC: Len Brown <mailto:len.brown@intel.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>


--=20
Thanks,
~Nick Desaulniers
