Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C27BEDF8
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 00:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378726AbjJIWCz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 18:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378321AbjJIWCy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 18:02:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053F99
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 15:02:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so56368231fa.3
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696888971; x=1697493771; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DY/DD0OlfoUqWCPcaHwwLrXANER1/Hg3tF5ZHTBZ1LU=;
        b=KG6uqJmqAeDaON3hU8JYlgUlZRkyl3pHPkC4xJaEzpqO4+3YMUJtjLd9td48Ml+M9Z
         NMw4iJmkhvEDaz88jf8/Dru5FN/lh1d18fTC/CgwwnOgkrl/MR9XbxWJZbuGRwn8vFjG
         AH7YQyWlCT6t1pN+Um/xSHnqsJnK6Ee/qUZPMQij/lM3qX+7opWmbGhJaYcPgp8AdSk2
         YB0ImGVh+cvLO2wOQLi+MINnPaCCq2A7U/OO5xBn65h93jiUeCOu6POQ6WrjJejGiOCi
         ajukPft1A+g/L54jjVxjFZ+iHgK45HZlDEHpmjlzMJJRSzJTtjCEb2zDghlXOi6zQVzb
         hWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888971; x=1697493771;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DY/DD0OlfoUqWCPcaHwwLrXANER1/Hg3tF5ZHTBZ1LU=;
        b=afcdgGJzFFkGhCaHVwtZFOV0TubjlA+p77FKw4cuL81Nmbfkv25i52LItTvne9JWAK
         vSJ3BBNu7eap9Oe4dDPD4Gs1aoG6KLOkGhomyis0DIA/yTwLfWkmW0FC5E3DD/0BBi15
         1k/KRyq+nZO1js2yyuV4c3oNzau76POP6OGij6tRQ+ZUWWzK/fTxrJKn4ZImAUppA/zB
         QgJ7XKm6N8hB8avCmUhLvgYhXVilGgwVCTvh+OdsYVI2dJ+mb1G1je6iBcZzr4qo9C4U
         08fty7y6nM80Oax8XFiFiWX5o4Uv+vdVDhCsobOZLzrgRuLtSatzPKEBOo6mFp2DeAzg
         X1zA==
X-Gm-Message-State: AOJu0YzPC04yDPkONmgTHjfsUL/GymBon0CGWrN5e2ZbGG9eZ4epO2cM
        hUD6ag2KRy0LuY6E8GFpGuKaLBpQAmVL8EAp7FU=
X-Google-Smtp-Source: AGHT+IHzqXbI1sX3nGgYn8+pAug+SoIndCTr0l49EgoKfMs76ByXleVW928nM+rYNSO6QgyrQ9FAfGnmlKHmB6i1xeE=
X-Received: by 2002:a2e:9b97:0:b0:2bf:d379:275b with SMTP id
 z23-20020a2e9b97000000b002bfd379275bmr16221583lji.20.1696888970644; Mon, 09
 Oct 2023 15:02:50 -0700 (PDT)
MIME-Version: 1.0
Sender: martines.rose02@gmail.com
Received: by 2002:aa6:ca0b:0:b0:279:6e2:6ea0 with HTTP; Mon, 9 Oct 2023
 15:02:48 -0700 (PDT)
From:   Sandrina Omaru <sandrina.omaru2022@gmail.com>
Date:   Tue, 10 Oct 2023 00:02:48 +0200
X-Google-Sender-Auth: edIt0JNV9YPEel4V6QUKM7KfOXY
Message-ID: <CAB3C3EdviqtMZF+ePibOQE1xo8cTY69+=qvxnxqOOpe2mZOsvw@mail.gmail.com>
Subject: =?UTF-8?B?0J7QtCDQodCw0L3QtNGA0LjQvdC1?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

0J7QtCDQodCw0L3QtNGA0LjQvdC1DQoNCtCf0L7Qt9C00YDQsNCyINCy0LDQvNCwINC4INCy0LDR
iNC+0Zgg0L/QvtGA0L7QtNC40YbQuCwg0LzQvtC70LjQvCDRgdC1INC00LAg0LLQsNGBINC+0LLQ
sCDQv9C+0YDRg9C60LAg0LfQsNGC0LXQutC90LUg0YMNCtC00L7QsdGA0L7QvCDQt9C00YDQsNCy
0ZnRgywg0JzQvtGY0LUg0LjQvNC1INGY0LUg0KHQsNC90LTRgNC40L3QsCDQntC80LDRgNGDLCDQ
uNC80LDQvCAyMCDQs9C+0LTQuNC90LAsINGY0LXQtNC40L3QsA0K0ZvQtdGA0LrQsCDQvNC+0LMg
0L/QvtC60L7RmNC90L7QsyDRgNC+0LTQuNGC0LXRmdCwINCz0L7RgdC/0L7QtNC40L3QsC/Qs9C+
0YHQv9C+0ZLQtSDQntC80LDRgNGDLiDQiNCw0LLRmdCw0Lwg0LLQsNC8INGB0LUg0ZjQtdGADQrQ
vNC4INGY0LUg0L/QvtGC0YDQtdCx0L3QviDQtNCwINC80Lgg0LHRg9C00LXRgtC1INGB0YLQsNGA
0LDRgtC10Zkg0YMg0YPQv9GA0LDQstGZ0LDRmtGDINC80L7RmNC+0Lwg0LLRgNC10LTQvdC+0YjR
m9GDDQrQvdCw0YHQu9C10ZLQsCDRgdGD0LzQtSDQvtC0IDMsNiDQvNC40LvQuNC+0L3QsCDQtdCy
0YDQsCDQutC+0ZjRgyDQvNC4INGY0LUg0LzQvtGYINC/0L7QutC+0ZjQvdC4INC+0YLQsNGGINC+
0YHRgtCw0LLQuNC+DQrQv9GA0LUg0L3QtdCz0L4g0YjRgtC+INGY0LUg0YPQvNGA0L4uINCi0YPQ
ttC90L4g0ZjQtSDRgNC10ZvQuCDQtNCwINGY0LUg0LzQuNGB0YLQtdGA0LjQvtC30L3QviDQv9GA
0LXQvNC40L3Rg9C+INGDDQrQpNGA0LDQvdGG0YPRgdC60L7RmCDRgtC+0LrQvtC8INGY0LXQtNC9
0L7QsyDQvtC0INGB0LLQvtGY0LjRhSDRgdC70YPQttCx0LXQvdC40YUg0L/Rg9GC0L7QstCw0ZrQ
sCDRgyDQuNC90L7RgdGC0YDQsNC90YHRgtCy0L4sDQrQuNCw0LrQviDRmNC1INGa0LXQs9C+0LLQ
sCDQuNC30L3QtdC90LDQtNC90LAg0YHQvNGA0YIg0L/QvtCy0LXQt9Cw0L3QsCDQuNC70Lgg0YHQ
tSDRgdGD0LzRmtCw0LvQviDQtNCwINGY0YMg0ZjQtQ0K0L7RgNCz0LDQvdC40LfQvtCy0LDQviDQ
vNC+0Zgg0YPRmNCw0Log0LrQvtGY0Lgg0ZjQtSDRgyDRgtC+INCy0YDQtdC80LUg0L/Rg9GC0L7Q
stCw0L4g0YHQsCDRmtC40LwuINCQ0LvQuCDQkdC+0LMg0LfQvdCwDQrQuNGB0YLQuNC90YMhINCc
0L7RmNCwINC80LDRmNC60LAg0ZjQtSDRg9C80YDQu9CwINC60LDQtNCwINGB0LDQvCDQuNC80LDQ
viDRgdCw0LzQviA2INCz0L7QtNC40L3QsCwg0Lgg0L7QtCDRgtCw0LTQsCDQvNC1DQrRmNC1INC+
0YLQsNGGINGD0LfQuNC80LDQviDRgtCw0LrQviDQv9C+0YHQtdCx0L3Qvi4NCg0K0KHQvNGA0YIg
0LzQvtCzINC+0YbQsCDRmNC1INC30LDQv9GA0LDQstC+INC00L7QvdC10LvQsCDRgtGD0LPRgyDR
gyDQvNC+0Zgg0LbQuNCy0L7Rgi4g0KLQsNC60L7RktC1INC20LXQu9C40Lwg0LTQsA0K0YPQu9C+
0LbQuNC8INGE0L7QvdC0INC/0L7QtCDQstCw0YjQvtC8INCx0YDQuNCz0L7QvCDRmNC10YAg0L3Q
tSDQv9C+0LfQvdCw0ZjQtdC8INC/0L7RgdC70L7QstC90Lgg0YHQstC10YIuINCY0YHQutGA0LXQ
vdC+DQrQttC10LvQuNC8INCy0LDRiNGDINGB0LrRgNC+0LzQvdGDINC/0L7QvNC+0Zsg0YMg0L7Q
stC+0Lwg0L/QvtCz0LvQtdC00YMuINCS0LDRiNC1INGB0YPQs9C10YHRgtC40ZjQtSDQuCDQuNC0
0LXRmNC1INGb0LUNCtCx0LjRgtC4INCy0LXQvtC80LAg0YbQtdGa0LXQvdC1Lg0KDQrQnNC+0LvQ
uNC8INCy0LDRgSwg0YDQsNC30LzQuNGB0LvQuNGC0LUg0L4g0YLQvtC80LUg0Lgg0ZjQsNCy0LjR
gtC1INC80Lgg0YHQtSDRiNGC0L4g0ZjQtSDQv9GA0LUg0LzQvtCz0YPRm9C1LiDQntC00LzQsNGF
DQrQv9C+0YLQstGA0ZLRg9GY0LXQvCDQstCw0YjRgyDRgdC/0YDQtdC80L3QvtGB0YIsINC/0L7R
gdC70LDRm9GDINCy0LDQvCDRgdCy0L7RmNGDINGB0LvQuNC60YMg0Lgg0YLQsNC60L7RktC1INCy
0LDRgQ0K0L7QsdCw0LLQtdGB0YLQuNGC0Lgg0L4g0LLQuNGI0LUg0LTQtdGC0LDRmdCwINC+INC+
0LLQvtC8INC/0LjRgtCw0ZrRgy4NCg0K0KXQstCw0LvQsCDQuCDQkdC+0LMg0LLQsNGBINCx0LvQ
sNCz0L7RgdC70L7QstC40L4uDQoNCtCh0YDQtNCw0YfQsNC9INC/0L7Qt9C00YDQsNCyLA0K0KHQ
sNC90LTRgNC40L3QsCDQntC80LDRgNGDLg0K
