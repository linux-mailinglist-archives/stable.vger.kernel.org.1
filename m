Return-Path: <stable+bounces-265464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wnKKOcOKMWp7mAUAu9opvQ
	(envelope-from <stable+bounces-265464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:41:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD96935F4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:41:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cFCVWke4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265464-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265464-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A76E30701C0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7A4611CF;
	Tue, 16 Jun 2026 17:35:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DD4502F;
	Tue, 16 Jun 2026 17:35:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631333; cv=none; b=YX4THUX0loYtFdIZgXBGpvvEQD5GxJp9CYlzRMw+sMJJrD7vPtsNNYctcOD75k05fbKh8bLwLOAI4KUUQu5/U1gqIM3rbQ/QJz/YAvSce7YFKBY2a6qTFRqP5piMR0JH9yfjlIX7C/bnJHtHCOVX0gIk6Pt1i90Sxq8fBbk5ghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631333; c=relaxed/simple;
	bh=L3l3k06sV5R8UaxPGC9PXa7TnsCdnwbhKitlMO/edfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcfdbsiISz1qRuGwfqXoDncl7HLWCbimiD4i0LhYuREfQJ57Mzq4YcJ7/BYFJLW5n1SRbi87OvuEI/jAlVmKpvRulfTdLj5gQR0s222lB4zdsn1I1Gz6j09bU/LvVPXp9bRJMPVS0rYaDXlj7EbrwEWLka3pgtEMqt3lv67kmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFCVWke4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2F01F000E9;
	Tue, 16 Jun 2026 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631332;
	bh=ocUwywtCwyaUFRanUW/0wD4MCI+2DW57wGmHkFN8Ko4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cFCVWke4+wKakbm++i+jBeiaDCL/pttePT0TdISstS/i87MhrpYr1rruKvY+5kxhp
	 UUOh9dU4WGP2CgmLpHtkXsmxdwuGTs8tbyJ/seZ/AQ5OQJ9wrb0jMicsfm5jmu7uQS
	 1wuD9hcurwMMzpb/p00VIN2aGHH4KuiKI/wFBa0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Huang <jinhuieric.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 174/522] drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
Date: Tue, 16 Jun 2026 20:25:21 +0530
Message-ID: <20260616145134.285780229@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265464-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jinhuieric.huang@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ACD96935F4

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Huang <jinhuieric.huang@amd.com>

commit e984d61d92e702096058f0f828f4b2b8563b88ce upstream.

The process_info could be NULL if user doesn't call kfd_ioctl_acquire_vm
before calling kfd_ioctl_svm.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 83a26c812e0529eb040d31a76f73e33e637243d4)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3404,6 +3404,9 @@ svm_range_set_attr(struct kfd_process *p
 
 	svms = &p->svms;
 
+	if (!process_info)
+		return -EINVAL;
+
 	mutex_lock(&process_info->lock);
 
 	svm_range_list_lock_and_flush_work(svms, mm);



