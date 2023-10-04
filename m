Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29E7B89CD
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJDS3a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjJDS33 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27EFD7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:29:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CD0C433C8;
        Wed,  4 Oct 2023 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444165;
        bh=dLCh2yCMAJuO2uWN+TQk2HE9DmuaQJk2Xmm470CJ1EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCuP823Tx28n2qyhToT4nAHUx/2QcOy6zsy38aQVQBSPKCtZF+782uagmjjcQfCRk
         ZRCVaRFZzlN2zyhj9y+yIsILiwFP83g+KqxYxr8yKFeZfnCFZVgtiJjUTT/3VFXRZu
         2t5VRfan0vmoihee1BIaT+ZGAGwDPhRGvEx7bWhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 124/321] firmware: arm_scmi: Fixup perf power-cost/microwatt support
Date:   Wed,  4 Oct 2023 19:54:29 +0200
Message-ID: <20231004175234.983273048@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sibi Sankar <quic_sibis@quicinc.com>

[ Upstream commit c3638b851bc1ca0022dca9d6ca4beaa6ef03a216 ]

The perf power scale value would currently be reported as bogowatts if the
platform firmware supports microwatt power scale and meets the perf major
version requirements. Fix this by populating version information in the
driver private data before the call to protocol attributes is made.

CC: Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
Fixes: 3630cd8130ce ("firmware: arm_scmi: Add SCMI v3.1 perf power-cost in microwatts")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20230811204818.30928-1-quic_sibis@quicinc.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 43dd242ecc49c..431bda9165c3d 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -858,6 +858,8 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo)
 		return -ENOMEM;
 
+	pinfo->version = version;
+
 	ret = scmi_perf_attributes_get(ph, pinfo);
 	if (ret)
 		return ret;
@@ -877,8 +879,6 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 			scmi_perf_domain_init_fc(ph, domain, &dom->fc_info);
 	}
 
-	pinfo->version = version;
-
 	return ph->set_priv(ph, pinfo);
 }
 
-- 
2.40.1



