Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5106F3CEB
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 07:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjEBF0F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 01:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEBF0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 01:26:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA161FEE
        for <stable@vger.kernel.org>; Mon,  1 May 2023 22:26:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so7731155276.1
        for <stable@vger.kernel.org>; Mon, 01 May 2023 22:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683005161; x=1685597161;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dFUV0L1R63Jk4VAOkU6+F6CH+X9il2e6eJhacXiMldA=;
        b=G4HZ9IQd8PuXCjbUd+yjMpTapEE7W8Ia8CSnx8tc5mX7YGgjYUdu0o9X3PCwRfI+OV
         o7O85difv4wieSK5beT55P2akYcyqL00ocaKgjJcFtrFkbhVQESC4Ud2zaWZDavJFiEK
         k4A8VK0ZPt884PUvKxcT1rK0+mIEhLot706Q0G8zyCCLwmLHBtQbrYLdReCTUBANdDZg
         ek3OhIIVxMIBbSQY3f8eyKCJcss7EQdkZxLD4f5EMi6LVePX/ZkvuXHUa67IfXrpbBy9
         7YtYYyd/SqSxcYVyBnR11/Ep4RKmI6K/C6pMPcLlSv+OFfT0lcCq7Qyzfh7zoG3kh8tU
         +ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683005161; x=1685597161;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFUV0L1R63Jk4VAOkU6+F6CH+X9il2e6eJhacXiMldA=;
        b=hmyeNFjMGIEyWGu8gVo25UEJ7mj1Ya/6L8uXt2ffEmFUV1ZmNvHrFt2s6CdUhbl4W3
         CZ54GRBfb6ydYdoajkVEhtl4cP43NvY+ggfYKbqtyHPAlRrwct34jl+sqnqa4eIePLAV
         IZnqCGMUMO0uzdTQbRR0EZLSNjG+3AOjqrtjNfGEpA0hLLMGrXLpVsaqWb8gKjXrneAK
         g0zN1pi/JnbGmMKPcZ2ioX1y+q5VjOFcjesypEQDnvefGkfNKsIrOF+1SomcDFe7L1VT
         K2b9KsdCynhjlkbCADAbWWZDW2pGIo9ef9lVrqFdjvHf0bAVGG6zhNkB4gssgh8t6jk7
         LpoQ==
X-Gm-Message-State: AC+VfDyQ4N79cZXd8W3hKXqgBpRW7j6ZSXUmRbMmPdXN/8rL+LlPcrRF
        UZBylsqDG41fRuCPQ0VJ1BE9cXS6zlzbN5ONQGCHUuf0jOfEJgjL0d1I8W1gFqtvg89nXVEpZ6d
        MPZ6rDvAWfayaaRZHX6P/ADw+U78zG0Bt5buOD8YFabA+y+uSIAuVIy30ojaGJWleOhseR4eUFW
        N8DqdCPqk=
X-Google-Smtp-Source: ACHHUZ6SVQL7EbPyEWacDVDULKOrkCLwsTMgV/+DLVjqq50o6MfJ3xu+d0NUTEr18jFrKLOmrBuRBto2HzEXqiV/Ar8TdQ==
X-Received: from meenashanmugamspl.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2707])
 (user=meenashanmugam job=sendgmr) by 2002:a25:81cb:0:b0:b9d:bb4f:f48e with
 SMTP id n11-20020a2581cb000000b00b9dbb4ff48emr3170454ybm.9.1683005161189;
 Mon, 01 May 2023 22:26:01 -0700 (PDT)
Date:   Tue,  2 May 2023 05:25:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502052554.3068013-1-meenashanmugam@google.com>
Subject: [PATCH 5.10 0/1] Request to cherry-pick 026d0d27c488 to 5.10.y
From:   Meena Shanmugam <meenashanmugam@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org, tytso@mit.edu,
        okiselev@amazon.com, Meena Shanmugam <meenashanmugam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The commit 026d0d27c488 (ext4: reduce computation of overhead during
resize) reduces the time taken to resize large bigalloc
filesystems(reduces 3+ hours to milliseconds for a 64TB FS). This is a
good candidate to cherry-pick to stable releases.

Kiselev, Oleg (1):
  ext4: reduce computation of overhead during resize

 fs/ext4/resize.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

