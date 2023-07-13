Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B9752BF2
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjGMVRs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGMVRs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 17:17:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B02D54
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 14:17:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so9884535e9.3
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689283063; x=1691875063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SJ39/4emjSBqidxqqm+hSVoBmdKYwJWI9c6gIRJrwY=;
        b=MQOKyAjPYTanB89cWMCX2J4We8mHG/LwU02ZcPmSgvFXX3VCxt/Gmx+J1azXF3R6Yu
         kcZ7fHr7qI1B148BEzwGy4YwZlRXHns/ugmQ/gvvf6bYFUSC5BiBuZqZt912g4NVqHY8
         2dA7NLxQ0fEZcLM6uMflFeSsnhAs1wvKDjMc9DLqH1XZCwVdt1e4H1LVRptsM1XHVxln
         VMOxXII4JBos2e5ca7dSGI9hlq/pVSiNHy67kW5dVmSfEpz4LB/w9Gf8Nm8PgHYm2Xgk
         fnfth5OVGJ0WCDxZQ9Rb7BMRcrrDaorWW6RiWeK5d/epMXUkey8zak8iLGf5Jg9Vylhm
         aaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283063; x=1691875063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SJ39/4emjSBqidxqqm+hSVoBmdKYwJWI9c6gIRJrwY=;
        b=bQGVRpkrYwUvVv0p7IYuvWJL2ZySUIAYSf6WTXWinmD1vTCHkkDhIheYlWAhVPHxtG
         WFGcQGfw/lPWd7ECam98vmMStiROkG8iIHUPoKkSV8aGtIrXfD7oHlfsttE17B0mOvcU
         mJtb8FlTRZqM3TivjqAxleadf7vzG4PWjVOp7CrTPvgIwefEZ+ng1kPyOjzTiKP98wPu
         pFjau5p5DnXi6LQELQH5tIm90NTNEexUt/qY9iWLA7PLxbPbyGPxrYMjfk2F9S3XfRiW
         5IrhI6HM9syE9qyw6SPJaK8aH5Cx5r3epYWIRt73QgIEOM1XJXliKbYf8H5Nl4mO1m5l
         ZQXA==
X-Gm-Message-State: ABy/qLbmYg9flzKP1EO5uaYaKIHjlOfRzNEamzG3r2BdpvRdKY/v0UnW
        86mQCzBmpQPaax+ouKt8WaIWqw==
X-Google-Smtp-Source: APBJJlHK1/lG2hgNlfU5T9vUiKYKjvPj4CCwde7DgVzxA8j+DT7soIe9qcuZieyexN1nyGW+IoLbPA==
X-Received: by 2002:a7b:cbc9:0:b0:3fb:e1ed:7f83 with SMTP id n9-20020a7bcbc9000000b003fbe1ed7f83mr2882736wmi.33.1689283062844;
        Thu, 13 Jul 2023 14:17:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bcb94000000b003fbfea1afffsm8734136wmi.27.2023.07.13.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 14:17:42 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/3] selftests: tc: increase timeout and add missing
 kconfig
Date:   Thu, 13 Jul 2023 23:16:43 +0200
Message-Id: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALtpsGQC/x3MQQqDMBBG4avIrB1ITLXYq4iLon/qUIklM0hBv
 LvB5bd47yBFFii9qoMydlHZUoGvK5qWd/qAZS6mxjXBPX1gm1ixRoOa8vqNxqELeLS9i961VLp
 fRpT//RwowWg8zwsrw3IxaAAAAA==
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        mptcp@lists.linux.dev
Cc:     Pedro Tammela <pctammela@mojatatu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=X7TmH0nuyH8IYOau93/uRL5n5B40ehly9tSIh/k77XU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksGn1fSBHW3xBP1UUe+C5C8geDtkmfExF5YBV1
 KB1xfHHozKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBp9QAKCRD2t4JPQmmg
 c2IiD/4275C6eSBB6If2iVSrVVuu040rBtAxF3vjZTgGMw4h1d+VzvS52fSGSIksGR8bdY0gjED
 UnmPuLzrChpaGx+m8o8fuVpTgFLQNUn6BUt3Q68ipTHyWVQDMBSgW80Djso53UtEmSKZqRSBsXH
 cCHlqwShwov5L7sl6kQz5a9skY8LJPJAWxAUz5kSkHobGdmQpSwO/DPqryh9SY+1D08GKVoA0Va
 4Qyjxw9CWe2EsjHfF6nShg7ufvS5hALVhw5cG68jOhIypW/DNnUvUFjaKaZHYRUjTOaj4RDJA/+
 4o5mqV1FkNGcSh7fJArppllho7Uu3f7UlO+xL6eS0Hw6+09lsqR4xuFCsGetegggREG3S3LpYNa
 hhQu9xkgAvCbyI1a9dlZJCIoNHZyaafvRpaOqqBVlIofwEXPnKJaRSgylHtC4rAKtH3Le8lcP4f
 RJP5G5VN4mTwd/kfGHccEEviE+OBdGyD6GZAh+fJQz0Yo3F9IVeRGW+S3+zlfZOhZmCFFAzkIk1
 y5X3DK27ZQ6o+Na+sLw3htKtxW/Yixy4Np1IPAVsB5W5qA8U7s8UfXksSIRXcUYGGSb7gtsqkeS
 vDsqBg+WiFThnjxvJAsJuOZyRBJ/CyTaQeJFTXwVk6HoRjFQyhpz3yM2VX4E/kIulcaZqI+Tzt1
 8YasD0mMn5Z06Mw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When looking for something else in LKFT reports [1], I noticed that the
TC selftest ended with a timeout error:

  not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds

I also noticed most of the tests were skipped because the "teardown
stage" did not complete successfully. It was due to missing kconfig.

These patches fix these two errors plus an extra one because this
selftest reads info from "/proc/net/nf_conntrack". Thank you Pedro for
having helped me fixing these issues [2].

Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (3):
      selftests: tc: set timeout to 15 minutes
      selftests: tc: add 'ct' action kconfig dep
      selftests: tc: add ConnTrack procfs kconfig

 tools/testing/selftests/tc-testing/config   | 2 ++
 tools/testing/selftests/tc-testing/settings | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: 9d23aac8a85f69239e585c8656c6fdb21be65695
change-id: 20230713-tc-selftests-lkft-363e4590f105

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

