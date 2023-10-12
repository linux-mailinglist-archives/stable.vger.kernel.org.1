Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EEC7C7AA5
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 01:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjJLXzd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 19:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJLXzc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 19:55:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C45B8
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:55:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7aa816c5bso24007567b3.1
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697154930; x=1697759730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHOckdJcbsRx9cFCLQvaLahHXANogjls7QekWFi4m2Y=;
        b=d+1JgdDHXEH0pgmefzAOrxsKzHN9laJ2QYrCbme7CsS0OINnPwGRymJ105HILJ2EN/
         KRzz3fvyiuu/LXh6+KIYd63E4Qcz/cLJKeitVTVoiewedYquVSLzt0C45F8tZE8JfZKC
         Kn4ax9rvqMz01kxRMvoIkRhqiNMTZ1GrLIx7N16ipC80ytZ1/9U7k7rrMa9jJzfce3a4
         3gjkHjYd4S0GFUkVRUwBl7wDJk1lwBO50dGseymvaYLurYAs1pQpU4/Rfwg9zuQThsfb
         r8PiK6eb1m6JKoYdtPF7+HsBSNvwvus0Wh3a6WA51k8vGBzOc/ZGcx4nnTgCRA4Th/CK
         MlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154930; x=1697759730;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHOckdJcbsRx9cFCLQvaLahHXANogjls7QekWFi4m2Y=;
        b=NVMswiEtgwxPriOjMSaiNg7iybXKy9ZCQ67c6YdhnekwF5zMEQg2kjZDhBiI1x654r
         0eq2R498t7yaUPMNFnx9YwpFS8edecWvZZ/1wvuQwPKIlFDyBX5n2b/ICTBYG/I5yJlZ
         lkUQrVmQ11PxQDjSwNif2gsP3RdcwCV45FC2eaAo1HjP/y9P3hmohfoCj/WlOd/kEld7
         F4C9UCmLl9jkQsJmQLKJ9MTaIAjO5rDASEk6XvmfzXdB4FNTxu2nlMwPZzG9k9lk17Em
         0BA9fuGq6w/4t871HN9GBdD0deP4vfeD8hI7lstlmwx95UFkCAKlZ6QrON+3tEtY7ALk
         c9Yg==
X-Gm-Message-State: AOJu0Yy2V3FvTHjvXxqfl9WaMTeK529rszHRQ6Iw/TvxKdi+Uu/zT0z1
        wO0E1pdbAjaP5fAelx4NX2DX5gWp3QPUDpbFezpfNW4ZWQbLfN3KDdQMJxE2npEksPHl9fw0PEh
        CSZwKlwyz2UqAdL63Py3ypP4KNvwirFgoSD1J/4lULnMuURX/r5/jSGQrIcA=
X-Google-Smtp-Source: AGHT+IF44rtdfiLAFPhte04w5xCZn6xzOt6F0HHRozvplciVyKcQPmzvGNkVxXtYEUqOzrF5ULSoL3ZgGg==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:b3aa:6851:9f24:c50a])
 (user=prohr job=sendgmr) by 2002:a81:bd0d:0:b0:595:5cf0:a9b0 with SMTP id
 b13-20020a81bd0d000000b005955cf0a9b0mr502281ywi.9.1697154930393; Thu, 12 Oct
 2023 16:55:30 -0700 (PDT)
Date:   Thu, 12 Oct 2023 16:55:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231012235524.2741092-1-prohr@google.com>
Subject: [PATCH 0/3] net: add sysctl accept_ra_min_lft
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg & Sasha,

I am following up on https://lore.kernel.org/stable/20230925211034.905320-1-prohr@google.com/ with
cherry-picks for 5.15.135 and 5.10.198. Note that they also cleanly apply to 5.4.258, 4.19.296, and
4.14.327. I have run our test suite against all of these branches with the changes applied -- all
passed.

I have skipped the UAPI portions in the first two patches as these are not actually necessary to get
the sysctls working. The rest of the patches applied cleanly.

Thanks!
-Patrick

Patrick Rohr (3):
  net: add sysctl accept_ra_min_rtr_lft
  net: change accept_ra_min_rtr_lft to affect all RA lifetimes
  net: release reference to inet6_dev pointer

 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 net/ipv6/addrconf.c                    | 12 ++++++++++++
 net/ipv6/ndisc.c                       | 13 +++++++++++--
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

