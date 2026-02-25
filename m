Return-Path: <stable+bounces-219442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBiRDn2gnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:10:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBA1930FA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B838831DEE8C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED927FB37;
	Wed, 25 Feb 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nE5VqYaa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B253148D5;
	Wed, 25 Feb 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002718; cv=none; b=CMM21WtAORAk7sC4gOjdAduU8iTskAUT6MbJsAwZIN63Oy6q60fPxCjuGV8hr3EYn6+yvhGALNSBnpdnJL3twSUJNaZl0MCGQym6RdJKrd2NcoU87kaNG75mtRA9jkpR9m5Wd/EwxWwjHZgWpGfaSisDJ9dmYjXI+xRmMdHHE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002718; c=relaxed/simple;
	bh=5mSbb/zI/q+MjQK/Yr1ai4JLJRxXZAmrMZMvfwf3iJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbtu+R45sXSVergYe4/R8iwvrjNh00lUDdNO7wZV+ZYMFZR6AY6mz2gmQNQdoSmorTxZVhQH3jjpVGmlVrQa/7e66z51/fgDC/Igj1AgzPZNQBmwqRjlgp/b/ltpoPDb0bDbeRP4sZc+sspb+EeacQL0g/5S/tYmHK4W8su/Caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nE5VqYaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE13C116D0;
	Wed, 25 Feb 2026 06:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002718;
	bh=5mSbb/zI/q+MjQK/Yr1ai4JLJRxXZAmrMZMvfwf3iJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nE5VqYaaoanH/6vluMTgut3fmNUkXdhKG+HeuyRwfzB6EpkVOXBTZ+T7OYGKEHEBv
	 /zBdqVRBk6FYqkpiiX71iiFiIK+i0yqOWmOJgbpIblfzILYICqI9vHaH6gHt4SL0AX
	 7Cip9KtniY6m8NLU1D69Qkg4hfJiV4Wkv+AMHLs0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 527/641] libbpf: Fix invalid write loop logic in bpf_linker__add_buf()
Date: Tue, 24 Feb 2026 17:24:13 -0800
Message-ID: <20260225012401.298199104@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-219442-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9CBBA1930FA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 04999b99e81eaa7b6223ec1c03af3bcb4ac57aaa ]

Fix bpf_linker__add_buf()'s logic of copying data from memory buffer into
memfd. In the event of short write not writing entire buf_sz bytes into memfd
file, we'll append bytes from the beginning of buf *again* (corrupting ELF
file contents) instead of correctly appending the rest of not-yet-read buf
contents.

Closes: https://github.com/libbpf/libbpf/issues/945
Fixes: 6d5e5e5d7ce1 ("libbpf: Extend linker API to support in-memory ELF files")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20260209230134.3530521-1-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/linker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 56ae77047bc36..b86b8ae3b6341 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -581,7 +581,7 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
 
 	written = 0;
 	while (written < buf_sz) {
-		ret = write(fd, buf, buf_sz);
+		ret = write(fd, buf + written, buf_sz - written);
 		if (ret < 0) {
 			ret = -errno;
 			pr_warn("failed to write '%s': %s\n", filename, errstr(ret));
-- 
2.51.0




