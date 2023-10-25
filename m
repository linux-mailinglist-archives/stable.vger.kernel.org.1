Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D827D60D2
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 06:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJYEWB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 00:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYEWA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 00:22:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4499F
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 21:21:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3a38b96cso5756058276.0
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 21:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698207718; x=1698812518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6lAjs7pCddl0624xK47O/wky+wQy4C2PARnl7T7Nt0s=;
        b=WBl8+Zn+7a5adGIRSNvo++8ZjiPzTc0NStewMPL3u9y/BLNPHB/ACcmhOC+NXghebr
         w8FW97rIoWdZ5piEIaLBUNCjrykD+hzd0GfcMGsA6SXkLBQeHnaUw6nmIPa+WQFkXdSP
         N9bgDHJP45fN/XVtv3BfAB3wUTsTBWseoJzbXl8DsTkwEXFcDqAat2KIfe9SUQ5Hd20Q
         x2Q8swFc46phuW2u4yl59pesmZgqdcE3TbnRAkMXQYBQXM94uPUhqoTeYkSwJcNUXlPp
         liwOMLr4lmzKYZxTAn4f85InNpgEilL87owe6YzmI7q8Q2QsoeVY+rvmRFp0ujeGMTS9
         LqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207718; x=1698812518;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lAjs7pCddl0624xK47O/wky+wQy4C2PARnl7T7Nt0s=;
        b=vx4nfls6rTUDFSbmfxzbhtj+3Onn0EgI+n3qSyZIb06rm3rXu9FHSHN9T5NzI1rbbX
         0KoTfvfr2qzzhmklHHXPtPo2MkQLtnGAUCuhBFWgu5r7w63SbATnlISlawLyY/WRmRI9
         3mI4ihfTagyIvV+BoCuZiff/rG7EhwExcqNQv3OHPpuoW1d85snd67oYs3w/HREUq+bU
         aqY00FPklPrPMX8f5rH8HivyKg2RKxVHLPAnIdyKZQxszbxja/28F9HoHoJPlXia5fFx
         +x+YENsaqRdBHIrgqCN/hkxJnz/1gPCnwpWWIlKsCK0+BLHquADaX5yq2sB7rbu6ETUh
         mmbA==
X-Gm-Message-State: AOJu0YyX6aKmdkIzR8cgQAKiA9vdFbOBKiPclPdmY8QcDzRzX0/L/uF2
        gMnhN6U6HDEj41rluwS5Gv79LFe7tMPK+v/NRNRI5Eei2DL3n8EmBUknSXaJOYeoDtlze/3i9Uz
        D859EBhPViEzFNdkhpx8tP+aYEL5bP2X0FqFCFbzz2nde4SZsHLo6Ig==
X-Google-Smtp-Source: AGHT+IEdoTyfmFJgU9dA+JziROVinlDNyuVHJe2ZiK6wJrgtvAs2oGx2FYI3CWAGa4lLg4rJMPtWZlY=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a25:e093:0:b0:da0:3b57:d23f with SMTP id
 x141-20020a25e093000000b00da03b57d23fmr68975ybg.7.1698207717516; Tue, 24 Oct
 2023 21:21:57 -0700 (PDT)
Date:   Wed, 25 Oct 2023 04:21:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025042144.2247604-1-ovt@google.com>
Subject: [PATCH 5.10 0/1] kobject: backport of slab-out-of-bounds fix
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     stable@vger.kernel.org
Cc:     Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a backport of slab-out-of-bounds fix to 5.10. The only change
from the original is adjustment of fill_kobj_path signature.

Wang Hai (1):
  kobject: Fix slab-out-of-bounds in fill_kobj_path()

 lib/kobject.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.42.0.758.gaed0368e0e-goog

