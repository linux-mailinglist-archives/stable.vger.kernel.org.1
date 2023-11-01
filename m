Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0C7DE330
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjKAPZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjKAPZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 11:25:16 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB5128
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 08:25:08 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457e36dcab6so652251137.0
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698852307; x=1699457107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SfiHwz4JZCGCwOFzpsQX+9HxRoqlRbBYRIA8jQuHjhk=;
        b=gojnSgNJNWZTFUvUV3ymj2lJ9sKywpT1fHMDi1Yiv+t69IHzCKqfXJYC29qOcwcmeD
         KoecJrPUI6bsCIH5O2kL89TEibdWrwaEtl04bfyMI3DbH3mkzT1C7OrDlYaTKWxnD2rD
         InyDywG2YfDzFk8LUSt8eRoRXDFCCqetezMABK9hzdZzhMv7acjW6ZPypjNuvwMaaDqh
         B6pDksBCVbsfjMxP+H9E0XMRY/ypG5GPpT3mEZRn0WxLBuMHYFwRnHLFPmn1zVQ1CzXS
         7EezqHc74TIHk9sA6qSIqUK8j1OcEKSwnAgwCtXfrviN5JhdVARyNjtoXpSiez2M9ZPi
         afdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852307; x=1699457107;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfiHwz4JZCGCwOFzpsQX+9HxRoqlRbBYRIA8jQuHjhk=;
        b=IMor4DDKr84RfRu9WFUdi56rcf734Y27nyLK5AFo+8qNa1BOUcXqT7/TRFd+OAOXbb
         3uNIfzDdT96wZoDEx0qEXv1qow3ZFuVxHR9JRFepmfjICJBaKzTV4VbUqiQsd9/mDIS1
         7dX4yt44Cl+0QpnhnDcKb84DBXOyWdhXyHEyPj7FPFhZ8vb09fjHUJ95uptOQisoOzRs
         viVuqGzoQuyBXTmSXDmI9aJy2ehqKf9OhLhrzqYT2AJu/Ym1rHu0k7s1h4gkVuRybrIP
         q77iFiwte4Ao8T2+TRamzCrN6RQH9gT32mA/lJfZyumv9JKOh9EW3THLEqDdW9342DnO
         ozcA==
X-Gm-Message-State: AOJu0Yz+9u37++sOxHWbH5OiPWxUgZr39A4tIKqjG7d3Ptkd1aq4EVfJ
        74JPPVG39F41lJ35OL0c06fOczqjBV6WVl5kAV8Wrx7afvxykElDUY9YhA==
X-Google-Smtp-Source: AGHT+IGB9b+1rEPVTrYv4IJ+vUsXCoo/tQMZZ3ZEmvnr6Jqqi+qZ3cnyKNaOVAab5gWZdhD70XttrEib3NGJJP2FEY0=
X-Received: by 2002:a67:c311:0:b0:45a:a173:aafb with SMTP id
 r17-20020a67c311000000b0045aa173aafbmr3587060vsj.12.1698852307068; Wed, 01
 Nov 2023 08:25:07 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 20:54:56 +0530
Message-ID: <CA+G9fYuFUTr+riZ5bREOowR_QsspR9n_UC4pLCJQGxksU46M2Q@mail.gmail.com>
Subject: stable-rc: 5.15 - all builds failed - ld.lld: error: undefined
 symbol: kallsyms_on_each_symbol
To:     linux-stable <stable@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

I see the following build warning / errors everywhere on stable-rc 5.15 branch.

ld.lld: error: undefined symbol: kallsyms_on_each_symbol
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
make[1]: *** [Makefile:1227: vmlinux] Error 1

Links,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/

- Naresh
