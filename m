Return-Path: <stable+bounces-230725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGgzLgr5xmlwQwUAu9opvQ
	(envelope-from <stable+bounces-230725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 22:39:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1316134BC99
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 22:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0778300DF7B
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67DA39B484;
	Fri, 27 Mar 2026 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toHYW7vR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D729DB88;
	Fri, 27 Mar 2026 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774647545; cv=none; b=q49AvDUeDI1zVPkVmAqGVFYc7Q/qFuenk5PSg2UAMbNXkZGGkbcajLsurCM/XcU2BlZv2bK5+r0k9OCKvIupRE2eDMZFi4vDo+VaF3P2Ta/olWe0Yqihvd2M40axeTgaLG1BNr+YN5ssKi51et2L/qx3C0y/PicKYkrEs+Fg0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774647545; c=relaxed/simple;
	bh=m0xyN/K4zSKcbMCe0Pigk/i5SRWQIcAcko2GQbCvTjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qSOetwC/dY+VH02tCTgp3QyJZbpVN95ByBxy0w1nnxOd2MPQj7ClYBc3Lt0iCSnRSnQ7OI4YUc3tFiSX9JPyR6sCqLf6dUTqx5aILyFNX9AQ8l6HjCFapIkKpBeZa6WDcFAoA6r3Ut3jkZ2xQ49j5Owdo64A1CzhaxsWgGPai58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toHYW7vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0354EC19423;
	Fri, 27 Mar 2026 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774647545;
	bh=m0xyN/K4zSKcbMCe0Pigk/i5SRWQIcAcko2GQbCvTjg=;
	h=From:Date:Subject:To:Cc:From;
	b=toHYW7vRoEUWdcJjPz6TA1qTwrnJuw2lVfyg8XYEcr3C0SVa0+i7LFe3PEWxhRPTc
	 30a33Msav4wL0TDWZZoYgjok56+O/WV61RkBGsTLgiTCfPt5RVH43WWN+3438Gp1KY
	 aEPIWd0YQrdraTa95iIUQbZk2H9jnaQoY+VaXXXXI0A0FZebSDUdrwI4qSdjV6cuoA
	 Himl6hXUQlpqErfe/E7QeQgqzlUuc7WLH9YlS47oCxwKJ9XEPXuR5hHx9MTHg0gLhM
	 4OFsZb7t95rOXQXoPDu0FDH8rqrOhDXORg0kaYOxKomajkS5UUDH1GjpMk2Z/i+UPF
	 maLu4iHUMzzcw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 27 Mar 2026 22:38:55 +0100
Subject: [PATCH] scripts/dtc: Remove unused dts_version in dtc-lexer.l
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-dtc-drop-dts_version-v1-1-41066690aefd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBAAvyJ7NmBiTcWvSBG7WdvtQWU3FUH8u
 1FvM4eZDZSESaHJNhBaWHkak9g8A/z244cMh+TgCueL0j1NiGiCTHMC7RaSMzC2Kqm26P3DIqR
 0Fhp4vbbt63b9v3+E8XzBvh+CB5t5eAAAAA==
X-Change-ID: 20260327-dtc-drop-dts_version-153e81c6641c
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=nathan@kernel.org;
 h=from:subject:message-id; bh=m0xyN/K4zSKcbMCe0Pigk/i5SRWQIcAcko2GQbCvTjg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJnHfnxz6zbt2fzjTpVxvsc/dZ5Mly/2E942ZbxUPK9v8
 un4kuQjHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiQPX/7N7rva6YLSAaW/rW
 NWJD+P80jTOCtT/V2gN9K8IZxGauYmS4mBW/ovheWF+kewjD33tPNz06+lve6qN3j/F9Lp0l4n1
 cAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lists.linux.dev,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230725-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1316134BC99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
in clang under a new subwarning, -Wunused-but-set-global, points out an
unused static global variable in dtc-lexer.lex.c (compiled from
dtc-lexer.l):

  scripts/dtc/dtc-lexer.lex.c:641:12: warning: variable 'dts_version' set but not used [-Wunused-but-set-global]
    641 | static int dts_version = 1;
        |            ^

This variable has been unused since commit 658f29a51e98 ("of/flattree:
Update dtc to current mainline."). Remove it to clear up the warning.

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This is commit 53373d1 ("dtc: Remove unused dts_version in dtc-lexer.l")
in upstream dtc. I sent it separately to make it easier to backport to
stable, along with updating the warning and hash to match the kernel's
version.
---
 scripts/dtc/dtc-lexer.l | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index 15d585c80798..1b129b118b0f 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -39,8 +39,6 @@ extern bool treesource_error;
 #define DPRINT(fmt, ...)	do { } while (0)
 #endif
 
-static int dts_version = 1;
-
 #define BEGIN_DEFAULT()		DPRINT("<V1>\n"); \
 				BEGIN(V1); \
 
@@ -101,7 +99,6 @@ static void PRINTF(1, 2) lexical_error(const char *fmt, ...);
 
 <*>"/dts-v1/"	{
 			DPRINT("Keyword: /dts-v1/\n");
-			dts_version = 1;
 			BEGIN_DEFAULT();
 			return DT_V1;
 		}

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260327-dtc-drop-dts_version-153e81c6641c

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


