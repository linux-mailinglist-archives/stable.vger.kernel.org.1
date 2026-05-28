Return-Path: <stable+bounces-255228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAylHrSfGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D25F7BFE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA163054F75
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FB0409605;
	Thu, 28 May 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DHeM8HM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5033CE8A;
	Thu, 28 May 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998321; cv=none; b=oHq/FD6t0sbYA0MChwCF/zCaxtV654pvMYyRLb0PqiZiVqaJh75FaFWuvc9HHg6IHtzYgfcv0LsYndxcsEZQH8urpVo1zNyXfxk+X4MgP/qOfg3RdKJpC1YSSTHWE3cL8CIcmJhsiyDSeZl7flSCOvEDhqxHbMUmX4S/Yz9BqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998321; c=relaxed/simple;
	bh=M00FM0ZwVBbok6kc27CwOVwnuh7W+oTW/jN3+fSIcmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy2B681Lbd/BcQ0da1O0yK3gZfTkfWu+EQT50xKaY3xKky7iwMtRxbBayjyRV53MQexbzxMeEfHc7KycdTtNMx74xRA//SkKtIqi68rjxcarai9UO55FS8PG8gRpJ5A5OOdB55OdWmvyxk0cAYDbSwRIYykwUiS6mBc/iSw9zs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DHeM8HM6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590691F000E9;
	Thu, 28 May 2026 19:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998318;
	bh=19S5siDZY4ww8/ZAfkB1h0zZux0bhoPFT66Dou/cuuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DHeM8HM6Tvztmgqy20yhxvq//Uj2YaUerOy8nngfoHYJ7AVtOVycT17/9drpFe9RN
	 AByaNH2uUcP1sFPOYKBwQbgQDpSMjTCJSAuIVEDLjVcsSggflAcvYdEoWEJlhIWvYU
	 lACtNb0vWIrjTVQkwzSkaEQ52c64cUeM+TQyfYTs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Iago Toral Quiroga <itoral@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 7.0 132/461] drm/v3d: Release indirect CSD GEM reference on CPU job free
Date: Thu, 28 May 2026 21:44:21 +0200
Message-ID: <20260528194650.811034241@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255228-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DA3D25F7BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -132,6 +132,9 @@ v3d_cpu_job_free(struct kref *ref)
 	v3d_performance_query_info_free(&job->performance_query,
 					job->performance_query.count);
 
+	if (job->indirect_csd.indirect)
+		drm_gem_object_put(job->indirect_csd.indirect);
+
 	v3d_job_free(ref);
 }
 



