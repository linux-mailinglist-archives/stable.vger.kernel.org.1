Return-Path: <stable+bounces-4281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEEE8046D4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3DA1F213F9
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CC8BF1;
	Tue,  5 Dec 2023 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wrbock0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7066FB1;
	Tue,  5 Dec 2023 03:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26109C433C7;
	Tue,  5 Dec 2023 03:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747121;
	bh=kQEfQ87PE4KweR6kRqAOcFD1TJCf+HdW28krdgvCpvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wrbock0gPasxY2ipFhIxkRFx6fip/4Sb1j9GQL42bRN94u3+EIjseN2DFxIiF/6MH
	 PWsbnzclrHcgeHb9QVgin5/iY8T7UW08Yd27WmYjTpms3c80sXZGXRuBOUjqRW1Fs1
	 9knuvZTtOlnEYuJkxZw6d3rwwWHuXSRHX8DWltDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 042/107] parisc: Ensure 32-bit alignment on parisc unwind section
Date: Tue,  5 Dec 2023 12:16:17 +0900
Message-ID: <20231205031534.015812069@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit c9fcb2b65c2849e8ff3be23fd8828312fb68dc19 upstream.

Make sure the .PARISC.unwind section will be 32-bit aligned.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org   # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -131,6 +131,7 @@ SECTIONS
 	RO_DATA(8)
 
 	/* unwind info */
+	. = ALIGN(4);
 	.PARISC.unwind : {
 		__start___unwind = .;
 		*(.PARISC.unwind)



