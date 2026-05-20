Return-Path: <stable+bounces-251188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLgvKOMVDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:13:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195B85994C2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED2AD323E383
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F93F4124;
	Wed, 20 May 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8FkV0+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935F3D8137;
	Wed, 20 May 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297329; cv=none; b=YOpo6Gn/c7jGaAfmJXU5t5u52KHgy1P4UYIKABW8I1QsDl55TBTWGMWpu+wKHUn8RJzz0/UVy91jniQlnI0Dx3OXGXgAfAIYX1wkfcVSeOfcCIBVG+8F8CGEdxlWa73eU3e1Tpr/1xExUMXzJX+Qe5ed7XejkYmerLYJh+Di++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297329; c=relaxed/simple;
	bh=KtDkyEbi5kQCXjyzdTO7BtXQ8W3FRDkcPLjyAL2b9A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHOvy8lNBD9/3L9tkarDPxm07ZRjPyKxxjgRjaIpj7EjQeu4ZJeamcEja2soivia6dc1DADTpFq2MquvS27pn7PPXXhh+RVjnbQVk1q3TLZdRSkYQrsSU9KNt63V6DWOsb8PJP7sNkxVer/v3YGf9Dnb6QnK0Gkg43ixkWVkRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8FkV0+u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A781F00893;
	Wed, 20 May 2026 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297328;
	bh=aTGfqL+PAwvIFlov48O4bGYzK+Ee1468MNfJztO8QVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8FkV0+uVr4yyqHUg5aPhid7qr7Ka1aeFkg4zsrJZfDpwj0xCQaj5SC7Wlw20uim6
	 k+mcg/367ds450WgSPS/ZHkiSuEBBUcYSfTv2PQZ7vHdFSrwddjkRfTcHThBjFKP/E
	 A9ccfOXYKUzP8Cgm9zGgLygXDS6WmYM9sl+zOKC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hristo Venev <hristo@venev.name>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7.0 1096/1146] ceph: put folios not suitable for writeback
Date: Wed, 20 May 2026 18:22:26 +0200
Message-ID: <20260520162213.046718077@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251188-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,venev.name,ibm.com,gmail.com];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,ceph.com:url]
X-Rspamd-Queue-Id: 195B85994C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hristo Venev <hristo@venev.name>

commit 544576f0f05c4a759806acddfaaeb686f14fb4b0 upstream.

The batch holds references to the folios (see `filemap_get_folios`,
`folio_batch_release`), so we need to `folio_put` the folios we remove.

Tested on v6.18.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/74156
Signed-off-by: Hristo Venev <hristo@venev.name>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/addr.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1322,6 +1322,7 @@ void ceph_process_folio_batch(struct add
 						  ceph_wbc, folio);
 		if (rc == -ENODATA) {
 			folio_unlock(folio);
+			folio_put(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			continue;
 		} else if (rc == -E2BIG) {
@@ -1332,6 +1333,7 @@ void ceph_process_folio_batch(struct add
 		if (!folio_clear_dirty_for_io(folio)) {
 			doutc(cl, "%p !folio_clear_dirty_for_io\n", folio);
 			folio_unlock(folio);
+			folio_put(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			continue;
 		}



