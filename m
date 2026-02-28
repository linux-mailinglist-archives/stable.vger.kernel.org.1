Return-Path: <stable+bounces-220150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JWNKnQso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C9B1C541B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 178AD31A0027
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2734FF46;
	Sat, 28 Feb 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW4EzGPO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECE34F49C;
	Sat, 28 Feb 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300059; cv=none; b=C5mMy226iCvOSeYUXrcm8lMSoTDJhBD1HEOl4Lj+SMlRq4/X5FhvUCR17BIcqJc0SaftEgADxWFJMGQ4KnQNmcxBEGhkBNpI8YazIi00SOZy99TLpo9LujetZdTfuBdHPOL0Ab+mwFc7LkLEovWgWiTmURtOructJyDRxRAnP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300059; c=relaxed/simple;
	bh=xn1bCIo/367N91ZjLg+LSBuqHZFM0nJNCs7CSOAh0R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu2FXGSATn9EsHnFt1nTDXOsnJjOjA5BQ48SlCqXZueVomz0pn8hZUqveM1dNUnBBhsiDLlvc6G7Hr5+O+KYz3gHjrSHbZ6rdqZnB5SspvZhOMq7G/8lClltrxiWNhVS3GaXeNJLDq89ga/EhmSEcczwsJWA0K7cpMConAzTG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW4EzGPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40552C2BCB0;
	Sat, 28 Feb 2026 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300058;
	bh=xn1bCIo/367N91ZjLg+LSBuqHZFM0nJNCs7CSOAh0R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TW4EzGPOz5syxJq/wq0Ww8fVHtiLCXxdKJWE1kMPyHOuRtQDfyh0CT0yBJfHNoCnZ
	 4JJD8H326154IdgExLsMExCnpK0hvzCK6urA3Yjvwu5iJgqM66Cu23f3/CFMCCQg1G
	 uyd6lY+CbdNpoQk/RNOT2z2gh8i+BZn4cT2Jl2/35T5oNbkAyG87dJU3zhrQMFV67O
	 EgAm03+9ktX6TlnKAmS+a4NG5ugsTSIuNWeEmFaLSoIgsccoIFCxY8Hb9PuVhKUGPW
	 F2PXcLaJ0UH1AowDqAzBHFZVzZrtpen8owz5g+qb2XnNe/Zh+UbirwvwpYSSOAWCyx
	 kCQST6LC1ODiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Tang <danielzgtg.opensource@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 072/844] powercap: intel_rapl: Add PL4 support for Ice Lake
Date: Sat, 28 Feb 2026 12:19:45 -0500
Message-ID: <20260228173244.1509663-73-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220150-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63C9B1C541B
X-Rspamd-Action: no action

From: Daniel Tang <danielzgtg.opensource@gmail.com>

[ Upstream commit 54b3cd55a515c7c0fcfa0c1f0b10d62c11d64bcc ]

Microsoft Surface Pro 7 firmware throttles the processor upon
boot/resume. Userspace needs to be able to restore the correct value.

Link: https://github.com/linux-surface/linux-surface/issues/706
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
Link: https://patch.msgid.link/6088605.ChMirdbgyp@daniel-desktop3
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 152893dca5653..3d5e7f56d68a1 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -160,6 +160,7 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
 	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
-- 
2.51.0


