Return-Path: <stable+bounces-54495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDB90EE81
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1154128230F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582214E2E2;
	Wed, 19 Jun 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DU+ruQQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF451146016;
	Wed, 19 Jun 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803748; cv=none; b=ZhhWWNWIeK/BV0Le7o4U02YjjDqlOyxRSp5nFVBiNcdoqgkj8RMa+tVWgbk5TDui7xV/gGNNoTBaJLTrAsVfpZB7Y7fNcwAb0Me/ZYSspRQLL64kdyiyqc9eDH3aRNdDby+OfHODay/GUtiYfimaB4OywwtPNa081oPidzQ4ge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803748; c=relaxed/simple;
	bh=hv2F3rUIGfdVtma68HIzZ4kA1PFKo7S9yid3tmcNfOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msZq3AA69oRltFr/yG/dZidcQRjrW0GbyvUCfBV3Drr2vXsi0YmV+Y6Dc97E7tIVQ8Ltx5/VA+RR5s6U41KIfYdFKeQoE8CS9CilwT0khV8IaBAIy1nrfsplylF0zDzlvmDxS7pf5eBIsqKhZaTOH0BYfPKneLck7tiDMwivfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DU+ruQQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448F0C2BBFC;
	Wed, 19 Jun 2024 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803748;
	bh=hv2F3rUIGfdVtma68HIzZ4kA1PFKo7S9yid3tmcNfOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DU+ruQQUSFXzbfyarzLsMK4Pvc00SMydaMFukAYyEsi1nYO2zUUEXKoJ1TVITb2x0
	 Zh9MSnchsAlQpHoON1DDWKEyJh9vLeDbyPGy8QcJ/QBZrJX6UaSicjKqtGfgzFM6th
	 sEtkZhZ3gUlEZG8yg4D3jnz5kUpxLCeCxl89cHPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vadym Krevs <vkrevs@yahoo.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.1 090/217] tty: n_tty: Fix buffer offsets when lookahead is used
Date: Wed, 19 Jun 2024 14:55:33 +0200
Message-ID: <20240619125600.161618990@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit b19ab7ee2c4c1ec5f27c18413c3ab63907f7d55c upstream.

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
Link: https://lore.kernel.org/r/20240514140429.12087-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_tty.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1602,15 +1602,25 @@ static void __receive_buf(struct tty_str
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



