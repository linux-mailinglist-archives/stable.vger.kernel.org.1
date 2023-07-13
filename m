Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FFF752919
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjGMQuD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 12:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjGMQuB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 12:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D3D2D59
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689266944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pZlL8jMpyOjdrZANlyHGPPGFAx27pk+4T5C748Xc53A=;
        b=T/lK5B+Dq+cH0wox7FKDSzb4tsRr7S/kT4ieaIIOqGxvAhi7AgYx8Jdm/0dx7UfmXbbCVX
        l8198bhzcnGvqAuBGvf68XD/uYAd5jXjBkUtGys1tQMYwBhZa/B9fqS+L+LSSVX2/6rOlV
        yC7SY0Z4nMMQS8MnZJTv3z3cbTFNpMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-vJsMivmyO-GFD_-bCRuVJg-1; Thu, 13 Jul 2023 12:49:02 -0400
X-MC-Unique: vJsMivmyO-GFD_-bCRuVJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D2A287322F
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 16:49:02 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A3592166B26;
        Thu, 13 Jul 2023 16:49:01 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org, agruenba@redhat.com
Subject: [PATCHv2 v6.5-rc1 0/3] fs: dlm: workarounds and cancellation
Date:   Thu, 13 Jul 2023 12:48:35 -0400
Message-Id: <20230713164838.3583052-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

This patch-series trying to avoid issues when plock ops with
DLM_PLOCK_FL_CLOSE flag is set sends a reply back which should never be
the case. This problem getting more serious when introducing a new plock
op and an answer was not expected as 

I changed in v2 to check on DLM_PLOCK_FL_CLOSE flag for stable as this
can also being used to fix the potential issue for older kernels and it
does not change the UAPI. For newer user space applications the new flag
DLM_PLOCK_FL_NO_REPLY will tell the user space application to never send
an result back, it will handle this filter earlier in user space. For
older user space software we will filter the result in ther kernel.

This requires the behaviour that the flags are the same for the request
and the reply which is the case for dlm_controld.

Also fix the wrapped string and don't spam the user ignoring replies.

- Alex

Alexander Aring (3):
  fs: dlm: ignore DLM_PLOCK_FL_CLOSE flag results
  fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY flag
  fs: dlm: allow to F_SETLKW getting interrupted

 fs/dlm/plock.c                 | 107 ++++++++++++++++++++++++---------
 include/uapi/linux/dlm_plock.h |   2 +
 2 files changed, 81 insertions(+), 28 deletions(-)

-- 
2.31.1

