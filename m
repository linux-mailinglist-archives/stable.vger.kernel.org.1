Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C694F7B6E3B
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjJCQSg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjJCQSg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 12:18:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DCBA9E
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 09:18:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 866C9C15
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 09:19:11 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.93.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A1513F762
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 09:18:32 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:18:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     stable@vger.kernel.org
Subject: v6.5 backport request: 6d2779ecaeb56f92 ("locking/atomic: scripts:
 fix fallback ifdeffery")
Message-ID: <ZRw-0snchQiF5shv@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Could we please backport commit:

  6d2779ecaeb56f92d7105c56772346c71c88c278
  ("locking/atomic: scripts: fix fallback ifdeffery")

... to the 6.5.y stable tree?

I forgot to Cc stable when I submitted the original patch, and had (mistakenly)
assumed that the Fixes tag was sufficient.

The patch fixes a dentry cache corruption issue observed on arm64 and which is
in theory possible on other architectures. I've recevied an off-list report
from someone who's hit the issue on the v6.5.y tree specifically.

Thanks,
Mark
