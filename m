Return-Path: <stable+bounces-123471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B826A5C5BB
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655B33B46E4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1E25DCE5;
	Tue, 11 Mar 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBxaXuAg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42392405F9;
	Tue, 11 Mar 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706053; cv=none; b=E1XAK//+QUPbRVOWyFJi19MXAJXwei1k+3O7GsY8KUaignUWtDQ/VqgLnqA9JIPJyZnGkoN23IHvY92Y3GVpCjX2y1Sg5NLdKAevAqF678bkuo15P5dytOu3oEsmJPKCPQhAxWWRTlg9AFdVxvjc9m6vb6bP7uTD9DGjcn2uA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706053; c=relaxed/simple;
	bh=LYxtcVAdkmSoIdIdeVKSPmQQgKoA47L2HZDOfhwcx9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqYIO1efIbpCnJmAhagfS5FeGNMQbXip7Uu5mwJ87D+s5dlmEWQ2VntI3brr2RdF+nLdce3x1jng/uvcjBw4yjTZXd0Lq+jr1atZG2wrcgl9lgWdzNKlhRVP3gnWQwNO5EZmEy2GJFPSJt+wvV5FtKa+cmjx1ea+iFt2AO2S094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBxaXuAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3CDC4CEE9;
	Tue, 11 Mar 2025 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706052;
	bh=LYxtcVAdkmSoIdIdeVKSPmQQgKoA47L2HZDOfhwcx9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBxaXuAgC4j7IslW+9FHMbjC0aIXs3Kde/1+nzrj64a96o37SFFeRcJmqt17oFAgF
	 eRT1xHkt44nN3NjwXhBnrFlkBE/0OJITh2/OQH2Bktvub2AxrPRgIpB2mlQvd0tqy7
	 eY2zLdS1rRxmSw03nJMacPmjgXwp4EqV19MiM/H0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 226/328] scsi: storvsc: Set correct data length for sending SCSI command without payload
Date: Tue, 11 Mar 2025 15:59:56 +0100
Message-ID: <20250311145723.893946416@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit 87c4b5e8a6b65189abd9ea5010ab308941f964a4 upstream.

In StorVSC, payload->range.len is used to indicate if this SCSI command
carries payload. This data is allocated as part of the private driver data
by the upper layer and may get passed to lower driver uninitialized.

For example, the SCSI error handling mid layer may send TEST_UNIT_READY or
REQUEST_SENSE while reusing the buffer from a failed command. The private
data section may have stale data from the previous command.

If the SCSI command doesn't carry payload, the driver may use this value as
is for communicating with host, resulting in possible corruption.

Fix this by always initializing this value.

Fixes: be0cf6ca301c ("scsi: storvsc: Set the tablesize based on the information given by the host")
Cc: stable@kernel.org
Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Long Li <longli@microsoft.com>
Link: https://lore.kernel.org/r/1737601642-7759-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1639,6 +1639,7 @@ static int storvsc_queuecommand(struct S
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
 	payload_sz = sizeof(cmd_request->mpb);
+	payload->range.len = 0;
 
 	if (sg_count) {
 		if (sg_count > MAX_PAGE_BUFFER_COUNT) {



