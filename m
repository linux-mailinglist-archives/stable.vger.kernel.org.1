Return-Path: <stable+bounces-250257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD7tF4PtDWpZ4wUAu9opvQ
	(envelope-from <stable+bounces-250257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:21:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80387593688
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92FD830C5566
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDF23EEAED;
	Wed, 20 May 2026 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZoBDSAbl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC53EE1C0;
	Wed, 20 May 2026 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294938; cv=none; b=i9Pd0gJtJBGPHqfpyv1oFh9Nh8/nlTM6mqeDU6HintgIXPCQ4BIoTeLNJyfaov6ZzRDG2XrabxsFznmahE2DZFF+xxCh+1tTND8aF+6s5tOzWfK3xNwEdc0pKylG5D5b1/cZRvfVAywnu0PeTUIK2FfeuX+Ifi3u/Yb+ci/h33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294938; c=relaxed/simple;
	bh=Rjxo6B4ygyGIYvPk1tpKnt5VV//wuuBU5g+esHCCR4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hY9yyzvTqc2TeHnKCHTLm4kTXPYd6IFlApVZQ8UfoqqS6emqiOdnbnxdzfS8xmUPpYbUmXNooZMVJY7wTrQA2HJqiEj55JKHDwXDbwcwI1rwqp3Pc9CJT57jZdl56QXuuLSFQDQF3W88zzuSXdLGt+d1W+o/lZQGjJLloeW4i0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZoBDSAbl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F71F000E9;
	Wed, 20 May 2026 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294937;
	bh=HaW+jvcTD7s2BUPi0AY+dD/E1B0JwRR5h+tN69HXWOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZoBDSAblXGTXn+GvcuVEqNNkcuLvb9RN6M8DXOFoeKQKnEgT7UY0EJdVP7eiK/iOu
	 KywLLLnTlD4yeS8g8GPyAxmEUt8o7RbyyH4EyDu7bPJF8JMFgikfBP+Vd/s+NFzcfB
	 numTZZD/Zp5KjX4ni1AAdMtVaQttOafj4dk/Kxrs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Patelczyk <maciej.patelczyk@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0229/1146] drm/gpusvm: Fix unbalanced unlock in drm_gpusvm_scan_mm()
Date: Wed, 20 May 2026 18:07:59 +0200
Message-ID: <20260520162153.434646095@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250257-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 80387593688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Patelczyk <maciej.patelczyk@intel.com>

[ Upstream commit d287dee565c3c32e1ed76ec1847af46809c29b90 ]

There is a unbalanced lock/unlock to gpusvm notifier lock:
[  931.045868] =====================================
[  931.046509] WARNING: bad unlock balance detected!
[  931.047149] 6.19.0-rc6+xe-**************** #9 Tainted: G     U
[  931.048150] -------------------------------------
[  931.048790] kworker/u5:0/51 is trying to release lock (&gpusvm->notifier_lock) at:
[  931.049801] [<ffffffffa090c0d8>] drm_gpusvm_scan_mm+0x188/0x460 [drm_gpusvm_helper]
[  931.050802] but there are no more locks to release!
[  931.051463]

The drm_gpusvm_notifier_unlock() sits under err_free label and the
first jump to err_free is just before calling the
drm_gpusvm_notifier_lock() causing unbalanced unlock.

Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260209123433.1271053-1-maciej.patelczyk@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_gpusvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 04bdc386c3fd8..35dd07297dd08 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -819,7 +819,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 
 		if (!(pfns[i] & HMM_PFN_VALID)) {
 			state = DRM_GPUSVM_SCAN_UNPOPULATED;
-			goto err_free;
+			break;
 		}
 
 		page = hmm_pfn_to_page(pfns[i]);
@@ -856,9 +856,9 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 		i += 1ul << drm_gpusvm_hmm_pfn_to_order(pfns[i], i, npages);
 	}
 
-err_free:
 	drm_gpusvm_notifier_unlock(range->gpusvm);
 
+err_free:
 	kvfree(pfns);
 	return state;
 }
-- 
2.53.0




