Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AA8768626
	for <lists+stable@lfdr.de>; Sun, 30 Jul 2023 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjG3PMD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 30 Jul 2023 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjG3PMC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 30 Jul 2023 11:12:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2421713
        for <stable@vger.kernel.org>; Sun, 30 Jul 2023 08:11:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9b6c57c94so9710971fa.0
        for <stable@vger.kernel.org>; Sun, 30 Jul 2023 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690729917; x=1691334717;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUpbHkVyKL4HsUhsvSG/1TM5KhJXa2rh1uwR0oUZw80=;
        b=phgTmwGqsTYC1GmPY3u5qHO84SEGM61W8PIpLs6NKnPEu3V1n6A8WcfwptMjT5sRCB
         LyYHBMnNoLlukd/wUtrG0mXQzsBTA4Fm/PLh0zn7O2OjWU0ZFKEjOjqNBYn7Nr0VGUiE
         Tns1+uxolfwbkSwGQNz979wwmH8bCEDHgLVZRhDWKyuJGNRhlxy9wPKPXfnkf+KKOCP7
         OCyESrMSwqPF1qXkN2WxUx+lIX57pVXmQYCp0B+O7v1rfQIuIydkGSzgG5Aps9QRZDwT
         0ICTiLyPLxDqbUeN4/DwPxli0opfZvu+zAwOVWxRXsgfSfalwekUWlFLzsKnEBkRZh8q
         MbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690729917; x=1691334717;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUpbHkVyKL4HsUhsvSG/1TM5KhJXa2rh1uwR0oUZw80=;
        b=Bxe2BdMPXNYM+ERvpUHXlAyhzPWDXbsXqCLUks/ZLjkyevbxrV5TVKJxk9yUbZfokT
         8nTCwgyoM4KQz/1Ct3p0E60Qf7SA4jrVMN74eNsR9wN6/l9Gp4CnI3vpE9abqvbOSCH0
         mqvJHWEUx3/mM5zrNhtVO6crTfsPH9o63K4gClI5V7OspRkH2z/1flHVyco6s+5Rel0k
         Qg86MoLNDiqjUXAj3VW5kNZKnuVdwtbrjqC7+QI7lKYX+4I5rnmRBYodkAbUpol52hUn
         O0cnBUcoMV5Y28VKgqWuHeqMkMEbjPhyNQxA/7iV18RHFhjXxMHBkhSU5f7UgpLIZ4dg
         8qzA==
X-Gm-Message-State: ABy/qLbwLA35R2+nHK0YkPv7yyjPjAg5bOQFEpoLwg+N2RlhjvpWH26+
        gFNQObojxw2E8iVpquEgijvRT0zPDwy8Zw==
X-Google-Smtp-Source: APBJJlGXP1IKHBT+3+CMs2OXt1jwXiLskpch5uLhfAMYlHl6ITwVRPq95W+vANNTA+22wcwNQ+5Viw==
X-Received: by 2002:a2e:bc13:0:b0:2b6:af68:6803 with SMTP id b19-20020a2ebc13000000b002b6af686803mr2629669ljf.4.1690729916951;
        Sun, 30 Jul 2023 08:11:56 -0700 (PDT)
Received: from ?IPV6:2001:470:28:187::46f? ([2001:470:28:187::46f])
        by smtp.gmail.com with ESMTPSA id u7-20020a2ea167000000b002b93cb80acbsm2109421ljl.91.2023.07.30.08.11.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 08:11:56 -0700 (PDT)
Message-ID: <21bae5f7-b765-9b74-c788-2cda42879181@gmail.com>
Date:   Sun, 30 Jul 2023 18:11:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
Subject: Asus Laptop wont resume by timer (timerfd_settime)
To:     stable@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

I'm using Asus Vivobook Laptop. Which fails to resume by timer set by timerfd_settime function call. It simply ignores the timer and keeps sleeping until I press any key. When key pressed notebook wakes up and treating key resume event as timer event.

I tested this using systemd and its HibernateDelaySec option, which allows to wake system during the sleep by timer to switch to hibernate state replacing suspend mode. During suspend notebook simply do nothing when timer hits, and when I press any key it wakes, and went to hibernate (treating key pressing wake event as timer event). Systemd has checks which should prevent hibernating if system wakes by key press, but those checks does not fails. I tested the same suspend / hibernate software on desktop - everything working fine.

This systemd code responsible for suspend / timer / hibernate logic:

tfd = timerfd_create(CLOCK_BOOTTIME_ALARM, TFD_NONBLOCK|TFD_CLOEXEC);
timerfd_settime(tfd, 0, &ts, NULL)
execute(sleep_config, SLEEP_HYBRID_SLEEP, NULL)
fd_wait_for_event(tfd, POLLIN, 0)
woken_by_timer = FLAGS_SET(r, POLLIN)
check_wakeup_type()

Basically it is POSIX calls responsible for setting timer alarms set and reading timer status.

I've tested on recent debian kernel Linux 6.1.0-10-amd64 and stable release from kernel.org  Linux 6.4.7 - same behavior.

It most likely hardware/EFI or kernel issue.

Full logs:

https://linux-hardware.org/?probe=d1a4b2769a


https://bugzilla.kernel.org/show_bug.cgi?id=217728


-- AK

