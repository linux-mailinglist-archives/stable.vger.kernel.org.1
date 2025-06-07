Return-Path: <stable+bounces-151754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26CCAD0C74
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1566618942F4
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D851F8723;
	Sat,  7 Jun 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjUAgiQw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB620CCED;
	Sat,  7 Jun 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290900; cv=none; b=SryCYL8q/Wqht9Fxsvul1ttVq5ylpOagUR8UDZdJ55GBDepKzWRv5ri3SSZaBDAB0yLfFjaDoEHt5VDL4rMe5QzF6NhxMB0dyRyoApYH7TIKyJ2Z6uhe5r0T5hfaRNJc2Pryuj5+olwSewdrOCkz7LV+aOnM3EvVL1GuUmGMsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290900; c=relaxed/simple;
	bh=DohA7DqO3q2kU/nLkE47HfxPMtKqm5hLQUvKr/7H6Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFBbroGR01FYyF1LzZkMIAlD9Dm7uFDnD8+jC1/T46dESsWTLXeMpuW5/t3DzqgbM7Juwd4cUGo2rjbWKpkhfuSc682eLPfE302CW3W6nArNa8ezS02dkrthommwVH8xULnmhda6IxGfYkgw8mwYI1RJnvrH0Pqom5Un4N0L6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjUAgiQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D819C4CEF1;
	Sat,  7 Jun 2025 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290900;
	bh=DohA7DqO3q2kU/nLkE47HfxPMtKqm5hLQUvKr/7H6Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjUAgiQw61yPGkc6GD3lgQTRzNg1K9CeBE7mpQm7AX7ieLeFOaj/kIRBWzZszl5L3
	 dafchfIH4oGaqLWi4aOa0tP4vL+QID2343/IVRF/fDF5vwPapL+59NF70I0nO004NI
	 Hou8tEa1bmCMXJqHx2/uCXlFb5BlvJdtgS8eG41k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Yeh <charlesyeh522@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.12 16/24] USB: serial: pl2303: add new chip PL2303GC-Q20 and PL2303GT-2AB
Date: Sat,  7 Jun 2025 12:07:47 +0200
Message-ID: <20250607100718.536367700@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
References: <20250607100717.910797456@linuxfoundation.org>
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



