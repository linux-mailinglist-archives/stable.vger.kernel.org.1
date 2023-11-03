Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406B57E02BC
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 13:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjKCMWC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjKCMWB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 08:22:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95915D54
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 05:21:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2809414efa9so1870841a91.1
        for <stable@vger.kernel.org>; Fri, 03 Nov 2023 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699014115; x=1699618915; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOW5o5Vz/UFvLvDgqa/XoJw/ZKIviQw6rnddoLVFPgA=;
        b=VVc3B65OgxdNfVFFYeHkFEHKDz70ZemPtZ8joTkAb2h6TJhFdq2at6GMt21kKT9+4t
         LuFpCRjX3VM8Deg9fVgKZmKHRUmaVemVkxB9s1JAs7iuhoyGO2EKikUJgeRuscwHm4CQ
         O/+hW8nI/o1bj/RYYHHw81wVwIHvgU6i/welNgCEexNTXPHd+gXrB9XDWi3xesu09Eej
         zeP8I+k6spbFJR670RCHojNi+ubKpHt/CKLSJ6OpMr20I7v3O3IlK5msYeO2+D2DDmr/
         n+UFC1hUqFPmZVmLt8mR1tU7Pyop8TGeCBI1BN11K+yOPThtfpsyLAYHBX+uAvRG2BpT
         oiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014115; x=1699618915;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOW5o5Vz/UFvLvDgqa/XoJw/ZKIviQw6rnddoLVFPgA=;
        b=GfBV3AWiKT6eJj2q2QuUXGpVk5TLDMVrdN9Jm4QdxiCtErV8UJh5MRrbmMlIO1Zn7V
         UEw0KSBHitMBVZbdJPEgLk3uycWRVL1V+iTniI3pfL/FfFqVB2fp279Skt7vEYMDk/8R
         FpQKiRT2uncVV0ZIeGqBQUHxelWhmMq6Z+Ct1/djPpfEb8PPWBvDCbL6tn9d0FE2shWo
         OJA5uu/OaEl3dFjDnUqEdmBtstMw9G90fx3SyQaKV7YYFU7hwRcXJZQcuehdYTqwOeEU
         7VkhqmQx1jbZhR51aaed7UP1ZPI3Pn6DyvGrAw07Tvr6acnlnREGFdkfaFE/dfv9/Z2C
         iO1Q==
X-Gm-Message-State: AOJu0Yx7qD/uvw+hZjHt899JVcCk1vykpjovs5DVeDpGzPMw4eVnJAbh
        th8C1jSVPVTPOW67x2lF12mYgM3T6tglVLV3Ghk=
X-Google-Smtp-Source: AGHT+IE1J5usVRn/faWOlGGcCkWNgoow57TY1j2dD8H51u0G2G8Wntv3g/zFTXZk7GqYFrqrdGdA+C/eZh2PJyhePe0=
X-Received: by 2002:a17:90a:1a51:b0:27d:4278:ba53 with SMTP id
 17-20020a17090a1a5100b0027d4278ba53mr18873123pjl.47.1699014114853; Fri, 03
 Nov 2023 05:21:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:7c19:b0:f4:d4fd:6db1 with HTTP; Fri, 3 Nov 2023
 05:21:54 -0700 (PDT)
Reply-To: fionahill00005@gmail.com
From:   Fiona Hill <asouche209@gmail.com>
Date:   Fri, 3 Nov 2023 12:21:54 +0000
Message-ID: <CALmDccL4WnCcqoSEmpLtOw26stODYUXdy_SHCeLn+vRnDueKDQ@mail.gmail.com>
Subject: How are you ?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

 Did you receive my message ? fionahill00005@gmail.com

Fiona
