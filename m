Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16F7B8843
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbjJDSO1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbjJDSO0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02337C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38984C433C7;
        Wed,  4 Oct 2023 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443261;
        bh=nMXXwtOw6IlZrOYR3uqzMCkqLceH7rn9bwk6qjw7Sek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvImaRfQiSjY0KIpXMPDAaSIKktGviU51M/pW4ljdCXKsZNbai8zLe47Suw4Q/V4L
         5kN0j/xPbluIIzpRQYkVNpi6YNkVn7U8/oMSszFUTwnUbeE7SZPKo7rIfSigk8eoas
         EM8mo+ZBDrgrmsQN/NnX9SYE5uMLptqg/MwpNHq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 065/259] platform/x86: intel_scu_ipc: Dont override scu in intel_scu_ipc_dev_simple_command()
Date:   Wed,  4 Oct 2023 19:53:58 +0200
Message-ID: <20231004175220.396621297@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit efce78584e583226e9a1f6cb2fb555d6ff47c3e7 ]

Andy discovered this bug during patch review. The 'scu' argument to this
function shouldn't be overridden by the function itself. It doesn't make
any sense. Looking at the commit history, we see that commit
f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
removed the setting of the scu to ipcdev in other functions, but not
this one. That was an oversight. Remove this line so that we stop
overriding the scu instance that is used by this function.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/r/ZPjdZ3xNmBEBvNiS@smile.fi.intel.com
Cc: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Fixes: f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20230913212723.3055315-4-swboyd@chromium.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index be97cfae4b0f3..dfe010f1ee084 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -444,7 +444,6 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
-	scu = ipcdev;
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
-- 
2.40.1



