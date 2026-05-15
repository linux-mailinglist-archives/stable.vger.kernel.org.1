Return-Path: <stable+bounces-248252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO9wJGtJB2rUwQIAu9opvQ
	(envelope-from <stable+bounces-248252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:27:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C45553374
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 136AA31054B0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D53FBB54;
	Fri, 15 May 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CeXJuHoc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A93EFFB2;
	Fri, 15 May 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861260; cv=none; b=qcg1qRJZ+WWOUAjyT9JBgfejcwpoQREHICJxUk2YX1xIGdFMWdWB4mGTIu3GIDkW1YBLMMwnnRJILVIhrOHeXI1cI4pRvsWw8GOhS0S3htCG6za0iNERnsbrelQmHNnsfVafObXtyD2nyeaIoEKwSMdmzZqbiOlt9QZlSzp4mOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861260; c=relaxed/simple;
	bh=/NYaGywIvOZD45BRgMbUbTC5xBygFs0LBQFe6AevBLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jegADnn/FsfJa+M+9xaC4QNMOJjR7WbuKv3JyFFmtM/L8+v5WTCl14AWjvH0zhHaL2XwXjDe3CaGbctqh20NgWBLRl0Xhir0wB4OVHoySjvMlsuM6/3q35W5c+2rLUOlVH5B8yYkGPtr8id0m2dVmITg3Wk+fqKCXIMsg3c69Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CeXJuHoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85BCC2BCB0;
	Fri, 15 May 2026 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861260;
	bh=/NYaGywIvOZD45BRgMbUbTC5xBygFs0LBQFe6AevBLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeXJuHocCoiiFNJ1SRaQ2ONyxow4jIHG0uzsmW2GMDmvG0A4sze0OjnVGkm2Rb5MM
	 rHj9k12i8Of2rab/4yua+gHXXB6ylv62DnpTFujqjjocHGH8kwuOlfhDZr4TohO/Ut
	 C4IAmStIDyac/3kNMLwuhhJ19h5HSUkydYh0IwIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	David Howells <dhowells@redhat.com>,
	David Gow <davidgow@google.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 261/474] lib/scatterlist: fix temp buffer in extract_user_to_sg()
Date: Fri, 15 May 2026 17:46:10 +0200
Message-ID: <20260515154720.648044372@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 35C45553374
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248252-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux-foundation.org:email,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <lk@c--e.de>

commit 118cf3f55975352ac357fb194405031458186819 upstream.

Instead of allocating a temporary buffer for extracted user pages
extract_user_to_sg() uses the end of the to be filled scatterlist as a
temporary buffer.

Fix the calculation of the start address if the scatterlist already
contains elements.  The unused space starts at sgtable->sgl +
sgtable->nents not directly at sgtable->nents and the temporary buffer is
placed at the end of this unused space.

A subsequent commit will add kunit test cases that demonstrate that the
patch is necessary.

Pointed out by sashiko.dev on a previous iteration of this series.

Link: https://lkml.kernel.org/r/20260326214905.818170-3-lk@c--e.de
Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Cc: David Howells <dhowells@redhat.com>
Cc: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <stable@vger.kernel.org>	[v6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/scatterlist.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1117,8 +1117,7 @@ static ssize_t extract_user_to_sg(struct
 	size_t len, off;
 
 	/* We decant the page list into the tail of the scatterlist */
-	pages = (void *)sgtable->sgl +
-		array_size(sg_max, sizeof(struct scatterlist));
+	pages = (void *)sg + array_size(sg_max, sizeof(struct scatterlist));
 	pages -= sg_max;
 
 	do {



