Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3939C77C681
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 05:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjHODxY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 23:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjHODvp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 23:51:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1A3A85
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 20:44:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso74648101fa.2
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692071070; x=1692675870;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExxWNL+LW7XzrZodND+dO5D7ugPfOldXXe3KWEY0aF4=;
        b=o8nbAqgu+tsuUEkjXoywwQsPd0GJ1xEiMjiU8UdSiJp+SnOFGmeUysJLF62JkaF8yT
         rcvpXKvkKpovOASx/WZNdMsZ7rRdpv5jB1bTcGnJZTcOMLdWwRILHFuxUdC/zWaTotjk
         1HnA/6HTMhtLtdYzsHHVBJJPpQ6FuN7xw7PwO4yyduqwu1hB1S+1B+I2IPxXGPn7i+rX
         nlZXr+8bPymcp8tfXw/ii8M/0b4oT3NQDYzI4tuB4r94aW+bYp2G3e5Abrz7VMz1rhf5
         1b7X5KgqTGdyhwk+xkvukslZ0m7kZc8NyHMWbOHcwx+5AdGSagnl4bRE/8OyDQnXd2O6
         rV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692071070; x=1692675870;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExxWNL+LW7XzrZodND+dO5D7ugPfOldXXe3KWEY0aF4=;
        b=VgzE6d90zdfJGP07kuNz64UGtbaEwKSTPEjWriGrRI1JmtdoZwL3ai46JiYkdnTpcJ
         KyTaJhP5zPv58hiZuknTu5Y13fuSzGU+in7z+9/gaR6t/Xq8RmSv8NClv27R+ca0zQmM
         4K+1YkH1bodbN9vS7ahVgrX/XTsiqFd1PYdgBbC4QCXkyeGslhKoa+jLVHKvUDZ49Jqp
         JD3IM1usSDFINsAZjuifpP4QE7xmtOurzEVuBGllu0WaeZS7+F9eW4m7nPdOU3mrfUos
         ggYYp6kBV5q3+UsSBJ4prt5VctNaV8G0S1dtQ7DWIjcr1gOv1XOBTuwRDn4pGiAk+TuS
         9aJw==
X-Gm-Message-State: AOJu0YwqHnFAozFKNohP0vfip1n7vqgBx516dyROt4EpJTMsmRXgzru7
        UOsi3DEcd7G/ppKWmcdGmv3RjrTsnWov4fNCd3rBE9iSbJMs4A==
X-Google-Smtp-Source: AGHT+IFgAyh9D6DMTdhSO6edBWp8xyryII/Mu1ztl6UbMz9eaIR9w9sl15mXEUaXtIVLI7GPSUxj5rJuMoWUUY99riw=
X-Received: by 2002:a2e:2c09:0:b0:2b9:c046:8617 with SMTP id
 s9-20020a2e2c09000000b002b9c0468617mr7719912ljs.5.1692071069534; Mon, 14 Aug
 2023 20:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+prNOpqd2Tk1tiBAa9MT6ZPxB5gj9ftxOhaZ-u1WEay9H-oHQ@mail.gmail.com>
In-Reply-To: <CA+prNOpqd2Tk1tiBAa9MT6ZPxB5gj9ftxOhaZ-u1WEay9H-oHQ@mail.gmail.com>
From:   Xuancong Wang <xuancong84@gmail.com>
Date:   Tue, 15 Aug 2023 11:44:19 +0800
Message-ID: <CA+prNOot8qCAws94CuFL7LqDRYk8jbHb=EWFuSQ9yDzJSy0VFw@mail.gmail.com>
Subject: A small bug in file access control that all have neglected
To:     security@kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear all,

I found in all versions of Linux (at least for kernel version 4/5/6),
the following bug exists:
When a user is granted full access to a file of which he is not the
owner, he can read/write/delete the file, but cannot "change only its
last modification date". In particular, `touch -m` fails and Python's
`os.utime()` also fails with "Operation not permitted", but `touch`
without -m works.

This applies to both FACL extended permission as well as basic Linux
file permission.

Thank you for fixing this in the future!

Cheers,
Xuancong
