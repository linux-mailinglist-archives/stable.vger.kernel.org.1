Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD84670BF7B
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjEVNRf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 09:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjEVNRe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 09:17:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E805AB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 06:17:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3f608074b50so4246245e9.0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684761451; x=1687353451;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rHmV2hTAY2gC1dGpeMri/B4lJrdKX0lEw/Ffb/jsP8=;
        b=AL07zTdZMgAk4CW/zhlCrSmTk8HdA2wdE9w46Hppi2EwOXH2erX5yZtb+GOgmMrHP2
         8P9hjvydgL55BMUobM+evqpRBzbPIGKuZQYtqtVKN7QFnhXJ5kIlElHMoDOtZ1jqyluH
         H5fDvhLUvR4YtRrSg8R1LramFOURF6+Xho6qvBuHxCnZYTVY8zmjqyOv25csjhE2AGBI
         jGgbhWb3dskJ45NNSTErLsbjzcU17Iq8MPiB9BuvfjYcOGJ7HY3FSOiHbR4v6WnU/yb1
         jWzUZicfGlA1MPhTeoZ3dbswFh5jkk8OzPyrRSGMsMze0ab2k+SKXQc7lcpwuahyDv4k
         RCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684761451; x=1687353451;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rHmV2hTAY2gC1dGpeMri/B4lJrdKX0lEw/Ffb/jsP8=;
        b=A6/eSe/4e6Kd1Ws8bC6zsKvw7wqEOAqmTjCYYhEei93I0kroUnD48eIstOv3FJ/DmZ
         Y8OLrEBMOznYPZE8BDngaLq/dEU0/euYW8xeqhmO5gE6XkN1PmwdPVdmYQGo5ZK2qd1x
         TPNRuaq6GXYh/Gy6yhr3jXavbv7cnUjqSJgjn/wx2R4QCaxcAQH+u2AgziP9LOylYypo
         2EhTYSSQhI+pu09k1EhUhxuB1AJmmObXA7W2A4+SQGXWQwbwokMFz2LuCT+WnUtiTc+3
         f9EPQaJyx3z4rELWKrBYzW6Oxh1106aYoe0o/Ggt3RfvFjWncqL1Z22+7FWjvoJvgnsU
         cYqA==
X-Gm-Message-State: AC+VfDwuL94wujsScvf8yZTQtYJM/p+H9QTK7SmRJRrpK6/3BG71ER+H
        F4NZTMIrACp01LvR4Fx64lr7UQRDfphaW8eirnk=
X-Google-Smtp-Source: ACHHUZ5MtxXjJaWsxc1hTKkEMXUCkALG4f5BDxEdxbecf1K6j2ComzcgHYxFk83e78RqB1bG3BF3FPLlIldINEg6uYk=
X-Received: by 2002:a5d:468f:0:b0:306:8f5b:1b49 with SMTP id
 u15-20020a5d468f000000b003068f5b1b49mr9597207wrq.47.1684761450605; Mon, 22
 May 2023 06:17:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5309:0:b0:309:4208:8cb5 with HTTP; Mon, 22 May 2023
 06:17:29 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   wormer Amos <hellomarkdon8@gmail.com>
Date:   Mon, 22 May 2023 14:17:29 +0100
Message-ID: <CADStPEetm4Z7XrUX9CTtZNAqv5gG=1b7H-1g1iRz8dbU3bYWjA@mail.gmail.com>
Subject: FROM AMOS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hellomarkdon8[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hellomarkdon8[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

How are you? please i want to know if you're ready for business investment
project in
your country because i
need a serious business partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Amos....
