Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3914E7CE84F
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJRT6A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJRT6A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 15:58:00 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1655112
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 12:57:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso8205003276.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697659078; x=1698263878; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I/XM1z5JZivZjrCtyiiMknZBzqnQ0wXs5QF6KiE/CLE=;
        b=O/V2UJWhKwysAOMR08k/LSHE4vZAwujVRjzSrSO+VaOqL8f4G8DM9yLWAuL1J4742c
         45TuUzLC+mpyvKbrlHOFE/bBlY2JyIzoZvGAVym8AJWScqN5A5J/OBg+yYgGtvPWHdUx
         Nv7YzNoKoSZVJA512bSDdBnuzMl+QF5H8s12tL8hZidODFdmJHrLwkG2JFQQhvPfwPI4
         1FfYv1A+rbQP9sMrzKC2N4JuJX9dE2OR2EY1QW0cd9QXLGq/LNZ7vlzzF6Bm+z1O//RC
         qTK/J5BSTAc0EGOkPRT7cy1aj1dUetZH8eFLyd9kRK6uJxD5h60mjOJuMJJAKrEGDnmO
         Jqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659078; x=1698263878;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/XM1z5JZivZjrCtyiiMknZBzqnQ0wXs5QF6KiE/CLE=;
        b=DBcqSgz3T0VgynVJHT4S4svMHmbQWg1q6HvVjz8F9YyToK0eF+KK6Dd6Py+tMowphN
         tuvg+EbnO+oXwbW+2r9rMzCOtMZLxTtIuQAIQKtMcm7swdUob3AxdLGRIdxoHof7CDWN
         D7dLTtZuRs6I5Htjoo7+syx6R+rQVclN3BB7gcolYaHEjuD0OX8A18giDDx9hpIBDB6d
         ojWred3Xc3Lea3QogwCvFCd+gLQWP7lJrQCRSBQTr6fXYJdXZXamdwoB3TgXyvYOfXRg
         czW4LpI1uuQH+E4oExuXQvtl57JmU+Q2pnoiedAUbiD6GaeO3JMaBIzTvS0ul9woZubv
         FhDQ==
X-Gm-Message-State: AOJu0YxDRP3+vF7aZRRlauoBPAI45+91PQgukwgEaCYKXHrKei2JGEWp
        NiYSfDyprgJBBy3WecDBbNTyiVjqZ3+HP8n0r1nm/kqwDHexng==
X-Google-Smtp-Source: AGHT+IFFmgbM3elbPOjcS01ubTUTSSjieu7PHMrZVqJv8gixG6ESvf/e6reoA08V7VNHaxAlMLlduakc5/QDu2Ozr2M=
X-Received: by 2002:a5b:252:0:b0:d91:fdb:afd4 with SMTP id g18-20020a5b0252000000b00d910fdbafd4mr350353ybp.16.1697659077787;
 Wed, 18 Oct 2023 12:57:57 -0700 (PDT)
MIME-Version: 1.0
From:   aftermath digital <aftermath.digital0@gmail.com>
Date:   Wed, 18 Oct 2023 20:57:47 +0100
Message-ID: <CADwTF6=b4wuC4ESVTZsAidDhxMj-A9RU6wOYShJcuhMKQFfVaw@mail.gmail.com>
Subject: vmlinux-gdb unable to parse_and_eval("hrtimer_resolution") on mainline
To:     stable@vger.kernel.org, jan.kiszka@siemens.com, kbingham@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

I've tested the below on both linux-6.5.7 and mainline linux-6.6-rc6,
both of which seem to have the same issue.

GDB 13.2 isn't able to load vmlinux-gdb.py as it throws the following:

Traceback (most recent call last):
  File "/home/user/debug_kernel/linux-6.6-rc6/vmlinux-gdb.py", line
25, in <module>
    import linux.constants
  File "/home/user/debug_kernel/linux-6.6-rc6/scripts/gdb/linux/constants.py",
line 11, in <module>
    LX_hrtimer_resolution = gdb.parse_and_eval("hrtimer_resolution")
gdb.error: 'hrtimer_resolution' has unknown type; cast it to its declared type

I've built-linux like so:

make defconfig
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
scripts/config -e CONFIG_DEBUG_INFO -e CONFIG_GDB_SCRIPTS -e
CONFIG_FRAME_POINTER
make -j$(nproc)
make scripts_gdb

$ gcc --version
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
$ gdb --version
GNU gdb (GDB) 13.2

This is my first time submitting a bug to the LK mailing list, please
let me know if this format is not correct or if you need more
information.

Thanks.
