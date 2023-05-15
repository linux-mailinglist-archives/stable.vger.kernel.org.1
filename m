Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B5703B29
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbjEOSA0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244937AbjEOR7o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541016E8D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65C0D62307
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58460C433EF;
        Mon, 15 May 2023 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173419;
        bh=+fVUNjXPeKO/Yn37AQ4KTkdEeM7tuGu+wFdR2FaG9vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el7Cl1iKjp6u8r5FUDyAjLEwIWEGB3E+nR8P/SUp6mDVmaF+wbMphtfb1PWwnnoSP
         g6KezLmTSe1yzuIPV1oacgPuWgEmn93OX6mUxehUiZZWKmbicJZWsfPpk53gzD7ypD
         e7FUIblzaMhbpQGLpMoEMQDOw4AqQiD/XbHamEeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 089/282] rtlwifi: Start changing RT_TRACE into rtl_dbg
Date:   Mon, 15 May 2023 18:27:47 +0200
Message-Id: <20230515161724.935111325@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit 78a7245d84300cd616dbce26e6fc42a039a62279 ]

The macro name RT_TRACE makes it seem that it is used for tracing, when
is actually used for debugging. Change the name to RT_DEBUG.

This step creates the new macro while keeping the old RT_TRACE to allow
building. It will be removed at the end of the patch series.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200723204244.24457-2-Larry.Finger@lwfinger.net
Stable-dep-of: 905a9241e4e8 ("wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/debug.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.h b/drivers/net/wireless/realtek/rtlwifi/debug.h
index 69f169d4d4aec..dbfb4d67ca31f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -160,6 +160,10 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 			 const char *titlestring,
 			 const void *hexdata, int hexdatalen);
 
+#define rtl_dbg(rtlpriv, comp, level, fmt, ...)			\
+	_rtl_dbg_trace(rtlpriv, comp, level,				\
+		       fmt, ##__VA_ARGS__)
+
 #define RT_TRACE(rtlpriv, comp, level, fmt, ...)			\
 	_rtl_dbg_trace(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
@@ -176,6 +180,13 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 
 struct rtl_priv;
 
+__printf(4, 5)
+static inline void rtl_dbg(struct rtl_priv *rtlpriv,
+			   u64 comp, int level,
+			   const char *fmt, ...)
+{
+}
+
 __printf(4, 5)
 static inline void RT_TRACE(struct rtl_priv *rtlpriv,
 			    u64 comp, int level,
-- 
2.39.2



