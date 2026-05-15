Return-Path: <stable+bounces-248123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJUeNp1IB2rUwQIAu9opvQ
	(envelope-from <stable+bounces-248123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:23:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E825553268
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FF80308822E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28613E009A;
	Fri, 15 May 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="An19j9WH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586E3BB116;
	Fri, 15 May 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860931; cv=none; b=bpVL+0iy3vWTDcCt11vgBgLCYNy05lSn55QSNTI6eVAiX018yuHQlX+ggRWYBFNnfKHLqhWN6LmLB9gTRuP8DBoVYNuzMiw+BAE7rbuWpmMqR4Iv2sEaRmGKmZ8xM1yBEgtrQGSJ/CwFjeN7IgSCOi09EvEcz7x9VwyhznmRqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860931; c=relaxed/simple;
	bh=aoLBnkuQBBvOEDZiU5HU+Hn/4IKstcfiyDn2REdFz1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to3vnYQwkbi9oEgzvosPEAjYOtsTph0hECyVSwGRbJuHa7hgJ8rb4y1U2lmRtMbcUT8U50YJ2hgE3d3/QRyYazbpPcKFIQ2B5hPjkKAwNWTetmY+vBSRGtufGQ2+oGUExAH8+e6Ljb/Hq7PWbNbT1nCueN4UdsBsEgv6/dkaZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=An19j9WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB86C2BCB0;
	Fri, 15 May 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860931;
	bh=aoLBnkuQBBvOEDZiU5HU+Hn/4IKstcfiyDn2REdFz1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=An19j9WHPBo8rByiFj+NO9C+BCZuCZsf1OPBFWya+Z2z/m1F85HiDe92R7Q5x0F1X
	 ZOGJapQLZx+lmi9AXwvNVmRcLkmnUzyEysjfXxCRmtpGc3lgX9wIQ78xg4uwZD+216
	 JGc2ICj1hsToZiGg5tb8UBNajjWv65ZCKIMJ4/1Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 134/474] seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode
Date: Fri, 15 May 2026 17:44:03 +0200
Message-ID: <20260515154717.930771774@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7E825553268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-248123-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,uniroma2.it,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Mayer <andrea.mayer@uniroma2.it>

commit ade67d5f588832c7ba131aadd4215a94ce0a15c8 upstream.

When SEG6_IPTUN_MODE_L2ENCAP_RED (L2ENCAP_RED) was introduced, the
condition in seg6_build_state() that excludes L2 encap modes from
setting LWTUNNEL_STATE_OUTPUT_REDIRECT was not updated to account for
the new mode.
As a consequence, L2ENCAP_RED routes incorrectly trigger seg6_output()
on the output path, where the packet is silently dropped because
skb_mac_header_was_set() fails on L3 packets.

Extend the check to also exclude L2ENCAP_RED, consistent with L2ENCAP.

Fixes: 13f0296be8ec ("seg6: add support for SRv6 H.L2Encaps.Red behavior")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Link: https://patch.msgid.link/20260418162838.31979-1-andrea.mayer@uniroma2.it
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -711,7 +711,8 @@ static int seg6_build_state(struct net *
 	newts->type = LWTUNNEL_ENCAP_SEG6;
 	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
 
-	if (tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP)
+	if (tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP &&
+	    tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP_RED)
 		newts->flags |= LWTUNNEL_STATE_OUTPUT_REDIRECT;
 
 	newts->headroom = seg6_lwt_headroom(tuninfo);



