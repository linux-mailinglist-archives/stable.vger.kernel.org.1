Return-Path: <stable+bounces-240015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKhHILHG5mmW0gEAu9opvQ
	(envelope-from <stable+bounces-240015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:37:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E566D435238
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC7D3018083
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE14199EAD;
	Tue, 21 Apr 2026 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FokUEpYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253081ACA;
	Tue, 21 Apr 2026 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731819; cv=none; b=G2RqTzSAf2K4BjB5hiw5uqp+bThh9rHG7/hUGATV/GFTs6hy0TnuDu79NwYlZvBGQdxckTg31HdwTD+bPXjNnc0MNDao0K8Z0ROKHtfSqygMKJ1pVGQjqBOnf4nFnhJGHPpMDNOIsrg03DkWv4VGy5tqEKHAAndnO2bobGcOrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731819; c=relaxed/simple;
	bh=vQNrpRb2Y2u/E42xvlMNCUcD2QXuD22cBcQ8aI2+HSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MWBtoVGN2bXnnvBIFSQRTbf28tIv2zBCrLtItI+DbHbxc9y5rz1mKnau1AxTYnsfuRm5aylGMvuPVhuG5e3VCrEVnppsdg2MlWK8Ip3qhPn7j4xyjvR9fyJ/SNAqljfIYFiAxaEAgjh1fvkgZgnOS04mH+MtNw4Ib7OJcP6NcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FokUEpYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7FAC19425;
	Tue, 21 Apr 2026 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776731819;
	bh=vQNrpRb2Y2u/E42xvlMNCUcD2QXuD22cBcQ8aI2+HSE=;
	h=From:Date:Subject:To:Cc:From;
	b=FokUEpYGAs2H3QPJ0exQEyw4JBfJztkZ6M2L3iaG6/AYkh2COYUHmsJ0dv4JfIKSi
	 1ggycskr8qsoRmbe/SuV/K8YoJoiA6gSy3oJkUvuZSIxDfAFYJTOlfyMFyM3bOWCyW
	 zkx+iSg9ev6e149ZWiGBCx5eC0s7un1LL2ugkGRBDPPes3m6HD0eE8FdNGxP90NfdG
	 UnzWKHyj1JIiujwtPH+4J+q0kjzzmwU7Royfk0iKwpBq9MA6aOAJ1QFhCfHLr+viyh
	 VAkfJO5fxMZbxOv2BcN1+a6DSmwCxQV/tsvNZp67yjJBf7pe2iakbbXCOQFve35l2j
	 gcc0E1fadPm0w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 20 Apr 2026 17:36:46 -0700
Subject: [PATCH stable] scripts/dtc: Remove unused dts_version in
 dtc-lexer.l
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-stable-dts-unused-but-set-global-v1-1-9bdfba6889bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSwrDMAwFrxK0rsAxbaC9SunCHyVVMU6x5FAIu
 XucZjkDb94KQoVJ4NGtUGhh4Tk36C8dhLfLEyHHxmCNHczVGhR1PhFGFay5CkX0VVFIcUqzdwk
 j3YO5hd6Og4OW+RYa+fe/eMK5htfppfoPBT36sG07VoFObowAAAA=
X-Change-ID: 20260420-stable-dts-unused-but-set-global-de9c05c12f6a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, devicetree@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=nathan@kernel.org;
 h=from:subject:message-id; bh=vQNrpRb2Y2u/E42xvlMNCUcD2QXuD22cBcQ8aI2+HSE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJnPjq1a/2ZCnBdnWb2YnOfTx0d/sb+/Gji94fBen92+h
 fYd/6sKOkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEJLkZGTYc+fJ+euXU79dn
 nS1XKHM33HO7oYgl/6HGBhOTjOzSGSsY/mdynpC/PCWjq+/7aZ8Hp3f9vvSuZPKy4IpAu4yHZyY
 vfMcOAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240015-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E566D435238
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
This should apply cleanly to all supported stable branches.
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
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260420-stable-dts-unused-but-set-global-de9c05c12f6a

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


