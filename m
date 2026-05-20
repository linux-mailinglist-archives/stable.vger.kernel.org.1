Return-Path: <stable+bounces-251167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KON+OekXDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:22:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96C5997D1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171AB3037D62
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590EC3F44D9;
	Wed, 20 May 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAmzwk8y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C5356748;
	Wed, 20 May 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297274; cv=none; b=h3uQw1lSPLoohx+KL3urheLbvvg8RJXRdVMECISGthJkkp1zIC8sPBPXr1BmSAkL74qZn8W/oXv1qxKB4gp9tNlykzhRfvHUQRB8MM2bQ7cLWSCxl/O1OLD1T8dDReDOytbWKtZLXiw05yvVE2p/+G4B59T4aL2bxZRcXAU45yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297274; c=relaxed/simple;
	bh=xbRm/9KoIPHHopxtfySZQNa+kz7kI05N8Uy3p3v+czk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU6r/gctiBuXQshaETb2F3GoJEFaPkkr6UI+3Am024EEX5MWqUCZXAeFUlH4/2w70t4dI5xK+sQr0OD0vqOHhSL8wQyypeCfrIokk5cfuQ2g479fJfawoFYeG6iOcGlzR1ieYrIvpbnCwqNKwv/0SH1MkYSe28+GCQP0zYBrGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAmzwk8y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FCD1F000E9;
	Wed, 20 May 2026 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297273;
	bh=j110dhZmWKLYL3exbBkstm0R2tqAz3fbBaNFmJic8G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAmzwk8ys9pur1S+I4qWNS55yb19c5LtDr6OzJBB1YQgTBOP6YdLGTVNvK5qL6uE+
	 3cf4pDR7zV8i5nCri+vR+S6i2vdVzNgiwjkkS0k7vr+KT1fZMwivpiaA6EwbNf9Az/
	 LnGngOud9wOIQJ36jtydaFJRoBP4IgZ6ZgdSkCt4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7.0 1116/1146] libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
Date: Wed, 20 May 2026 18:22:46 +0200
Message-ID: <20260520162213.499494528@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251167-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tu-ilmenau.de,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 3D96C5997D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>

commit 821365487aa58d06bda65c676ba215d506ba9768 upstream.

In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
ceph_x_encrypt_header, and the magic field of this struct is accessed.
This happens without any guarantee that the buffer is large enough to
hold this struct. The function parameter ciphertext_len represents the
length of the ciphertext to decrypt and is guaranteed to be at most the
remaining size of the allocated buffer p. However, this value is not
necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a message
frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
the ciphertext at its end with a ciphertext_len of 8 or less, can
trigger an out-of-bounds memory access when accessing hdr->magic.

This patch fixes the issue by adding a check to ensure that the
decrypted plaintext in the buffer is large enough to represent at least
the ceph_x_encrypt_header.

Cc: stable@vger.kernel.org
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/auth_x.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct
 	if (ret)
 		return ret;
 
+	if (plaintext_len < sizeof(*hdr)) {
+		pr_err("%s plaintext too small %d\n", __func__, plaintext_len);
+		return -EINVAL;
+	}
+
 	hdr = p + ceph_crypt_data_offset(key);
 	if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
 		pr_err("%s bad magic\n", __func__);



