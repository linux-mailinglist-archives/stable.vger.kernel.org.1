Return-Path: <stable+bounces-210819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMdoIdcqcWniewAAu9opvQ
	(envelope-from <stable+bounces-210819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB65C4EC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88EC1788EA1
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0C23C4FF;
	Wed, 21 Jan 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p5l+lIpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0B378D72;
	Wed, 21 Jan 2026 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019488; cv=none; b=W2wkbqaqXoz8iDLzE6RQc9tGk8P2ibglYcHhlXyktfJ5DeUfFPSzqyaG+awlER865xoCWoj9UOxf/Y5PPkj9JFVRrTRB9jwg8n/T1FI/96MzgpgNuESvJ6yHDzeCLUbl0jgJPWrFzdGirIScOulv2yJvaDYmSPe4WgjHf06TGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019488; c=relaxed/simple;
	bh=1rjkJtahBBxGsy12X5CQJYTCM/AAo//2uMdhvMex4yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2a0sWQwuAbX86uk57pFyjMzmCLOxObQIeVCbEM0VqsUn1SX++q9ZSebLk8akkdIxf2xJUwNqoSAVLo/GgL1SIkg6Vcs6i+GujlzXJMnNSD0b3WZcl2K11dGjp2RkRhzBq+4rgeWlXCSeZMrTqe6pHenUgbwokBfbTekiLnGk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p5l+lIpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E066DC4CEF1;
	Wed, 21 Jan 2026 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019488;
	bh=1rjkJtahBBxGsy12X5CQJYTCM/AAo//2uMdhvMex4yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5l+lIpxAdrDdrDaGV3kCt0XQpbjpNEogyEr3hVBOVRdk1cxRhYgfTUvPTRH2q4IL
	 ysmOvbM1UJbR4A7NqC2J9Onz9uKBDXUomZm26cPVeX0fZ04FIkxAIGk/ql+Uz1kejf
	 0hOtncWROtKDjKQqATV48fIdWJ2kTfCczFNaYJy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 6.12 003/139] Revert "gfs2: Fix use of bio_chain"
Date: Wed, 21 Jan 2026 19:14:11 +0100
Message-ID: <20260121181411.579333348@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-210819-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,ams.mirrors.kernel.org:server fail];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 38AB65C4EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 469d71512d135907bf5ea0972dfab8c420f57848 upstream.

This reverts commit 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941.

That commit incorrectly assumed that the bio_chain() arguments were
swapped in gfs2.  However, gfs2 intentionally constructs bio chains so
that the first bio's bi_end_io callback is invoked when all bios in the
chain have completed, unlike bio chains where the last bio's callback is
invoked.

Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/lops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -485,7 +485,7 @@ static struct bio *gfs2_chain_bio(struct
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(prev, new);
+	bio_chain(new, prev);
 	submit_bio(prev);
 	return new;
 }



