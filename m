Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5875D47F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjGUTVu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjGUTVt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4B1BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97D5D61D5F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA070C433C7;
        Fri, 21 Jul 2023 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967307;
        bh=eCsDnf1oQhVzWVgJLDqVu4WT5qNqn9sFUv95P53tH7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxYPNA4c0a9fYRHxgGZfMVyXFFGyiQnwjgCt88SX2u+h82j66ZJMxivr8edJcJjgt
         /tFUEBCs9LDZGYDf+oY74mwllpDiI6c8v7GLWehNAF/9LkfGbU2ECmlKcC/4UUF0aB
         coQF1WiTfWPu08IKaEUrx3kw2kTvaJw9k9hhbi4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 117/223] scsi: mpi3mr: Propagate sense data for admin queue SCSI I/O
Date:   Fri, 21 Jul 2023 18:06:10 +0200
Message-ID: <20230721160525.865489452@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sathya Prakash <sathya.prakash@broadcom.com>

commit f762326b2baa86ae647e2ba6832bc87e238f68ad upstream.

Copy the sense data to internal driver buffer when the firmware completes
any SCSI I/O command sent through admin queue with sense data for further
use.

Fixes: 506bc1a0d6ba ("scsi: mpi3mr: Add support for MPT commands")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Link: https://lore.kernel.org/r/20230531184025.3803-1-sumit.saxena@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -402,6 +402,11 @@ static void mpi3mr_process_admin_reply_d
 				memcpy((u8 *)cmdptr->reply, (u8 *)def_reply,
 				    mrioc->reply_sz);
 			}
+			if (sense_buf && cmdptr->sensebuf) {
+				cmdptr->is_sense = 1;
+				memcpy(cmdptr->sensebuf, sense_buf,
+				       MPI3MR_SENSE_BUF_SZ);
+			}
 			if (cmdptr->is_waiting) {
 				complete(&cmdptr->done);
 				cmdptr->is_waiting = 0;


