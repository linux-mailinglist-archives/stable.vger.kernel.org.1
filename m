Return-Path: <stable+bounces-245959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC0ZKvBoA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:52:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1FA526426
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00BE430656B3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC903D9693;
	Tue, 12 May 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MHCMBPrm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4663ADB9A;
	Tue, 12 May 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607993; cv=none; b=OkxUcPyY2q3aM9bQzeJpfJyOV5Swe5NgU/8CR29j87ijXy3q7FsfDZb8sqib2IgT78aN3pfgExR9y3NJBqmbce06syI4OUys8SUpSeo5ls18D3/YTYAKgLv13SFI79rvNlY3Xvpkpw6UHCUx2y2ummmjyM2EpDwQl+hgHxjK9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607993; c=relaxed/simple;
	bh=FqC6exrqdww/ELvGgv3C6hoJybnk5rrRXQ50QDs1PvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRepOyGpG4wriZPUwwcZhsHX6WRs6SxYKUnbtBlIKAPqDUlJrB11qyjZ6mDL8jywccn6sT7BimAvdaictUjemsbC18Fyb6XLBhv7ibCqQSqBqoO0Ql7GpHSDaD0EbOfOCVpIrUEsKJsPwkHm5MafjWarny6zr/YifZZXfkjOO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MHCMBPrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D940CC2BCB0;
	Tue, 12 May 2026 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607993;
	bh=FqC6exrqdww/ELvGgv3C6hoJybnk5rrRXQ50QDs1PvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHCMBPrmqZnBJ9JPjWiKaYapKB5yEoIn3pbO+4FCa7Tuc1PgIv6/cQgfg1Uhv1XtC
	 C4oeQBy+fi6U++lmjkEpRlN2DheGpXov1o3MvrlPjP+HC9jzPdfkqicoG8Sy2itNqH
	 pYOSB7ZZLrS2pBUu16lKyBRCWfrx/hqeCEUgXWdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zdenek Kabelac <zkabelac@redhat.com>
Subject: [PATCH 6.12 116/206] dm: dont report warning when doing deferred remove
Date: Tue, 12 May 2026 19:39:28 +0200
Message-ID: <20260512173935.313272855@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4C1FA526426
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245959-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit b7cce3e2cca9cd78418f3c3784474b778e7996fe upstream.

If dm_hash_remove_all was called from dm_deferred_remove, it would write
a warning "remove_all left %d open device(s)" if there are some other
devices active.

The warning is bogus, so let's disable it in this case.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Zdenek Kabelac <zkabelac@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 2c140a246dc0 ("dm: allow remove to be deferred")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -384,7 +384,7 @@ retry:
 
 	up_write(&_hash_lock);
 
-	if (dev_skipped)
+	if (dev_skipped && !only_deferred)
 		DMWARN("remove_all left %d open device(s)", dev_skipped);
 }
 



