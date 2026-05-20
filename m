Return-Path: <stable+bounces-251834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCOtChkfDmpd6QUAu9opvQ
	(envelope-from <stable+bounces-251834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:52:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD159A3D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B802A3771B1D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE33A3E60;
	Wed, 20 May 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ss/XzQJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB5369D7E;
	Wed, 20 May 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299010; cv=none; b=XIbRdrCVZDLkoP2IRzOYtVMrK5/nWh+qt7r/LzHxYxYibR6oR889DyLl2GgfyMSlB1JLG0NuzTrLAr55tWCofVeMYCOAGI9z2aNL/YRsycxhq02LMXpbJcHwbIp6AHEWHPH7TNvXOwc2Lx4DXDo7xvRZEh6lxs699UCogOfsPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299010; c=relaxed/simple;
	bh=BPLUAeytY8dDlAfzAP2xz8NsIdMsweg7ObeObAlFiCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScSeCXm4mTRHcq7j79K8/nx/oYfg7pavehiNRMCQfBwK94/zO81M/DnzeNST+h/1qwRLQ2ZkGHBqjJ2ku2uwSDXimmmh3QFQkWvKED0pzQZmRGhJwgz0pyI8BnWaXAKM9UtN15zaIynq6nyilmN0J+D3aJ9KhKde/27XzakNumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ss/XzQJR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B8C1F000E9;
	Wed, 20 May 2026 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299009;
	bh=lZxv4w2AXoMS7vEayEVISYD2JsAhiNIzaL5FXYakdxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ss/XzQJRg//rFQZwE5si/DtsCRzSYyBRbp+G4KzYqybBhc7B28lp/bMeQ6DlXChZs
	 2YZgQ9xroYshApAmRWQdMbTsekOpte17e0DXktUMp3rHk9ttUph0KJ6vXYwbz8dXdO
	 h8SuJzff8PIscZhv6Tg8N4ARaro83UgjmKiA+Qts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 629/957] tcp: move tp->chrono_type next tp->chrono_stat[]
Date: Wed, 20 May 2026 18:18:32 +0200
Message-ID: <20260520162148.169922200@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251834-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A3AD159A3D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4b78c9cbd8f1fbb9517aee48b372646f4cf05442 ]

chrono_type is currently in tcp_sock_read_txrx group, which
is supposed to hold read-mostly fields.

But chrono_type is mostly written in tx path, it should
be moved to tcp_sock_write_tx group, close to other
chrono fields (chrono_stat[], chrono_start).

Note this adds holes, but data locality is far more important.

Use a full u8 for the time being, compiler can generate
more efficient code.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Link: https://patch.msgid.link/20260308122302.2895067-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 267bf3cf9a6f ("tcp: annotate data-races in tcp_get_info_chrono_stats()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef3..8e1266cf8ef69 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -231,8 +231,7 @@ struct tcp_sock {
 	u32	sacked_out;	/* SACK'd packets			*/
 	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
 	u8	scaling_ratio;	/* see tcp_win_from_space() */
-	u8	chrono_type : 2,	/* current chronograph type */
-		repair      : 1,
+	u8	repair      : 1,
 		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
 		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
@@ -267,6 +266,7 @@ struct tcp_sock {
 				 * total number of data bytes sent.
 				 */
 	u32	snd_sml;	/* Last byte of the most recently transmitted small packet */
+	u8	chrono_type;	/* current chronograph type */
 	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
 	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
 	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
-- 
2.53.0




