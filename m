Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3B7D341D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjJWLgz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjJWLgy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:36:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1863B102
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:36:49 -0700 (PDT)
Received: from pwmachine.numericable.fr (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B4EC20B74C0;
        Mon, 23 Oct 2023 04:36:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B4EC20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698061007;
        bh=BxMBhLCpyH7Uitm6mHIegkVB9Nty6KBveTUC2RPQbUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhdeALWdHlmqzBfJjkDAbxrTeWQl4atabm5Rdi9APy4le87iJnjtRj370BDO7EVe2
         qwlM4As3s1EOqrC8zewwzxncFXRD2X62Xl+RotU9Ti/x+mYzNdQoV+kzMdpT6A+ccU
         Z2gEA/w1cUtXVZQEnbEaGbkWVMtOnG4U8SjtoYg8=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH 5.4.y 0/1] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Mon, 23 Oct 2023 14:36:22 +0300
Message-Id: <20231023113623.36423-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102137-mobster-sheath-bfb3@gregkh>
References: <2023102137-mobster-sheath-bfb3@gregkh>
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

Hi.


There was problem to apply upstream patch on kernel 5.4.

I adapted the patch and came up with the attached one, it was tested and
validated:
root@vm-amd64:~# uname -a
Linux vm-amd64 5.4.258+ #121 SMP Mon Oct 23 14:22:43 EEST 2023 x86_64 GNU/Linux
root@vm-amd64:~# echo 'p:probe/name_show name_show' > /sys/kernel/tracing/kprobe_events
bash: echo: write error: Cannot assign requested address

As I had to modify the patch, I would like to get reviews before getting it
merged in stable.

Francis Laniel (1):
  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
    symbols

 kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  1 +
 2 files changed, 75 insertions(+)


Best regards and thank you in advance.
--
2.34.1

