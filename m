Return-Path: <stable+bounces-1810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A977F8177
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D143A2826DC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93A364A6;
	Fri, 24 Nov 2023 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1s7YMmD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCF2EAEA;
	Fri, 24 Nov 2023 18:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4D8C433C7;
	Fri, 24 Nov 2023 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852327;
	bh=2uu3K+oojQsp9b1RhEkInY720ZVq+eAOL0WZcJKwq9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1s7YMmD7Sb7J3O3rvUfGiTD45Full+gXh7/HSx66h3FnBuxgh2mjIMH5iY7NEraPf
	 sp/TgCfApKz8PS5DTPz42cXPiE4AFYS4FsZ17dUFmA86lC7gGojWo/N0ejKl2X6ulD
	 CFuGoJvr+tC9zuj7rw5wIAM9yNYpWBZBdgP1njEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Duyck <alexanderduyck@fb.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 312/372] net: ethtool: Fix documentation of ethtool_sprintf()
Date: Fri, 24 Nov 2023 17:51:39 +0000
Message-ID: <20231124172020.801477287@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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
@@ -836,10 +836,10 @@ int ethtool_get_phc_vclocks(struct net_d
 
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



