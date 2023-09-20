Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324317A804A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjITMgQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjITMgP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:36:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E98BC6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:36:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD4C433C7;
        Wed, 20 Sep 2023 12:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213362;
        bh=A8rYscBv4DYUMl33nppNuvghlqpObWi+HaptaZDPs94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcqdYTOnH4wyEYxNucIf6npOjVKruP2xUZEBXzol2UdBD8qJP+k6PSzbGfzL8cyke
         75uGfxroaouL4i2cLFSMB2jM32Kb97AF34z5hfMLrvc5CyZhvi5kFmPrDxmLj3rGx2
         dzP6QXxMtg5jgtfv9LHh8LWCVqRs37uTi0Qa74XY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Battersby <tonyb@cybernetics.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 184/367] scsi: core: Use 32-bit hostnum in scsi_host_lookup()
Date:   Wed, 20 Sep 2023 13:29:21 +0200
Message-ID: <20230920112903.395343332@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Battersby <tonyb@cybernetics.com>

[ Upstream commit 62ec2092095b678ff89ce4ba51c2938cd1e8e630 ]

Change scsi_host_lookup() hostnum argument type from unsigned short to
unsigned int to match the type used everywhere else.

Fixes: 6d49f63b415c ("[SCSI] Make host_no an unsigned int")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Link: https://lore.kernel.org/r/a02497e7-c12b-ef15-47fc-3f0a0b00ffce@cybernetics.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hosts.c     | 4 ++--
 include/scsi/scsi_host.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index b97e046c6a6e1..a8ae573294e57 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -518,7 +518,7 @@ EXPORT_SYMBOL(scsi_host_alloc);
 static int __scsi_host_match(struct device *dev, const void *data)
 {
 	struct Scsi_Host *p;
-	const unsigned short *hostnum = data;
+	const unsigned int *hostnum = data;
 
 	p = class_to_shost(dev);
 	return p->host_no == *hostnum;
@@ -535,7 +535,7 @@ static int __scsi_host_match(struct device *dev, const void *data)
  *	that scsi_host_get() took. The put_device() below dropped
  *	the reference from class_find_device().
  **/
-struct Scsi_Host *scsi_host_lookup(unsigned short hostnum)
+struct Scsi_Host *scsi_host_lookup(unsigned int hostnum)
 {
 	struct device *cdev;
 	struct Scsi_Host *shost = NULL;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 31e0d6ca1ebaa..4488c3468c6de 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -744,7 +744,7 @@ extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern int scsi_host_busy(struct Scsi_Host *shost);
 extern void scsi_host_put(struct Scsi_Host *t);
-extern struct Scsi_Host *scsi_host_lookup(unsigned short);
+extern struct Scsi_Host *scsi_host_lookup(unsigned int hostnum);
 extern const char *scsi_host_state_name(enum scsi_host_state);
 
 static inline int __must_check scsi_add_host(struct Scsi_Host *host,
-- 
2.40.1



