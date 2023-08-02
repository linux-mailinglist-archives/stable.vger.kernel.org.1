Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDB76CD9A
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHBMxZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHBMxY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 08:53:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17070CC
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 05:53:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5646f8ac115so1030076a12.2
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980803; x=1691585603;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c82RifwY5R4ovRFBE1LhL+2d9xEHdEO18cPILFFaF/Q=;
        b=MT0tu34CyF+WDp3HXJJqXPcBUfo1Sukyq9zHfRZ4GcafR3FyDi40YBIIIFe9SJBjUy
         N1gzZc/ddOpK4pq0T/8Nmvi8+QEjGivfVUigqCCRVD2LhuNSrO6RhlEtovtoPNIEDwZX
         HOkW4+TsrKja+V6TEJ/IP87zxMx95Nrbhr+Z/ugyCYbJDrvdBZ7vgXnF9++K7WghuXhD
         zyTFd5aaWkuAjRZSQovzioM8uKonPApObV2f8zF3C4XyIgazznSkep62sD1+veHX0cng
         yEv7wp8AJJyIVKMcsKLPWCYWNsCeJUpZqzUnvMjk12UZTQxO4hc7s3OmoveHaB3nNZqq
         aawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980803; x=1691585603;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c82RifwY5R4ovRFBE1LhL+2d9xEHdEO18cPILFFaF/Q=;
        b=hHcuHVXRqW0HtM1+k7mVJ1nA9t4z3p1kSybJ8wX4+yRqRL+5OK4B4iB+jvbpF6hOWH
         g7OEUaV+/GchelGjCfqUxpBzA/JL8/LF/T2yb5WF/96IbGgFU/8uwb3jXildi/aY+QMH
         qmGt5v9z1ENlWHQYsGjYnyaTMJuoUbqA7XqqMJzwp7WE3az4VnD4dAbNYrJuC/9mROo1
         n0SRzKIa6MTcvSSOoBn/lBcE9bskdQ4ooYClQbY4UxNzLqbp53c/hNzcS5Siiy3WxP2g
         SjzRBIWSDFBijWxBXHAu7uPdu3ma+Vg/iGaQLDIgB8srx0LzTshTpWZ4gqhKZEsAwdSf
         6b7Q==
X-Gm-Message-State: ABy/qLYt8ma7eqcFS+/1bUgOTcWbajIICH1cozzkMUWZiNPlabUB6yQx
        kD7nDAwytb1BsRBkGVvBzU99XLTsyzheCyWJV2A=
X-Google-Smtp-Source: APBJJlEyu3enVvgkQqz6nv5FNpciT7eMLLdAemYnzRZWv/49K5jo5Hs0wBR6ZHfNhoAPRMVRlGfrl55b3y86QThbE0U=
X-Received: by 2002:a17:90a:3b0b:b0:263:4157:66de with SMTP id
 d11-20020a17090a3b0b00b00263415766demr12083355pjc.42.1690980803466; Wed, 02
 Aug 2023 05:53:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:af2a:b0:4be:acd5:a91 with HTTP; Wed, 2 Aug 2023
 05:53:22 -0700 (PDT)
From:   Sam Peters <martinsabali5167@gmail.com>
Date:   Wed, 2 Aug 2023 05:53:22 -0700
Message-ID: <CAEgFAiQ-VOcKiiEvNrsgeStWnN3haHHBDKy+-YnD5qgnyqgQJQ@mail.gmail.com>
Subject: Sehr dringend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hallo mein lieber Freund.
Ich entschuldige mich f=C3=BCr den Eingriff in Ihre Privatsph=C3=A4re. Es t=
ut
mir sehr leid, Sie auf diesem Weg kontaktiert zu haben. Mein Name ist
Herr Sam Peters,
Ich habe Sie zuvor kontaktiert, ohne dass Sie eine Antwort bez=C3=BCglich
Ihres Familienverm=C3=B6gens erhalten haben, das bei einer Bank verbleibt,
und die Bank m=C3=B6chte es beschlagnahmen. i(8,5 Millionen Dollar). Ich
brauche Ihre dringende Antwort, damit wir wissen, was zu tun ist,
bevor es in der Bank verloren geht.
Weitere Informationen erhalten Sie =C3=BCber meine private E-Mail-Adresse
(osam93860@gmail.com).
.
Mit freundlichen Gr=C3=BC=C3=9Fen.
Herr Sam Peters.
