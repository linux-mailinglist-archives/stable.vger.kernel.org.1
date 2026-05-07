Return-Path: <stable+bounces-244525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHrOK/5H/Gk0NwAAu9opvQ
	(envelope-from <stable+bounces-244525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:06:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 480754E47B5
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B20393006B73
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897433064D;
	Thu,  7 May 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="VaR7Nx4i"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85F32F770;
	Thu,  7 May 2026 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141177; cv=none; b=f8jst0UbtxFVgQxhR/jUKif4959iWgNSaez+cHak92fvozQZemewB3WjhqyIYV7ucVIQ7mRgK+UPE40QpcfSBpHW9w4AQ90wuKf3OQcNyAmU608KqcLWLQQQQTTqCg0bgHOK7NstDYupLDG49RC2PFiucJZCZqpoL4VAdSfLnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141177; c=relaxed/simple;
	bh=ObHsI6yvsJqtZrX66uSHRsPF3X2UzW09Pssks/HsHFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrTlUO7CJy1JLKvL2Pg3iLkaIEB7jcPkL3aoifiVRNnivr82QTxsfZF0FuabLpza2u7jp/0gzIeHL7wX0j0D5wBgKtluDxRayZWx4MbCO2HlE9sh940xthwYw2YQ1005kmtVfze6+mrZccUYsE1ju7+MWNyvvsA1Mmev6SFN9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=VaR7Nx4i; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.lan (unknown [95.24.24.108])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0FEE945A1D2A;
	Thu,  7 May 2026 08:06:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0FEE945A1D2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1778141164;
	bh=t6msmjqawU/IEsj5CPxud70TuqJjAjCucEWvMJ3Guhk=;
	h=From:To:Cc:Subject:Date:From;
	b=VaR7Nx4iurJc2k38ZCC7sKPUbG60TZzh7zWCskj64/r4czrnXDx1pFOSS1dizzxNP
	 wBq7v7eOONtbPocEz7tHcevL23XJV6XUduTbRQL971Nov5XqcgXBwRfmg4XIKQdCUS
	 +SkSk6FIcNQkkmyra6AbeboWACBXhpWV3ReiyMnA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Michael Cheng <michael.cheng@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: fix up region size calculation for flushing dcache lines
Date: Thu,  7 May 2026 11:05:43 +0300
Message-ID: <20260507080544.57053-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 480754E47B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ispras.ru,gmail.com,ffwll.ch,intel.com,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Computing region size for flushing dcache lines currently involves

  execlists->csb_size * sizeof(execlists->csb_status)

while the second operand should represent the size of the csb status array
element (u64), not the size of the pointer variable.  It works on a 64-bit
kernel, but it's not correct for exotic 32-bit ones and may result in an
incomplete flush when the number of csb entries covers more than a single
cacheline.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: dc0406820ee7 ("drm/i915/gt: Drop invalidate_csb_entries")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

The patch is against drm-intel/drm-intel-next,
HEAD:775fb670745015d679a65f948b3da0fbff3f100c

 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 1359fc9cb88e..31037ee3c2c4 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2833,7 +2833,7 @@ static void reset_csb_pointers(struct intel_engine_cs *engine)
 	memset(execlists->csb_status, -1, (reset_value + 1) * sizeof(u64));
 	drm_clflush_virt_range(execlists->csb_status,
 			       execlists->csb_size *
-			       sizeof(execlists->csb_status));
+			       sizeof(execlists->csb_status[0]));
 
 	/* Once more for luck and our trusty paranoia */
 	ENGINE_WRITE(engine, RING_CONTEXT_STATUS_PTR,
-- 
2.53.0


