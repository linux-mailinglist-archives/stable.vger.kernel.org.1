Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA307CE090
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjJRO7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjJRO73 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 10:59:29 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039DC109
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 07:59:28 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-457bfdc1cdaso2190021137.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697641167; x=1698245967; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BUz99UmL8wUGNq3ldoN6zFoTydWQFmImnEvwxSw+6Xg=;
        b=ndyqdxeD/gJpiqPa6km/J0w5TIECbBpQvEY7bpIGGYUYAXLsoTGHAHJz1Z4tknvKkD
         pGQ7hMDgVQx4j+BcJy12bV0URGA7JDjUf/zuEMAsim4s1iKB+/9zQlu3ccR50fnW03xa
         fahINlA5dQqW2utPU+xN5XB2NNdCvpXABSQCKe0WqUkx6Zt4Iyr0Ih7jezKfeVKfOjoR
         7vl6M0ZjLmbTdIM363vuxxPGyZiV2vnVjY4jenyHWn339yJqJzO2+byiKZ46JFkx4ANy
         p7pSAbgQmDxaMdRnk4ncHW0+ESwFGXUAfBR5jLeToKRFbHsyEpbP1TE+RTGgPUfHUXmz
         G9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641167; x=1698245967;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUz99UmL8wUGNq3ldoN6zFoTydWQFmImnEvwxSw+6Xg=;
        b=oUIZYB7crZoEFklA63WlL7isi4rj+agNnchZiBpfJaIDqLpFEChZVmqD/VDGpPia49
         CfnftKF1MFUamVPWsjR90DBo3VDXPBEcqb9RFi2d/f5ifMxcss6yecIfp5xe5Y/CsgEj
         BEm9EQ3xfY31eXVgaZ+NWACUNGv/XKy3qRwMlKzHsdau/88uBBykECOe2r+tEyexTL/7
         4p/wpmA2B+yUKQLE/z5E9yRHFrvqyB0eADB9SgQfvFf3P+uo3BjWLdLFt9SJJCAjC6h7
         AtuCnrrmJpM8fJlYBay28wO6lOFVoB5C0SWOs6My+3NpxrvOWvq7QAxkD+D8nX0Awwxt
         /Oaw==
X-Gm-Message-State: AOJu0YxwSvoVmS2HkcC5cwlXgS1yNfAMICrGF3gKHfbt1BXAs7pN1goV
        M3NY1WIXN/Scy9e73bTridaFeaXfXRVMZz8MP3I=
X-Google-Smtp-Source: AGHT+IHQmHdCOFfCnZ0K/0VhV4tERfqbL8Ac0tnvqB+Hcrx0ZQyl13iF0Mn50HSXRWWTgtJvLgtC/nNONjEQEBQvRyc=
X-Received: by 2002:a67:ec49:0:b0:457:6b29:9486 with SMTP id
 z9-20020a67ec49000000b004576b299486mr5782601vso.33.1697641166977; Wed, 18 Oct
 2023 07:59:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c743:0:b0:403:949f:ccaa with HTTP; Wed, 18 Oct 2023
 07:59:26 -0700 (PDT)
From:   Audu bello <afaf95101@gmail.com>
Date:   Wed, 18 Oct 2023 16:59:26 +0200
Message-ID: <CAPxFRXQN3Oe_DmAHNseSuxkNPUUUsM8fqL1NVp-oWqVUi7=k1Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

An email was sent to you about receiving a pending funds but I'm
surprised that you never bothered to respond.

Please URGENTLY use my regular email address: mgr.audu@yahoo.com
Yours faithfully
Audit Manager
