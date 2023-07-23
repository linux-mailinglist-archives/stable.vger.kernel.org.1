Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC29875E5BE
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 01:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGWXlr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 19:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGWXlq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 19:41:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1365E5F;
        Sun, 23 Jul 2023 16:41:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb85ed352bso1728205ad.0;
        Sun, 23 Jul 2023 16:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690155705; x=1690760505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwrLRuLXj8SHaGOhqw9PbpKmc82/+6Aipnzx6dTElL8=;
        b=AM/kFZCWa3uzV8PQc0is47mGVWBl0jPW74oQtHwlHDYr4a8khPFczbevFQj7xKv/iJ
         K86ey5Fgtkg54XSNRp33uyN/HL611jA35vCZ5qmq7yhdhtVPyG1gzRyKGw8MCJ23vPAh
         RvdLvzp92G6po+2oc/IXpdPACnaItxKLlFCN7pPk9it5ZSwzlw4C/Nk41aueNK8ajhOP
         TJSKF9bjkThbb7GPdY1AcxL/XuAcGps79N0Ns1/lU6PQc7bal1Fwh+b33Xsz8VWzPT7y
         9x3dODT4UB+HsCn2moD/ZRMDDA7sqelpE17SN/5xm48SqmtWOCsT359nJDsUmCqO88U1
         Blwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690155705; x=1690760505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwrLRuLXj8SHaGOhqw9PbpKmc82/+6Aipnzx6dTElL8=;
        b=TkdohDaHSk2bI1BNKtbqSl9NyhXaDhrAsDna7Tw0S5ulv3KzmiBFc+a568U51SYW9F
         iZCH7XNgHhNcXyRUih29ySDxlQ7j/PkWZu+YJSdS+j56dnUQ6mKw6ke35dDzXV7htM1f
         UNIxdrpdVaSyG1uZXKFTiWhqiwCzRwqwXSZz9wwORguldanYvNvuVSDZvt7076NMzakJ
         Uj/JVw3zAi0cgck01peOB0cMmANdF+yZ/+KztW6nvGSDtGlmCsWtVl7wBdF4rhTCP3mR
         FcfsCKgNEvLPSUkn1/z/LeHY4f6LwHmmg+j9IJD0Y4bWPcYeHu+bTuHbgRew3aJedFrO
         fbnA==
X-Gm-Message-State: ABy/qLZyrXfrW3CdtEiMsdSMGbSleRGTMyUnCoz/zyawnXzeWMyY6LGr
        HyDASWcyd5MajipCrZ49gjA02yMqYIjmCugtvFykpldS
X-Google-Smtp-Source: APBJJlH6vs+K/CbuFkeV7XO9qfwoQkwgdpOdDnjtv1vn97dIw5hiB+z2jOkl3L5LVuKXhYeeF9PZyrm8nUqy7QNMY6g=
X-Received: by 2002:a17:903:32c9:b0:1b8:5827:8763 with SMTP id
 i9-20020a17090332c900b001b858278763mr10842761plr.4.1690155705222; Sun, 23 Jul
 2023 16:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230712115301.690714-1-festevam@gmail.com>
In-Reply-To: <20230712115301.690714-1-festevam@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 23 Jul 2023 20:41:34 -0300
Message-ID: <CAOMZO5AgwLypVJNNbkd20rzouLxSWeYDd2ScaGLFNFv1st8H_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: imx6sx: Remove LDB endpoint
To:     shawnguo@kernel.org
Cc:     hs@denx.de, linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
        abelvesa@kernel.org, linux-clk@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Shawn,

On Wed, Jul 12, 2023 at 8:53=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Remove the LDB endpoint description from the common imx6sx.dtsi
> as it causes regression for boards that has the LCDIF connected
> directly to a parallel display.
>
> Let the LDB endpoint be described in the board devicetree file
> instead.
>
> Cc: stable@vger.kernel.org
> Fixes: b74edf626c4f ("ARM: dts: imx6sx: Add LDB support")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v2:
> - Rebased against 6.5-rc1.

Please consider applying this one as it fixes a regression, thanks.
