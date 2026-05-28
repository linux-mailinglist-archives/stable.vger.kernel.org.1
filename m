Return-Path: <stable+bounces-254985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KaWKc1EGGr5iAgAu9opvQ
	(envelope-from <stable+bounces-254985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:36:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B46F5F2D10
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB0A43011797
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC13E6394;
	Thu, 28 May 2026 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rJLuN34P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5C3E8330
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975370; cv=none; b=FArbkEe6cgwyc9/MWnpaS9ZZLw/NZxumI4Y56sDa0un+/xK5HU7txuE8wxuByjeW9ZNGJF6PL/0coZO15Np49YoJ6CUQHv+tnuOzQ2wwjclcnitp3bphyxcugtOHgUJmZYwx/UtA8fhUv8/ympT3+UBRfxstRw7Z72C9QRrHr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975370; c=relaxed/simple;
	bh=NDfDv/Fi7uq+FVkDpmQMLPoOWvIP6kafQks3TCu6s2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aorm5o/wJAxaY12CmbUkRs/Z7gkLoAGrXuCIRpPSlHksuJnewZPX3jpAeP4bpya1i4SyWQbowX2g7ZE63oX5P8q98Pd0xKyW9FXMneNGSFNfHa0YeLyGO+ox0/C6H1sAjFoI2YoKW4sp5rL1ihaaNjkUxnfjYSqCrOmNHbw9sXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rJLuN34P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3DB1F000E9;
	Thu, 28 May 2026 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779975368;
	bh=h/VSMs1gfL3xp95zQUN78WID58mLP9y4h3IsxwoWbmQ=;
	h=Subject:To:Cc:From:Date;
	b=rJLuN34PE3FAsQHx/cUWN2RQC0EF3vX80fsk6J2kGYPBCoHS6x7FCPFOqAZqwYOKj
	 wgCCs+qbrXV0FvpVe+WwYiWkLQv5kXuEWtmQrMDnelDMxb0qimNSwypSQLb42ndNor
	 Hh3NrfcHvJ8UHGflO1+BQ5EXZfDc6mHgDQW8f2iA=
Subject: FAILED: patch "[PATCH] drm/v3d: Release indirect CSD GEM reference on CPU job free" failed to apply to 6.12-stable tree
To: mcanal@igalia.com,itoral@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 15:35:15 +0200
Message-ID: <2026052815-arose-kabob-9b34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254985-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email,igalia.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 4B46F5F2D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6eb6e5acafa46854d4363e6c34981289995f3ace
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052815-arose-kabob-9b34@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6eb6e5acafa46854d4363e6c34981289995f3ace Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Fri, 15 May 2026 12:07:15 -0300
Subject: [PATCH] drm/v3d: Release indirect CSD GEM reference on CPU job free
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index e3a6e7cc7bd5..3ddd53b6f437 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -135,6 +135,9 @@ v3d_cpu_job_free(struct kref *ref)
 	v3d_performance_query_info_free(&job->performance_query,
 					job->performance_query.count);
 
+	if (job->indirect_csd.indirect)
+		drm_gem_object_put(job->indirect_csd.indirect);
+
 	v3d_job_free(ref);
 }
 


