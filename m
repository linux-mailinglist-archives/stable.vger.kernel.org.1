Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595947F142F
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjKTNTt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Mon, 20 Nov 2023 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTNTt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 08:19:49 -0500
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79E131
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 05:19:42 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 30.0.50
From:   Sam James <sam@gentoo.org>
To:     gregkh@linuxfoundation.org
Cc:     djakov@kernel.org, konrad.dybcio@linaro.org,
        patches@lists.linux.dev, sashal@kernel.org, stable@vger.kernel.org,
        mgorny@gentoo.org,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>
Subject: Re: [PATCH 5.10 137/191] interconnect: qcom: sc7180: Set ACV
 enable_mask
In-Reply-To: <20231115204652.746475501@linuxfoundation.org>
Date:   Mon, 20 Nov 2023 13:18:14 +0000
Organization: Gentoo
Message-ID: <87fs10k1ee.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch breaks the build for 5.10.201:

/var/tmp/portage/sys-kernel/gentoo-kernel-5.10.201/work/linux-5.10/drivers/interconnect/qcom/sc7180.c:158:10:
error: ‘struct qcom_icc_bcm’ has no member named ‘enable_mask’
158 |         .enable_mask = BIT(3),
    |          ^~~~~~~~~~~
make[4]: ***
[/var/tmp/portage/sys-kernel/gentoo-kernel-5.10.201/work/linux-5.10/scripts/Makefile.build:286:
drivers/interconnect/qcom/sc7180.o] Error 1

Looks like d8630f050d3fd2079f8617dd6c00c6509109c755 ('interconnect:
qcom: Add support for mask-based BCMs') is missing from 5.10.x.

thanks,
sam
