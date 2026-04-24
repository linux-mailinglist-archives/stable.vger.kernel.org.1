Return-Path: <stable+bounces-240840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FdhB6N062koNAAAu9opvQ
	(envelope-from <stable+bounces-240840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:48:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907E945FAB4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEEDD301F481
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1473D6CB2;
	Fri, 24 Apr 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eC3Fepxn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262003D6690;
	Fri, 24 Apr 2026 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037976; cv=none; b=Sy8QY/i1Qf9vgCqvKvGixhL0GJNDDbisf+KEGRQW9lyC1b1mB2mMcJpmo3+GG7uiITy1B2/kCI8tn9wWZrMvRm64wXt1SW/5sRwdzoMctBgmSczEc+q2mpsfdvO5TpqoqBy3sS+fJYkR6BzlorDt7AxJMcndaBCEHw7HlAXiDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037976; c=relaxed/simple;
	bh=2HidbOtiYWbAPjfcJy9khzSWkYjDCeu4a9rLyHspG0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvpnjSuIFYm60xxmG2/xjBhGVqGuxb21itY58SNNZOH2r1mgBQC2E4C3mCtdJPgrhsieC4tvwzq8WOX6VOy00RpT2MMQgZdRqCAwP5vBl3f7eoDbRmvF8cIXYzZWnVdAbGlad7sBZdp6VQ3ArmTSrpLBKK+cGxUe/jvMceuf4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eC3Fepxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69094C19425;
	Fri, 24 Apr 2026 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037975;
	bh=2HidbOtiYWbAPjfcJy9khzSWkYjDCeu4a9rLyHspG0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eC3FepxnAUg2FmJQu/6t56Ikl1jn9S1JKH2oXKW+71aAL51WKhVZVjvRtxEgr0WUu
	 b4fp0qjmvyYRMlB9lMFB/sfAhxceRfBrWc5SDd113RdREkeNsa8jITHj4L3oa30ora
	 2OUn2IPvryQYp5xUt5XAlSgMlFAyQtxZR9jrA7Dg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"stable@vger.kernel.org, devicetree@vger.kernel.org,  Nathan Chancellor" <nathan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.6 142/166] scripts/dtc: Remove unused dts_version in dtc-lexer.l
Date: Fri, 24 Apr 2026 15:30:56 +0200
Message-ID: <20260424132602.740952666@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 907E945FAB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240840-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

This patch is for stable only. Commit 5a09df20872c ("scripts/dtc: Update
to upstream version v1.7.2-69-g53373d135579") upstream applied it as
part of a regular scripts/dtc sync, which may be unsuitable for older
versions of stable where the warning it fixes is present.

A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
in clang under a new subwarning, -Wunused-but-set-global, points out an
unused static global variable in dtc-lexer.lex.c (compiled from
dtc-lexer.l):

  scripts/dtc/dtc-lexer.lex.c:641:12: warning: variable 'dts_version' set but not used [-Wunused-but-set-global]
    641 | static int dts_version = 1;
        |            ^

Remove it to clear up the warning, as it is truly unused.

Fixes: 658f29a51e98 ("of/flattree: Update dtc to current mainline.")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
This should apply cleanly to all supported stable branches.
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/dtc/dtc-lexer.l |    3 ---
 1 file changed, 3 deletions(-)

--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -39,8 +39,6 @@ extern bool treesource_error;
 #define DPRINT(fmt, ...)	do { } while (0)
 #endif
 
-static int dts_version = 1;
-
 #define BEGIN_DEFAULT()		DPRINT("<V1>\n"); \
 				BEGIN(V1); \
 
@@ -101,7 +99,6 @@ static void PRINTF(1, 2) lexical_error(c
 
 <*>"/dts-v1/"	{
 			DPRINT("Keyword: /dts-v1/\n");
-			dts_version = 1;
 			BEGIN_DEFAULT();
 			return DT_V1;
 		}



