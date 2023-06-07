Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500957270F9
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjFGVzk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjFGVz0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:55:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067692D56
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:54:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3063433fa66so6604305f8f.3
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686174889; x=1688766889;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PEmZ3yopNstxOEpb/yexKbECJPoRAyNNsfhCpCOxTak=;
        b=CW+JOB7oFtE2NDmnvJlHlNgZUjMqexpQJ/De5PHGPoriqHSranVX2dRXozsTetGZ8O
         OrxKCUECv/4IdCjALfWg/tcfod8JcUTtSPjQsLVxg64ImfMmCqnls6D3kyoOH9H4q3je
         tHRhZ5RloaPH+y48Aq3ybLP7u+tLB3r6a3yXnUi1k6CF20VZyBDI0HQSmDaGkj2eiBLU
         0FmipWCHnbOl6OT+HcEO1z6+RfYMRIUJfICHok77NbsJ2G3d/C2sFoehW98cRbomZzdP
         Bcp1a08pAtPpRLYkqKeVUZWx1dLH/GC7TVJXYdg/o2jKG1NexyIUcAv/iCRpaVor17Sr
         kGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174889; x=1688766889;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEmZ3yopNstxOEpb/yexKbECJPoRAyNNsfhCpCOxTak=;
        b=ZCzovuzDTsEqcT67tJ7RlY0hQEEqC+cVQB0nz4TSxtqqAq+SBUjZlKGqb7qdCbpvZO
         0JRIkjDSIkd/+9jlSy6T50v78dFlhWwwASuAooWY5x1UcvFZF3IJBKkEEoID3s7QpL36
         p8HqOl0gJVweKSc+8NNuIHNPpdCwXVqr+IV5LQG0NqXaFH88HUxyKReyYZJjl9uASHfz
         xNdzCZgrmqWbdv85AnAnzSijGQRZaz40Xs0eJO+VX/oIJmbLjQRx6iY7S6Staj7gXJUN
         VNvYd+5yGIIWKKvyHTRKtRlBK/mya7o3Ys6E5TPXXec5q6QDY88dz1RVojVB0n/5PByL
         sW4g==
X-Gm-Message-State: AC+VfDzkEwaF4+zi45h+wL0aQ3x6wWyJJZprsODxRkoqLXJQAg8ODA2r
        0u9Rjc+Sy3N5uj53nbs0rRVw4kji68xqvCDaEhI+tiDfPPoa7zCUez1qFg==
X-Google-Smtp-Source: ACHHUZ6u/1NC3Pbg8rDVZQn7hjGjYMeeU1kppCnC6tFqov2LzAOL9Tfe0eKA2FSzyVo8DbgSNVWF99sTFZWATIi/t40=
X-Received: by 2002:adf:f289:0:b0:2f6:c5bd:ba13 with SMTP id
 k9-20020adff289000000b002f6c5bdba13mr5343607wro.42.1686174889242; Wed, 07 Jun
 2023 14:54:49 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 7 Jun 2023 14:54:38 -0700
Message-ID: <CA+PiJmQRvJSARPejSHuQY2J_f4ZxMqH6Zps9YZNJbvwtgUDjQg@mail.gmail.com>
Subject: f2fs: fix iostat lock protection
To:     stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.2 required=5.0 tests=BAYES_05,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

144f1cd40bf91fb3 ("f2fs: fix iostat lock protection")

Fixes a deadlock present since 4.14
