Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26E67F2C82
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKUMF7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 07:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKUMF6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 07:05:58 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C57137
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 04:05:53 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cc5b705769so48323335ad.0
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 04:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700568353; x=1701173153; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AGYGjqCeMYW06tp17+z4oaGGiZv+BcoAcjr1hwuzGik=;
        b=TPsNrutQO5Pijy0xnO8o+mWXeDNvlHMwlJpRVGXC3Y4nshVNuyix7OH/VN+Lc3nH0e
         hxff7YN3nOpuJVr7JmIl7brMI/DTCORs9DhAVZR1KsAa9eFvctSSG0WEnuGCZ+IIYE2k
         2p2YR/kOo5pXAHtBAv6o7l4jrPs3AxDPlnU4ovCaABvLVWzE9iBUkqXzv870fAUFs2j6
         e1pOWaTkVTsoV6Z5IcuA6+uWeOZe3u5waIMH9aCGVXurNP2ztHQPZRJCIvi+rDDvLsrh
         C4+uX+JyEQlSO+95vfGZHN1lXIbUQnlKiJyJhrpU6SXUAjGKtkdUg/H5hEfsaI3e9gfa
         vv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700568353; x=1701173153;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGYGjqCeMYW06tp17+z4oaGGiZv+BcoAcjr1hwuzGik=;
        b=XfNfiCraEMhG8kU12Li5QvvVoldFin4nmvvyaV+uxl94foHzrcyR5xndyYygFMwV0d
         ZKfYHdhtxxXKQj1zcvEuF0akbLwB9a2+VTy7pI/Ya+EIJzRlBJ+jBgC1JQeEowZk2djB
         /beb7q5s5/mdHWysWTiMlwHVftKGRg8qUYK9e31iipORTAVnhOmXV54BCWPstw2WMV8e
         DYK1lJ/Uuxj+2t8Np1Dzi5xGTBbhJ9hniq+JCLE4wUgW4559j+EXz2nUpU9tpIi6nPbe
         X8d4oe9pDwXDWVES6Ux5KRdl3XYex6Vt/Gsmc/6bCjfWNWH1RXErCxF9K+d9EJB/DRjI
         RZfQ==
X-Gm-Message-State: AOJu0Yw00mh0GrwaZJyaXq/clorC6/G5sv4hPhg6s1MFd2+SMb3/HxKp
        RJYR8L0J128kHQ1PdaFa5DmvSm9DtskD7g==
X-Google-Smtp-Source: AGHT+IHOvNKkgQj/M7fdpg6Z1fehfMzXNHyuTTOyepfvh2eCm5R1ARLP7lsik36NZx8vwhGde5zuyA==
X-Received: by 2002:a17:902:ce81:b0:1cc:474a:ddeb with SMTP id f1-20020a170902ce8100b001cc474addebmr12845014plg.47.1700568352874;
        Tue, 21 Nov 2023 04:05:52 -0800 (PST)
Received: from DESKTOP-F161D3M ([103.106.239.92])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902ac8700b001c9b8f76a89sm7804695plr.82.2023.11.21.04.05.51
        for <stable@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 21 Nov 2023 04:05:52 -0800 (PST)
Message-ID: <655c9d20.170a0220.63b65.4571@mx.google.com>
Date:   Tue, 21 Nov 2023 04:05:52 -0800 (PST)
X-Google-Original-Date: 21 Nov 2023 18:04:42 +0600
From:   Prescription <estellamcallister743ynuc@gmail.com>
X-Google-Original-From: "Prescription" <jadenrobi6874@gmail.com>
MIME-Version: 1.0
To:     stable@vger.kernel.org
Subject: Hurry Up! You are important to US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [103.106.239.92 listed in zen.spamhaus.org]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?103.106.239.92>]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [estellamcallister743ynuc[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGV5LApXaHkgeW91IG5vdCBidXlpbmcgb3VyIEV5ZXdlYXI/CkJsdWVSYXksIENsZWFy
LCBQaG90b2Nocm9taWMsIEJsdWVjaHJvbWljLCBTdW5nbGFzcyAKCmh0dHBzOi8vcHJv
bW8ucHJlc2NyaXB0Z2xhc3Nlcy5jb20vCgoKQlVZIDEgUEFJUiAtIEdFVCAyIFBBSVJT
IEZSRUUhCgpDaGVjIGl0IG5vdy4KCldpdGggb3ZlciA2NTAgZnJhbWVzIHRvIGNob29z
ZS4=

