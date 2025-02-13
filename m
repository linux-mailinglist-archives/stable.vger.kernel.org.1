Return-Path: <stable+bounces-115360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3598A3433F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0385D161E47
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43AB28137F;
	Thu, 13 Feb 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N7/TBiIK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8C281369;
	Thu, 13 Feb 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457779; cv=none; b=iJD+Z4ezThMl/dG4g85KOos89pdbQzdkPxsgkuDD0qCN1zEEp3ihzTk/aefjy+4ak3KtXjNgBYo1z6Z3Q0rsQ49mAmCyHmzRUsZqOtVI9Y01kEyhy2p7wTetZjUDcjCS9QNCFZHDP/N2AEEed7PXnoraiX3pkZVRLAbVWzF76w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457779; c=relaxed/simple;
	bh=4fV+t5EXtYj72sYx8pCijUgmt4lqnFqKesrXBpo+8gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYpzLs/kxWID5j+AOPtUErxnNMNw+jRWL0lLakOIcefDuSjaOcVq7dCP5MatybIiBTBqL/KsPA4ojkRkywHXHRMMsZDp8VK1AUtbDeu7Dj1msYFuNibyqFRyayfW9nzyUZbTv6qmnILXZ94nM5vS/Npce/Co/BuuLnyMa7DzGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N7/TBiIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953B9C4CED1;
	Thu, 13 Feb 2025 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457779;
	bh=4fV+t5EXtYj72sYx8pCijUgmt4lqnFqKesrXBpo+8gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7/TBiIK5Cl8ne895rhmlgBzJWsv02WF/M4TNk8btq7JVNtZm5md4gku2TIK6j7uw
	 08pnfUyWcw044CbND4+YIPhx30x/YWjx7e3q/uGGztD/g+Bl2ohimly22rZkreYjmo
	 qdPzXW2738odYYBlbGILhfZtYR25DvgschbZjoW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Foster Snowhill <forst@pen.gy>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 212/422] usbnet: ipheth: fix possible overflow in DPE length check
Date: Thu, 13 Feb 2025 15:26:01 +0100
Message-ID: <20250213142444.719074546@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Foster Snowhill <forst@pen.gy>

commit c219427ed296f94bb4b91d08626776dc7719ee27 upstream.

Originally, it was possible for the DPE length check to overflow if
wDatagramIndex + wDatagramLength > U16_MAX. This could lead to an OoB
read.

Move the wDatagramIndex term to the other side of the inequality.

An existing condition ensures that wDatagramIndex < urb->actual_length.

Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Cc: stable@vger.kernel.org
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/ipheth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -243,8 +243,8 @@ static int ipheth_rcvbulk_callback_ncm(s
 	while (le16_to_cpu(dpe->wDatagramIndex) != 0 &&
 	       le16_to_cpu(dpe->wDatagramLength) != 0) {
 		if (le16_to_cpu(dpe->wDatagramIndex) >= urb->actual_length ||
-		    le16_to_cpu(dpe->wDatagramIndex) +
-		    le16_to_cpu(dpe->wDatagramLength) > urb->actual_length) {
+		    le16_to_cpu(dpe->wDatagramLength) > urb->actual_length -
+		    le16_to_cpu(dpe->wDatagramIndex)) {
 			dev->net->stats.rx_length_errors++;
 			return retval;
 		}



