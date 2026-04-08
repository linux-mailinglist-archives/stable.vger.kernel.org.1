Return-Path: <stable+bounces-234932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJxBASOk1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AA63C1DA3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC72307C753
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5934AB06;
	Wed,  8 Apr 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I3MJw2TV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191E2641FC;
	Wed,  8 Apr 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674136; cv=none; b=E6F6cC4RyLDRLbEL2uib1vHqhQ0mAMp3sdsgsgIBcbUanDocMkUj0x+c7UBqmWJtKnIJtC0O7isRp4ZbLkCez3MDdXxBLXZ+sMZk5Hzm+uNIB+zGc1OEyhi7e6UOFXFxzBr9hQJZ1BhIOGrmvl1w5hODnddTpfVRJJJ7E9pVw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674136; c=relaxed/simple;
	bh=u61zN4MGdtOdNhW6g8gNibyFyIQFvF9k0AlxWMZQ9rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajRqTv4F7OAE7BgHVI8MlbwwJ9cSpmpzKL/9/JJiCM+7DWnvugx0H2sULPmQ+9pkaoF0wy3CgeQ4VPtTFXpkhlb7di5MR5ssoby14Wko/MNdIWlYcxmQT3FGeRjo+9VYQOyREh4hEH0MJiAUhAeTuWDkgGNOEOtSrKUHaJMETJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I3MJw2TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2C7C19421;
	Wed,  8 Apr 2026 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674136;
	bh=u61zN4MGdtOdNhW6g8gNibyFyIQFvF9k0AlxWMZQ9rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3MJw2TV9CL6M077DCglOAGf9RLuSocWDQqkaypkDX9NE5WDcGy3ZSIMfhXBUZDBH
	 rDr6DTjfY8WVzruaD4MBgln4/K8Th3qj1XbQ4W1OypGU8GFLM6Pw861oOS8yQxQ08/
	 g8yHJ0ZU90XZLbB4ClKEhp69HF5Et+GrltqUTwrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 224/242] s390/cpum_sf: Cap sampling rate to prevent lsctl exception
Date: Wed,  8 Apr 2026 20:04:24 +0200
Message-ID: <20260408175935.477469649@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234932-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 87AA63C1DA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 57ad0d4a00f5d3e80f33ba2da8d560c73d83dc22 ]

commit fcc43a7e294f ("s390/configs: Set HZ=1000") changed the interrupt
frequency of the system. On machines with heavy load and many perf event
overflows, this might lead to an exception. Dmesg displays these entries:
  [112.242542] cpum_sf: Loading sampling controls failed: op 1 err -22
One line per CPU online.

The root cause is the CPU Measurement sampling facility overflow
adjustment. Whenever an overflow (too much samples per tick) occurs, the
sampling rate is adjusted and increased. This was done without observing
the maximum sampling rate limit. When the current sampling interval is
higher than the maximum sampling rate limit, the lsctl instruction raises
an exception. The error messages is the result of such an exception.
Observe the upper limit when the new sampling rate is recalculated.

Cc: stable@vger.kernel.org
Fixes: 39d4a501a9ef ("s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/perf_cpum_sf.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1188,6 +1188,7 @@ static void hw_collect_samples(struct pe
 static void hw_perf_event_update(struct perf_event *event, int flush_all)
 {
 	unsigned long long event_overflow, sampl_overflow, num_sdb;
+	struct cpu_hw_sf *cpuhw = this_cpu_ptr(&cpu_hw_sf);
 	struct hw_perf_event *hwc = &event->hw;
 	union hws_trailer_header prev, new;
 	struct hws_trailer_entry *te;
@@ -1267,8 +1268,11 @@ static void hw_perf_event_update(struct
 	 * are dropped.
 	 * Slightly increase the interval to avoid hitting this limit.
 	 */
-	if (event_overflow)
+	if (event_overflow) {
 		SAMPL_RATE(hwc) += DIV_ROUND_UP(SAMPL_RATE(hwc), 10);
+		if (SAMPL_RATE(hwc) > cpuhw->qsi.max_sampl_rate)
+			SAMPL_RATE(hwc) = cpuhw->qsi.max_sampl_rate;
+	}
 }
 
 static inline unsigned long aux_sdb_index(struct aux_buffer *aux,



