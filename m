Return-Path: <stable+bounces-222773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO86A8A+pmkZNAAAu9opvQ
	(envelope-from <stable+bounces-222773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 02:52:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0551E7D59
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 02:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96FD03076B50
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 01:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D30374197;
	Tue,  3 Mar 2026 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SETiF0PA"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE07364EA5;
	Tue,  3 Mar 2026 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502689; cv=none; b=PnbOXGj/ISLk9ooxzgiRnVXXRkPsndlp78frH8Si9+E6b2/3qQcdt00mPtcBnMqAJN9qGYS9PtdeYepMbCAaGQbbMfDCZIgSVlXh55NtyuScpYRd9aiGOQoaLWEoJcWcAvCjL2HV5XstX1s8IcmRP9MgKXUf7kl6oNGUNmPH3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502689; c=relaxed/simple;
	bh=SrM78CwYmsi7NLly+zHTpsqAUqXmMmeX6ryp1zEhTfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piNN1MLID+4fcETca/qZ41jZX6Tl1Oae5IldEmG9hKB8Qv72pzuJFgp+du1XCgYskjrEgqSV2GgPhsaKeKH6yulphi9UlQPXwecKp6cRMonkTkkq8NWHoZ14cwvG+ZM9Bx3A9Hoc6IIdZ8lPET9GOgrAVZmSJE5cdQdgPJZK0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SETiF0PA; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XG
	FqIj6YZfW1vO9tfInL0Hqq+SBbiSTcDvtPlDVfVTs=; b=SETiF0PA/7QxTWYq+f
	oNxEix/ogwG70x+0DjA2gJJUyw+R1UV2kYeG8wuoTeesDv37nMmDK1+av9nosAEA
	DvNmLOzXfRULeisJCMScXD2zAP8LER0gxFCLb8Xk7JRwOb8PVgssdrsk74QQoJfv
	foBsqVPE1cqAvON/x8oK2GkoY=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnhCODPqZp1ezIOw--.34317S3;
	Tue, 03 Mar 2026 09:51:00 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.12.y 1/2] arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state
Date: Tue,  3 Mar 2026 09:50:46 +0800
Message-Id: <20260303015047.2014999-2-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303015047.2014999-1-black.hawk@163.com>
References: <20260303015047.2014999-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnhCODPqZp1ezIOw--.34317S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry8AF4DtFyxJF18Wr4Uurg_yoW5ZFWrpr
	W7Kw1Yyr1UGF1fAa90vF4F9a95W34ft3W5WF93Ga48ZrW5JrZ8urnYyayqqryUGr93GryY
	qFyjqr40gayDt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR-AwxUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+QW0TmmmPoU7cgAA37
X-Rspamd-Queue-Id: 3A0551E7D59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222773-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,arm.com,kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,pstate.sm:url]
X-Rspamd-Action: no action

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit b465ace42620970e840c7aeb2c44a6e3b1002fec ]

Non-streaming SVE state may be preserved without an SVE payload, in
which case the SVE context only has a header with VL==0, and all state
can be restored from the FPSIMD context. Streaming SVE state is always
preserved with an SVE payload, where the SVE context header has VL!=0,
and the SVE_SIG_FLAG_SM flag is set.

The kernel never preserves an SVE context where SVE_SIG_FLAG_SM is set
without an SVE payload. However, restore_sve_fpsimd_context() doesn't
forbid restoring such a context, and will handle this case by clearing
PSTATE.SM and restoring the FPSIMD context into non-streaming mode,
which isn't consistent with the SVE_SIG_FLAG_SM flag.

Forbid this case, and mandate an SVE payload when the SVE_SIG_FLAG_SM
flag is set. This avoids an awkward ABI quirk and reduces the risk that
later rework to this code permits configuring a task with PSTATE.SM==1
and fp_type==FP_STATE_FPSIMD.

I've marked this as a fix given that we never intended to support this
case, and we don't want anyone to start relying upon the old behaviour
once we re-enable SME.

Fixes: 85ed24dad290 ("arm64/sme: Implement streaming SVE signal handling")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20250508132644.1395904-4-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 arch/arm64/kernel/signal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f7b05267a76b..2ff6af928426 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -391,6 +391,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	unsigned int vl, vq;
 	struct user_fpsimd_state fpsimd;
 	u16 user_vl, flags;
+	bool sm;
 
 	if (user->sve_size < sizeof(*user->sve))
 		return -EINVAL;
@@ -400,7 +401,8 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return err;
 
-	if (flags & SVE_SIG_FLAG_SM) {
+	sm = flags & SVE_SIG_FLAG_SM;
+	if (sm) {
 		if (!system_supports_sme())
 			return -EINVAL;
 
@@ -420,7 +422,16 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (user_vl != vl)
 		return -EINVAL;
 
-	if (user->sve_size == sizeof(*user->sve)) {
+	/*
+	 * Non-streaming SVE state may be preserved without an SVE payload, in
+	 * which case the SVE context only has a header with VL==0, and all
+	 * state can be restored from the FPSIMD context.
+	 *
+	 * Streaming SVE state is always preserved with an SVE payload. For
+	 * consistency and robustness, reject restoring streaming SVE state
+	 * without an SVE payload.
+	 */
+	if (!sm && user->sve_size == sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
 		current->thread.svcr &= ~SVCR_SM_MASK;
 		current->thread.fp_type = FP_STATE_FPSIMD;
-- 
2.34.1


