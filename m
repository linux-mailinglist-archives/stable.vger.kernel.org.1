Return-Path: <stable+bounces-248692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKZGNwdOB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:47:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83104553E78
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D07330ACD48
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC23E7BAB;
	Fri, 15 May 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pMyr+5ZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A33B9D91;
	Fri, 15 May 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862383; cv=none; b=ccOHYAEuhDK84lzHZxg2U1gg77QzBhDKICeXSJcEo12NV4FVdTOPxt1MYc7tjlzvpukSz/utMw3599fGe84s4uoB0Pt1mLzg0H7Ufjvzkxsrbgp2KMbk9dPAvin3JqOcQpqWRfJUrLLPOCMQ8ao3YXJX5qgsJJsa9uNxO9hy0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862383; c=relaxed/simple;
	bh=gSv5+V5pZ6S1kulaZmXhGh2AaZCLRQ/FIhZJUAlXLbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbhO4JvPycO9QzirQe9vySwcBNsut3NQJ8RdjKW/FAp4eQ2RyzG1/Y/tJ/JzqqDUHJ9cZSNLLA+FmXEEODcMRgxKws53bS/D2VgQw3/tsNK4C0ACAILnYSXogeyJFH5CZtigMI0XLOmTLpeNHmszfnyCdUGO0A904y/C1om++2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pMyr+5ZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CDBC2BCB0;
	Fri, 15 May 2026 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862382;
	bh=gSv5+V5pZ6S1kulaZmXhGh2AaZCLRQ/FIhZJUAlXLbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMyr+5ZXBWa6utvQym+wUQ491ROhCLNKxWLCjCy323lCa7YEgFW7zrsAdteKZDV5k
	 CefckdHKF6N6O2JAUWJhgKuvz+5vUwk1J+JSCqQvVFymhHHH8yW5KMcpgOvWIgnxrJ
	 p9HrjYy6nkYqWwS6jln0MexV/fOAnFhu/rzoCZ5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH 7.0 027/201] drm/gpusvm: Force unmapping on error in drm_gpusvm_get_pages
Date: Fri, 15 May 2026 17:47:25 +0200
Message-ID: <20260515154659.121115023@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 83104553E78
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248692-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Brost <matthew.brost@intel.com>

commit 556dba95473900073a6c03121361c11f646dc551 upstream.

drm_gpusvm_get_pages() only sets the local flags prior to committing the
pages. If an error occurs mid-mapping, has_dma_mapping will be clear,
causing the unmap function to skip unmapping pages that were
successfully mapped before the error. Fix this by forcibly setting
has_dma_mapping in the error path to ensure all previously mapped pages
are properly unmapped.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Francois Dugast <francois.dugast@intel.com>
Link: https://patch.msgid.link/20260130194928.3255613-2-matthew.brost@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_gpusvm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1572,6 +1572,7 @@ set_seqno:
 	return 0;
 
 err_unmap:
+	svm_pages->flags.has_dma_mapping = true;
 	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
 	drm_gpusvm_notifier_unlock(gpusvm);
 err_free:



