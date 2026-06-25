Return-Path: <stable+bounces-268271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bd40HcDEPGqgrggAu9opvQ
	(envelope-from <stable+bounces-268271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF46C2E02
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:03:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JAoszi7l;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268271-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268271-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD0A303012A
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC9302742;
	Thu, 25 Jun 2026 06:03:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF91624D5
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:03:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367420; cv=none; b=YO8Ehe7O+yu2CoAeO5qFsBU3PUt6X1la18ZmeMsGBS+gZtHbk38sengIIJpzlDOQ42IytV84HNDvILmJacNear/rQvV08nRcsM7cX+CGs9553+fhJ9we0fdnPP4hLCx4HVfZeOu1uDED8ksutI3OqBgthKHykcsEPj5NpqshNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367420; c=relaxed/simple;
	bh=q/YwrEFIdj69fHdgVP44qW151yn/KW8ps9+eXO3UHFo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=lCo5tZMKgyeMHNwVskdYqC6Pq4naC7DzZD1gv9wIXz8W8i5OQ6aTlsYUbZxtKNRa4oCkeDnZhbQEUrhQ4/YV9ZX0w9z3swrP70IcAt3NNSiqS6Ax6OAy6NwyOX0i4bdP82XTSJ9ck1iZkFjYtY6dPdX8yDYNG6MEGe5krfs0WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAoszi7l; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367419; x=1813903419;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=q/YwrEFIdj69fHdgVP44qW151yn/KW8ps9+eXO3UHFo=;
  b=JAoszi7luhOdjpO4+AqlXIQ7wyh3nJMMIfa69hbxEuad9HQGdXdkvdJE
   YBPwSD1DCx4ScT2PeUDntmLDgm+K1a7y2MSUtfaVYI+QrSPneR+RTBvj8
   HzFp1avDQDAAdUy6r00g4Vq9iVi8jq8vHVOoMtbB7whbfcV1d83jy16/j
   DvoeWITGCP73vIG9apkBXPFGs/MNSvn0RjbH+YseQ9g1xMpLDGVGh1SWc
   gsW9zGIOQCC8QDdWo6E6I91OycI8nUlPCMZtnWv8+HB/c4tUEMSGsT6JS
   PoCqKaSbtLIRTfAYAX0WFMEWHR6Yd1QmWiu0cLv1ZniUTLcMg6dIbPAFC
   g==;
X-CSE-ConnectionGUID: cXwiQbfVRGWg9AtwFMZu2Q==
X-CSE-MsgGUID: C32sqXS4ThiaL9kcR6DM5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83190189"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83190189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:03:38 -0700
X-CSE-ConnectionGUID: vq5Cf/qQR4G4HhsQIQKN4g==
X-CSE-MsgGUID: vBKTnjf3Ti6bg1qjUqLxJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288475638"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:03:36 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ajvTjodx7LLj_BPO@zenone.zhora.eu>
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com> <178230031953.112641.4817434529385736057@jlahtine-mobl> <ajvTjodx7LLj_BPO@zenone.zhora.eu>
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instance
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
To: Andi Shyti <andi.shyti@kernel.org>
Date: Thu, 25 Jun 2026 09:03:32 +0300
Message-ID: <178236741262.19845.6184407491878204182@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-gfx@lists.freedesktop.org,m:martin.hodo@intel.com,m:maarten.lankhorst@linux.intel.com,m:thomas.hellstrom@linux.intel.com,m:simona.vetter@ffwll.ch,m:stable@vger.kernel.org,m:andi.shyti@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268271-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jlahtine-mobl:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CEF46C2E02

Quoting Andi Shyti (2026-06-24 15:59:30)
> Hi Joonas,
>=20
> On Wed, Jun 24, 2026 at 02:25:19PM +0300, Joonas Lahtinen wrote:
> > Pushed to drm-intel-gt-next, thanks for the reviews.
>=20
> please, next time:
>=20
> - Give people more time to review the patch. Only two hours
>   passed between posting it and pushing it

And why exactly is that a problem? I got the review from the original
patch author and a yet another person on top while it's a very
uncontroversial and trivial patch. Two reviewers per patch is already
quite a high bar to clear if you look at git history.

> (during lunch time, BTW).

Sorry, I did not know there is a universally agreed 2 hour lunch window
in UTC timezone that I should follow. I've missed that memo.

> - There were BAT failures. They were unrelated, but so far we
>   have generally held back patches until BAT was green, even for
>   the most obvious changes.

Strong disagree here. That'd have caused the patch to miss -next-fixes
PR just due to random noise of CI.

If there was a reasonable doubt about the impact of the patch on the
failure, that'd of course be different, but here there was absolutely
none in this case.

As per patchwork automated mail reply:

> If you think the reported changes have nothing to do with the changes
> introduced in Patchwork_169089v1, please notify your bug team

That's exactly what was done here. That's a fair ask, but asking for
maintainers not to merge any code because of false positives is simply
not.

Regards, Joonas

>=20
> Thanks,
> Andi

