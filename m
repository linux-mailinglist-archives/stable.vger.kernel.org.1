Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C875CCFE
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjGUQCj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGUQCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:02:23 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2323A90;
        Fri, 21 Jul 2023 09:02:16 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b8a462e0b0so13399065ad.3;
        Fri, 21 Jul 2023 09:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955336; x=1690560136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyAlTrXUN+hI+1p5Q65ZUZ9TvfaGx2yL/aNs/62Y+S8=;
        b=VsyDJtBVVf8M6+oKkRXevXwgk0DSTTowOpz7Nd1HQ8qy+GgGSRqNdcfugOdNeNgMnt
         fFir+txJB7nFcp6ZXv+1t9Z6imbuOtxM6OlnkgplIBmpw1FlraDeYOfWyn7Yw9XPyBbK
         m7QVjF3eNOexmYMN3umSU/upGhyMbmL21y1C+k1XW+VOarrfoqsvWwtkGcMZU6xAH/Id
         AuadLp91YZoZDY3TYO37mJFSLVGDBSsu5xGER+IrOW2ziEP7JJXo8oXL+gOB6hMZ+vji
         ZEUPpZqacv6+zlzKZ6Dw3FaM3krspcqSwXJRiJLTxMvkBmcUQ1cjiru/N3kxT1EN5bA1
         FBBg==
X-Gm-Message-State: ABy/qLa2jXYlI8UXoAHfi+tBROu9cLeQkTZ4l1oJshvTDd6meH6amUYS
        kYyW1IzQEF89H4KtlEnTyRI=
X-Google-Smtp-Source: APBJJlHODPzNU/VamsP21G56Ht8TKok12UYA9F2N0pHodabwqW+/xlg4SiSl6pqamACm87q8TlqRzw==
X-Received: by 2002:a17:902:ce84:b0:1b8:6b17:9093 with SMTP id f4-20020a170902ce8400b001b86b179093mr2002048plg.1.1689955336125;
        Fri, 21 Jul 2023 09:02:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5043:9124:70cb:43f9])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902a51800b001b890b3bbb1sm3652298plq.211.2023.07.21.09.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:02:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>,
        stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.g.garry@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 1/3] scsi: core: Fix the scsi_set_resid() documentation
Date:   Fri, 21 Jul 2023 09:01:32 -0700
Message-ID: <20230721160154.874010-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721160154.874010-1-bvanassche@acm.org>
References: <20230721160154.874010-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Because scsi_finish_command() subtracts the residual from the buffer
length, residual overflows must not be reported. Reflect this in the
SCSI documentation. See also commit 9237f04e12cc ("scsi: core: Fix
scsi_get/set_resid() interface")

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/scsi/scsi_mid_low_api.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 6fa3a6279501..022198c51350 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -1190,11 +1190,11 @@ Members of interest:
 		 - pointer to scsi_device object that this command is
                    associated with.
     resid
-		 - an LLD should set this signed integer to the requested
+		 - an LLD should set this unsigned integer to the requested
                    transfer length (i.e. 'request_bufflen') less the number
                    of bytes that are actually transferred. 'resid' is
                    preset to 0 so an LLD can ignore it if it cannot detect
-                   underruns (overruns should be rare). If possible an LLD
+                   underruns (overruns should not be reported). An LLD
                    should set 'resid' prior to invoking 'done'. The most
                    interesting case is data transfers from a SCSI target
                    device (e.g. READs) that underrun.
