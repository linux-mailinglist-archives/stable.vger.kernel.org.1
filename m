Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F7E735C2D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjFSQ17 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFSQ17 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 12:27:59 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12AE5C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 09:27:58 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56080bf991aso357733eaf.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687192077; x=1689784077;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pbkRGoAwD+xTGIzNbiOUsFZY/U8ts8/bIf1TwfvPb/4=;
        b=kqfsMoLQPU0o2q2I4c8khTwCVTtfWeCEPFW/bk4bovj/W5doURSHNYs2PcaaxuXRVB
         gJ9+Oy1of+xlYCVUDhMwuq1NsknytW+Z9TVoO2Sr7un7O0s4FOu21EztRt9UJr55rCJv
         n4RDkXWadEundp83sHZOL6LrgZuCxAkV7RVCfDsajGkR18+IbXxd3mmmW1GFrLSzceX1
         T+mccN0J0OqfUL6N1a2BxJZ9OWfOnu+dElOKxyHh1ykl51VIEAIQq6Cjnf0O+Ed8Xsn4
         zbUo4OM05x7z0uHVw90RdPtSlButOh1dIfFZR6zC2bBifXcvd/se2YtM58NeOEdEwtdn
         K05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687192077; x=1689784077;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbkRGoAwD+xTGIzNbiOUsFZY/U8ts8/bIf1TwfvPb/4=;
        b=U6I7SEee0da7vqeXe3nKC+1V9sqVyHF33rzxQj6C3ZyN70TgXTBvHNMlL3QUyAWC5j
         wMB8wFnSg3UanQOVkEf6RnaQObEAPQHoTS1EWQ7JUcwkCfEwCscsaVz0mXanCUNIpYoD
         Qvjjmfj/a9MHljyBry/O7ucuUzlNuVVZcIXJ7mMp3I3SQoqJsPfNhtkcSw6O8+iLBID1
         6+MpAYHSZB5665dNFH1JeJfytDIxdsz2Rt1mpjI6PUuSwuk8qVawU9vw2Zs+Zn4HvH0r
         CKfGYzcP2Fj3OmMkN2nT3LJLZ7rEq7Ei3RpOoWYcuophP3GwGHk9nW0csy8IXjNJ16+J
         d2Hw==
X-Gm-Message-State: AC+VfDzn4PDUxcNIggXBjccf2JYi4YT/yD1BViUZVmoKKZ036o3U8+Jt
        dJ3q7/MACYH7LatMHE1WpYlwqRR4S6U0lmMhOnHEYQzjRkPGNg==
X-Google-Smtp-Source: ACHHUZ5I7PK9iXI04XDScG+vKQ2iHAf8lFbROqtfaSJvc4znZfGShMZ2mk0CWfJWIMatsXOR/h+aVOVP/vH4iUXtyvY=
X-Received: by 2002:a4a:ea8f:0:b0:55e:16f4:e2e5 with SMTP id
 r15-20020a4aea8f000000b0055e16f4e2e5mr5888148ooh.9.1687192077328; Mon, 19 Jun
 2023 09:27:57 -0700 (PDT)
MIME-Version: 1.0
From:   Javier Honduvilla Coto <javierhonduco@gmail.com>
Date:   Mon, 19 Jun 2023 17:27:46 +0100
Message-ID: <CA+6vxF33CQucQZYwNjs4z_-dckj+Ys_xUyFvFfYrFrFgbAAqpA@mail.gmail.com>
Subject: [backport request] "mm: Fix copy_from_user_nofault()." d319f344561de23e810515d109c7278919bff7b0
To:     stable@vger.kernel.org
Cc:     ast@kernel.org, "dev@der-flo.net" <dev@der-flo.net>,
        hsinweih@uci.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

This patch fixes a deadlock that can render a system frozen when
reading user memory from BPF.
Ideally, it should be applied to any supported revision equal to or
greater than 5.19.

patch subject: mm: Fix copy_from_user_nofault().
git revision: d319f344561de23e810515d109c7278919bff7b0

Thanks,

-- 
Fco. Javier Honduvilla Coto
