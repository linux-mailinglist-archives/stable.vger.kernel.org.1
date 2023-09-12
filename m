Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA179D318
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjILOCm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjILOCl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:02:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B128610D0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a6190af24aso709168866b.0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527356; x=1695132156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2xEIwQZVfvKmwKCnHMysqNI/f2L0GjfXNf2n/j4BR8=;
        b=B28lS/qiVoSVj8EhgW8yeyNfmNYhP5Pfjnn94TVOLUDmhLu0klGKi8L5Mj/YF/BG8c
         xmTB/2cYxm4MGaanbi3hnTKs5WYSsvKweZ8swe+8piWdNMXsa8g2gRd4bS8zbRWJB+9A
         Iljfo6OLFrhMblGTf25hiYpBmadW1esapL6PK5cDoxab/Y+/5n1Gg5p1N7u0QaTxp56W
         TsM2OjCemPdx/IvTIV/l+F+XLFvs0JaBXrt5IE68g7hpBxGi/bqTyGyuzSweF4TQURgW
         2unN6rrfkdJiwFRfvv+4zaLXNAFfM3G4INvBDJfmVNQ36GOlworw5zNfBehh4VyfD4I0
         PFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527356; x=1695132156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2xEIwQZVfvKmwKCnHMysqNI/f2L0GjfXNf2n/j4BR8=;
        b=cqJ1mbA2FoLVcHm3zZkPeZADMbEZzh/ZSyUnYz6xj5U3y8gH6Qz0Mj7VaCK7HcD9DX
         ZP9+HBiSYKC3S6RUDVLGIB7fV55otoIStUXASOxWd8ycPLT7N/ET0NAiF5J/GaTLFbnY
         9otaiNHjhbEfj96SA0nLfuAb7ID88iFac+Eu1H4+wtvxhLQWayV2zz8RpMf80+Yb5k/8
         pGsyuvvCILsKJY+RMwpPqeU1J6noFcSDFKqCWvz0sN4PbNTI9saHGJiqoS6gzZ0kBnI7
         qS5okuoxPy7DXgCJfQyidZcJdOrarQeJoRgXmVhFfx98KgRTz/pma+Y7nxTmFmOf//RH
         9djw==
X-Gm-Message-State: AOJu0YybaqIhFg3WThcBCOSyMZXdR9j7s3ado4slpaNMzc4jmtqvg2Rn
        Om3YIHKY83bjlxnFW02Z160E5rnSnjE=
X-Google-Smtp-Source: AGHT+IHWjdBfOI8IbanYKMCsANlGkNGLUb7LNyRlAfBAVlgG8CfwAcllFhsgSoB1KFKFRcfOk7xP0Q==
X-Received: by 2002:a17:907:7815:b0:99c:ae35:8cc with SMTP id la21-20020a170907781500b0099cae3508ccmr11331208ejc.26.1694527351314;
        Tue, 12 Sep 2023 07:02:31 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b0098d2d219649sm6997770ejb.174.2023.09.12.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:02:31 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 0/3] stable-5.15 io_uring patches
Date:   Tue, 12 Sep 2023 15:01:58 +0100
Message-ID: <cover.1694522363.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Recently failed to apply io_uring stable-5.15 patches.

Dylan Yudaken (1):
  io_uring: always lock in io_apoll_task_func

Pavel Begunkov (2):
  io_uring: break out of iowq iopoll on teardown
  io_uring: break iopolling on signal

 io_uring/io-wq.c    | 10 ++++++++++
 io_uring/io-wq.h    |  1 +
 io_uring/io_uring.c |  9 ++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.41.0

