Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF97B9DC1
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjJENzx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbjJENvP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 09:51:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898B1F75C
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 02:59:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so7433025e9.0
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696499997; x=1697104797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfdb1dM/aoOmDJrjt2RWm8chCIw3FIQo5AAZYxu0Nh8=;
        b=fnLfsAtht9SkmpKhsHgWS1oVqTyt0rU10Of0lSuL5F6e+BS1E46P9Hia8me8wV1SVw
         ByYJyDjR/EnIAp/yO9tMYSXqJQy6u16VI1vD+J1E3CbF1ad5KubWVDSIKwvzAi8+STvC
         eZnOhuJMYrM+WBqfSu5eBxMD2kwZI+Ya4oo7dJZjCr/sZmreoPVslnuN5NN5ABohhb0p
         AyRK4WK7JxwQEIS6WvmhGzbQkpMUwrl/mpn2Yoq7pMwpvPb4DjGzA8VDhgcZHIbw+3XG
         jWxk1D+6fUREdvvGiDIddoDI4uKn8DGunIwuYPxO19FD5H4r8yhwQsX2j3+pxZDnG7JY
         gNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499997; x=1697104797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfdb1dM/aoOmDJrjt2RWm8chCIw3FIQo5AAZYxu0Nh8=;
        b=hmFONV6+lJHiGGU2AwCf/xb6v06NMdmgfM49+VucICpR6/NWO0NsjlEsI1nOQZLrGz
         bdJBDrVAf+60kuFBZ9Zqkh1yC05EkV/jV7bl1wSA9xR32Tu51wHqF5bpAphXhxZnwNx2
         0xbVWB6GTKOlwfJcWPYmrOkMjQMhFkCujh0WBmhx+2nJtejDbV4YrQA4YlkQasqLr7WG
         HXAUENL2ybc5UNVYYfGKKRDf3pK0g/KutL6fYmghzeUmh4YOYQdooUj2UnWhwHTAHRSF
         Rl0Yrxu9oAIHAu266rnquBoRpGfGOCs2tl/AnykC8MOXDSoHHCI2xLXR7TIf8Lf2dI8z
         rtQQ==
X-Gm-Message-State: AOJu0Yy1OY9B2qkrq7TXv3Po+zZT/XSurenTiOan8UqfKQxhh/1IMw/H
        Ox5kgMO6YLJxE/IFJe6X6Os9riukiOI=
X-Google-Smtp-Source: AGHT+IH+FCFC61djK0BudwRxrwbf2s95j4EBj+uKQH2HxSJqPnyQcXIR479gNW9OmAfU9zdK9zxNhg==
X-Received: by 2002:a7b:c391:0:b0:405:359a:c950 with SMTP id s17-20020a7bc391000000b00405359ac950mr4540879wmj.19.1696499997296;
        Thu, 05 Oct 2023 02:59:57 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d4d4b000000b003231ca246b6sm1389897wru.95.2023.10.05.02.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 02:59:56 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.10-6.1 0/4] rbd: fix a deadlock around header_rwsem and lock_rwsem
Date:   Thu,  5 Oct 2023 11:59:31 +0200
Message-ID: <20231005095937.317188-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,

Patch 1/4 needed a trivial adjustment, the rest were taken verbatim and
included here just for convenience.

Thanks,

                Ilya


Ilya Dryomov (4):
  rbd: move rbd_dev_refresh() definition
  rbd: decouple header read-in from updating rbd_dev->header
  rbd: decouple parent info read-in from updating rbd_dev
  rbd: take header_rwsem in rbd_dev_refresh() only when updating

 drivers/block/rbd.c | 412 ++++++++++++++++++++++++--------------------
 1 file changed, 225 insertions(+), 187 deletions(-)

-- 
2.41.0

