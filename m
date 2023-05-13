Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085D701965
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjEMSsC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEMSsB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 14:48:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0A40FD
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:47:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ad819ab8a9so90389201fa.0
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684003654; x=1686595654;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3xo2HPsVxKvlx9TiSYT0nmy2XipK8eYqEnmbNmlf+8=;
        b=WtIoYCDBDOGmGjLBQqDDEIkyDV6EwcM9frgGo50Ksc0fIgzO04O5Yzm5TnF+K0Vfr1
         /qN6SifJDGzk50rcWes0ero2Mejaj75rNObnTJ5oI34R4OjPFPC0tj6pUSZgY7DnVZ2m
         qKZRtdT3lXpSkpuUUay93h7FlFTFYEuQLgJhLku6VrwH2hMT9gm+3jzGUJJ5xwWKNZuv
         WIwR+L5xuU549zaX9Y47VRjSpLOpzml/SXTFpm3IGvxjEIGCmG+gFzighabkVLIWInOl
         HfERV23rwaGGcYbWYmTz9Qy46TRD/NyBNctL4/pYFIkpj3olPXv1xOT0vPQATrH+QR1B
         +q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684003654; x=1686595654;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3xo2HPsVxKvlx9TiSYT0nmy2XipK8eYqEnmbNmlf+8=;
        b=PyDSXJCjBB/YqRoDzQprQkN8RtwSjKU9tg2Zg5KLj1wHNoa5jursa2zTi39vTMRikQ
         FBrZHuJeROKjLegG0GBjuyKohF/2aghWtaCt7nnGQ7L5o/HEhHR9lFHLIf98sDUBVsJj
         CgMcjHZsuDTkdBihTcZRESQ5Hd7vZKM9dVgqehpPWTKBkPvAn2BhmgkOMeFG5GRZIRuI
         eczHgFp/fCaNn7VYLxfq2li39RrcUowcofPdifmBUcp4R3eUXfhW97c5u3j0JFcswH3X
         J2tSZr/ype5CA6yQ7D2FlnyoxUmiS7dj0HMF2HRPW2M/sEUR1d50TvIeW/wzLLsCDAP5
         bhbg==
X-Gm-Message-State: AC+VfDx9LMs8bIfCp0lKXpD6ezWZGn8VsrDrOICqm7Y9pw+8nheq4tOi
        lG2Pgyzd3fPK//asb/xfr5j+5J9Rlt1qh+appp4=
X-Google-Smtp-Source: ACHHUZ5QGe+gpH8q6AZM5NW+TvHMn3CfQCN+u6TFTq6QawVy710CdVNwAHzh77DqBHD/g/scySOt5CXvE9yQU/9MNO4=
X-Received: by 2002:a2e:7004:0:b0:2ab:365b:dc7d with SMTP id
 l4-20020a2e7004000000b002ab365bdc7dmr5368853ljc.27.1684003653507; Sat, 13 May
 2023 11:47:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 May 2023 20:46:56 +0200
Message-ID: <CA+icZUVq2eAb_hRLZjt5Uuf=Na3O5vPPHeca2oFay7ZeNQL8wA@mail.gmail.com>
Subject: [queue-6.3] Double "fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()"
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
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

while looking through 6.3-series patch-queue I noticed:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.3&id=5a5aea218d527e82c59d0164b4205a96399bda8e

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.3&id=a5085c4040ae421cc5d90bba2a1a1cecd6f800c0

Looks like the same patch:

fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
commit 254e69f284d7270e0abdc023ee53b71401c3ba0c upstream.

fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
[ Upstream commit 254e69f284d7270e0abdc023ee53b71401c3ba0c ]

Thanks.

Best regards,
-Sedat-
