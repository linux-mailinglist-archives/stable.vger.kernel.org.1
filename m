Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE88D7D9AE5
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbjJ0OL6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 10:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346112AbjJ0OLz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 10:11:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3AD4F
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 07:11:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c7c2c428c1so1550534a34.0
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698415910; x=1699020710; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/icHmGf3VQZB0GE/sPdJiL9eb5mVY2as86LmsjnaEtg=;
        b=Kuko6cJjcaq1/LaxCFBOp3tmv5zKSAng1xxmimgiF2nNjDdn6tX8r1oDdgGUDMgPS8
         AzufbJiqC+FIOanLuIjVQWtJ4ijZp8CWszg5xu8/iubEcAH6HjiFINy/gnY9VVTrehIg
         Ok1H71C457tKSoEj3A9hBWJnnDxrNSpXz2udSNliSp2a6KJxmE0UT7Q58GWsTQPTE0vg
         EfKxC7IeEqakdRyNA/NdUBJkTlzlg5VRM2f6KvWwH7WEPab/y6APOdlvccC85sbwI7be
         eih5Y7DAVlo5G7OFM2Wjz1ClGS5r/llpqwEPYAUv75S46KLVuDuYO9yBDoPt0zJVM4yV
         uhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415910; x=1699020710;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/icHmGf3VQZB0GE/sPdJiL9eb5mVY2as86LmsjnaEtg=;
        b=nQ/QcjPYZp3KpjJduIlQiiW//dbPnyXy4ksSsZ2pLhBFm5pr79R5kBkBNP/mHuylTm
         vVzZqSZB6SrWqp06Qi9DC/2tYdJJsXfli/6yX21ONRhkvxaSp8eSSQyTekABIHkNtDjz
         Mgb3AZBBxIc0CzItwD6czUkT0LC4e6XAvX9awB8NCTzSFW1Y1WSRFXJqXbPdNc38Yuvt
         ojNOqPSA9leV6kJd4EgrsZJnAuWwxYTTCF8m0I3oppw+rI3doigtWxlsjgV1tMp1COSm
         oOLJ95c4V/ViBiofleGYPrAicyJYm1kl1HoUE1E1rpFgjorKhQpqb/Kzgby3efvlqVou
         KX/g==
X-Gm-Message-State: AOJu0Yw5PU5oZNE0G1RYFfrEfJzs58i9sOTxWg1bX6THgIsr6R6KQ/BE
        gCfI02AtbcnBMnlaI/9Q9Y1/EC+PPFIkX1R6lgk=
X-Google-Smtp-Source: AGHT+IFO8iQZH/XhEaU7pHKHmgGRVybbC5wJl7/6mL356FTblICVlS+8E6nJXRIupFf3d/mBo9Vf2qliEcB2MQRvBwA=
X-Received: by 2002:a9d:7d8e:0:b0:6c7:b299:530c with SMTP id
 j14-20020a9d7d8e000000b006c7b299530cmr3610688otn.3.1698415909787; Fri, 27 Oct
 2023 07:11:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:1506:b0:6ad:e0ad:49a6 with HTTP; Fri, 27 Oct 2023
 07:11:49 -0700 (PDT)
From:   audu bello <du13061@gmail.com>
Date:   Fri, 27 Oct 2023 16:11:49 +0200
Message-ID: <CAL1wh1HhrcyTFdwaa7ywJUuUe_WkpZbhCHO6hjnNTReVo4UmZw@mail.gmail.com>
Subject: Hola
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Se le envi=C3=B3 un correo electr=C3=B3nico sobre la recepci=C3=B3n de fond=
os
pendientes, pero estoy
Me sorprende que nunca te hayas molestado en responder.

Utilice URGENTEMENTE mi direcci=C3=B3n de correo electr=C3=B3nico habitual:
a00728298@yahoo.com
Atentamente
Gerente de Auditor=C3=ADa
