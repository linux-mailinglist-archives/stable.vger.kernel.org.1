Return-Path: <stable+bounces-226850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMvYKkCPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:28:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6482AFA1B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBBDE3030481
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32993336880;
	Tue, 17 Mar 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EItujorE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994B2D739D;
	Tue, 17 Mar 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768470; cv=none; b=dnUJb0vBRlg5KOUbOmi7Zhrlkkf0+FA5U9R8oHlAX6E3kTM5mHLo8B1coxGnYyQqLGMra26najXljveti+kdzIo0n2HL1laY0KBeeOLcQmpdlzzPlID97vOz7dfkPSmNf9KxFNGOcBSVCPrpjhZekI+ujMcDY0D8mpNQWNRRIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768470; c=relaxed/simple;
	bh=cR2PQx/aEv0EtFuKYTovJjwgkanBmdIfvgTLUxjkeaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDMlFSMtiBPcgI37dFl2aRDu0YrW6x+BVui3kC1DKkDODDH5hvqHfuA6rnu0nLu+kwsfLCxQ73UeSvXI0WbmUyu3bTIvY1/Jhmr/JuOSbJXVVVkn0CjcOaeOCa33SPZ/CRpIHEZ+gDVgt8WpGKg49S36f4oDNa9ch8UBS4Sa3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EItujorE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12757C4CEF7;
	Tue, 17 Mar 2026 17:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768469;
	bh=cR2PQx/aEv0EtFuKYTovJjwgkanBmdIfvgTLUxjkeaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EItujorENwSBtON7CV7NxEtH3QdyfYHBK19BK8D2kYIATWcUKYv+CeyWiZu6Gx4I1
	 ty3Wd6VOUgpDrbm6uAUj6mh62/ZyojUXjufsNUqaAh1EpXcw03fMCly0ocY8Eh4qzn
	 cn1dC9g/kTBM3I+/LpKvpD1CzHV+bhslp485pzao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 6.18 283/333] lib/bootconfig: check bounds before writing in __xbc_open_brace()
Date: Tue, 17 Mar 2026 17:35:12 +0100
Message-ID: <20260317163009.885674743@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-226850-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,objecting.org:email]
X-Rspamd-Queue-Id: 3B6482AFA1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Law <objecting@objecting.org>

commit 560f763baa0f2c9a44da4294c06af071405ac46f upstream.

The bounds check for brace_index happens after the array write.
While the current call pattern prevents an actual out-of-bounds
access (the previous call would have returned an error), the
write-before-check pattern is fragile and would become a real
out-of-bounds write if the error return were ever not propagated.

Move the bounds check before the array write so the function is
self-contained and safe regardless of caller behavior.

Link: https://lore.kernel.org/all/20260312191143.28719-3-objecting@objecting.org/

Fixes: ead1e19ad905 ("lib/bootconfig: Fix a bug of breaking existing tree nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Josh Law <objecting@objecting.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/bootconfig.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -532,9 +532,9 @@ static char *skip_spaces_until_newline(c
 static int __init __xbc_open_brace(char *p)
 {
 	/* Push the last key as open brace */
-	open_brace[brace_index++] = xbc_node_index(last_parent);
 	if (brace_index >= XBC_DEPTH_MAX)
 		return xbc_parse_error("Exceed max depth of braces", p);
+	open_brace[brace_index++] = xbc_node_index(last_parent);
 
 	return 0;
 }



