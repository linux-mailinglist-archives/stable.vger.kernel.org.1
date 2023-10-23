Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BA7D365C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjJWMWf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJWMWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 08:22:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C91AEFF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 05:22:31 -0700 (PDT)
Received: from pwmachine.numericable.fr (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4D4C120B74C0;
        Mon, 23 Oct 2023 05:22:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D4C120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698063751;
        bh=jvhMnzauQhN8ozyF/JUc7qDeB01x6+nMb5LSr1uGfMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHihdjmHoRKQI46K0naK9QePkIU7DF/onExCziIE7cK0gwIUCCYXddaYTfhRB6kMS
         vZmsMNZf3tnG1sSa4z0HAlAicLRdCZNyJqz4+QjFyR+9LU9TP0LyJe1+pq06GXvJTa
         wQ4QRWw/ZmVlpxYogy2m/A/YpMGSDwSSDWOcxlYQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH 5.15.y 0/1] Return EADDRNOTAVAIL when func matches several symbols
Date:   Mon, 23 Oct 2023 15:22:16 +0300
Message-Id: <20231023122217.302483-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102127-unbeaten-sandlot-da45@gregkh>
References: <2023102127-unbeaten-sandlot-da45@gregkh>
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

Hi!


Applying the upstream patch leaded to compilation error regarding
kallsyms_on_each_match_symbol().
So, I adapted the patch to use kallsyms_on_each_symbol() instead:
root@vm-amd64:~# uname -a
Linux vm-amd64 5.15.136+ #126 SMP Mon Oct 23 15:18:02 EEST 2023 x86_64 GNU/Linux
root@vm-amd64:~# echo 'p:probe/name_show name_show' > /sys/kernel/tracing/kprobe_events
bash: echo: write error: Cannot assign requested address

As I modified the patch, I would like to get some reviews before it lands in
stable.

Francis Laniel (1):
  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
    symbols

 kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  1 +
 2 files changed, 75 insertions(+)


Best regards and thank you in advance.
--
2.34.1

