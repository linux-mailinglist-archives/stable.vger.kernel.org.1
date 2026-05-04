Return-Path: <stable+bounces-243103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DlgO+em+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D774BE620
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74B1630429A4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B633D6489;
	Mon,  4 May 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CcNKEkWU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168529BD9A;
	Mon,  4 May 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903025; cv=none; b=gFBYNMffRi3H7ApH/FqeYHUfXvlX2CdBeRt6p1O8HbWGQpej3ktg4MYeCMn2uQ0TBL8jNzzlMEUummNCFhRei98C+w691SMhtLXZPEY8cF2+G6KwBb+twaImoECCW1AV4trxqdY3n6Qsaf6k1XYEgBZ0fy2FWdZvnCumPASEJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903025; c=relaxed/simple;
	bh=7p8txR31dcYiQpWWlneWsrbLb7v2ju9cSfum0Gcfq0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6CRnKPTmW6xaafAEWoeQ4diYSWHEjoxxQJ/ngvUgTP6qjKE3Uz880HcsFaLrkV/FnD10oPXn3y1VBfmigIJqlWiH131eVvYdS7miWdJnzzFfyEBCfU6hXqyurzn+eqb/DcFIExlLrdiv3wUy4R6ALzKEiPH/Er/H5Nt1BrzzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CcNKEkWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286E2C2BCB8;
	Mon,  4 May 2026 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903025;
	bh=7p8txR31dcYiQpWWlneWsrbLb7v2ju9cSfum0Gcfq0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcNKEkWU6aTRpOSfbYdwIKChqha+s1Qf/zBKTv+ef1vM8rdmHvaQN0j+JqvpKNcsT
	 LFBqqY6my3rSocxbn9rRrzun9b3r9ZceoA19C50KadtVXRDV+xjkqkdv06kY7n93FG
	 FgFYEq//NU/MqJsEz58yaI8akow6f8uQOd1o02/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiquan Li <zhiquan_li@163.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 7.0 075/307] KVM: selftests: Fix reserved value WRMSR testcase for multi-feature MSRs
Date: Mon,  4 May 2026 15:49:20 +0200
Message-ID: <20260504135145.637540155@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 69D774BE620
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243103-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 9396cc1e282a280bcba2e932e03994e0aada4cd8 upstream.

When determining whether or not a WRMSR with reserved bits will #GP or
succeed due to the WRMSR not existing per the guest virtual CPU model,
expect failure if and only if _all_ features associated with the MSR are
unsupported.  Checking only the primary feature results in false failures
when running on AMD and Hygon CPUs with only one of RDPID or RDTSCP, as
AMD/Hygon CPUs ignore MSR_TSC_AUX[63:32], i.e. don't treat the bits as
reserved, and so #GP only if the MSR is unsupported.

Fixes: 9c38ddb3df94 ("KVM: selftests: Add an MSR test to exercise guest/host and read/write")
Reported-by: Zhiquan Li <zhiquan_li@163.com>
Closes: https://lore.kernel.org/all/20260209041305.64906-6-zhiquan_li@163.com
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260212103841.171459-5-zhiquan_li@163.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/kvm/x86/msrs_test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -175,7 +175,7 @@ void guest_test_reserved_val(const struc
 	 * If the CPU will truncate the written value (e.g. SYSENTER on AMD),
 	 * expect success and a truncated value, not #GP.
 	 */
-	if (!this_cpu_has(msr->feature) ||
+	if ((!this_cpu_has(msr->feature) && !this_cpu_has(msr->feature2)) ||
 	    msr->rsvd_val == fixup_rdmsr_val(msr->index, msr->rsvd_val)) {
 		u8 vec = wrmsr_safe(msr->index, msr->rsvd_val);
 



