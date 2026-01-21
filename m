Return-Path: <stable+bounces-210962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CANhNJwfcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:49:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7215B833
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CF7D82A044
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B53A7853;
	Wed, 21 Jan 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J2gVVQ4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA46396D35;
	Wed, 21 Jan 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019971; cv=none; b=SEQPKEZYnKUPd4XJ6GhditwjEeWeah+0RmgDo69bELtrRsayDEOlOeSjmL/WE3LNN5I0vW8seROPQd2epSdshPSUtadtpjRcwsAJmT/mhHJlXLOPp493It/3ANOzIrzfhQOfCCgoBb0Ok/TPF6SxoUDtUE8V5SCLLJ7b+qwQU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019971; c=relaxed/simple;
	bh=xw16w4gMmKr0C5q02sI1bGw7JXF++zeu9S2ovThVRgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eknhpBi5VH6tCYF+PPf036YRQlRdOcavnVh1oxWbzl8IkN5+j7wOOU84Xs0/sRNaij/WSmgKF/m4ODN8LmYZ6uLiSpRC/vjgjcIr2bEOfO6r0Cd+H+nAHYDmxsEYcP7Xtqk54ILhORzVcWNZ0o6byRyFlXaxyln9Y73FV8n6rsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J2gVVQ4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2883C4CEF1;
	Wed, 21 Jan 2026 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019971;
	bh=xw16w4gMmKr0C5q02sI1bGw7JXF++zeu9S2ovThVRgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2gVVQ4Jo3Aar6ZF6LPl4XV9gDxNkK4MBKevXAADJHSEcyZzHEjpSqJGazFxKWTsH
	 Whq5PgQo/q4WSfGjkv7eb0ZCdnyJAF+bDg1/aDYo5liJkx8YH1YPk8HuBrViXQzYHp
	 iam6cYbtxWw3aTLvCSGZej8eJh3v+lDLlmxNc33A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 021/198] NFS/localio: Deal with page bases that are > PAGE_SIZE
Date: Wed, 21 Jan 2026 19:14:09 +0100
Message-ID: <20260121181419.317312255@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210962-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6F7215B833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 60699ab7cbf0a4eb19929cce243002b39c67917d ]

When resending requests, etc, the page base can quickly grow larger than
the page size.

Fixes: 091bdcfcece0 ("nfs/localio: refactor iocb and iov_iter_bvec initialization")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index ed2a7efaf8f20..f537bc3386bf2 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -461,6 +461,8 @@ nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
 	v = 0;
 	total = hdr->args.count;
 	base = hdr->args.pgbase;
+	pagevec += base >> PAGE_SHIFT;
+	base &= ~PAGE_MASK;
 	while (total && v < hdr->page_array.npages) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
 		bvec_set_page(&iocb->bvec[v], *pagevec, len, base);
-- 
2.51.0




