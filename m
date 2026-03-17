Return-Path: <stable+bounces-226695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPtVOPSMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:18:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C12AF4D3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF20B3061533
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFC2FE579;
	Tue, 17 Mar 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nc2SXbR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87D1A9B58;
	Tue, 17 Mar 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767856; cv=none; b=Fqo3eTclqX7GfnL3LJG1pTGmW+D8lSZzYAuaVKdr/QDj95zKAaZ0z4vCiWSJJ31/Beff5ewNDw/WWVOI+SA6tCjzusUi38cDahND/UWqlZ2r/hODj8tVNOvaoM8fe8u5lXWkQBN7OvX58JJsJNOJMY7QtpGB7fucqEqlX4w+s1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767856; c=relaxed/simple;
	bh=49m9qf5Vwv8UN9M8hcS9VitzapDCqqM5Jh+9QH68oVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkeAiY2Hs/qXd8I1c98IKasgUs3YtxPW35KPlm8dMb8pICP+rEDr4BoUcGzHvTMYxkI5z+OcJTNJTXtmEyxf6jYJWoF0vE6EeMl0xZWn9WSXmpmfEOj6n22bt9Olz8fN7pIj5uHQ4BWNTlln/mIiZgZpUFXQnjl/fZ9sQzoZjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nc2SXbR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6626C4CEF7;
	Tue, 17 Mar 2026 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767856;
	bh=49m9qf5Vwv8UN9M8hcS9VitzapDCqqM5Jh+9QH68oVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nc2SXbR4231fWXRsXTRSYBDvQF+ZrvUgqph3IvDm2WPPw5qdkod4uIqAN4UaTi0pK
	 ZKgPSOcBEHxBZ1lmlNErruHD6u9L3nJOfgjUjbj5LQqmqJpnvU6Prbbdbfbfk4MbXU
	 RFD0rhLggLq5rETAOAvR2BhArfBBM+Ne2bhzx3a4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hristo Venev <hristo@venev.name>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.18 171/333] ceph: do not skip the first folio of the next object in writeback
Date: Tue, 17 Mar 2026 17:33:20 +0100
Message-ID: <20260317163005.700542352@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226695-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,venev.name,ibm.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,venev.name:email,ceph.com:url]
X-Rspamd-Queue-Id: 654C12AF4D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hristo Venev <hristo@venev.name>

commit 081a0b78ef30f5746cda3e92e28b4d4ae92901d1 upstream.

When `ceph_process_folio_batch` encounters a folio past the end of the
current object, it should leave it in the batch so that it is picked up
in the next iteration.

Removing the folio from the batch means that it does not get written
back and remains dirty instead. This makes `fsync()` silently skip some
of the data, delays capability release, and breaks coherence with
`O_DIRECT`.

The link below contains instructions for reproducing the bug.

Cc: stable@vger.kernel.org
Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Link: https://tracker.ceph.com/issues/75156
Signed-off-by: Hristo Venev <hristo@venev.name>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/addr.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1334,7 +1334,6 @@ int ceph_process_folio_batch(struct addr
 		} else if (rc == -E2BIG) {
 			rc = 0;
 			folio_unlock(folio);
-			ceph_wbc->fbatch.folios[i] = NULL;
 			break;
 		}
 



