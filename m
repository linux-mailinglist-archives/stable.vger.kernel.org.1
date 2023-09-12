Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8479D11A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 14:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjILMaO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 08:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjILM3o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 08:29:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92149199C
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 05:29:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31f915c3c42so3013547f8f.0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521777; x=1695126577; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R9IuEw4G9LWwDgWkkTsMBJnIy6GFGBJ28aUkaVyc45w=;
        b=KZYR2sNuf7yww9hvTQkc0i4vyKttxgJwvW/yBlTHlNcSE17IhQuP+NI7dJCxcbeb/Q
         +ZnabrRFo7JjvKMICjA2zjHhgFzEnLFq/KkeLnVrB9qOEVkPija6gFd+aPsox1m6K1kO
         loHBXf01s1AncvP/GOqah1ieW7XmrNR7qZnj8n5lnew3W2NmMg5MIOY4X1fpqcXRoXFX
         WXNOdnnLeTygmY/vJlbO9w3JNTqheY/fr/ySuJYpJ2GmAoti0hJPz3TCU2DRmLTpZlG/
         u8fIJQSCQXB2qZVehQz4xfq+kZdo9hASzbcpAVq0ik2uq/J10e8eWSf8V6N3dxUW5Yze
         zyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521777; x=1695126577;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9IuEw4G9LWwDgWkkTsMBJnIy6GFGBJ28aUkaVyc45w=;
        b=u3l3iT+uZOMxjXWSOPABLMDgk1t+7f5jFZkGOq5vIAfuktCa8dzFwcKsjwiE0ffI6t
         T35CwlG2TEuIqDCC2H6O27N7t/OGY44hcBngmb1El0K6v4WlVuAVF0KGB1Cepkr/24tB
         5NgTSg4RzVoyjEXMsl1brdPp7EhzyMLKL9aUfefrHzx8Fu3RkTM/X5d3yn/Yhy6DluU9
         liwPkK2dcxXCeXIlsmjUqV6E7P9lZvWCgIgsraaMMqaKu/4+QpW77lxNOK64BD3TSy84
         KnfqUCDl7RGMe9WpmH1XfSo8vEo5Rry5pLlxPPEWUBbNiYLMAsdXjM9LbU2U0+vKxi5p
         BvIQ==
X-Gm-Message-State: AOJu0YydP1CWglFGbNtQFLUi+L9M8+5WPKlny5XpAdGIMgyAPw3SS2xY
        zOr/gTbJgHJFLEd5DrrCTPm22bYuKJjUzg==
X-Google-Smtp-Source: AGHT+IEzzh91BX3W97ldgbmINVWNcJhn9/xYPrxDri1Hu+B+eA5d2IN7V8Y33pF7Dwo7/aiEVn5ytw==
X-Received: by 2002:adf:cd0b:0:b0:317:3b13:94c3 with SMTP id w11-20020adfcd0b000000b003173b1394c3mr10518864wrm.41.1694521776281;
        Tue, 12 Sep 2023 05:29:36 -0700 (PDT)
Received: from [192.168.1.7] (82-64-78-170.subs.proxad.net. [82.64.78.170])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d594c000000b0031ad5470f89sm12645807wri.18.2023.09.12.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:29:35 -0700 (PDT)
Date:   Tue, 12 Sep 2023 14:29:29 +0200
From:   Paul Grandperrin <paul.grandperrin@gmail.com>
Subject: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, Wei WANG <wei_wang@realsil.com.cn>,
        Roger Tseng <rogerable@realtek.com>,
        Ricky WU <ricky_wu@realtek.com>
Message-Id: <5DHV0S.D0F751ZF65JA1@gmail.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi kernel maintainers!

My computer doesn't boot with kernels newer than 6.1.45.

Here's what happens:
- system boots in initramfs
- detects my encrypted ZFS pool and asks for password
- mount system, pivots to it, starts real init
- before any daemon had time to start, the system hangs and the kernel 
writes on the console
"nvme 0000:04:00.0: Unable to change power state from D3cold to D0, 
device inaccessible"
- if I reboot directly without powering off (using magic sysrq or 
panic=10), even the UEFI complains about not finding any storage to 
boot from.
- after a real power off, I can boot using a kernel <= 6.1.45.

The bug has been discussed here: 
https://bugzilla.kernel.org/show_bug.cgi?id=217705

My laptop is a Dell XPS 15 9560 (Intel 7700hq).

I bisected between 6.1.45 and 6.1.46 and found this commit

commit 8ee39ec479147e29af704639f8e55fce246ed2d9
Author: Ricky WU <ricky_wu@realtek.com>
Date:   Tue Jul 25 09:10:54 2023 +0000

    misc: rtsx: judge ASPM Mode to set PETXCFG Reg

    commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.

    ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
    to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
    always set to HIGH during the initialization.

    Cc: stable@vger.kernel.org
    Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
    Link: 
https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/misc/cardreader/rts5227.c  |  2 +-
 drivers/misc/cardreader/rts5228.c  | 18 ------------------
 drivers/misc/cardreader/rts5249.c  |  3 +--
 drivers/misc/cardreader/rts5260.c  | 18 ------------------
 drivers/misc/cardreader/rts5261.c  | 18 ------------------
 drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
 6 files changed, 6 insertions(+), 58 deletions(-)

If I build 6.1.51 with this commit reverted, my laptop works again, 
confirming that this commit is to blame.

Also, blacklisting `rtsx_pci_sdmmc` and `rtsx_pci`, while preventing to 
use the sd card reading, allows to boot the system.

I can't try 6.4 or 6.5 because my system is dependent on ZFS..

Have a nice day,
Paul Grandperrin


