Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7472E1E5
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjFMLp4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjFMLpz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 07:45:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3DBA
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 04:45:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8cc04c278so3554275e9.0
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 04:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686656752; x=1689248752;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R7x6ic8P/ga8SKz5pUJ8SOxpXgGnO05H5fJ99+XZxR4=;
        b=YbngVKoymLTVhFS0T7vWo+sDQOidyyJ5ZZ1TxjIUuDkyPh9VN+ijt6yiOdgnA4wbkq
         phgvtH2Eyt9BkPk+ibNGR28suZQz+u85RREKJ04cETsYGLDPX0Wwb9XoT2x6JIQQPpvE
         5NZ41xnycoDiCqRC9vgS8rEv4syOgDwdryoB8HhQdfnCind4gxv53ORGTJxMJUoZlqfA
         oCdkhMM1oz8ooOF/gVPTbOl6uHCZB2Frnqi5D4saLLBMnC0OiwbutnTsO2Z0s10+2AXN
         m0qH/mAWGA/XVn3wjXBzgqBQdr9/hVz2YXKKhzIJIDWWLWhA2jthMAy48Y6gaiHcxX/3
         elDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686656752; x=1689248752;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7x6ic8P/ga8SKz5pUJ8SOxpXgGnO05H5fJ99+XZxR4=;
        b=eqDYoPUmsqk5LsaaJ0eZfAuOwqHlykdnVwt87IjDanl04bDf0b99z9H5tJq573m7Nl
         /q+8cYe5jzwzWvohbEBzWmsUVu1r3Q2oCsAUeBDDa4fREctFIhYuYJL0UuwOHfJBhf+j
         jeFIg6seIUMTqcJHsDxgzDgiPyJos2DeIw69q/UjwAm2AcKFkgOLe2gaNqdeb03F70k6
         EmhQdE6o0/i1NB5eUKMxZO2PxDam4Y6VEAk044eXaAcyBYgsPNcqKkrE07SyhS6V6lz7
         e02k6Ma/I0VihP8xSCGlawBBHsdhh9caEEnR+nP9GYHShBgNkwgLoT/310qTNoLy0tYT
         40hw==
X-Gm-Message-State: AC+VfDyrTVJ5UUPn0Ld+3kj2MrY/cH3PxyIpF20+HG5pImHmibCbRv4j
        RAJv98IUWb0nZVLnIR1HYKp91/z+arhT1nUdBu0=
X-Google-Smtp-Source: ACHHUZ5vOeqot7G76o0h07CyGnqJMc8KgaR2GLVdHJMnE/6QAyBJ15nzI9nBBX45C9HI4lnB0MGdGJ37DUWTpuepzq4=
X-Received: by 2002:a5d:6647:0:b0:30f:cc22:d832 with SMTP id
 f7-20020a5d6647000000b0030fcc22d832mr1013477wrw.11.1686656752022; Tue, 13 Jun
 2023 04:45:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4f0d:0:b0:30f:ce52:549d with HTTP; Tue, 13 Jun 2023
 04:45:51 -0700 (PDT)
Reply-To: anapayne80@gmail.com
From:   Ana Payne <mariamsawadugo1@gmail.com>
Date:   Tue, 13 Jun 2023 04:45:51 -0700
Message-ID: <CAFAVePGrrUdhA2KtMyGmPK4wr+_o_67Y2KDZr8_mo5HYvsqSRQ@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5oiR5biM5pyb5oKo5Zyo5L2/55So57+76K+R5Zmo5YaZ5L+h57uZ5oKo5pe255CG6Kej5q2k5raI
5oGv44CCDQoNCuaIkeaYr+WuieWonMK35L2p5oGp5Lit5aOr5aSr5Lq644CCDQoNCuWcqOe+juWb
vemZhuWGm+eahOWGm+S6i+mDqOmXqOOAgiDnvo7lm73vvIzkuIDlkI3kuK3lo6vvvIwzMuWyge+8
jOWNlei6q++8jOadpeiHque+juWbveS/hOS6peS/hOW3nuWFi+WIqeWkq+WFsOW4gu+8jOebruWJ
jeS4juWQjOS6i+S4gOi1t+WcqOWIqeavlOS6muePreWKoOilv+aJp+ihjOS4gOmhueeJueauiuS7
u+WKoeOAgg0KDQrmiJHmmK/kuIDkuKrmnInniLHlv4PjgIHor5rlrp7lkozmt7Hmg4XnmoTkurrv
vIzlvojmnInlub3pu5jmhJ/vvIzmiJHllpzmrKLnu5Por4bmlrDmnIvlj4vlubbkuobop6Pku5bk
u6znmoTnlJ/mtLvmlrnlvI/vvIzmiJHllpzmrKLnnIvlpKfmtbfnmoTms6LmtarlkoznvqTlsbHn
moTnvo7mma/ku6Xlj4rlpKfoh6rnhLbmiYDmj5DkvpvnmoTkuIDliIcgLg0K5b6I6auY5YW06K6k
6K+G5L2g77yM5oiR5oOz5oiR5Lus5Y+v5Lul5bu656uL6Imv5aW955qE5ZWG5Lia5Y+L6LCK44CC
DQoNCuaIkeS4gOebtOW+iOS4jeW8gOW/g++8jOWboOS4uuWkmuW5tOadpeeUn+a0u+WvueaIkeS4
jeWFrOW5s++8myDmiJHlnKggMjEg5bKB5pe25aSx5Y675LqG54i25q+N44CC5oiR54i25Lqy55qE
5ZCN5a2X5Y+r5biV54m56YeM5YWLwrfkvanmganvvIzmiJHnmoTmr43kurLlj6vnjpvkuL3Ct+S9
qeaBqeOAgg0K5rKh5pyJ5Lq65biu5Yqp5oiR77yM5L2G5oiR5b6I6auY5YW05oiR57uI5LqO5Zyo
576O5Yab5Lit5om+5Yiw5LqG6Ieq5bex44CCDQoNCuaIkee7k+WpmueUn+WtkOS6hu+8jOS9huS7
luWOu+S4luS6hu+8jOS4jeS5heS5i+WQjuaIkeS4iOWkq+W8gOWni+WHuui9qO+8jOaJgOS7peaI
keS4jeW+l+S4jeaUvuW8g+WpmuWnu+OAgg0KDQrlnKjmiJHnmoTlm73lrrbnvo7lm73lkozliKnm
r5Tkuprnj63liqDopb/ov5nph4zvvIzmiJHkuZ/lvojlubjov5Dmi6XmnInnlJ/mtLvmiYDpnIDn
moTkuIDliIfvvIzkvYbmsqHmnInkurrnu5nmiJHlu7rorq7jgIIg5oiR6ZyA6KaB5LiA5Liq6K+a
5a6e55qE5Lq65p2l5L+h5Lu777yM5LuW5Lya57uZ5oiR5bu66K6u5aaC5L2V5oqV6LWE44CCDQrl
m6DkuLrmiJHmmK/miJHniLbmr43nlJ/liY3llK/kuIDnlJ/nmoTlpbPlranjgIINCg0K5oiR5Liq
5Lq65LiN6K6k6K+G5L2g77yM5L2G5oiR6K6k5Li65pyJ5LiA5Liq5YC85b6X5L+h5Lu755qE5aW9
5Lq65Y+v5Lul5bu656uL55yf5q2j55qE5L+h5Lu75ZKM6Imv5aW955qE5ZWG5Lia5Y+L6LCK77yM
5aaC5p6c5L2g55yf55qE5Lul6K+a5a6e5ZKM6K+a5a6e552A56ew77yM5oiR5Lmf5pyJ5LiA5Lqb
5Lic6KW/5Y+v5Lul5ZKM5L2g5YiG5LqrDQrnm7jkv6HjgIIg5Zyo5L2g6Lqr5LiK77yM5Zug5Li6
5oiR6ZyA6KaB5L2g55qE5biu5Yqp44CCIOaIkeaLpeacieaIkeWcqOaRqea0m+WTpeaJp+ihjOS7
u+WKoeacn+mXtOWcqOaRqea0m+WTpei1muWPlueahOaAu+WSjO+8iDU3MA0KMTAsMDAwIOe+juWF
g++8ie+8jOaIkeS8muWcqOS4i+S4gOWwgeeUteWtkOmCruS7tuS4reWRiuivieaCqOaIkeaYr+Wm
guS9leWBmuWIsOeahO+8jOS4jeimgeaDiuaFjO+8jOWug+S7rOayoeaciemjjumZqeiAjOS4lOaI
kQ0K5Zyo5LiA5L2N5LiO57qi5Y2B5a2X5Lya5pyJ6IGU57O755qE5Lq66YGT5Li75LmJ5Yy755Sf
55qE5biu5Yqp5LiL77yM5aW56L+Y5Zyo5LiA5a625pGp5rSb5ZOl6ZO26KGM5a2Y5LqG6ZKx44CC
DQrmiJHluIzmnJvkvaDkvZzkuLrmiJHnmoTlj5fnm4rkurrmlLbliLDov5nnrJTotYTph5HvvIzl
ubblnKjmiJHlrozmiJDmiJHlnKjov5nph4znmoTlt6XkvZzlubbojrflvpfmiJHnmoTlhpvkuovp
gJrooYzor4HlnKjkvaDnmoTlm73lrrbkuI7kvaDkvJrpnaLlkI7nhafpob7lroPvvJsNCuS4jeeU
qOaLheW/g+mTtuihjOmAmui/h+mTtuihjOWIsOmTtuihjOi9rOW4kOWwhui1hOmHkei9rOe7meaC
qO+8jOaIkeS7rOWuieWFqOW/q+aNt+OAgg0KDQrnrJTorrA7IOaIkeeOsOWcqOWcqOWIqeavlOS6
mu+8jOaIkeS4jeefpemBk+aIkeS7rOimgeWcqOi/memHjOW+heWkmuS5he+8jOaIkeWcqOi/memH
jOS4pOasoeeCuOW8ueiireWHu+S4reW5uOWtmOS4i+adpe+8jOi/meiuqeaIkeaDs+aJvuS4gOS4
quWAvOW+l+S/oei1lueahOS6uuadpeW4ruWKqeaIkeaOpeaUtuWSjOaKlei1hOivpeWfuumHke+8
jOWboOS4ug0K5oiR5Lya5p2l6LS15Zu95oqV6LWE77yM5byA5aeL5paw55qE55Sf5rS777yM5LiN
5YaN5piv5Yab5Lq644CCDQoNCuWmguaenOaCqOaEv+aEj+iwqOaFjuihjOS6i++8jOivt+WbnuWk
jeaIkeOAgiDmiJHkvJrlkYror4nmgqjmjqXkuIvmnaXnmoTmraXpqqTvvIzlubblkJHmgqjlj5Hp
gIHmnInlhbPotYTph5HlrZjlhaXpk7booYznmoTmm7TlpJrkv6Hmga/jgIINCuS7peWPiumTtuih
jOWwhuWmguS9leW4ruWKqeaIkeS7rOmAmui/h+mTtuihjOWIsOmTtuihjOi9rOi0puWwhui1hOmH
kei9rOenu+WIsOaCqOaJgOWcqOeahOWbveWuti/lnLDljLrjgIIg5aaC5p6c5oKo5pyJ5YW06Laj
77yM6K+35LiO5oiR6IGU57O744CCDQo=
