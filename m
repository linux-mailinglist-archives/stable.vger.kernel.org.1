Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C26739EAC
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjFVKkP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFVKkN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 06:40:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04039173F
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:40:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3112d202363so5401943f8f.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687430410; x=1690022410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6D+RaaKkVmDI7AoZSGeNcMmUzXkeJD5fqRbSxvwWzQ=;
        b=AiL4YFDN1dy6bi2eOGWAW8fajSEIalPxK4GJsr3BgKflD0SdZG8wYWo6UP09SayhrL
         QVctuWCVs+EFj3UyYrPIjzFHk6WDNazrb2iNB9KhOF+OpKSDzr/Wy+ScI0nWNnijmqUc
         B8bQSfXs8N36apMjzv1earzW8BDTjMnitGh00dwVk3c/WVmSDxsViE6NccQ4on9FnzRP
         R3p1OTWqnoQXrJdd+AXCpUbGPsgU6B+//7W47+AeUSUt16O2RTmmPqjqm3HvPif/EeAD
         N9/uUPDDKttpTOR/Q0WtW/KPSmpNifGJjY/qI0SRq60izL2ysHntQq1AB5IF42KKEONE
         aMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687430410; x=1690022410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6D+RaaKkVmDI7AoZSGeNcMmUzXkeJD5fqRbSxvwWzQ=;
        b=AUUmw/nonONcHtL02+I4TStea0XlMZVSmuS1nnfcolyulKYrjHzdMtJR/8GJdVwonF
         iEeY34710WceTvN8sjiMU6kQ1uOB5OW5YvR5tBxvJf0Co0rAOOxn9vf+4jkvKvdVvGae
         vr2ulIw2IsbNM3KbBs2dQFJeDQY1cZX9eTBaoKk9Bll9G1zRIOrpW5ncljVAf8FuFY04
         0l/oKc0dbeUitszSSZZSYrws53aNmAlL9r4cJ+lgf3bR6aaRvQvgRNo3yf+Ksv8i9Lvi
         l4ljI6EmnySskuPqbN9nkK7h1ZYuv2bCnI53mv6EZw1mAvrfMJAwXei2f4ch05TopziY
         ucrQ==
X-Gm-Message-State: AC+VfDyyKMsoNF8C6btdluzWLwzJj6aNuwMRo7OwNEXntOOzmhLXyA/8
        Osr+0EWZCUogD/FJH2ln54BjTjP2Bp0XzKpcszlisdME
X-Google-Smtp-Source: ACHHUZ5agMZ7p3rVL9n47mGBb9Y4hsbThLroMa6cSp8tpbP/8E3G54tCeN6wn8WrXObmfsdsR/qUgA==
X-Received: by 2002:adf:f845:0:b0:311:108f:16cb with SMTP id d5-20020adff845000000b00311108f16cbmr13238011wrq.1.1687430410039;
        Thu, 22 Jun 2023 03:40:10 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d5442000000b0030789698eebsm6784183wrv.89.2023.06.22.03.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:40:09 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: skip fail tests if not supported
Date:   Thu, 22 Jun 2023 12:40:01 +0200
Message-Id: <20230622104001.2952219-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062254-neglector-upbeat-10ca@gregkh>
References: <2023062254-neglector-upbeat-10ca@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=S0wVwkN3IPMnBvYaUU0H5OAk/epEtQFCGb9f700HhYY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklCUBzg2TChWWlh58oWdh/A5bXHd/zv3jolMTd
 +uQZlCAc3uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJQlAQAKCRD2t4JPQmmg
 c7RmD/457EddaR9vy1b/dOdEDvvb9Ep779lRK0loo6wokSAg2LbSzoc80IWSWZJQSYXsnnsd2fj
 ysw3UEhAXPPAt6U4uu6Lqz6BskjqdIqdlUEBZ0u7EVQ9H/fAWt4neIMwY+yi6Acz+pCe0PTG5TC
 DUycC+b340TPR3M1Or+tX/K22tlFMxWGWbjFI6dMxC4IzMwnwfmMs82aqxcK5S77P6KEr4Fzrok
 KImhr93FJlRCgKGUfuzyCeNWsUZ3NeSGdtcp7szlZQ2To1bylvMEc2skmDGEjqLC8FzsKtfiQ8H
 FuW3e07wJit8j9r1Og94xp67ddYiMd/YX/XXsyGG7C1s00yfmteZOd1vCY7lQEH468mlUZjAVCb
 D2sHLD5cjwupDVLWiiBsX5HjdyNaTN6PEFMZQWDqW+x4hxHkvTxL/+xbumcuX+RYLeJC9+H9W7L
 KqAA5or6O+e3NP7RpVyR9cF+yfEj02ToePNpuORzzo7TfMUATT3EAUEDY/jcNV9/FRgyuPZdpEk
 o812tBm3BmrNctvImHhYA2a3b5vvC2Mk+We91Ch/OjqTWE6R+5tZ4BFm1DIFKtmx6fLKzgN4fCT
 heBQxz/ThWfc7irsZ0vJHGO+kL7NExNwG+mfjj4EJjOsCcFT6i/TwZHhThrq9unxt9okgs6KsnS J0Y24efjIZf5CSw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit ff8897b5189495b47895ca247b860a29dc04b36b upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the MP_FAIL / infinite mapping introduced
by commit 1e39e5a32ad7 ("mptcp: infinite mapping sending") and the
following ones.

It is possible to look for one of the infinite mapping counters to know
in advance if the this feature is available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Cc: stable@vger.kernel.org
Fixes: 2ba18161d407 ("selftests: mptcp: add MP_FAIL reset testcase")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1")
and on top of "selftests: mptcp: join: skip test if iptables/tc cmds fail"
patch sent just before. After having applied this previous patch, there
is no more conflicts.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1ad7de52e1a9..2a238ae842d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -376,7 +376,7 @@ setup_fail_rules()
 
 reset_with_fail()
 {
-	reset "${1}" || return 1
+	reset_check_counter "${1}" "MPTcpExtInfiniteMapTx" || return 1
 	shift
 
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
-- 
2.40.1

