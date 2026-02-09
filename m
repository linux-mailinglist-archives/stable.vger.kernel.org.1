Return-Path: <stable+bounces-215000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKVQBD3wiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:33:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84071110701
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C23305B443
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434E37BE68;
	Mon,  9 Feb 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xO28FodU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43237BE64;
	Mon,  9 Feb 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647338; cv=none; b=uonQWPAeKG9j7YSdLCpYwuiBF2J/flqiieHXrFKn1+98TaTw8w4jxR844q1GgP+uGedvDRs94ympiYtQiP6IJ5f86sodyM/66Sen2VpkTKjmKtVEzriyzpPGDm8MwYTEoK5yw9JnkIQ7KLznNp+v7qpUpgNjyXM2bGxhziy5OB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647338; c=relaxed/simple;
	bh=SxMCJ6cTsqQIqYDcEt1tmEc6NC1WqzgamCC0uYwfI6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqRGmntU2wYyPomPg9ooxM6as1cnnzHgyTtGJnHetRdNBVZTx9yPdPgwf3Cs2JRetbL5ZvgqMn9TDjAI4rjgF5ey2HigXW4pQORu8vliNX1eREqhS7HTweEh31mGnggj3Zp97eXteuZ7klK34T1cl0mdW1I3xZLDrw0vawCWKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xO28FodU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A091C16AAE;
	Mon,  9 Feb 2026 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647338;
	bh=SxMCJ6cTsqQIqYDcEt1tmEc6NC1WqzgamCC0uYwfI6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xO28FodU9T2Ep27yet3Nky0YoAMYIbdbhO9I1Bx8CQVisx2E77HWGdyf2HtWbfz8W
	 NNMezsqaalrt/I0ptlNSjfSmkktKaopMKBsA9myH5dseZeoUEecVTkxrpCBCjoqavp
	 FaY/NWiYrJq5+cZ2+aRiyE52dpsN7VkmRNvyBeAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brendan Jackman <jackmanb@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Marco Elver <elver@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 070/175] x86/sev: Disable GCOV on noinstr object
Date: Mon,  9 Feb 2026 15:22:23 +0100
Message-ID: <20260209142322.971819142@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215000-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:email]
X-Rspamd-Queue-Id: 84071110701
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brendan Jackman <jackmanb@google.com>

[ Upstream commit 9efb74f84ba82a9de81fc921baf3c5e2decf8256 ]

With Debian clang version 19.1.7 (3+build5) there are calls to
kasan_check_write() from __sev_es_nmi_complete(), which violates noinstr.  Fix
it by disabling GCOV for the noinstr object, as has been done for previous
such instrumentation issues.

Note that this file already disables __SANITIZE_ADDRESS__ and
__SANITIZE_THREAD__, thus calls like kasan_check_write() ought to be nops
regardless of GCOV. This has been fixed in other patches. However, to avoid
any other accidental instrumentation showing up, (and since, in principle GCOV
is instrumentation and hence should be disabled for noinstr code anyway),
disable GCOV overall as well.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20251216-gcov-inline-noinstr-v3-3-10244d154451@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/sev/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 3b8ae214a6a64..b2e9ec2f69014 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -8,3 +8,5 @@ UBSAN_SANITIZE_noinstr.o	:= n
 # GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
 KASAN_SANITIZE_noinstr.o	:= n
 KCSAN_SANITIZE_noinstr.o	:= n
+
+GCOV_PROFILE_noinstr.o		:= n
-- 
2.51.0




