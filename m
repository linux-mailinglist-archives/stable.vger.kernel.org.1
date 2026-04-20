Return-Path: <stable+bounces-239400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFnNBntX5ml5vAEAu9opvQ
	(envelope-from <stable+bounces-239400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89042FE00
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53C9D339D1CB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613B336EDE;
	Mon, 20 Apr 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WDlaEQqt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932A2D77E5;
	Mon, 20 Apr 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700150; cv=none; b=GpYcOM+ocdeIavBoavIMFaXtwU1QbHzjIsKwRfcyCJ9KcnJ7B8vA3bKypOOEZsU+Nh/SEhe6tQNohkfv+R2dfMkrIVjEp/PoMFUb3TPTwjhsVVNg/PIbUJkc1FV2mavOKq90jKboxRC4EDe8uwlBzTLyPIjb+PuERS+8Q+Z3mU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700150; c=relaxed/simple;
	bh=SUtC7y4j8mqSM6m8EyrewbOSuIaq2YH/JiGU5pMX2Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB5cgDOAlL+2KsUs3QyKFwX51NCvl0E3tJARC0yU+lLZjcq9PVaUVOKwSyEdfL3rI7atJydga7vRFU3aSpUFIpksO/d1KXnU7LcXH1UJNrLICyQQJeUUS3mojAyIv2jnFXsifrQclPwyXnjd9wsvOSIJyHM91wUYuj75H9a9ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WDlaEQqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEFCC2BCB4;
	Mon, 20 Apr 2026 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700149;
	bh=SUtC7y4j8mqSM6m8EyrewbOSuIaq2YH/JiGU5pMX2Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDlaEQqt51zcO0preSmZ7XA6JmBvjJ4XcS08AlkwsQQYFCsm+HeTV6f7AoKMX+N25
	 1/mu7vFOCblUFEHMLpcpm/M2fgepYamcTzXrznkN0S3VDt2ACUQLBhE/vczHWYMIdy
	 /V7e7lPW2fa7OPMVvOGwy4QYcWWugiaf5k85KxNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 061/220] tools/power turbostat: Fix delimiter bug in print functions
Date: Mon, 20 Apr 2026 17:40:02 +0200
Message-ID: <20260420153936.239042248@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239400-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CF89042FE00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

[ Upstream commit cdbefe9d4029d4834d404f7ba13a960b38a69e88 ]

Commands that add counters, such as 'turbostat --show C1,C1+'
display merged columns without a delimiter.

This is caused by the bad syntax: '(*printed++ ? delim : "")', shared by
print_name()/print_hex_value()/print_decimal_value()/print_float_value()

Use '((*printed)++ ? delim : "")' to correctly increment the value at *printed.

[lenb: fix code and commit message typo, re-word]
Fixes: 56dbb878507b ("tools/power turbostat: Refactor added column header printing")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b01a905bd24a7..c6060f65eaaf1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2732,29 +2732,29 @@ static inline int print_name(int width, int *printed, char *delim, char *name, e
 	UNUSED(type);
 
 	if (format == FORMAT_RAW && width >= 64)
-		return (sprintf(outp, "%s%-8s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%-8s", ((*printed)++ ? delim : ""), name));
 	else
-		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%s", ((*printed)++ ? delim : ""), name));
 }
 
 static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
 {
 	if (width <= 32)
-		return (sprintf(outp, "%s%08x", (*printed++ ? delim : ""), (unsigned int)value));
+		return (sprintf(outp, "%s%08x", ((*printed)++ ? delim : ""), (unsigned int)value));
 	else
-		return (sprintf(outp, "%s%016llx", (*printed++ ? delim : ""), value));
+		return (sprintf(outp, "%s%016llx", ((*printed)++ ? delim : ""), value));
 }
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
 	UNUSED(width);
 
-	return (sprintf(outp, "%s%lld", (*printed++ ? delim : ""), value));
+	return (sprintf(outp, "%s%lld", ((*printed)++ ? delim : ""), value));
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
 {
-	return (sprintf(outp, "%s%0.2f", (*printed++ ? delim : ""), value));
+	return (sprintf(outp, "%s%0.2f", ((*printed)++ ? delim : ""), value));
 }
 
 void print_header(char *delim)
-- 
2.53.0




