Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09707704F9B
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 15:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjEPNn2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjEPNn1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 09:43:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C1B4480
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ad819ab8a9so120381261fa.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684244604; x=1686836604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQVKegH9TG7qcJnFN8av6hZAa0V6mxd6dfFBgberNok=;
        b=gxYQbPwcQkQtXMqfTgSa/91iY/peh4taOdI/0stetIHa6U6SvAs0Pcjb6v0e36g/Bu
         /AkpzuuvYRIZi+EdiuelQ93/hQrAO1eWPc6vljtujhkCwe69gLgNygHHv+UXargQzPoH
         DcRZt7DITq8ozRFrUIVfjepz5AbkOz3BpRP4PA1TXdSAKjZYcCslqcIl5xB8XecLwUTn
         GIakpHRbFp7FDrCBcEfCaiFnZJHCjRTJFbGdjlGmbVyb1aL30KlkXq4m5QkejlapMWrB
         +YAnMrj+rqX/v0iTAPzKOw7n+qGq8UMMESj9ua5ZiL51kgqXhmDhLna5lR0hsajfhyhb
         dhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244604; x=1686836604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQVKegH9TG7qcJnFN8av6hZAa0V6mxd6dfFBgberNok=;
        b=N5Q9l3wTazdR/6l7aVyjG+2pbsuSUkTHVhi1KNjK4TfoEatArnThgVAppbKC9xiHA6
         vilXTkLdXhahsDObQpZfMnAoGDlJ7g2sbFTRyhrrrjJ5UcAya8hoOAjWEWRHYgdVRfMq
         zGFSgsakVc0FVTb4G2eV5U3U+ALMeG42CD85/FD5Gorqu2Du4HrLXtGCRq7oZa9PajDZ
         u5AkNSijha/ybMJO22vHHD87S28+Yc/vYKEum/4XvMZuR03YgoKblTd8dKyg76kTlHcR
         XcjJxJa3TdBN9tYkyVQ1SDCaD9IuXBPCKsJ/kp8YrdftBlWWPtzAX5SHMFLJuiLPKzFi
         CRRg==
X-Gm-Message-State: AC+VfDyzAtwpVOTb6FtyjmrEahjNRUoUNwNa65kRspBbmDvgYBnrC9Jh
        cBfyq1fUp/Nbp66lrtyyMLeS9A==
X-Google-Smtp-Source: ACHHUZ5lCqHg7hne/jpemxl9kPSClFWxPstwhO03Y5VET1grDmOU/pGV77pQOsbVZGH46Fz31+/mdw==
X-Received: by 2002:ac2:5483:0:b0:4e9:9f10:b31d with SMTP id t3-20020ac25483000000b004e99f10b31dmr7073001lfk.2.1684244604447;
        Tue, 16 May 2023 06:43:24 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b004f13b59307asm2962558lfp.232.2023.05.16.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:43:23 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 0/6] can: kvaser_pciefd: Bug fixes
Date:   Tue, 16 May 2023 15:43:12 +0200
Message-Id: <20230516134318.104279-1-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch series contains various bug fixes for the kvaser_pciefd driver.

Jimmy Assarsson (6):
  can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
  can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
  can: kvaser_pciefd: Call request_irq() before enabling interrupts
  can: kvaser_pciefd: Empty SRB buffer in probe
  can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt
  can: kvaser_pciefd: Disable interrupts in probe error path

 drivers/net/can/kvaser_pciefd.c | 51 +++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 22 deletions(-)

-- 
2.40.0
