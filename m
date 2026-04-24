Return-Path: <stable+bounces-240961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGqgLttz62kLNAAAu9opvQ
	(envelope-from <stable+bounces-240961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:44:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418045F8B4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51839300B9CA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C89E3D6CD6;
	Fri, 24 Apr 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8aT/tT3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E03D75B6;
	Fri, 24 Apr 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038285; cv=none; b=Q7QcLsFongFxGaSHBH9t5pNPuxfNkcDpVPmI78pHyZI25tOMdvx7S4IE53AQBbK44gzGnFemm41yHu7CSKWZfrroWbTvPRfQTvkg0hN7J6nxLYGZ3hUt4UxdURGw7ooR56ZSUxQoAi7EnYY3S6obCdXvfVmyfJoLld1wWBZsz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038285; c=relaxed/simple;
	bh=0NhJrTOK6QTSVre/BLYj1F0mz1eTPlgrXbmk14RBnx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFsRnK8clH7sBZXX2QAl35MuK5zzk+leIXMFTxJrU3Ohm8B+qVxiUCsrHmhUlstBK/kGNzJGKe31QHVkdKBWAHu7RNPO/crvu8Ji8ZArpIFdyMPTrV4t5s4nqq2XvwRY8lO/GUaE9+QKWSTQCnB1fCkX639WoCCP/5kD9Wfb3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8aT/tT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D20C19425;
	Fri, 24 Apr 2026 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038284;
	bh=0NhJrTOK6QTSVre/BLYj1F0mz1eTPlgrXbmk14RBnx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y8aT/tT3z4edjqrAR4/Z7LDEpzA808NquzQE2/HmuHgmMYbWTP+P0t3z8tE93WNkw
	 d92TLtaAuDaMvg/VG17ZtFOAiTJcWaAkxjDCX3BNPuUJBFn4o21I9vUxBDPXIdvwNy
	 wsMDwIXyTVE+quaPif3wSDQh8qyoGTIIGUOafsow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"stable@vger.kernel.org, devicetree@vger.kernel.org,  Nathan Chancellor" <nathan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.12 12/35] scripts/dtc: Remove unused dts_version in dtc-lexer.l
Date: Fri, 24 Apr 2026 15:31:19 +0200
Message-ID: <20260424132414.223848631@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132411.427029259@linuxfoundation.org>
References: <20260424132411.427029259@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5418045F8B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240961-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.12-stable review patch.  If anyone has any objections, please let me know.

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



