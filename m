Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397B75AF9C
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGTNZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGTNZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:25:24 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65951E60
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:22 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bb2468257fso4418825ad.0
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859521; x=1690464321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRX3V+382NNbaIxu61v/mbukxo4YHJ1pw7jEJ61zOyI=;
        b=H31tJ3eFXGS9iG0vlFc6oj6Vvq3UeT2XIk01AgVOEqhe1wPztepaim3BiCsL1rMkwc
         vdsgQL2aFsKtsTgCtK/OVU4KLKUB19qjj32SZoQxKZKlMs3dFZWnoTXIg3YsnsEuQejH
         ltf51EJpusw87OToaEt1OnqGG6jWBd5EZAlQod6haqmu4Kc35vSEKJfB33fs8cqdmVDG
         RvU5wMK48THPE3dRwNg9WBeR/cy7FIrCi6akWLftKXwe0U2pty84JT0lQz7RAUS/Ffuo
         xGjbxaAIXYNTntbvUW7rbyUsPuiSrDvTxhB2eONqs6MtM5NcuvxXNkf3khCiEaog+HO9
         M5tw==
X-Gm-Message-State: ABy/qLbFkSFQR/eaG7lQZ4NUtW++SA3Va0Ec2Mq4X1T4zifm8MOVz5y6
        LvRQC8aHDQmdZVWNSH5LeBJOl1HDqMo=
X-Google-Smtp-Source: APBJJlGY4auCTsBhOgvUNPV+TsZGjZIItoCM/MoHgUEyumNGKZusz5ta5ex/WR0QHK6COSGCQcZkjg==
X-Received: by 2002:a17:902:eccd:b0:1ac:3605:97ec with SMTP id a13-20020a170902eccd00b001ac360597ecmr21800980plh.62.1689859521595;
        Thu, 20 Jul 2023 06:25:21 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b9bebb7a9dsm1336039plb.90.2023.07.20.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:25:21 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>
Subject: [5.15.y PATCH 0/4] ksmbd: ZDI Vulnerability patches for 5.15.y
Date:   Thu, 20 Jul 2023 22:23:27 +0900
Message-Id: <20230720132336.7614-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

These are ZDI Vulnerability patches that was not applied in linux 5.15
stable kernel.

Namjae Jeon (4):
  ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()
  ksmbd: validate command payload size
  ksmbd: fix out-of-bound read in smb2_write
  ksmbd: validate session id and tree id in the compound request

 fs/ksmbd/server.c   | 33 ++++++++++++++++++++-------------
 fs/ksmbd/smb2misc.c | 38 ++++++++++++++++++++------------------
 fs/ksmbd/smb2pdu.c  | 44 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 79 insertions(+), 36 deletions(-)

-- 
2.25.1

