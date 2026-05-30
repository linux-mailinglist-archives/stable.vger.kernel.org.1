Return-Path: <stable+bounces-258579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NyvNjEpG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BD4611584
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC32C308131C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48978223DC6;
	Sat, 30 May 2026 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPJ6nf/G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080829B799;
	Sat, 30 May 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164822; cv=none; b=pMRrYRa6jGr3ntmZ2bn6GsECufqgY2yc2wVkNKOVh6NfXm4hTJaLGv4KeSYCQ+3FOk3uCHzmc6HRTuV1x3U651jqseLdIEUQCktdcP/Bfbr2F6ZgOIzHk7Y3UGpBy12oUHZBiMOJwBFLhuS6s9vPbvkoU9EWwAZfsG2oS0SKlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164822; c=relaxed/simple;
	bh=KZvanTeFuommuvsENPU0JA3VW3+dUN2pTq664KNhfio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVT964j0VDlcFI98NJKGGPGj+sa0yTcHOyY1D2LB6XDoRrpn8ecB0XjR+e0LPFV42fEkR6jVRthNZiE0rp5Me7Dv6dIXW6TBPPzql35RGLyk8/2D+Taf1+q5dCvaggREES9musdCZAWf5H2M/a8EP6U5bORCG+aRTTZnF6LRnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPJ6nf/G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C501F00898;
	Sat, 30 May 2026 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164821;
	bh=jiVAuPLPWdtUPrmPnfpTpNw2zd8zR/JK+rlyYW9hhJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPJ6nf/G0nZhZ5b86LUoJDcto6tYL9woj03Q+/gVbXoj2r3LZysOUg3V9u+NpEfQE
	 pDFsCH5miKWFSGT5eDT2MzKORNyFbd4BIdh6aIpRTu4RFSopnUOEZDoSJ/uNBPzPxa
	 XEVGyiqF/w+GV0z99hb37quxPK/FSmhLsJUGdDnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricardo Robaina <rrobaina@redhat.com>,
	Sergio Correia <scorreia@redhat.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.15 652/776] audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV
Date: Sat, 30 May 2026 18:06:06 +0200
Message-ID: <20260530160256.768542947@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-258579-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,paul-moore.com:email]
X-Rspamd-Queue-Id: 62BD4611584
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergio Correia <scorreia@redhat.com>

commit f9e1c1324b4d98d591a6f7568fdebf5cf456dfc2 upstream.

AUDIT_ADD_RULE and AUDIT_DEL_RULE correctly check for AUDIT_LOCKED
and return -EPERM, but AUDIT_TRIM and AUDIT_MAKE_EQUIV do not. This
allows a process with CAP_AUDIT_CONTROL to modify directory tree
watches and equivalence mappings even when the audit configuration
has been locked, undermining the purpose of the lock.

Add AUDIT_LOCKED checks to both commands.

Cc: stable@vger.kernel.org
Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Sergio Correia <scorreia@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/audit.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1430,6 +1430,8 @@ static int audit_receive_msg(struct sk_b
 		err = audit_list_rules_send(skb, seq);
 		break;
 	case AUDIT_TRIM:
+		if (audit_enabled == AUDIT_LOCKED)
+			return -EPERM;
 		audit_trim_trees();
 		audit_log_common_recv_msg(audit_context(), &ab,
 					  AUDIT_CONFIG_CHANGE);
@@ -1442,6 +1444,8 @@ static int audit_receive_msg(struct sk_b
 		size_t msglen = data_len;
 		char *old, *new;
 
+		if (audit_enabled == AUDIT_LOCKED)
+			return -EPERM;
 		err = -EINVAL;
 		if (msglen < 2 * sizeof(u32))
 			break;



