Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898AC7BAA37
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 21:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJETfb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJETfb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 15:35:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 981A298
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 12:35:27 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.224])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2BAC820B74C0
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 12:35:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BAC820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696534527;
        bh=ZlKClPuRPeslRgevarPFcenPGtQmv0YFKmI5WLHNnIg=;
        h=From:To:Subject:Date:From;
        b=QGfkCmyERBzF05ZWUba9N6v1lKERziksIdAM4wEY+6OJwRtQbrPUC83wATR2me0zn
         ibmmeyVbZ/FZNEZdmh8kv9Z7fG69cbZugKl5JK9YWbMAmABXoanBdgkaI4FQg9JBWy
         ORpVepsFjQUkh19BBTmUIY6qQ+BzHPRXXa1gVvJM=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Subject: [PATCH 5.15 0/2] ARM SMMUv3 errata fixes
Date:   Thu,  5 Oct 2023 19:35:18 +0000
Message-Id: <20231005193520.657277-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

An errata fix, and a fix for it

Robin Murphy (2):
  iommu/arm-smmu-v3: Set TTL invalidation hint better
  iommu/arm-smmu-v3: Avoid constructing invalid range commands

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.34.1

