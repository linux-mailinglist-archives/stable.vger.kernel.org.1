Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1678C342
	for <lists+stable@lfdr.de>; Tue, 29 Aug 2023 13:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjH2LXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjH2LXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 07:23:16 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 04:23:08 PDT
Received: from mail.confident.ru (mail.confident.ru [85.114.29.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5010E
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 04:23:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.confident.ru (Postfix) with ESMTP id D04343FC0709;
        Tue, 29 Aug 2023 14:13:33 +0300 (MSK)
X-Virus-Scanned: amavisd-new at mail.confident.ru
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.confident.ru 73D963FC04E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=confident.ru;
        s=54152002-4729-11E9-BD92-62EA33CD6873; t=1693307613;
        bh=h/Prj+t3YJBOgR6jfLlOW3H6BP+VW5rG2WwLrks2i8w=;
        h=From:To:Date:Message-Id;
        b=PJDmK93QGDb1lrVejvEJXfwU89jLXu36w/9V/aVUpWZiWFrYIl/LEVl8XmK4mHPPC
         z+4igMxLDvcJFRzqUFlVKTNU9kWelYAsjRHUEuRKgQqMaqlt5Rl26a23fPqdb3nHBP
         DFANlfB80K7C9lsOznpIDWffAO5PXndQONBH+JRPLMycjOPL2FA10sfTwoXi1XKGvu
         BrZRt/VzyI7+RD5OywoVKVYGA7UeaVIHojih6Jvekx44Ad6ObNJ7GYpLQD+H8pCWsC
         YZsuuJhbrwUYrIoFWpUPKD+cQKbSHOGr2eJCbDGYCAF3VX6cUbq/0DYE7c6iXFY+E8
         2vYWUxnZ0bRcA==
From:   Rand Deeb <deeb.rand@confident.ru>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru,
        Rand Deeb <deeb.rand@confident.ru>
Subject: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Date:   Tue, 29 Aug 2023 14:12:51 +0300
Message-Id: <20230829111251.6190-1-deeb.rand@confident.ru>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In the line 910, the value of m1 may be zero, so there is a possibility
of dividing by zero, we fixed it by checking the values before dividing
(found with SVACE). In the same way, after checking and reading the
function, we found that lines 906, 908, 912 have the same situation, so
we fixed them as well.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <deeb.rand@confident.ru>
---
 drivers/ssb/main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 0a26984acb2c..e0776a16d04d 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -903,13 +903,21 @@ u32 ssb_calc_clock_rate(u32 plltype, u32 n, u32 m)
 		case SSB_CHIPCO_CLK_MC_BYPASS:
 			return clock;
 		case SSB_CHIPCO_CLK_MC_M1:
-			return (clock / m1);
+			if (m1 !=3D 0)
+				return (clock / m1);
+			break;
 		case SSB_CHIPCO_CLK_MC_M1M2:
-			return (clock / (m1 * m2));
+			if ((m1 * m2) !=3D 0)
+				return (clock / (m1 * m2));
+			break;
 		case SSB_CHIPCO_CLK_MC_M1M2M3:
-			return (clock / (m1 * m2 * m3));
+			if ((m1 * m2 * m3) !=3D 0)
+				return (clock / (m1 * m2 * m3));
+			break;
 		case SSB_CHIPCO_CLK_MC_M1M3:
-			return (clock / (m1 * m3));
+			if ((m1 * m3) !=3D 0)
+				return (clock / (m1 * m3));
+			break;
 		}
 		return 0;
 	case SSB_PLLTYPE_2:
--=20
2.34.1

