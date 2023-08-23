Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599E785EFE
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjHWR5V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjHWR5U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 13:57:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6455410C2
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 10:57:19 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.174.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id DEB992126CC0
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 10:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEB992126CC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692813438;
        bh=caGN99EGeeQ+1VnT0tTDMYC4s6HalVuqiyUNufVogq8=;
        h=From:To:Subject:Date:From;
        b=MQ7kZe3Vqp0yMb/C6xZEenO8caMEUEtczAnTaLtTETgJHUD+aBTfWU+dsF/QxCay1
         rD7wGsgNUnKlYOWFYVMnpNVHmOBlLUrXNRkT6dQukxJiCVh5HGYt7MoHSy7etHINAh
         R4sojhsUxBLpLKJ6skA8EZTPD+3/qFG8PJbtEwtU=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Subject: [PATCH 5.15 0/2] Fixup IOMMU list in MAINTAINERS
Date:   Wed, 23 Aug 2023 17:57:04 +0000
Message-Id: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
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

The IOMMU list has moved and emails to the old list bounce. Bring stable
in alignment with mainline.

Joerg Roedel (1):
  MAINTAINERS: Remove iommu@lists.linux-foundation.org

Xiang Chen (1):
  MAINTAINERS: update maintainer list of DMA MAPPING BENCHMARK

 MAINTAINERS | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

-- 
2.25.1

