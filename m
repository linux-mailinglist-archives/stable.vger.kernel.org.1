Return-Path: <stable+bounces-191308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBEC1129A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDA81A63636
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357062D2398;
	Mon, 27 Oct 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="veUurOsE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5321576E;
	Mon, 27 Oct 2025 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593595; cv=none; b=ec4oUx+1eFL+hCTfOB+bhQnz+/q/lJ9YU8mxth3s7QVUzq2YoZ/lKpN6e1D4O/ISIP7y4KElBEAtQ1T1jete9QCxzsNIsJbCIU3GwvbFxdoECuDGws+ooMl7F2vg+hglR/4ieclLDZWbdJR2nAcm4EWA4XP/LUG4n2ksvQCuWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593595; c=relaxed/simple;
	bh=fhx0lFr5NRj1aGpOjFKjca+rOJSVFg3ZgqRCe7lTkNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KE6i42XLStdHp2G/ccuOjB6g3XhxlMIDBrWZlFgLxNmUoI/RftJRHh8muqBj1NF9Nhtr+ED6x/9Epqi2gsHhLpDU1tc7L/FrmLoK2MvI5BNMiF7ilHJ0vqcPmpAlJ+UzisXKr0jqxOtrcLRsKiqYL865e5ieoPZ3G0+hl0kb1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=veUurOsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61879C4CEF1;
	Mon, 27 Oct 2025 19:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593595;
	bh=fhx0lFr5NRj1aGpOjFKjca+rOJSVFg3ZgqRCe7lTkNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=veUurOsEqT6ljQOXchOjWQS8MfTeYr5K/Ut9HSkDe8E57VLAU3Px8WZmZ3K2jmC1A
	 4l5lykJ9E642ALE0+YxkRMj4ufRr71GUIaFH9DleGrIOfvQ/0nsWcOHM83MVLxDoDD
	 gYfuqhHAlYatrIUspMnHBoCbAUykFlLYrDyUIatY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org
Subject: [PATCH 6.17 156/184] x86/microcode: Fix Entrysign revision check for Zen1/Naples
Date: Mon, 27 Oct 2025 19:37:18 +0100
Message-ID: <20251027183519.127003109@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Cooper <andrew.cooper3@citrix.com>

commit 876f0d43af78639790bee0e57b39d498ae35adcf upstream.

... to match AMD's statement here:

https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7033.html

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/20251020144124.2930784-1-andrew.cooper3@citrix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/amd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -194,7 +194,7 @@ static bool need_sha_check(u32 cur_rev)
 	}
 
 	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80012: return cur_rev <= 0x8001277; break;
 	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;



