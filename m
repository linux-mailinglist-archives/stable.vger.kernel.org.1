Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470779BF79
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbjIKVse (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbjIKOQS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:16:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37645DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:16:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D282C433C8;
        Mon, 11 Sep 2023 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441773;
        bh=efHZC7FAh0T4gjRFu9engcza660I0CF8HEuTO/LVPvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzezzXEq/moq1PCaSBmfD5maVAw7sumAX5TzUA+FRns5lPpsKdoGmqZbdcQlZ+1Ss
         y7WVDBfMPQ2Nwkm2KIY6QNtG3FgDRxAjp/S21GWMg+IffJ1qhQHndcsXLmAnnVf0dA
         HJczcMyo5Blko1HW7Q6udur3sBWJ3tpqWTbb/hbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 532/739] docs: ABI: fix spelling/grammar in SBEFIFO timeout interface
Date:   Mon, 11 Sep 2023 15:45:31 +0200
Message-ID: <20230911134705.967119962@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 2cd9ec2a51474d4c0b4d2a061f2de7da34eff476 ]

Correct spelling problems as identified by codespell.
Correct one grammar error.

Fixes: 9a93de620e0a ("docs: ABI: testing: Document the SBEFIFO timeout interface")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eddie James <eajames@linux.ibm.com>
Cc: Joel Stanley <joel@jms.id.au>
Link: https://lore.kernel.org/r/20230710052305.29611-1-rdunlap@infradead.org
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo b/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
index 531fe9d6b40aa..c7393b4dd2d88 100644
--- a/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
+++ b/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
@@ -5,6 +5,6 @@ Description:
 		Indicates whether or not this SBE device has experienced a
 		timeout; i.e. the SBE did not respond within the time allotted
 		by the driver. A value of 1 indicates that a timeout has
-		ocurred and no transfers have completed since the timeout. A
-		value of 0 indicates that no timeout has ocurred, or if one
-		has, more recent transfers have completed successful.
+		occurred and no transfers have completed since the timeout. A
+		value of 0 indicates that no timeout has occurred, or if one
+		has, more recent transfers have completed successfully.
-- 
2.40.1



