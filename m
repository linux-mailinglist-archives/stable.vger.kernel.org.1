Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B581727F86
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjFHL6R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 07:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjFHL6Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 07:58:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87212113
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 04:58:15 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-568900c331aso4675257b3.3
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686225495; x=1688817495;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntkIf0rMAxVwra80GhgCLDY1J6N5qFnD5+850Okp+fE=;
        b=IATQPDJtWICo3vrYKWZkA39WcuHj2Amm+zKms2/7jum8vrowQNzPnZxVu5Ud1rX1X9
         HoXNJbf2ucyomQMiae3Ow3w7NJ2opWK7JB1uOvBBGbXX1zoacp6vPgEhZ1skH3ixOf4p
         MDScuAqVKdNP4bM3edKLA47n3Mws6G7pxKGLg9DgmH9TMAkpLgGEAP2iBCOP7z/6qt54
         VGoudQ/0HkaFAsyTLu5FGay1Kru35o0ktG/nBhT0+JqUpcKcYkvovigQgelvNj6dl/9R
         Dur25i88N4S+if1gqAOQcjDsWyDk8ReHtc/8PJ56BpzGISAwB8S3i4ytHJXtei9fSDPd
         vSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686225495; x=1688817495;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntkIf0rMAxVwra80GhgCLDY1J6N5qFnD5+850Okp+fE=;
        b=l1v+kR6DstmzupOmnwoeM45JvyhFmCaj8N4TxwdLpzK/ksZVoiXMbS24e7KqvYzAkg
         st6KbllByMS3YHOLmlbpfeYfSoqr2W2cQG5gGkGTYNn4PTdb1AjfWCIbxEmSqY3RKajk
         /e2VhJRV77of5NHax77Bvvb86a6XbIEd/P2kHmQW0d/BFZAca6favgifoRIdQWnoNjeu
         pzZXVnG1FJBt+S8VoogehEu8ZiA0LVgszT242qG43In7BAdgRqTI4/Zgn9zxS40FpyOz
         Vt5sPIhsAkNc9m3/B3nJ1L20m2dqa4yyOqj3IrNbSG6pSV1vlcHqoDsa0qlpqQzItNiX
         ytIA==
X-Gm-Message-State: AC+VfDwrZMVn09Kkm3d3F9x78KfZWJ6SIXxyQw7P50AmgsOvvmzPrNHo
        voHPTQPCnN2ZpO30YptREbSyCdmcBruAHaluD2M=
X-Google-Smtp-Source: ACHHUZ7+6Eu1uQd4khyhz6fize5cptYdjsanKyuFbX4tz1O1KgsikJas1lpLijldrbxBv+Zh1RL50jE1zlfPP2Hcq9E=
X-Received: by 2002:a81:5bc1:0:b0:561:a422:f3cd with SMTP id
 p184-20020a815bc1000000b00561a422f3cdmr8476955ywb.30.1686225494845; Thu, 08
 Jun 2023 04:58:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:1702:b0:35e:fd9:3d98 with HTTP; Thu, 8 Jun 2023
 04:58:14 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <info.cherrykona@gmail.com>
Date:   Thu, 8 Jun 2023 04:58:14 -0700
Message-ID: <CAEiOkH5Tf=juV+vqCc2Oit+eOu2kBZ_OnOAVWfEbBRhzDjkUYQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

-- 
Hello did you see my message i send to you today?
