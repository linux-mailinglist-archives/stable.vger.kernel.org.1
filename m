Return-Path: <stable+bounces-264663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jPlOHg15MWrrkAUAu9opvQ
	(envelope-from <stable+bounces-264663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:25:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AB16920FE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:25:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=InX3F6VH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264663-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264663-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B9D43035B88
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3943E4BA;
	Tue, 16 Jun 2026 16:25:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21643E4BE;
	Tue, 16 Jun 2026 16:25:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627147; cv=none; b=YmHGZm0AeLwUOQee3EMw64UKGr7vSE4/QaZUgCiracJvLpdVChdvbuZGschtyu4prSgWJLK+2qU8XqGggzqk2VvaT4ErhA6VPC953kboc+FxTt2uFC8oDm2cMdqie7Q1bAmVdM4ZdE44XYtQDQhQ5nCOmWv10FwMuwSAZ/0jdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627147; c=relaxed/simple;
	bh=gFmHiJtEsRiLGbztsvstXebFO3/vPqbFBwIzjg5EpiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px+3a18lwGZwr3tQhxO4pJZxHcoSTk9RyAnizzUz9har2HPrKO5Gk4UbZceowdUCnERc6G3rFyNUQgXTrO24dVNibAw2Jxt3B+bGuDLj+Ce4U6NiAI+L/xbhJ1OtmBxXHrLorajvpJlPDV50NXnJmUWlE0rWbLO5NvinddpIFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=InX3F6VH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9732C1F000E9;
	Tue, 16 Jun 2026 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627146;
	bh=3bFrGQilEl2VDrKh1tHay4mSY4+6TuIwhdhMR8FCZHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InX3F6VHajr8uKgQqEclXLIklgsbAi5AT5u3EpmWm/4CChJ194VQJ/sAgZ+JrCMM3
	 AxjwlM4iY5YkoxGcAsJehKpNFmWraJ2CR38ttlEQ2xUMUdzKLb+h7ry8PNmbqmsFk3
	 EVoL+f3cT3+35nqww5sihO3jZavG6KQ/18J+W6yo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 6.12 126/261] accel/ivpu: Add buffer overflow check in MS get_info_ioctl
Date: Tue, 16 Jun 2026 20:29:24 +0530
Message-ID: <20260616145050.923307629@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264663-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrzej.kacprowski@linux.intel.com,m:karol.wachowski@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10AB16920FE

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

commit fb176425837693f50c5c9fc8db6fbb04af22bd0a upstream.

Add validation that the info size returned from the metric stream info
query is not exceeded when checked against the allocated buffer size.
If the firmware returns a size larger than the buffer, reject the
operation with -EOVERFLOW instead of proceeding with an incorrect
buffer copy.

Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260529120841.135852-1-andrzej.kacprowski@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_ms.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -282,6 +282,13 @@ int ivpu_ms_get_info_ioctl(struct drm_de
 	if (ret)
 		goto unlock;
 
+	if (info_size > ivpu_bo_size(bo)) {
+		ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
+				      info_size, ivpu_bo_size(bo));
+		ret = -EOVERFLOW;
+		goto unlock;
+	}
+
 	if (args->buffer_size < info_size) {
 		ret = -ENOSPC;
 		goto unlock;



