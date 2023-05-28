Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1D4713E6E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjE1Tfe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjE1Tfd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB87ED
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E10E61DF2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA8DC433D2;
        Sun, 28 May 2023 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302521;
        bh=f7t2ldgANhpQoF1Q/P/4/m8ikNgrW8/ejigJltQAi3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ou64YGBqrWSgP+1tu8wtd75N+JW6In14Ca0290QBD36I7pd9+ybxma9p36mlFdV+z
         GTRrTgGN3SXUdIre7qM5Q0HBlZzbZZMPZHYn3T79d/6+B9WiG+iFzk+LhdlE6Z+iHi
         3tR9YGSgY3Mj0QCJtJuTuDViW8Y7wC7Z01aowJl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 036/119] parisc: Enable LOCKDEP support
Date:   Sun, 28 May 2023 20:10:36 +0100
Message-Id: <20230528190836.578361685@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit adf8e96a7ea670d45b5de7594acc67e8f4787ae6 upstream.

Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -129,6 +129,10 @@ config PM
 config STACKTRACE_SUPPORT
 	def_bool y
 
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
 config ISA_DMA_API
 	bool
 


