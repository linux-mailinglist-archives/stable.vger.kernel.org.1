Return-Path: <stable+bounces-102181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99929EF137
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC80172846
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D8C22E9FB;
	Thu, 12 Dec 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJnLOik9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6C22E9F8;
	Thu, 12 Dec 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020279; cv=none; b=eZ2nKqJKA8C6y+raO5MUcYu6hzIy6rxA2gehF8LgUYhPkkr237bvInHWfIfsGU23YwHTWb+f7rbreWJptZinegHUNF3RLYBkhuAnsvMwTmb0lXQ2hCneC40sKtnRQsvT/y+AfiitUSFRVeIrTCPG18Mn3Bn5bGw15BrtGWlCeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020279; c=relaxed/simple;
	bh=y1mibXLxghWxy0wKA+mqT6/WmohTJJtfBKylaMtZdEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EofrbjlsIMAjEvJkJxFBnG++NJ2kG15UPShg5kErtfWWA/Mp7LMGakTqfeeuZcnqPZwXEkGVAE5s12LqHzOq9GGdni2NQLXpKrC/p5D8JkOuguYiHfokLMZA0yjBpZQ8dYVNJ5eLlHmbpov45lfIC6Sc7Kbg0ja9nDhd0FS1Y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJnLOik9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AEDC4CECE;
	Thu, 12 Dec 2024 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020279;
	bh=y1mibXLxghWxy0wKA+mqT6/WmohTJJtfBKylaMtZdEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJnLOik9oUDCA6WKMzKGhneHQqB0tbxfrIdQFl9onYhbbS4HWRdsjngpXd7k6MZfB
	 eHs4u6xZqIhQPCWuhq3sKd+odewhQtJCIDcg5zntRaRQwn0Iy5BYhyjr3GwmKwYsO8
	 NXU0dFyJMfKl8ZwjqFTY/MR7pkwONkUK81IwpK4Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 395/772] parisc/ftrace: Fix function graph tracing disablement
Date: Thu, 12 Dec 2024 15:55:40 +0100
Message-ID: <20241212144406.237022408@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit a5f05a138a8cac035bf9da9b6ed0e532bc7942c8 upstream.

Due to an apparent copy-paste bug, the parisc implementation of
ftrace_disable_ftrace_graph_caller() doesn't actually do anything.
It enables the (already-enabled) static key rather than disabling it.

The result is that after function graph tracing has been "disabled", any
subsequent (non-graph) function tracing will inadvertently also enable
the slow fgraph return address hijacking.

Fixes: 98f2926171ae ("parisc/ftrace: use static key to enable/disable function graph tracer")
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/ftrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -87,7 +87,7 @@ int ftrace_enable_ftrace_graph_caller(vo
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	static_key_enable(&ftrace_graph_enable.key);
+	static_key_disable(&ftrace_graph_enable.key);
 	return 0;
 }
 #endif



