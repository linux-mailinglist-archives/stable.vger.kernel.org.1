Return-Path: <stable+bounces-216142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMquJe4sj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:53:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18760136AB3
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2535300A8D4
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75C35FF49;
	Fri, 13 Feb 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7XCGAVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB535CBD8;
	Fri, 13 Feb 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990775; cv=none; b=slSf4QNa2mo+n0y3BOTZyjVleOoDs3j+lbS56vigyxO3rzF/iDptu7ZrdQQUAUt9RIMWgUErIB9ZQ30Rcq+UW8IPpWrWXZ+udF9jDvY/q9GdDGo6UZyBCSqyoZB2tlegU/SsMt5q3Oa0Vqx++DUfCsS3wJvGAhcD3ci1ql9cTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990775; c=relaxed/simple;
	bh=utRT/G/5ZTzr5btttaeUR5cTiNfERqb7TVa4677dXcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPh0Rekq0OSvFLaSHCm+v+sWZctJTulmyqdfFC0IDFFrM56j7o7UcnId8p2zEM2mk9OUZKCjUJs4DqtzHP7635amXasFMrEhIfg5UI3A3Yi+wUjdtePdE2AHPELtTxYu2kVy8d2fNaMzFg8u+An9T9p+L/9byMF0YuVgDx6zeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7XCGAVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F16C116C6;
	Fri, 13 Feb 2026 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990774;
	bh=utRT/G/5ZTzr5btttaeUR5cTiNfERqb7TVa4677dXcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7XCGAVqR+Y/MXnjANqnnRr5wE7w7qGdobHZ8pUd/ciFw9Vb19Qmjeq/SBWM6aEMc
	 YgDr5rGb2LcRcs+/jtnIAbXagABy+oDVYfcfju4ymD+pKgPWJb39sQGbkpBjJIcAlm
	 iCHj+IsfgZM25MMedbWePdP9KLWL4g2GnCSgetYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 03/49] smb: client: split cached_fid bitfields to avoid shared-byte RMW races
Date: Fri, 13 Feb 2026 14:47:47 +0100
Message-ID: <20260213134709.012478039@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216142-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 18760136AB3
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henrique Carvalho <henrique.carvalho@suse.com>

commit ec306600d5ba7148c9dbf8f5a8f1f5c1a044a241 upstream.

is_open, has_lease and on_list are stored in the same bitfield byte in
struct cached_fid but are updated in different code paths that may run
concurrently. Bitfield assignments generate byte read–modify–write
operations (e.g. `orb $mask, addr` on x86_64), so updating one flag can
restore stale values of the others.

A possible interleaving is:
    CPU1: load old byte (has_lease=1, on_list=1)
    CPU2: clear both flags (store 0)
    CPU1: RMW store (old | IS_OPEN) -> reintroduces cleared bits

To avoid this class of races, convert these flags to separate bool
fields.

Cc: stable@vger.kernel.org
Fixes: ebe98f1447bbc ("cifs: enable caching of directories for which a lease is held")
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -36,10 +36,10 @@ struct cached_fid {
 	struct list_head entry;
 	struct cached_fids *cfids;
 	const char *path;
-	bool has_lease:1;
-	bool is_open:1;
-	bool on_list:1;
-	bool file_all_info_is_valid:1;
+	bool has_lease;
+	bool is_open;
+	bool on_list;
+	bool file_all_info_is_valid;
 	unsigned long time; /* jiffies of when lease was taken */
 	unsigned long last_access_time; /* jiffies of when last accessed */
 	struct kref refcount;



