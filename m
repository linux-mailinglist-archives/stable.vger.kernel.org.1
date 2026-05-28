Return-Path: <stable+bounces-255688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCOvNKilGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:29:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6E5F8CE4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF4132A7166
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843C2D9787;
	Thu, 28 May 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/AyuHos"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DE2D1303;
	Thu, 28 May 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999612; cv=none; b=qAcRVMU5m4HUfm3u2tjKtapAfCWLJuEOlNv4H8pUgV6Rv3eSzCr3iz7hL2nneajxU6DBsqtazAYflwUc1d9u8CjW4q7+7ShgqU9ZGLnIxKmsLmVcMUs9053sVtTjIWc0vNmFicQzqFkNgIjm/UVFv6MALXmpPCOsFAxezU0O1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999612; c=relaxed/simple;
	bh=ZMhG8O/Ao+f0gW+nD7f1TmZyYt1WCTq6TFm8jCSJXsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJzZEMPrO4Q5Hzqoav/g5NQwVGTB3O7QSHWE0Pa0n8i2vBTucoDjEUP7Nt/R3SKpJznc2yl5v9N8YqfIWkvEqgKpL9mkK5Gpnod24n/OUZUhTH2vyBFdeNXy3LlNIQb+7OYu4DPTB6Nnn4r+aYj2Q/FqIdlR6dqqGO0glZ1v8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/AyuHos; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AA21F000E9;
	Thu, 28 May 2026 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999610;
	bh=Lz96mrW2DkfkHL9NtDr/F7DoBS2ObBKypMbcgRxsCmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s/AyuHos9Kr9Gqp6KoNkxQRCsIoxPiHyQzUZvi06Z+32LMLDCfkPqrT54RsZLfVaT
	 MeEb0A/DJKjNYn8q72fRTTsn2voIAfIw4UO/zWIYCTi5crlG8qO+LpHj6M1qi0p88n
	 GO383rEl8Pzq2vppdUiY2rAsqqYoQG4n+RgV6AT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Iago Toral Quiroga <itoral@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.18 129/377] drm/v3d: Release indirect CSD GEM reference on CPU job free
Date: Thu, 28 May 2026 21:46:07 +0200
Message-ID: <20260528194642.097083972@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255688-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5AA6E5F8CE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

commit 6eb6e5acafa46854d4363e6c34981289995f3ace upstream.

v3d_get_cpu_indirect_csd_params() takes a reference to the indirect BO via
drm_gem_object_lookup() and stashes it in cpu_job->indirect_csd.indirect,
but nothing on the CPU job teardown path ever drops that reference.

Drop the extra reference in v3d_cpu_job_free(). The NULL check covers ioctl
errors before the lookup ran and CPU job types other than
V3D_CPU_JOB_TYPE_INDIRECT_CSD, which leave the field zero-initialised.

Cc: stable@vger.kernel.org
Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Assisted-by: Claude:claude-opus-4.7
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260515-v3d-cpu-job-leaks-v1-2-7f147cbbf935@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/v3d/v3d_submit.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -131,6 +131,9 @@ v3d_cpu_job_free(struct kref *ref)
 	v3d_performance_query_info_free(&job->performance_query,
 					job->performance_query.count);
 
+	if (job->indirect_csd.indirect)
+		drm_gem_object_put(job->indirect_csd.indirect);
+
 	v3d_job_free(ref);
 }
 



