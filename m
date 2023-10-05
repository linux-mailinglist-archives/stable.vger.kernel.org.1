Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16D7BA4F3
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbjJEQNZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbjJEQMP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:12:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160A93CA
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 08:30:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so10006985e9.3
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696519826; x=1697124626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzgCsZsqyeKIPjM783ub2AUVn8qxeLuvBiXBKUlrXfU=;
        b=eXP8G6p/nEi0xYsVM9flx/kmOMaAHuh5qsFZNuN6rjPSp2nxfKGkJMIu93BctoJmsU
         vLvlFRrtAEUVlG+4Oow9rM+Klnsw3qWIiMybYITa3aSw8wlYfI+eP1DtNvvnNhS5iZz5
         VkEzmfeSpkmGt5CR0aV4tPreWl3vp/Qu7KGuObxqPL8lX3pHO4jqQrLswbr2Bj3RZCYA
         HR5aUTTPikg2oLNAnGN9NDXfMGWrWd5OmUG6O3whYGz7VnhtJnYPzH1zpewqFw5Ao1pv
         G2VK/pkZ5YdFkJN59hkpX/Mar/oneRsIereiJPqal8Nyy0JkV4PYd+W5FlE7CxRuRnqA
         pwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696519826; x=1697124626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzgCsZsqyeKIPjM783ub2AUVn8qxeLuvBiXBKUlrXfU=;
        b=MH91gScgeuIMEdTxkcENMP5rGK0HkFe9UmMrshsBKVySnFT2ObAggSxunp2zzfGD28
         WuHPADgVpqsO31Ra+tKGdIB+yDRSq/gyPKAcAhrOZjYsKqnbWPjg1rCFgfGc8hLQe59G
         9R9anpiVSbYDK2+2+hHPZrP8AiKbBD+y7e0A/ehHi0sThrtHbTy8MODaQZBiyR5SEOv7
         aHvH54VeH5nfey0F42EaZFkSyLHq/WfHvINI5zs1tJ3V5SfN0wiCzBdHto/X4p67KSBC
         fOOTbDqDKxqPBeMetDg3flymUdFf2ehw+0j8jzyDNIbJ60/xOTR/QKAz89qD/SCKT73J
         JF2A==
X-Gm-Message-State: AOJu0YyUstLEAH4p6/wnxwX+dAUoWjxB9EIn4g7MczXqurfr+zv3ayQf
        8OIoJHL4eNBENWr2Do1G5x7rIWOW4CE=
X-Google-Smtp-Source: AGHT+IFS/SfAmdUJufFp6Q8zrZ91Ow8HudIsSrepWL0n1J42nfbLATTy7KhDTGFVE5U7tSRJvuKhnA==
X-Received: by 2002:a05:600c:211:b0:405:3dbc:8823 with SMTP id 17-20020a05600c021100b004053dbc8823mr5304155wmi.12.1696519826248;
        Thu, 05 Oct 2023 08:30:26 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b00405953973c3sm3989560wmc.6.2023.10.05.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:30:25 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.4 0/4] rbd: fix a deadlock around header_rwsem and lock_rwsem
Date:   Thu,  5 Oct 2023 17:29:49 +0200
Message-ID: <20231005153003.326735-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,

This is the series I sent out earlier today for 5.10-6.1 backported
to 5.4.  More adjustments were needed but still very modest.

Thanks,

                Ilya


Ilya Dryomov (4):
  rbd: move rbd_dev_refresh() definition
  rbd: decouple header read-in from updating rbd_dev->header
  rbd: decouple parent info read-in from updating rbd_dev
  rbd: take header_rwsem in rbd_dev_refresh() only when updating

 drivers/block/rbd.c | 420 ++++++++++++++++++++++++--------------------
 1 file changed, 230 insertions(+), 190 deletions(-)

-- 
2.41.0

