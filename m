Return-Path: <stable+bounces-218889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDIBI1RWnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:54:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E89190262
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54FF232DBEE1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D350D26FD93;
	Wed, 25 Feb 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mb6YUbrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4D26E6F4;
	Wed, 25 Feb 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983777; cv=none; b=P7j546rR3gYKpMH5BBOJjB22/8f4yVyjXSby+eAXAGvo3tBmYBU0sdwtYMTa6ZVkflgVVaWtkPyaBBD7OsO5njCbDU20nXXhKe8lA1bt5ImDt27hFR87WbRBuYXZGJIGJ7XRHwpxF3ab51BEy59XkBwYSQYTxgTOYQZ4ssQUkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983777; c=relaxed/simple;
	bh=y+FV5htgREM4ILZZcfxen1t3Oa5lL8FQE+WJXMYRpxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyKWED1rnHhQ5a2Ql+otWJB+dPfWvvfHlbNffpj9wRPmr+uwW5yZ4j5zuSQmfMGqRpN5Ig6+LxpDyRI+3eHvikB80KwtamuOd/eQqGHUkl77F6VZfOSA7gHDw7oRiHioNPaL26ergxLIntjWdtLuf9kOFoSe8EA0d82KIVRuUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mb6YUbrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57395C19423;
	Wed, 25 Feb 2026 01:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983777;
	bh=y+FV5htgREM4ILZZcfxen1t3Oa5lL8FQE+WJXMYRpxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mb6YUbrC+5aD4y51VGwaXuhYPH9nx6Tl8MEo+V9cqtFtwIecNoK+HFO0d3+pWG8PT
	 I3SiM4M48L7c7/dG+XArD5a/wJZMPRfwDfsjQu8BEoq6puTBalUvEiNfmMQCMERNUQ
	 K2kIswzeho9CCYWMkghwHLCzYD/xaRqgE4H0c4bk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harrison Green <harrisonmichaelgreen@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 067/641] libbpf: Fix OOB read in btf_dump_get_bitfield_value
Date: Tue, 24 Feb 2026 17:16:33 -0800
Message-ID: <20260225012350.684521043@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oracle.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218889-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email]
X-Rspamd-Queue-Id: B0E89190262
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varun R Mallya <varunrmallya@gmail.com>

[ Upstream commit 5714ca8cba5ed736f3733663c446cbee63a10a64 ]

When dumping bitfield data, btf_dump_get_bitfield_value() reads data
based on the underlying type's size (t->size). However, it does not
verify that the provided data buffer (data_sz) is large enough to
contain these bytes.

If btf_dump__dump_type_data() is called with a buffer smaller than
the type's size, this leads to an out-of-bounds read. This was
confirmed by AddressSanitizer in the linked issue.

Fix this by ensuring we do not read past the provided data_sz limit.

Fixes: a1d3cc3c5eca ("libbpf: Avoid use of __int128 in typed dump display")
Reported-by: Harrison Green <harrisonmichaelgreen@gmail.com>
Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260106233527.163487-1-varunrmallya@gmail.com

Closes: https://github.com/libbpf/libbpf/issues/928
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6388392f49a0b..53c6624161d79 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1762,9 +1762,18 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	__u16 left_shift_bits, right_shift_bits;
 	const __u8 *bytes = data;
 	__u8 nr_copy_bits;
+	__u8 start_bit, nr_bytes;
 	__u64 num = 0;
 	int i;
 
+	/* Calculate how many bytes cover the bitfield */
+	start_bit = bits_offset % 8;
+	nr_bytes = (start_bit + bit_sz + 7) / 8;
+
+	/* Bound check */
+	if (data + nr_bytes > d->typed_dump->data_end)
+		return -E2BIG;
+
 	/* Maximum supported bitfield size is 64 bits */
 	if (t->size > 8) {
 		pr_warn("unexpected bitfield size %d\n", t->size);
-- 
2.51.0




