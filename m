Return-Path: <stable+bounces-59281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD41930F2C
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 09:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386842814A9
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5FF1836E4;
	Mon, 15 Jul 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsvYNswD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB9174EC6;
	Mon, 15 Jul 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030127; cv=none; b=HDTX6ublEQqTQM7PeZW2e+v6WhWlnQrLzwSYkFWaeZqDyER7v4dpYnGcNRdSnTKMkaNJ1Jvv7uYWJyM2FwNt/VYGhLWzQZnfD0PjjueHl9cCPd4lD4X1STGwdEOmkf18c03Tuefx5tsgZlOwDCYcObaR8NRt69Hbi2m34WMLSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030127; c=relaxed/simple;
	bh=S6mDdLmJlLk5asMkLgXSGVFFk20+sEC0L15zUPsPUvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJTFE8OsC+2ZwMIIt8YMS5+/t3r3Y5nvcwaAIz33UgUG5aJ2tDTalNjgrI4oU7RB5fbWhWtUPk0gkKXzpR4JVNG16eAwWsF/UwVPmzVLuo0LlUy9mUfGRoAZF8b3R72V53aaI1/0VFiTCrMHwm93W/tY4SSZMvA5FG4wVruiizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsvYNswD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F03C32782;
	Mon, 15 Jul 2024 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721030127;
	bh=S6mDdLmJlLk5asMkLgXSGVFFk20+sEC0L15zUPsPUvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsvYNswDZ2z2mGFW000TK8SL43Xb9LnXUwmjDZxcRNrJRBwMGnSdAKIKLzCgu8N+X
	 LwLGfOsUC0FmJUuhk+Rb/gpaOPnVLw8ciVDRBrieujG8neNDdqnOr8nZBiBKJdWAwt
	 3gp5ntlCeJ+WkIHg5fvP0Gs8vX7zgeYNUoGEEXw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.99
Date: Mon, 15 Jul 2024 09:55:14 +0200
Message-ID: <2024071548-pranker-neon-0e97@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024071546-mortify-sphere-6c7a@gregkh>
References: <2024071546-mortify-sphere-6c7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index c9a630cdb2ec..c12da8fcb089 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 98
+SUBLEVEL = 99
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index be5b0ff2966f..7549c430c4f0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2631,17 +2631,16 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			else
 				xhci_handle_halted_endpoint(xhci, ep, 0, NULL,
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

