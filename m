Return-Path: <stable+bounces-239395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WErpBbtc5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:04:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CD430818
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BB4234D649F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FF33E377;
	Mon, 20 Apr 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvMGAm7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5833D6FC;
	Mon, 20 Apr 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700137; cv=none; b=RX7sx8IdnGYk2HMZIZxUpn8Jk+tyi1wucy+4CllW8t979xieqyzSPG4bOS/YhfOD49ha++0YVZmVDfWpehJNv/CEuooB1VTqokKkhk+5LAOcLqNow0cPhCuVMtUVGpSI9IK15YN5gIFd9OCnCNj9rSV4w1pQYwM7v6x38Dn9uBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700137; c=relaxed/simple;
	bh=263tf+q1ugULV8KfdHSKfHQXlgU8ghkJSkV+R3NqIJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDMSfP9fZeKdmnR7rRkVEqr0l4OP5gktIBz+VbylE7y8/WKV8pM7HERQv/wgY5x1b+iSQv53KSSMQUUtib/pM+Zk+X6nGAy8UOyob+d6hTdfZ0Qqj8dU6WZd7GslKyA77KK39+LU9UxoFjVnjRUK3Jaf65XNxDOfZ5FC22qm4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvMGAm7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71D3C19425;
	Mon, 20 Apr 2026 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700137;
	bh=263tf+q1ugULV8KfdHSKfHQXlgU8ghkJSkV+R3NqIJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvMGAm7qZIsXs/gD98qe5xrX5ZM9oBTx8YYWPyjFSIoxHGde1JO7y8xUn591Z6LmQ
	 NCv6bj/IjbcfRlTgMWjNO7fwvgZA1x+6Q2n1OKASlDRlsmPdzC8w96oMxojPKc3NpP
	 CQwCAUhkYnfEaf7KHgGLNsoRCNF4gtFdWn+n0zBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 056/220] tools/power turbostat: Fix swidle header vs data display
Date: Mon, 20 Apr 2026 17:39:57 +0200
Message-ID: <20260420153936.056810764@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239395-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: AF3CD430818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Len Brown <len.brown@intel.com>

[ Upstream commit b8ead30e2b2c7f32c8d2782e805160b110766592 ]

I changed my mind about displaying swidle statistics,
which are "added counters".  Recently I reverted the
column headers to 8-columns, but kept print_decimal_value()
padding out to 16-columns for all 64-bit counters.

Simplify by keeping print_decimial_value() at %lld -- which
will often fit into 8-columns, and live with the fact
that it can overflow and shift the other columns,
which continue to tab-delimited.

This is a better compromise than inserting a bunch
of space characters that most users don't like.

Fixes: 1a23ba6a1ba2 ("tools/power turbostat: Print wide names only for RAW 64-bit columns")
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1b26d94c373fb..903943d30f713 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2747,10 +2747,9 @@ static inline int print_hex_value(int width, int *printed, char *delim, unsigned
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
-	if (width <= 32)
-		return (sprintf(outp, "%s%d", (*printed++ ? delim : ""), (unsigned int)value));
-	else
-		return (sprintf(outp, "%s%-8lld", (*printed++ ? delim : ""), value));
+	UNUSED(width);
+
+	return (sprintf(outp, "%s%lld", (*printed++ ? delim : ""), value));
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
-- 
2.53.0




