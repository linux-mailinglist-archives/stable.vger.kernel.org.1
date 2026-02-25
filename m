Return-Path: <stable+bounces-219419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB26FuSdnmk5WgQAu9opvQ
	(envelope-from <stable+bounces-219419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB4192B05
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 940AC3034984
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3242D839C;
	Wed, 25 Feb 2026 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SEeDyc95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F103033CB;
	Wed, 25 Feb 2026 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002703; cv=none; b=h2TqkvyYzHiXNina+k1B1IrXAud6pec4DH5EnAfYqgTN/L9GLZu7ck9lhxG5fawiiXfbkGuxtgbtqfkwsMiMLVl2O1E+PHGUmSFhGqpW5oAYMUBUMCPmGTnT3uU4q28aOWDvBqyrWPJfCdtfwBfWCBBvKTO+M/3wc0NqU0+Y1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002703; c=relaxed/simple;
	bh=VbrUGBZGP0Umsdg/Wej9heXyuwnPZd4SNdgJAmVgoQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtYkyP9ouskXB2+8CcSI0WEJykMZY3PpB2V/fCIQ7jFWP3+2ec9Y+Yt+RVwcmJHeXt6SY7F2wHQPbK6rlvqvDeqn+dxXR6vsLsCd94OP7LEf2/xdCxU8wTdrnvBp26/HYwM2jsZe4I1hZexNYbJAuWUfRwGKwi+EBLGfQfXoXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SEeDyc95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C97FC116D0;
	Wed, 25 Feb 2026 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002703;
	bh=VbrUGBZGP0Umsdg/Wej9heXyuwnPZd4SNdgJAmVgoQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEeDyc95ggZ6c46MkB+wq5Wuy5rLjIeVVCEzxIc2td6ttsDQzQDmTQH/Y4PcWB6KN
	 rXpbY5KnsF4nnXDaacOl1A9VmsLU27drstAy+mE2mNar9tAlB/uMQsL+8zpM52tw8Z
	 Zwa9OlKDhsP0fSdv6lg7qWNMpe99aqaIfinim7xE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 502/641] fs/ntfs3: Fix slab-out-of-bounds read in DeleteIndexEntryRoot
Date: Tue, 24 Feb 2026 17:23:48 -0800
Message-ID: <20260225012400.683486233@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219419-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,paragon-software.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 38EB4192B05
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit b2bc7c44ed1779fc9eaab9a186db0f0d01439622 ]

In the 'DeleteIndexEntryRoot' case of the 'do_action' function, the
entry size ('esize') is retrieved from the log record without adequate
bounds checking.

Specifically, the code calculates the end of the entry ('e2') using:
    e2 = Add2Ptr(e1, esize);

It then calculates the size for memmove using 'PtrOffset(e2, ...)',
which subtracts the end pointer from the buffer limit. If 'esize' is
maliciously large, 'e2' exceeds the used buffer size. This results in
a negative offset which, when cast to size_t for memmove, interprets
as a massive unsigned integer, leading to a heap buffer overflow.

This commit adds a check to ensure that the entry size ('esize') strictly
fits within the remaining used space of the index header before performing
memory operations.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 38934e6978ece..28bd611f580d9 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3429,6 +3429,9 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 		e1 = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
 		esize = le16_to_cpu(e1->size);
+		if (PtrOffset(e1, Add2Ptr(hdr, used)) < esize)
+			goto dirty_vol;
+
 		e2 = Add2Ptr(e1, esize);
 
 		memmove(e1, e2, PtrOffset(e2, Add2Ptr(hdr, used)));
-- 
2.51.0




