Return-Path: <stable+bounces-45079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945068C578D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B75E1F21F8A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C21448FD;
	Tue, 14 May 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V16J9SL6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6A6D1A7;
	Tue, 14 May 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695486; cv=none; b=WZLER6JREEOd10H/+KItI5e3TQGjtegB5EYCuwDFwt+jbF0FBCfUwKvOaOP6NWw+e3M3tweu+nb1nqYCsIaIVeUjiRPF4HXZIEn/e5HuzQ7AvhmQFK773FVAtUCfr0XfhX8kjL8PAAuS3hs/1ZeCvVUo5n8+SFtoIAac1nzwJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695486; c=relaxed/simple;
	bh=roA5uGCbP+e8h4PQDitrEk7fpYUwL35HV0MhxPXymsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lVs9gAYPY/IGy7c27/vIGxFdXUdcbDEgRJOa2zZ+nyrqoIZLZ0KxfRj06heq0nLn+bLVlZf7pgU0g9oAgUXoRxN6FXDmsvDQgR1Hlm07UQQ0GFWvPxWn7cHbrBn2X6znnz8H26XfVmVu3FuaIF1fQMazNrGc7qtkCklGJdoGEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V16J9SL6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715695485; x=1747231485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=roA5uGCbP+e8h4PQDitrEk7fpYUwL35HV0MhxPXymsI=;
  b=V16J9SL6M2Kc7I9lhZkc5aJINdZ9gTMUETCu5R08XIhJ3z02nAadvAfj
   8qBR4PReFgvhrufVcyXooB3Kt+iEKLtGckHhn5uHFkYbJVqJD3bZfrMYO
   AyNX3Xgm4fWa2q44siOfnX9Jkxev/KGHj84KR4bAX/1M8hJI7plEmYdUL
   Ev+HHupg/Ig9C5JmFTh1w0lYk5ynSxoXGO1D9u6Piz9Dt8RDhPYeIBI/7
   lMEFtXOKCFwLOB+4vpjgl12tkqu0kuRruHe+nc8SdPEZVRpT/Go5at+yW
   LvhynvkMVuybwRghzwyBLjgBRw6cwnO8r+J42UB7Q2N1eteiPSPZ4KbWF
   g==;
X-CSE-ConnectionGUID: TK4U5mcFR/eq6Jk3um84WQ==
X-CSE-MsgGUID: z4uBX5T3TtC7pRfYinqIcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22279586"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="22279586"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 07:04:44 -0700
X-CSE-ConnectionGUID: pR7pUOi8Taabsd581odKmA==
X-CSE-MsgGUID: MvVByz+1QASJFJv03dHGzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35230071"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 07:04:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Vadym Krevs <vkrevs@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] tty: n_tty: Fix buffer offsets when lookahead is used
Date: Tue, 14 May 2024 17:04:29 +0300
Message-Id: <20240514140429.12087-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When lookahead has "consumed" some characters (la_count > 0),
n_tty_receive_buf_standard() and n_tty_receive_buf_closing() for
characters beyond the la_count are given wrong cp/fp offsets which
leads to duplicating and losing some characters.

If la_count > 0, correct buffer pointers and make count consistent too
(the latter is not strictly necessary to fix the issue but seems more
logical to adjust all variables immediately to keep state consistent).

Reported-by: Vadym Krevs <vkrevs@yahoo.com>
Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218834
Tested-by: Vadym Krevs <vkrevs@yahoo.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f252d0b5a434..5e9ca4376d68 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1619,15 +1619,25 @@ static void __receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 	else if (ldata->raw || (L_EXTPROC(tty) && !preops))
 		n_tty_receive_buf_raw(tty, cp, fp, count);
 	else if (tty->closing && !L_EXTPROC(tty)) {
-		if (la_count > 0)
+		if (la_count > 0) {
 			n_tty_receive_buf_closing(tty, cp, fp, la_count, true);
-		if (count > la_count)
-			n_tty_receive_buf_closing(tty, cp, fp, count - la_count, false);
+			cp += la_count;
+			if (fp)
+				fp += la_count;
+			count -= la_count;
+		}
+		if (count > 0)
+			n_tty_receive_buf_closing(tty, cp, fp, count, false);
 	} else {
-		if (la_count > 0)
+		if (la_count > 0) {
 			n_tty_receive_buf_standard(tty, cp, fp, la_count, true);
-		if (count > la_count)
-			n_tty_receive_buf_standard(tty, cp, fp, count - la_count, false);
+			cp += la_count;
+			if (fp)
+				fp += la_count;
+			count -= la_count;
+		}
+		if (count > 0)
+			n_tty_receive_buf_standard(tty, cp, fp, count, false);
 
 		flush_echoes(tty);
 		if (tty->ops->flush_chars)
-- 
2.39.2


