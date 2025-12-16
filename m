Return-Path: <stable+bounces-202622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7725CC307D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BAA312437D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3935CBC3;
	Tue, 16 Dec 2025 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ie5N59Mg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A0344035;
	Tue, 16 Dec 2025 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888499; cv=none; b=ckK8QkuCP1YfLUaQvA+H93ml+rgM0XY/BB1B95aQ/H/toMIHqPjTO6D2iHTV5jDgfdlXuIOC2S2oWEeA6vntdJy7xNt+Kt48sIA3uPrsRI6SRrj3ckuNnXFxxQMaRZarfEicHav567BfxNmkEvuJmoK5SWeoVycnsoksJOTza0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888499; c=relaxed/simple;
	bh=lxffcEVdSO7Fb0KkOGsAms+pqldJfixo2oSQHohi9fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqIoVkuY80FBm3zNh7irF+nV3v8WwKS4mJGGQpSli6HLFpi4nsPXg7ky7TTofOWrewXGKuA5AZ1gqGISdtCOMmAT7TDfpnLqgWnYCHJzp85a6K/2r9ys3xfpiioTO5cXOHtr3yVp9FV675W2qcoDBbnkadzI5IF82egmT1ZNdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ie5N59Mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FEAC4CEF5;
	Tue, 16 Dec 2025 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888499;
	bh=lxffcEVdSO7Fb0KkOGsAms+pqldJfixo2oSQHohi9fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ie5N59Mg5OLKt6YJK7M0sFtY8mc+ktcRXYwmbhcjxMCrIDUdepCiZkcMUx/I50F7M
	 EeGM35s6ZHqnBT0PNXlwl+Vt4UDQyg4NxNTMJemzqN1uVmw1GNSjTE2nwnV5xxlU54
	 WCO4BL6XdtgV3pRf/9ZFTVMeeIlNF3TDC6jCcENw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 552/614] fs/nls: Fix inconsistency between utf8_to_utf32() and utf32_to_utf8()
Date: Tue, 16 Dec 2025 12:15:19 +0100
Message-ID: <20251216111421.379555252@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit c36f9d7b2869a003a2f7d6ff2c6bac9e62fd7d68 ]

After commit 25524b619029 ("fs/nls: Fix utf16 to utf8 conversion"),
the return values of utf8_to_utf32() and utf32_to_utf8() are
inconsistent when encountering an error: utf8_to_utf32() returns -1,
while utf32_to_utf8() returns errno codes. Fix this inconsistency
by modifying utf8_to_utf32() to return errno codes as well.

Fixes: 25524b619029 ("fs/nls: Fix utf16 to utf8 conversion")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20251129111535.8984-1-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nls/nls_base.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index d434c4463a8f7..a5c3a9f1b8dc5 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -67,19 +67,22 @@ int utf8_to_utf32(const u8 *s, int inlen, unicode_t *pu)
 			l &= t->lmask;
 			if (l < t->lval || l > UNICODE_MAX ||
 					(l & SURROGATE_MASK) == SURROGATE_PAIR)
-				return -1;
+				return -EILSEQ;
+
 			*pu = (unicode_t) l;
 			return nc;
 		}
 		if (inlen <= nc)
-			return -1;
+			return -EOVERFLOW;
+
 		s++;
 		c = (*s ^ 0x80) & 0xFF;
 		if (c & 0xC0)
-			return -1;
+			return -EILSEQ;
+
 		l = (l << 6) | c;
 	}
-	return -1;
+	return -EILSEQ;
 }
 EXPORT_SYMBOL(utf8_to_utf32);
 
-- 
2.51.0




