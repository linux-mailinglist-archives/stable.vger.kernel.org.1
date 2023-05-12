Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06D570017E
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbjELH2N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbjELH2J (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:28:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C5A5C8
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:27:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso16914329a12.2
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683876461; x=1686468461;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=PIdKTOruLsLDNNWSLYaAaddRnuhpzU71B5JcQJSoPtO/X4Ug2hmXqrq6s5XFk9W8ls
         iO5jF3jJAlM5zVE64ZqIeNPQtzNUKi/KqD3mzY0dVYJButFAFrtwgaRL7ehuKcNOUM2U
         WpziumjhAjKmrnixEEj6z9WPuWzuYhNYcUHe3VRSQpadkwHTd1oiMRUwX0F7o1KhpTlz
         b3WW2JwRtEuj0wrPkLb8DApF4Ju5pzJDJGnA0ke6xrRYrxNWneR4fgeYhlEU24VBWojl
         3el7iKq6kxyM7dJKBQjd+Ri/tcQ3FbyTbY7M+HFFw1SoDbmW/loc0CLECGbMKIy4fSLN
         /H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876461; x=1686468461;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=JuNSLfV+Vrf+YCFGRqIwvX0EBGltIK4oQzb1WRMmCDTUjG1+sLzSN+M82kFYAdUOJD
         aXHGDuEOo4mE/z8NviP0xjweBw7DNzIa65THxgw/1w43i7rpntw0gNtSgilUj17O1xMQ
         50DzaWJuLRhaBu4mp3bFj53rxRA28MNAU924vcPFixU8izlIYZfLeTlyC2UQdwkuTo79
         b/6Q6KQrmyBMKqFEpaj0PDSqsbRkEPXMG3LBdV2CBhdFE/TUa6I34ct3YDC5gn+r3OWy
         G7n/DokLQG/N+xrtTMpiWCFnxcaBn4wCW53S6dCpdIa6Es+od8miT8ejCYdjPUmyatHs
         7JTg==
X-Gm-Message-State: AC+VfDxvp4sOvNPJC1CmwbTlmCy4W3AIzk+pGR9MfcUFDNdTdrBHsWnM
        B+Ri8BBk7pJUuL4nOuTlVAGvcS5c5Yz6zLW0Cl4=
X-Google-Smtp-Source: ACHHUZ6pcyHhNahkM1inE0lRaH/mZ24s5538GK1VAZQpi8JAPCD13bXG6sBJasbN3XNMuC2FzTMrFC9QWUY+FBWWtyU=
X-Received: by 2002:aa7:d286:0:b0:506:83fc:2dab with SMTP id
 w6-20020aa7d286000000b0050683fc2dabmr18316624edq.22.1683876460574; Fri, 12
 May 2023 00:27:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:c556:0:b0:506:af22:20ea with HTTP; Fri, 12 May 2023
 00:27:38 -0700 (PDT)
Reply-To: westernuniont27@gmail.com
From:   westernunion <ezen99425@gmail.com>
Date:   Fri, 12 May 2023 08:27:38 +0100
Message-ID: <CAO_4fO8Hzm3FPb55at5Wizmf2bY_G7h4M5qya4fxuLAV2N8Tqg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Your overdue fund payment has been approved for payment via Western Union
Money Transfer. Get back to us now for your payment. Note, your Transaction
Code is: TG104110KY.
