Return-Path: <stable+bounces-251170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC2ZOesXDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:22:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F75997DF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D49631BFADF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF03ED3A4;
	Wed, 20 May 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gAf3VSMH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09E3A3833;
	Wed, 20 May 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297282; cv=none; b=Dv7/QZZ9ilbr96ag7y59Q1wLdZ0folnmbn+zhJNYNpqXdsjftigs0RXQVfEJWbZi8BnduQ+Cbn6pJX/dOuS4J1J4kqYc58mCwSe/TWvAA5SdDx3+d3WSANB+1M1rvvZu715cpkE7hslMuD0b+NQjN8PIZC0/+KZHxz68Xsk3HgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297282; c=relaxed/simple;
	bh=Pb9EkSAfdKYYUB0ULC0G4KKOJ4YvX2a8csTHwJFxNB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucoFcDUVxmnUXj7qYJCZZBlWarQbjtBHpbbZd3zZ+sA6aCdsKz7+lBQPprjXQTW3hOOvQsc7LkPfB5KQPvbP36DYwAFronl3/SKukJEmFDEVojr784dqQlabBPNB2ct97lwQ6OxDgdTS9W7eT12fbHzhOEOByIBbR2wBNjMN0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gAf3VSMH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C78F1F000E9;
	Wed, 20 May 2026 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297280;
	bh=6LMRrPcw4YWKmHAfHN6YrKULMNVWTzURLiZtYz4Az4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gAf3VSMHzYw9ezYtS+lHdiHamksQuPyn8Gy+2yw2OpxmsZDwFChSLL4pQYsdMfcmt
	 XxmlIMWCQRJVN5KeWue21/3hCaYULfTMpBH9SGtz+/TdGZSg7VYXoTDGOvO5cvG1MW
	 vtLgnP0U3qevgkEz67To+FIqv6dHJyulekzqmasU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7.0 1118/1146] libceph: handle rbtree insertion error in decode_choose_args()
Date: Wed, 20 May 2026 18:22:48 +0200
Message-ID: <20260520162213.544777296@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251170-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tu-ilmenau.de,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tu-ilmenau.de:email]
X-Rspamd-Queue-Id: 933F75997DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>

commit d289478cfc0bcf81c7914200d6abdcb78bd04ded upstream.

A message of type CEPH_MSG_OSD_MAP contains an OSD map that itself
contains a CRUSH map. The received CRUSH map may optionally contain
choose_args that get decoded in decode_choose_args(). In this function,
num_choose_arg_maps is read from the message, and a corresponding number
of crush_choose_arg_maps gets decoded afterwards. Each
crush_choose_arg_map has a choose_args_index, which serves as the key
when inserting it into the choose_args rbtree of the decoded crush_map.
If a (potentially corrupted) message contains two crush_choose_arg_maps
with the same index, the assertion in insert_choose_arg_map() triggers a
kernel BUG when trying to insert the second crush_choose_arg_map.

This patch fixes the issue by switching to the non-asserting rbtree
insertion function and rejecting the message if the insertion fails.

[ idryomov: changelog ]

Cc: stable@vger.kernel.org
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/osdmap.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -394,7 +394,10 @@ static int decode_choose_args(void **p,
 				goto e_inval;
 		}
 
-		insert_choose_arg_map(&c->choose_args, arg_map);
+		if (!__insert_choose_arg_map(&c->choose_args, arg_map)) {
+			ret = -EEXIST;
+			goto fail;
+		}
 	}
 
 	return 0;



