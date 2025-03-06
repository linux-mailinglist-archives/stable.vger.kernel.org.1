Return-Path: <stable+bounces-121128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F204BA53FB4
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BB416EC6F
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71370838;
	Thu,  6 Mar 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gprx5ZKk"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7533FD;
	Thu,  6 Mar 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223744; cv=none; b=QzmdEVTGaILD3ezdFlRJJntxGFdZedp6iac5jgKsd0QMpO5qQnFoa0S3189J8dqnzDJjAMJXuOQCqNDlLoFg0qKbMZy64ltrV7tQGV0ShHW60E+c9617PTIm3fw+20SMA+4iSOIEvd9wDsPr1thIFSb40waCdxs22uBIXXmTQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223744; c=relaxed/simple;
	bh=iQzTEFwfuVLsQKQGvQgXcDfAHyDsEP5Q3V6KiT0+yWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mO1I5y43I7Xiz/bPLCfJRUQWHhRiqjXnnAHrvo7ONFZXmZNh4t5yzzj5gG9wZdCj8sRbCakOh5WkPLB602Ub31hllQdDMqNR45JsPlt6hcvf5ulFIXAe66rsqPklgjwDIhwvTrVfUlG6rKAIYSsovOsakAZAOG168quUbp2Yva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gprx5ZKk; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8996FC0005BB;
	Wed,  5 Mar 2025 17:08:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8996FC0005BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1741223281;
	bh=iQzTEFwfuVLsQKQGvQgXcDfAHyDsEP5Q3V6KiT0+yWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gprx5ZKk57lw1IWzRBfvdEGYT8jfsCtu1UPXkfSuwuJ1p35hjK0qJDogBaDZnW1At
	 ysdUj4Bhj7WrGEkPMs5iYUkdcEY3lhZdrO4nBUhRt3TbBtH0uj+bb6J7EXksNNv4gZ
	 iQDyc51NHw2qzep6+KOiq9lxNp0VhqSY5X6a16C4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 8E23D4002F44;
	Wed,  5 Mar 2025 20:08:00 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kees Cook <keescook@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH stable 5.4 2/3] overflow: Correct check_shl_overflow() comment
Date: Wed,  5 Mar 2025 17:07:55 -0800
Message-Id: <20250306010756.719024-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306010756.719024-1-florian.fainelli@broadcom.com>
References: <20250306010756.719024-1-florian.fainelli@broadcom.com>
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


