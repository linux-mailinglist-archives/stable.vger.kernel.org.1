Return-Path: <stable+bounces-257163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PYTGiwWG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:54:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C560E904
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 564FB30202A8
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71D332EA7;
	Sat, 30 May 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1TYuEdSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426FB33FE15;
	Sat, 30 May 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160024; cv=none; b=PTozP7PDQuyNzof5/+PUjjYVGZL57n/t0upk+dOuzAcTtUh9QfcsVB665gZeRdqGopY4WkAlg1Nytp7THKMGnm2b4YWVO9x/AlWiy1Qoy5QQ0zKIvovtOKLvx6cSYIYq2M2EjbaeZr7rlUCXwJIOXxTZANnEiUtrpGX5S7fq36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160024; c=relaxed/simple;
	bh=v0uUv9hPXPG6bhdUGaw/kVedWxgsDJsdyL5wEE/1eMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qssyzxl7BA+9sXFnux/pag4K95t7kHmpVDYQv0uW4Wdr/UqB09wExkZkGUfVtT4sJP6Te2KqmdzCzUu2DOGuGd7bSqj9cP9Q/TjGoYggHcTx/Bh/KZ3AG4NG2j01YCez2wsYZgE1xHYJnaNPw8FIHlWi/LtmEQASq6+aALUyBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1TYuEdSH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340AD1F00893;
	Sat, 30 May 2026 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160022;
	bh=WayxdCoCbZiYIV7yWu9JLO8fBfRO8UpTGMnJP7zAHzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1TYuEdSHVkXZHkf04inHegvSKQ3TvRFrJatIAWwXNapm/mLDCT/xuOka2cg/kl9ZS
	 ceGy+3dV2OO5k9XBUe5OFrm+sSf1DVNMyZM9NSUy8rji5Z5Kfa+Ji0F8hxFajYlBjs
	 yl7fYz08KhGIY/tefJS+wE0ztsz3wHRIMzrVuZZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.1 223/969] tpm: avoid -Wunused-but-set-variable
Date: Sat, 30 May 2026 17:55:47 +0200
Message-ID: <20260530160306.610250698@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257163-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0A0C560E904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 6f1d4d2ecfcd1b577dc87350ea965fe81f272e83 upstream.

Outside of the EFI tpm code, the TPM_MEMREMAP()/TPM_MEMUNMAP functions are
defined as trivial macros, leading to the mapping_size variable ending
up unused:

In file included from drivers/char/tpm/tpm-sysfs.c:16:
In file included from drivers/char/tpm/tpm.h:28:
include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
  167 |         int mapping_size;

Turn the stubs into inline functions to avoid this warning.

Cc: stable@vger.kernel.org # v5.3+
Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/tpm_eventlog.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -131,11 +131,16 @@ struct tcg_algorithm_info {
 };
 
 #ifndef TPM_MEMREMAP
-#define TPM_MEMREMAP(start, size) NULL
+static inline void *TPM_MEMREMAP(unsigned long start, size_t size)
+{
+	return NULL;
+}
 #endif
 
 #ifndef TPM_MEMUNMAP
-#define TPM_MEMUNMAP(start, size) do{} while(0)
+static inline void TPM_MEMUNMAP(void *mapping, size_t size)
+{
+}
 #endif
 
 /**



