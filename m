Return-Path: <stable+bounces-236271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAICAWoX3WnNZwkAu9opvQ
	(envelope-from <stable+bounces-236271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDE3EE99B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23B76304267D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA2F2DEA6B;
	Mon, 13 Apr 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bm06LCq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683A2D3225;
	Mon, 13 Apr 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096483; cv=none; b=QBseas0sFUTPTNXrwJubLB8vpBM6qDeqH84NZEMEYgSxCc1Ix6O8Da/eFab2ELgYdgRlm9VYrbec4Fa5ZzOjtgU72PVa8t6vj+I8lSbz81DqOQHgBEy9x5bALJ1WAaHtG6mJajdy0RooaKxORYET8gvgJNDlr6R8iLU0VTN4E70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096483; c=relaxed/simple;
	bh=JLFA/QnYpVQ3ahjbh2WcYu4wcC7jMh+ibA7tgTco214=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEmYNGDPuMaM+teXg0AiqFeBYNMfFSYPE7mhnlQobrXtQ9qfmTLNk1lEfFsFT3ccd/A0cAUOcT9NHYmT8c/HJxjR/6/v6StbZJEt+wjCzPjJl4ohrcUULha4Vyjr3v8SWzR57TshnbmcIU2cAEbM37lf7YwRKZP5RkwHH5dU+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bm06LCq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5444C2BCB4;
	Mon, 13 Apr 2026 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096483;
	bh=JLFA/QnYpVQ3ahjbh2WcYu4wcC7jMh+ibA7tgTco214=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bm06LCq0d/rCXZyh3/w5Njo+MCoAIMZCbYENp6JHTmTwUqdiyXEZl18opa7QYtDAS
	 3Lrhkk9AHf/8ngWsFGo3jvFS0m3F30jWPVw14R6mlaBZyjavuhpiBqoJqQevp7Cv9j
	 oBimxx2NReJjefbVBZvfcXNxw09b5sn31VXJlK58=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.18 28/83] platform/x86: ISST: Reset core count to 0
Date: Mon, 13 Apr 2026 17:59:56 +0200
Message-ID: <20260413155732.070209685@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236271-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBCDE3EE99B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit e1415b9418eb22b4a7a1ef4b4aec9dd0a49e3fa7 upstream.

Based on feature revision, number of buckets can be less than the
TRL_MAX_BUCKETS. In that case core counts in the remaining buckets
can be set to some invalid values.

Hence reset core count to 0 for all buckets before assigning correct
values.

Fixes: 885d1c2a30b7 ("platform/x86: ISST: Support SST-TF revision 2")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260325192638.3417281-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1460,6 +1460,8 @@ static int isst_if_get_turbo_freq_info(v
 					    SST_MUL_FACTOR_FREQ)
 	}
 
+	memset(turbo_freq.bucket_core_counts, 0, sizeof(turbo_freq.bucket_core_counts));
+
 	if (feature_rev >= 2) {
 		bool has_tf_info_8 = false;
 



