Return-Path: <stable+bounces-220582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Kx2HlU/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A71C6CB3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4475368ABF8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3C3DEAA4;
	Sat, 28 Feb 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKj+f8Rm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25C3DEA9D;
	Sat, 28 Feb 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300464; cv=none; b=IrfDkn7XFUPGV25oogvpzpz16aZIlxFepXDEz9Jw6dUcmr2+4DYWpiSOdWyzUCvJ/sonNXYRkx7PSBpAV+jmVSVOyyQBc8Bg2FcN8Rsf1QLx+FQrosv90kBHdmkTbyMx5dNS8ZIAQQ5W/uYXnGXuHpI0KjUAlbpcnamFoz+NWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300464; c=relaxed/simple;
	bh=NjVMZIFF01Ct9/8k1rhQgQ8mLN3iYbuKfSR59VHi294=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le3AbO57d4mZaC0sOCTY5mh2I5qn7DTYHvyyYvdzX3OB3cnGpeekbTr4V/aJ9hbVs1vYELvn81M/t8l8c58MPmZErACtQYdJOToHVGFxIVzVj9McwZKo+KgarM8q2TsJWxpu3pJ0sTuVSQkrIWutOGh20/HW0dvjGeWApgEH65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKj+f8Rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7D7C116D0;
	Sat, 28 Feb 2026 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300464;
	bh=NjVMZIFF01Ct9/8k1rhQgQ8mLN3iYbuKfSR59VHi294=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKj+f8RmN8TwedLYoZ8XorqkdCxWJg0hUaO381KfV9DoYkK17zfk0oAEdAzSfwvDv
	 w27cUEGQDWqyJVisK6i8BYZc7KxVpJxHYK5RdqaxTlsizmefKFDIgRYomC5KGw7qgW
	 chtEvW6sV+pzg0cDAfTMn+CApcM75qXiMOIi0AsgWdjuOg0yXlG+GkFKQa1ShTqUAN
	 Q+NMCME89oY/FZw7a33i/Wlus2g0hegkFk3mAKY/EHfSGIjbSsR2X1kTqtIvM0FJjw
	 VbmMrPKZuAsyQYXxQoh5qUF9kfKBlm2TR5j1UVamXHPOfeVe+g0LI14ebl/q/8ZkC2
	 OtChCADGIpCQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vahagn Vardanian <vahagn@redrays.io>,
	Florian Westphal <fw@strlen.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 503/844] netfilter: nf_conntrack_h323: fix OOB read in decode_choice()
Date: Sat, 28 Feb 2026 12:26:56 -0500
Message-ID: <20260228173244.1509663-504-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220582-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,strlen.de:email,redrays.io:email]
X-Rspamd-Queue-Id: F32A71C6CB3
X-Rspamd-Action: no action

From: Vahagn Vardanian <vahagn@redrays.io>

[ Upstream commit baed0d9ba91d4f390da12d5039128ee897253d60 ]

In decode_choice(), the boundary check before get_len() uses the
variable `len`, which is still 0 from its initialization at the top of
the function:

    unsigned int type, ext, len = 0;
    ...
    if (ext || (son->attr & OPEN)) {
        BYTE_ALIGN(bs);
        if (nf_h323_error_boundary(bs, len, 0))  /* len is 0 here */
            return H323_ERROR_BOUND;
        len = get_len(bs);                        /* OOB read */

When the bitstream is exactly consumed (bs->cur == bs->end), the check
nf_h323_error_boundary(bs, 0, 0) evaluates to (bs->cur + 0 > bs->end),
which is false.  The subsequent get_len() call then dereferences
*bs->cur++, reading 1 byte past the end of the buffer.  If that byte
has bit 7 set, get_len() reads a second byte as well.

This can be triggered remotely by sending a crafted Q.931 SETUP message
with a User-User Information Element containing exactly 2 bytes of
PER-encoded data ({0x08, 0x00}) to port 1720 through a firewall with
the nf_conntrack_h323 helper active.  The decoder fully consumes the
PER buffer before reaching this code path, resulting in a 1-2 byte
heap-buffer-overflow read confirmed by AddressSanitizer.

Fix this by checking for 2 bytes (the maximum that get_len() may read)
instead of the uninitialized `len`.  This matches the pattern used at
every other get_len() call site in the same file, where the caller
checks for 2 bytes of available data before calling get_len().

Fixes: ec8a8f3c31dd ("netfilter: nf_ct_h323: Extend nf_h323_error_boundary to work on bits as well")
Signed-off-by: Vahagn Vardanian <vahagn@redrays.io>
Signed-off-by: Florian Westphal <fw@strlen.de>
Link: https://patch.msgid.link/20260225130619.1248-2-fw@strlen.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 540d97715bd23..62aa22a078769 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -796,7 +796,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
 
 	if (ext || (son->attr & OPEN)) {
 		BYTE_ALIGN(bs);
-		if (nf_h323_error_boundary(bs, len, 0))
+		if (nf_h323_error_boundary(bs, 2, 0))
 			return H323_ERROR_BOUND;
 		len = get_len(bs);
 		if (nf_h323_error_boundary(bs, len, 0))
-- 
2.51.0


