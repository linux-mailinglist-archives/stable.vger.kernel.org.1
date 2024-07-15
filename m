Return-Path: <stable+bounces-59282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7B930F2E
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D05C1F2195D
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168B18411C;
	Mon, 15 Jul 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/df9LwH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D8174EC6;
	Mon, 15 Jul 2024 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030132; cv=none; b=RQc5YLFltrhbhw6/3mluEhkCXfFtypLhP2gc0VfCJ989rICN0/fJH3RW7qvbzIv4x/avKHHjuZ1habsodgvqMAn3fhDWg/gFcEnLeKyM7jCyjv+M8xA2FgvU5hUYEJGUgzRu85t/baSYKmmd8DJ0E5cgzUlQ0d8surlGVsbp0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030132; c=relaxed/simple;
	bh=V+4E5jckJnwldRUAaWyovlKBTnN/NVhxZiSvn5X4Xog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfEgEFD/1mWO98dNDUKf48pnTHS/35EZ6bcKsZt+xLiVhS+8nmJeo09265GwbZrKUfffOMID2Ln7ZaD6vrcAyX2HXYfW5bpII8QyUUGGjcB94WKJDK2zNPCPLZwWVKkj4e8anVwdX8MfIJQLlJfPM+JuVi1LLhImfUlGdFo01/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/df9LwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26F0C32782;
	Mon, 15 Jul 2024 07:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721030131;
	bh=V+4E5jckJnwldRUAaWyovlKBTnN/NVhxZiSvn5X4Xog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z/df9LwHDrZ4Ry0d1c6Ykcgg7cdJisCxqZ1AHki189IIeGErEUG8ImfBYunTOiQOh
	 uQAmtjaRJTnLegFnVK0v55/cRYfB7cNcb7juAzIOVe3NIvu1B+FzuYZHM2AY3NroG9
	 TNf5Cddy8fxY3w8f9eDGYOnlxJDvQ9mc/5uzcpwI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.40
Date: Mon, 15 Jul 2024 09:55:23 +0200
Message-ID: <2024071547-paramount-capably-48b3@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024071546-savanna-giggly-15b8@gregkh>
References: <2024071546-savanna-giggly-15b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 5ba70f0649f3..c84413077456 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 39
+SUBLEVEL = 40
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 592dabc78515..8dd85221cd92 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2649,17 +2649,16 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			else
 				xhci_handle_halted_endpoint(xhci, ep, NULL,
 							    EP_SOFT_RESET);
-			break;
+			goto cleanup;
 		case COMP_RING_UNDERRUN:
 		case COMP_RING_OVERRUN:
 		case COMP_STOPPED_LENGTH_INVALID:
-			break;
+			goto cleanup;
 		default:
 			xhci_err(xhci, "ERROR Transfer event for unknown stream ring slot %u ep %u\n",
 				 slot_id, ep_index);
 			goto err_out;
 		}
-		return 0;
 	}
 
 	/* Count current td numbers if ep->skip is set */

