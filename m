Return-Path: <stable+bounces-205338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37651CF9BC0
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56A1300422E
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164A3557E2;
	Tue,  6 Jan 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pM3xF7k1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F736227BA4;
	Tue,  6 Jan 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720361; cv=none; b=ro24T8US27eCPNeT1zk+mF+AEWDG3rLqb9ksfUwVNdRtEP2nY4wVTUhbcXfjCNAUchh5bijfkETYBFYZvWjlsn3cVNubn/eAv6tDynBxM/DRJ/5rH9OhCEkZ8YBblqVDM5t79q6nARDKREPIxEakW5W5+qCb4Cdm2gfkSG3cFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720361; c=relaxed/simple;
	bh=M/ExLbNppusWkwAWmjvZm2P/Zkw52nLF7lrhWL+2tP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojv3F7tPcUP9gsZMP/tUpp69BMfiKn2Qrm0c4b3n3eZFVOciy8JbutVJELw2xs6a4QYxOfEh7q3LxVwGpVr4c/4me951Kn1jS52H4yRpW5SrJ2NYnU6JC/ZGkfvHWb0zz2Ve8ietCu1Cb6bZuoBzuhWZ+ieGrWGMsjRR0kVctK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pM3xF7k1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25A4C116C6;
	Tue,  6 Jan 2026 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720361;
	bh=M/ExLbNppusWkwAWmjvZm2P/Zkw52nLF7lrhWL+2tP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pM3xF7k1p0BWGst5mUAB4MwD/ECD0Kn7AZoGDef5tdgOBoO4KSAMgGvKS81jmn9lS
	 3skMzg6kGIo7Oo45LBDAV7taZGFi2leAW1W+4rwXt9+xaWGKKzH2bv3WKT602QErXC
	 Bl+Io+TTWme10OeKdCusM3nYJvKUUKPQ+l1u2120=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Ian King <colin.i.king@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12 180/567] media: pvrusb2: Fix incorrect variable used in trace message
Date: Tue,  6 Jan 2026 17:59:22 +0100
Message-ID: <20260106170457.988542499@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.i.king@gmail.com>

commit be440980eace19c035a0745fd6b6e42707bc4f49 upstream.

The pvr2_trace message is reporting an error about control read
transfers, however it is using the incorrect variable write_len
instead of read_lean. Fix this by using the correct variable
read_len.

Fixes: d855497edbfb ("V4L/DVB (4228a): pvrusb2 to kernel 2.6.18")
Cc: stable@vger.kernel.org
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -3622,7 +3622,7 @@ static int pvr2_send_request_ex(struct p
 		pvr2_trace(
 			PVR2_TRACE_ERROR_LEGS,
 			"Attempted to execute %d byte control-read transfer (limit=%d)",
-			write_len,PVR2_CTL_BUFFSIZE);
+			read_len, PVR2_CTL_BUFFSIZE);
 		return -EINVAL;
 	}
 	if ((!write_len) && (!read_len)) {



