Return-Path: <stable+bounces-163807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F419B0DBC0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52DE3A7FAF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DC2EA481;
	Tue, 22 Jul 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rMpo/uhl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC242EA484;
	Tue, 22 Jul 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192277; cv=none; b=qou+CV7iS8dTErjWhNmfILIYeYlmQG/1PHoZgjtA5bALxAst8tpy7s2Ad6IO92hIC6vKYP70sRgLe66xrZ70jPlGC62/is1keA6DgdI/eK4zEAgaxK2l1UsfzbsFFdI2R8uNRUIP5vaDeixf2bRkdf266LvbLhaoxjs87yHKpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192277; c=relaxed/simple;
	bh=HJq3u9RqSGSte9nAOcGYCw2NZtSKEOQt1qy2HdAadNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiwIe8W3JDV1NyY9LWWBjzEEGSv6BwI3wSvL45R5sOUZ9rKBYgxdMwJMHPvUx8zkjPaogYfogIbmojctYNG3s8kkkMSkHj2JQvY+xRfcXH63SGApE6bFwdL26v+MVdPu6Ft1RWVn8IQjl9AyM9Viqb5L72LPIoKiWvt8YPDEsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rMpo/uhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCC8C4CEEB;
	Tue, 22 Jul 2025 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192275;
	bh=HJq3u9RqSGSte9nAOcGYCw2NZtSKEOQt1qy2HdAadNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMpo/uhlyDyiYBrXguUa2oWqa+oqw3BLiS6RS+e5V43XG5KUd1F/im+t+xEmk1A6F
	 edtE0T4ujvY0Fd59Ov5DAWdhf0YTtkDGCBjRY4VdZBDbgVa5/fuY8jSKgLrvpwqzqE
	 8CfAPz8gqvAx1rEafsUGnMzKhIdF0ddeJQUCQj/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.6 017/111] HID: core: ensure the allocated report buffer can contain the reserved report ID
Date: Tue, 22 Jul 2025 15:43:52 +0200
Message-ID: <20250722134334.034053447@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <bentiss@kernel.org>

commit 4f15ee98304b96e164ff2340e1dfd6181c3f42aa upstream.

When the report ID is not used, the low level transport drivers expect
the first byte to be 0. However, currently the allocated buffer not
account for that extra byte, meaning that instead of having 8 guaranteed
bytes for implement to be working, we only have 7.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Closes: https://lore.kernel.org/linux-input/c75433e0-9b47-4072-bbe8-b1d14ea97b13@rowland.harvard.edu/
Cc: stable@vger.kernel.org
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20250710-report-size-null-v2-1-ccf922b7c4e5@kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1873,9 +1873,12 @@ u8 *hid_alloc_report_buf(struct hid_repo
 	/*
 	 * 7 extra bytes are necessary to achieve proper functionality
 	 * of implement() working on 8 byte chunks
+	 * 1 extra byte for the report ID if it is null (not used) so
+	 * we can reserve that extra byte in the first position of the buffer
+	 * when sending it to .raw_request()
 	 */
 
-	u32 len = hid_report_len(report) + 7;
+	u32 len = hid_report_len(report) + 7 + (report->id == 0);
 
 	return kzalloc(len, flags);
 }



