Return-Path: <stable+bounces-152914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB5ADD172
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CD03BD0B0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731FA2DF3CB;
	Tue, 17 Jun 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R5mJY8++"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD52EF659;
	Tue, 17 Jun 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174247; cv=none; b=btJz33zazV9m/qSFGuflXdsXFY8f8JVLbvykKh9FBvbvrGxwEqCp6yEnFiMtvDb+e1zuJ0og9yijc8wtLZ2QawrydL7lgnRVwaR0CE7Hgw1izUX4NmeSB2xWAXMmGOQ1RNm5dCsp3MLv6OskAxXNK0rf7kUjeSgZF5iUGD1v/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174247; c=relaxed/simple;
	bh=gtX9O8hto5+lPhd9wZj8uU/9I2MbisYHBKH2Cf+E5+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwSjnjedFNAS+GtOXX9MY67Kb2mXARERM6AtHJ9cIjVnzxkARN6msq+gWj4UQSvTgUE6i5cJx+F4fME3a4iGv3ZSImpzkpRUZrW1GTROHBPQbpUi4H3TCmuWcon+jGfuPZFILppwSYfLx39EKWf6ovqeuQZtWninzRdauiNU8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R5mJY8++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E535C4CEE3;
	Tue, 17 Jun 2025 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174246;
	bh=gtX9O8hto5+lPhd9wZj8uU/9I2MbisYHBKH2Cf+E5+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5mJY8++YP+dDMFztv07dxfFxme4IznkDtOC7lNNkjSgMfuT76Qp4JdRh5dH00M+w
	 4Z1QCOuOgrs6416zGuwV455MWHQttEWivnGAAeEu/Q+bApdGl7GexNQeChoAInDaoA
	 VBRLbbBpwVziBhU37nNYjk5gr/iY6//e0ZpsSpZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Yeh <charlesyeh522@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.6 009/356] USB: serial: pl2303: add new chip PL2303GC-Q20 and PL2303GT-2AB
Date: Tue, 17 Jun 2025 17:22:04 +0200
Message-ID: <20250617152338.601571684@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

From: Charles Yeh <charlesyeh522@gmail.com>

commit d3a889482bd5abf2bbdc1ec3d2d49575aa160c9c upstream.

Add new bcd (0x905) to support PL2303GT-2AB (TYPE_HXN).
Add new bcd (0x1005) to support PL2303GC-Q20 (TYPE_HXN).

Signed-off-by: Charles Yeh <charlesyeh522@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/pl2303.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -457,6 +457,8 @@ static int pl2303_detect_type(struct usb
 		case 0x605:
 		case 0x700:	/* GR */
 		case 0x705:
+		case 0x905:	/* GT-2AB */
+		case 0x1005:	/* GC-Q20 */
 			return TYPE_HXN;
 		}
 		break;



