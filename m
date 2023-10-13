Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829FE7C8F84
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMVoh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjJMVoh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:44:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1FB7
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a39444700so3210128276.0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697233475; x=1697838275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rsl4cFpU0bdpX03Owq52aH2UY/KdGY+A56uShGG6r10=;
        b=OggqfEcFc/Wulf1AsljXJBT0HpM3+Vx7wkXGaQ5iEDyG9mF5GHJxC7NXsKYnXozWk2
         gvoanphe0OcmZfIE/sgRFI/+TJNHyicM/WnKX/X9lNY7kQvV1BtSS0ZXdOmtgTPqFO8R
         01xiptDMCphfoJjZdtIjvhv8KFAQnuKW7vKelXWh2j0TPguqLNhAgL8ozyWehgn+Ojy5
         99gTj2gY2yV0Jq4ffhiK0yyEuPA+M07ja3gUU4DPyJzeNITItHDZ9cTy2HvprnpxXTs/
         a/4fpAbBR6fPQKM+8e4Fy5PTWFkpcsNs6/G5MCFjAP4/2LziC9N/IDmpiMKyXXaaAzvT
         Vv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233475; x=1697838275;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rsl4cFpU0bdpX03Owq52aH2UY/KdGY+A56uShGG6r10=;
        b=CKp7pqFJmchHPZerfKavf6IhPQ/2N0SBuBAsT35joeBrK+/9mWVS80u5K9EuorJGkk
         I3kS6J/ZKFW78Wf4v0YvRFC+ZvojeCtdpAQvdmSPJUlpwR1bAyyIwWdPXELGe56ngK2D
         rovW1oqAjhpe1vzF4m3+rFyO3PgSB22xRJT+sJzufWDcUAghViGgnL0mSQEmqz3RIQ/e
         0ttoNGWSeOSJ0t+WXPkJ9VqNkKzxqhfXiAJXe3A36DDJ/QAfJIF3qRFoTIF3cwCeQoMS
         k4awyIxU800fk80OPA4l04+7mdWFlC9HQTIdF8kdy4jHfZIFqpUIERl2c+BUGNgUXHOP
         YIcw==
X-Gm-Message-State: AOJu0YwIxzWp8OtkoUHTdR4gH7cakH3veSzPN8Rjv/Gu6/0EbKBIx8OE
        ElZCFzZ++Uzb7oG0Nx+cqWqiNy8EYBbvjlOt+9OSe1jG1/64LsAop5/E75PtqHioYB67tWF0Bbf
        OmujG/XyhoxmTHjlTgDq0qDhVm3YuFGsFMXSY3ZKTgfRXbxOwHqReqPwAxSE=
X-Google-Smtp-Source: AGHT+IHSRSbOApUiNBgAlYi3sUPGq6599tuAicOxAdwfXeOWNtnVI3NxGtYUV5SK0fLgmcYGln6p8nKxLQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a25:ab83:0:b0:d9a:b81b:fd66 with SMTP id
 v3-20020a25ab83000000b00d9ab81bfd66mr35346ybi.2.1697233474960; Fri, 13 Oct
 2023 14:44:34 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:44:11 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013214414.3482322-1-prohr@google.com>
Subject: [PATCH 5.10 0/3] net: add sysctl accept_ra_min_lft
From:   Patrick Rohr <prohr@google.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I am following up on https://lore.kernel.org/stable/20230925211034.905320-1-prohr@google.com/ with
cherry-picks for 5.10.198. I have run our test suite with the changes applied and all relevant tests
passed.

Thanks,
-Patrick

Patrick Rohr (3):
  net: add sysctl accept_ra_min_rtr_lft
  net: change accept_ra_min_rtr_lft to affect all RA lifetimes
  net: release reference to inet6_dev pointer

 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  7 +++++++
 net/ipv6/addrconf.c                    | 13 +++++++++++++
 net/ipv6/ndisc.c                       | 13 +++++++++++--
 5 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

