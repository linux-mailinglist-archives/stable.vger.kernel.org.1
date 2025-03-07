Return-Path: <stable+bounces-121383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779DA56880
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52461898928
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4674321A955;
	Fri,  7 Mar 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="poC9lxf/"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DA21A43D;
	Fri,  7 Mar 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353006; cv=none; b=c89I4Oqm1aK9ZzTRQJCZ5Ua0mdIsLSFI8Gvg75tzQ2pR58LJbO+XHfKhmT+jE1MAk4Uf0AfbklhRTP2aXpcD3dMbbzOsdAIxwR70GwCW/ifJ6Zcfp50o1ufZP3fALEO5ERCT9ejxx54qo7kMX03Zo2g2jWrYLL3igeSyhWti8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353006; c=relaxed/simple;
	bh=iQzTEFwfuVLsQKQGvQgXcDfAHyDsEP5Q3V6KiT0+yWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fy8egLsy+2iTH7fXgXLylppF2/eHVqXOEZknkail0vUUGnaP+L88EG5A3dyZTN+wzmLTu+1xUse5C3SN7cZt7YPBi/mRj5jHCc6vzZ/Bo9L35hSLVz5vK8fpN/yuufTsjiPoNUfp7Hz2Dqkwwn3jtArVBZt0Z3bjaMhydZFCELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=poC9lxf/; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B2754C0000F4;
	Fri,  7 Mar 2025 05:09:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B2754C0000F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1741352997;
	bh=iQzTEFwfuVLsQKQGvQgXcDfAHyDsEP5Q3V6KiT0+yWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poC9lxf/6UDfgmIgvoB+t+Og+Eb+K3kvoToG6sjeKm9UhKg1V9/EWKvBZBLpqg5Sg
	 nJ7cwcrKK1q6aCWH+I0r1nTn2oKtyto5J+YjCFJQeCX8JSh+JZoNOA48w5NLmgyUsZ
	 cFWOfTXUsmqs1fj3UHXofnHJWfvkPHfC3cuNfwrI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id D388D4003010;
	Fri,  7 Mar 2025 08:09:56 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kees Cook <keescook@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH stable v5.4 v2 2/3] overflow: Correct check_shl_overflow() comment
Date: Fri,  7 Mar 2025 05:09:52 -0800
Message-Id: <20250307130953.3427986-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307130953.3427986-1-florian.fainelli@broadcom.com>
References: <20250307130953.3427986-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

commit 4578be130a6470d85ff05b13b75a00e6224eeeeb upstream

A 'false' return means the value was safely set, so the comment should
say 'true' for when it is not considered safe.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper")
Link: https://lore.kernel.org/r/20210401160629.1941787-1-kbusch@kernel.org
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 include/linux/overflow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 35af574d006f..d1dd039fe1c3 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -235,7 +235,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * - 'a << s' sets the sign bit, if any, in '*d'.
  *
  * '*d' will hold the results of the attempted shift, but is not
- * considered "safe for use" if false is returned.
+ * considered "safe for use" if true is returned.
  */
 #define check_shl_overflow(a, s, d) __must_check_overflow(({		\
 	typeof(a) _a = a;						\
-- 
2.34.1


