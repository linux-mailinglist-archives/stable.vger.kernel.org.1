Return-Path: <stable+bounces-227539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLBUMq1BvWn28AIAu9opvQ
	(envelope-from <stable+bounces-227539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:46:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5A2DA790
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 742613006106
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D61FE471;
	Fri, 20 Mar 2026 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9ecXcsO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6A329378
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010793; cv=none; b=ddnTIzs63DISGLecoktbILpK9q+pm7Y8Ig7/fEOnQtnrfA37LddcOXiHlKcIYwSYR0R4PrFON/QB/uX/JHtb/ll9Z6N8sXarfBKFxy3kc9/JI8F1nle/l8XwshX2WVAh61CHlKEn5v79z9VyjY7RK8XaOYoYByqmt4/YquHLC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010793; c=relaxed/simple;
	bh=tuMlyhFXowWQJlTWT/rAvjCmaaPYBabH+m5XFJdd5sY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVcqEkGY7HdYLTeGdxuCYea6OVUAdkIsbul45UVKx2olVgFaOtbSDOdu8opkMjXBuJbFJ933f5srijk97KCzXluVk45OvdY0OHfA91dfTA7vz+dnKvDgoe5t/chnhVbb/vaR+z1v/ZtK75igRvvgn63GFmfsALpikLkYgClnWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9ecXcsO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774010791; x=1805546791;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tuMlyhFXowWQJlTWT/rAvjCmaaPYBabH+m5XFJdd5sY=;
  b=S9ecXcsOQywltVOg69iVs01D0mn4fjOEYH/ktET8JyURwWUc2UKzYOSJ
   o4a/O9t9jCsVtssvXrlX7G0N2Dc7qygKa4n2ZQ47BJyHGTbsQHET3ZAbl
   w0phBKsZAEAVL1Hmsvh96+kTzRdT7DPvRjXA1aSnYer/fPwCs9kIgR626
   oc3PaRW7HSmCa6FbZmwMQ4vKsWZDlrKl89suJE+lvDPhm33WJKHrZoZwO
   8HMl7nCBWSDOk8W4BHNxP4jOo9JPfeD9BvSiOpGCfyl6QUMPgORAjgv8+
   aycgwR0OBdHErI6diwXd7agh1wRzGa/SxvU0qxXGZVIpvcStvxrc16J3i
   g==;
X-CSE-ConnectionGUID: ksveKf69S/6zh9oQXvU9IA==
X-CSE-MsgGUID: 9OSFozyeQFu6OM97JxMJvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="78950702"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78950702"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:46:30 -0700
X-CSE-ConnectionGUID: 5v6FXgybR4WBU5PvTdK9Yw==
X-CSE-MsgGUID: RC6IOj3UQ3G5vxONf4qshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218635962"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.69]) ([10.245.245.69])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:46:28 -0700
Message-ID: <7c282de391630193875e2ffcc3002cc1f6e75178.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Disable garbage collector work item on SVM close
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Date: Fri, 20 Mar 2026 13:46:26 +0100
In-Reply-To: <20260227015225.3081787-1-matthew.brost@intel.com>
References: <20260227015225.3081787-1-matthew.brost@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 47B5A2DA790
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-02-26 at 17:52 -0800, Matthew Brost wrote:
> When an SVM is closed, the garbage collector work item must be
> stopped
> synchronously and any future queuing must be prevented. Replace
> flush_work() with disable_work_sync() to ensure both conditions are
> met.
>=20
> Fixes: 63f6e480d115 ("drm/xe: Add SVM garbage collector")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/xe/xe_svm.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_svm.c
> b/drivers/gpu/drm/xe/xe_svm.c
> index 002b6c22ad3f..f8b57eca76fd 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -903,7 +903,7 @@ int xe_svm_init(struct xe_vm *vm)
> =C2=A0void xe_svm_close(struct xe_vm *vm)
> =C2=A0{
> =C2=A0	xe_assert(vm->xe, xe_vm_is_closed(vm));
> -	flush_work(&vm->svm.garbage_collector.work);
> +	disable_work_sync(&vm->svm.garbage_collector.work);
> =C2=A0	xe_svm_put_pagemaps(vm);
> =C2=A0	drm_pagemap_release_owner(&vm->svm.peer);
> =C2=A0}

