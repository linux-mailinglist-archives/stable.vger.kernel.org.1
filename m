Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6835B7A388A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbjIQThG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbjIQTgp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:36:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038C13E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:36:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5311DC433CA;
        Sun, 17 Sep 2023 19:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979399;
        bh=OEGEfyV9bZ4fW6jS3S8Mry9xdjkyIvPismTsn1dYOR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSrpmKqLLoGgWw1e6iiWmszSILq1w0/27JLqCl2jpGNZESL87gYz0m3/LCazry2Mv
         36Q0lhvV2ZBpN2WxbV+KHVJfs57sBR5WNwobn2j/F/GeQs9FkKvaC0swXYVoc/hXgj
         /3qbVmskQUntV10xjYFf0UBNbrOtI7g20a1xDbsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5.10 301/406] s390/ipl: add missing secure/has_secure file to ipl type unknown
Date:   Sun, 17 Sep 2023 21:12:35 +0200
Message-ID: <20230917191109.259306853@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Schnelle <svens@linux.ibm.com>

commit ea5717cb13468323a7c3dd394748301802991f39 upstream.

OS installers are relying on /sys/firmware/ipl/has_secure to be
present on machines supporting secure boot. This file is present
for all IPL types, but not the unknown type, which prevents a secure
installation when an LPAR is booted in HMC via FTP(s), because
this is an unknown IPL type in linux. While at it, also add the secure
file.

Fixes: c9896acc7851 ("s390/ipl: Provide has_secure sysfs attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/ipl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -501,6 +501,8 @@ static struct attribute_group ipl_ccw_at
 
 static struct attribute *ipl_unknown_attrs[] = {
 	&sys_ipl_type_attr.attr,
+	&sys_ipl_secure_attr.attr,
+	&sys_ipl_has_secure_attr.attr,
 	NULL,
 };
 


