Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429C57C8EEB
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 23:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjJMVVU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 17:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMVVT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 17:21:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA495
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so2168017276.1
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232077; x=1697836877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zfTA8VaZv5rdrg7/cEK2VCte/Hm7Rf1qV3PJRXDA+Io=;
        b=duxLCxEvkF/StVMibY18SFiSkJX8LtE1A0a/EgHqSSp+HW8AoMlsEwuWq5ozSlPqLI
         9DGcJDdBY0RJ/tmbEhVR87mdjdhaOfHwxkB1W22jm/pxwCl7BboKWNQIPz8ZfN5kNuLd
         2GhMZztkS4asHWgrRJ2q9hNG+NcLg/vaLtLUwHsg8zfCSdnlLsqHL1bjknDge4ROrUdv
         5Yh3NRd4HUV31j3Hrb8JsE5NS8I8cmlsUoN5YAPQSbxpbPr4TDo7dm1/OAF4O4vXkba6
         rzkcoBQ7szqZ7d9cQjK2AxnLrVkFXscWj0Wqmx0g5HzH5zetGx3oMuG86dl4zZgjBDgJ
         O8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232077; x=1697836877;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfTA8VaZv5rdrg7/cEK2VCte/Hm7Rf1qV3PJRXDA+Io=;
        b=RW6Y6Th6DKDPt2OSJUz8nctt3+MybyoeEHdgydI7+CvI5EzKrtAVHCfxGnBarqQ+OK
         +2E+vdU3te6RqyIIEojL0ZyzAzqpADeo10mfCjJlstcwllKMQTXE+0hF7rR6s6rc5NLc
         tsZbLOwY8mXwYJJtIu0GbTbwiKKDTcLFRfGnNNqyP5lTzWNoiK9fumSi2XzAvthxURe2
         NCaas2oYlFuabgrm6Thxe3yBoSFYY6JQgT4g+kbkn5RBCO75xEvpCDIYZpq2xxyZfh/b
         Ve2BlPLsvMxhQUVgITK9pij1m9grwPexPrgsgkup2xWxkXiC7X74VQv0apzSboighslE
         J5xA==
X-Gm-Message-State: AOJu0Yz67YZawZK3T/sYKRZ8vhSO1SUiIh/m2y/T1cU/ficN/qkEvJUV
        3bh3Pojsk1tmInwkdAPNbf9Re2ujeodSImGtELk1tKHbkfYY2CUXLJIVkcqKLHJ++P8LTB7OBio
        BuRAN55d0WyYp7hs4aQmmBEF3+nyac8QuiFZt2zIUEhqMhvsEJHcodABHBbQ=
X-Google-Smtp-Source: AGHT+IFKH+l7zUstS/XKjY5lNPXDHrUhAy0f7cnfIaIfizHuM1PaN+CCQ2ObBPVBXUT3cBhahf2zmMg2CQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:2cb4:ec7b:cfc0:caf7])
 (user=prohr job=sendgmr) by 2002:a25:8d8f:0:b0:d9a:6360:485b with SMTP id
 o15-20020a258d8f000000b00d9a6360485bmr39296ybl.2.1697232077348; Fri, 13 Oct
 2023 14:21:17 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:21:11 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013212114.3445624-1-prohr@google.com>
Subject: [PATCH v2 0/3] net: add sysctl accept_ra_min_lft
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
cherry-picks for 5.15.135. I have run our test suite with the changes applied and all relevant tests
passed.

I will follow up in a separate email with cherry-picks for 5.10.

v2: Add UAPI sections back in and resolve conflicts. Note that the first patch adds UAPI, and the
second patch renames it.

Thanks,
-Patrick

Patrick Rohr (3):
  net: add sysctl accept_ra_min_rtr_lft
  net: change accept_ra_min_rtr_lft to affect all RA lifetimes
  net: release reference to inet6_dev pointer

 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  3 +++
 net/ipv6/addrconf.c                    | 13 +++++++++++++
 net/ipv6/ndisc.c                       | 13 +++++++++++--
 5 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

