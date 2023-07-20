Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1875AFA4
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGTNZo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjGTNZl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:25:41 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24241989
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:40 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bb1baf55f5so5752805ad.0
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859540; x=1690464340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRX3V+382NNbaIxu61v/mbukxo4YHJ1pw7jEJ61zOyI=;
        b=UAYNESHC0ctFkOZQ4ZPfOVnCOTyB7eqKlW3CaJ+E4p6QJc6+KDlTwUoDQxQkDAyh9G
         1YgvNQWyPpMblWMfvlqoHrgaJYipz1IqkfZ4KZ2isd40i0Lm81h9ok8zJA7uHyAEzd1+
         hxSu+h8pCDnYBV3coETAmjhemFexsLyij2psskzeNDXtYjS7teOUvu+irPRwGwZQID1i
         kyoKkrgcFZzKPMYzaB8Pci4JGZ6scduD7ETswMgPNFH7FrgR7KOh20xPPCVE/l4vuu2C
         zFsnX30OUe+zIK82UpwHSeN87+kxnS4mYhA7eVcSCOjam8A8Wn0zZ7Z4b3s7LMt2oyuU
         MIhg==
X-Gm-Message-State: ABy/qLYWv9+snnAq8CCoropsAmUZWun2905XXitbO4aZrDKQB3phfWV2
        +axyAuNdROUG8nQZiUW2+l8gXwG7HSk=
X-Google-Smtp-Source: APBJJlEkxTVJPxzQGtNOZqj59CzpYCks59qyb+2bBc/AUu1EfEuRjKIFpS9GzAb76GSFTcjVoY+CAg==
X-Received: by 2002:a17:902:dad2:b0:1b8:b3f7:4872 with SMTP id q18-20020a170902dad200b001b8b3f74872mr26540090plx.28.1689859540134;
        Thu, 20 Jul 2023 06:25:40 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b9bebb7a9dsm1336039plb.90.2023.07.20.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:25:39 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>
Subject: [5.15.y PATCH 0/4] ksmbd: ZDI Vulnerability patches for 5.15.y
Date:   Thu, 20 Jul 2023 22:23:32 +0900
Message-Id: <20230720132336.7614-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720132336.7614-1-linkinjeon@kernel.org>
References: <20230720132336.7614-1-linkinjeon@kernel.org>
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

