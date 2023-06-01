Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF855719DD3
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjFAN0u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjFAN0l (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEAC19D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55EB6644AB
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752DCC4339B;
        Thu,  1 Jun 2023 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625977;
        bh=fplDzVp6B3/ORRrKudlbN0BsEAEHoivu2HIEGJvfbaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LU4TZxJGj7WYA7uANWYXvQxYwJ6nuzotT+Ud4GOfPPwhb6C0WB5KycQeqN4Jes8aQ
         CKQALuhKT50+MWTFLvciXEgMtsk2r+QhTjZ9t9Xy81TOUn8TmLwErUieiAA8Nnan0t
         iX3SNvBlpLsvKEY8VY+NtXLgOJ39ew7ZuLANsGjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Richter <rrichter@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 19/45] cxl/port: Fix NULL pointer access in devm_cxl_add_port()
Date:   Thu,  1 Jun 2023 14:21:15 +0100
Message-Id: <20230601131939.595852162@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

[ Upstream commit a70fc4ed20a6118837b0aecbbf789074935f473b ]

In devm_cxl_add_port() the port creation may fail and its associated
pointer does not contain a valid address. During error message
generation this invalid port address is used. Fix that wrong address
access.

Fixes: f3cd264c4ec1 ("cxl: Unify debug messages when calling devm_cxl_add_port()")
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20230519215436.3394532-1-rrichter@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/port.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4d1f9c5b5029a..27cbf457416d2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -751,11 +751,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 
 	parent_port = parent_dport ? parent_dport->port : NULL;
 	if (IS_ERR(port)) {
-		dev_dbg(uport, "Failed to add %s%s%s%s: %ld\n",
-			dev_name(&port->dev),
-			parent_port ? " to " : "",
+		dev_dbg(uport, "Failed to add%s%s%s: %ld\n",
+			parent_port ? " port to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
-			parent_port ? "" : " (root port)",
+			parent_port ? "" : " root port",
 			PTR_ERR(port));
 	} else {
 		dev_dbg(uport, "%s added%s%s%s\n",
-- 
2.39.2



