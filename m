Return-Path: <stable+bounces-251965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBpFOZD9DWo95QUAu9opvQ
	(envelope-from <stable+bounces-251965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:29:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550C59657D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2126E32FF554
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1D3F44F7;
	Wed, 20 May 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9t6mBSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBD233933;
	Wed, 20 May 2026 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299391; cv=none; b=sZXaApDbN2gaB+Q8QL4zMIQeDmI3qpAgvR/JKlVhoKBPOcujhCGwNgbc+5D/ZAbZNFIrCy3EH0JWKbw0iTXPdoI2plCFj2xnJgz04jdzwGxR2Kr2VgK4LDuUmXTuuYl2Wy2FuXMnQAsJ1OAWQvhxdoFCtQvUEJMiJCGRe43d3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299391; c=relaxed/simple;
	bh=iF6vkfrlB+hkAjHibw73A19lZkRYGv/qeRCTjPpNRKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ddlk/tAV4bv2L33wBeSTjmHQDryoJJ3Xkha4cXJyEzuVbTGOKYPjAFFFeP5W4x/J1XJwPpN91VqWMHDyXHVh753JfrX6vX8fm9vZ4q+BWhn9qCDZoKA8IAFlr6jrpqDuQCnJffzU6J26Fk05efdsfnjaVERmtV+vX0bcT2wQ97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9t6mBSh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883241F000E9;
	Wed, 20 May 2026 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299390;
	bh=8m0izHOHDuXM3D9+pQ56KhHTAXVA2EPj2mW+9mqhb0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9t6mBSh5+BUM0uwvK5tzB+/lS+YgiYcv/Jkz5UBQFVYaZbq2muKgB0comNlJuaAP
	 4bUaav1eQvwocH6c4M+o07UcukuquR+yuG9DETzU4T+Z0FNeOqpw3WX4Sw1UWtFqQC
	 kMAVmgCEKTYUCDNWOsgSqFKClc8mudkYyvIHMgx8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 712/957] nfp: fix swapped arguments in nfp_encode_basic_qdr() calls
Date: Wed, 20 May 2026 18:19:55 +0200
Message-ID: <20260520162149.987610557@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251965-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2550C59657D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

[ Upstream commit 4078c5611d7585548b249377ebd60c272e410490 ]

There is a mismatch between the passed arguments and the actual
nfp_encode_basic_qdr() function parameter names:

  static int nfp_encode_basic_qdr(u64 addr, int dest_island, int cpp_tgt,
                                  int mode, bool addr40, int isld1,
                                  int isld0)
  {
      ...

But "dest_island" and "cpp_tgt" are swapped at every call-site.
For example:

  return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
                              mode, addr40, isld1, isld0);

As a result, nfp_encode_basic_qdr() receives "dest_island" as CPP target
type, which is always NFP_CPP_TARGET_QDR(2) for these calls, and "cpp_tgt"
as the destination island ID, which can accidentally match or be outside
the valid NFP_CPP_TARGET_* types (e.g. '-1' for any destination).

Since code already worked for years, also add extra pr_warn() to error
paths in nfp_encode_basic_qdr() to help identify any potential address
verification failures.

Detected using the static analysis tool - Svace.

Fixes: 4cb584e0ee7d ("nfp: add CPP access core")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Link: https://patch.msgid.link/20260422160536.61855-1-aleksei.kodanev@bell-sw.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/netronome/nfp/nfpcore/nfp_target.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
index 79470f198a62a..9cf19446657c6 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
@@ -435,12 +435,17 @@ static int nfp_encode_basic_qdr(u64 addr, int dest_island, int cpp_tgt,
 
 	/* Full Island ID and channel bits overlap? */
 	ret = nfp_decode_basic(addr, &v, cpp_tgt, mode, addr40, isld1, isld0);
-	if (ret)
+	if (ret) {
+		pr_warn("%s: decode dest_island failed: %d\n", __func__, ret);
 		return ret;
+	}
 
 	/* The current address won't go where expected? */
-	if (dest_island != -1 && dest_island != v)
+	if (dest_island != -1 && dest_island != v) {
+		pr_warn("%s: dest_island mismatch: current (%d) != decoded (%d)\n",
+			__func__, dest_island, v);
 		return -EINVAL;
+	}
 
 	/* If dest_island was -1, we don't care where it goes. */
 	return 0;
@@ -493,7 +498,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * the address but we can verify if the existing
 			 * contents will point to a valid island.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		iid_lsb = addr40 ? 34 : 26;
@@ -504,7 +509,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 		return 0;
 	case 1:
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && !addr40)
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		idx_lsb = addr40 ? 39 : 31;
@@ -530,7 +535,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * be set before hand and with them select an island.
 			 * So we need to confirm that it's at least plausible.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		/* Make sure we compare against isldN values
@@ -551,7 +556,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * iid<1> = addr<30> = channel<0>
 			 * channel<1> = addr<31> = Index
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		isld[0] &= ~3;
-- 
2.53.0




