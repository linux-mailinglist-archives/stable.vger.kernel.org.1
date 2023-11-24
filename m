Return-Path: <stable+bounces-2329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D2F7F83B8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013541C24619
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36783381CC;
	Fri, 24 Nov 2023 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXdBM+F3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51A22EB15;
	Fri, 24 Nov 2023 19:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FA7C433C8;
	Fri, 24 Nov 2023 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853615;
	bh=/SWpbBLXjF3MT4uUx16LEWjiNcaw2sQzknNXZIulvTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXdBM+F3ex1yV3kx6rXc5pniJISkQpt37H18H4HSl1upEoQa1xDAp+y8FSCh7JOEL
	 PKL6f7ZARGhTzgl9x1mh8fc6dD5a1uEGZVUOkJLmLeRwoT6HEyeJDNc9t1GKC/MoDe
	 cuoq5Bh4Sf0E5bUyakmtk5kAJfyuIiMG4ZEBMOFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Duyck <alexanderduyck@fb.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 259/297] net: ethtool: Fix documentation of ethtool_sprintf()
Date: Fri, 24 Nov 2023 17:55:01 +0000
Message-ID: <20231124172009.228083788@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

commit f55d8e60f10909dbc5524e261041e1d28d7d20d8 upstream.

This function takes a pointer to a pointer, unlike sprintf() which is
passed a plain pointer. Fix up the documentation to make this clear.

Fixes: 7888fe53b706 ("ethtool: Add common function for filling out strings")
Cc: Alexander Duyck <alexanderduyck@fb.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/r/20231028192511.100001-1-andrew@lunn.ch
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ethtool.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -781,10 +781,10 @@ int ethtool_get_phc_vclocks(struct net_d
 
 /**
  * ethtool_sprintf - Write formatted string to ethtool string data
- * @data: Pointer to start of string to update
+ * @data: Pointer to a pointer to the start of string to update
  * @fmt: Format of string to write
  *
- * Write formatted string to data. Update data to point at start of
+ * Write formatted string to *data. Update *data to point at start of
  * next string.
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);



