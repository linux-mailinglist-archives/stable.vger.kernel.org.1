Return-Path: <stable+bounces-258412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A13KCAnG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:06:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3531E610FFF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F20C301468A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116C341AC7;
	Sat, 30 May 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zFHsxcbQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A423392B;
	Sat, 30 May 2026 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164265; cv=none; b=N5xXmRF4Zf9+9q6LDzvcwpUp1w4/OdFzONL6wXlpaDHPd0tL829E6cpWO4lE9d7qQ0T4D1CoTE+Ob5u5qshIaUJcgo9FhdPjTQ0tGKxknxD38gniCowyhfJQE1jiOrHicn5T0Lj4lDeJIL9mbGAkwcfyrbZCbpXqR7lfDYGJ4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164265; c=relaxed/simple;
	bh=nVesS3kgsOQwvNK78T/80lZ30FlpPKcMXC5KA5Ww+CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3z63lsgxdlR/Q/9CXVjxs02JEp87/tYeROdzzAiPziSHzeL7cfB0gJQMNyPz8Qar1PrTBBAqm75ZJHCwyHeFu7fQh2EKjegDrAi+3Q5+V6y0T4o90Hxv8K2q4jH4kivxGm7yajkRLCh1pxSs2LPxyM290cVIB8cz32rv8B0ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zFHsxcbQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716A41F00893;
	Sat, 30 May 2026 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164264;
	bh=yMqvaUhoQStpaNgcH/eUTnWtAcakdZ9vcBqY3KftpCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zFHsxcbQbSDc1LHY7GvmtBu0pt/WUseDHd0o8sUTtWceOCGC4TQ2EkFSWONE/oDqO
	 4VsaCcuIAuGluOh2PqHBkyrOAwLxxKCTGDhaYxPXF1V5l3cUm7aIu/2m0lxiOtNcyI
	 Uu4sbwQi4p5X+oFHsNoZ95Yt1BUJk/yQTcwJhhZg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Hodges <hodgesd@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 503/776] ima: check return value of crypto_shash_final() in boot aggregate
Date: Sat, 30 May 2026 18:03:37 +0200
Message-ID: <20260530160253.287195808@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258412-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3531E610FFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Hodges <hodgesd@meta.com>

[ Upstream commit 870819434c8dfcc3158033b66e7851b81bb17e21 ]

The return value of crypto_shash_final() is not checked in
ima_calc_boot_aggregate_tfm(). If the hash finalization fails, the
function returns success and a corrupted boot aggregate digest could
be used for IMA measurements.

Capture the return value and propagate any error to the caller.

Fixes: 76bb28f6126f ("ima: use new crypto_shash API instead of old crypto_hash")
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 64499056648ad..c5153f0d7306d 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -837,7 +837,7 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 		}
 	}
 	if (!rc)
-		crypto_shash_final(shash, digest);
+		rc = crypto_shash_final(shash, digest);
 	return rc;
 }
 
-- 
2.53.0




