Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE57ECD7B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjKOTgt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjKOTgs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF112C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9538C433CB;
        Wed, 15 Nov 2023 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077005;
        bh=W/cC/sUwkSm6tCDZJrJdFJeIX3brPtNntsGqJhkPfhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZ3TiwqDnqctlyLQN5137CXQ2gfr6TZBdEkCGDt04w7Eef071S5arazPLMX0ZY276
         HyFPlo0octh8FD+lWauminx9CrYFVZc8pASDUf3roGggXJM7HDN51hBKOFixqcrO7B
         jbaVpsh33IT3ba6VjJPbIgHmOWCS3Kqww5xQCO74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 490/550] cpupower: fix reference to nonexistent document
Date:   Wed, 15 Nov 2023 14:17:54 -0500
Message-ID: <20231115191634.838625557@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vegard Nossum <vegard.nossum@oracle.com>

[ Upstream commit 6feb1a9641197ee630bf43b5c34ea1d9f8b4a0aa ]

This file was renamed from .txt to .rst and left a dangling reference.
Fix it.

Fixes: 151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/man/cpupower-powercap-info.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-powercap-info.1 b/tools/power/cpupower/man/cpupower-powercap-info.1
index df3087000efb8..145d6f06fa72d 100644
--- a/tools/power/cpupower/man/cpupower-powercap-info.1
+++ b/tools/power/cpupower/man/cpupower-powercap-info.1
@@ -17,7 +17,7 @@ settings of all cores, see cpupower(1) how to choose specific cores.
 .SH "DOCUMENTATION"
 
 kernel sources:
-Documentation/power/powercap/powercap.txt
+Documentation/power/powercap/powercap.rst
 
 
 .SH "SEE ALSO"
-- 
2.42.0



