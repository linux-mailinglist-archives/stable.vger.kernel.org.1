Return-Path: <stable+bounces-267593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g4SbLi+POGrfdgcAu9opvQ
	(envelope-from <stable+bounces-267593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 03:26:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B46ABF06
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 03:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kFOwmDBj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267593-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267593-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18C293008523
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 01:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C0E245020;
	Mon, 22 Jun 2026 01:26:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9412B94;
	Mon, 22 Jun 2026 01:26:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091563; cv=none; b=ds7hBUkyox8BktkWGlwyyCyiynPUnVzT6tZ7jwCZDtHwqxoQ2rUaXWy2xTvC372jqO4NdDxs9Ryf/H+tn66vslFyc6XOoGXRrTS57aZ9UBsVyqQYsuGVaKM/KCisEerF78ZdT3LAKy9h4lp7TBW8UTkxUaj/TN7VxZYUtjprAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091563; c=relaxed/simple;
	bh=FYXFG0/TfrGv4Al8kmRQ7eXUqLItVkQl0lZqAhBTFm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwuXh0xiz6/Q4vIQzxkf/Jlhg+TmkagnAXJJVS/ByUOoMnYzEBfJZFAl82ytLwT/yZM7lDhhtJwW03JweYZTpOHZ2Z/frnhN+my3WYZQ4pQkhaOoQPWKLxS/Tr0wuHxfsB/dGZD0dTuVHeXgq9rakShaUv0Ef0rhY0Jo/+qo03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFOwmDBj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278651F000E9;
	Mon, 22 Jun 2026 01:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782091561;
	bh=vBFFAv4vJY9m1MG+5W9luTeAXHDARWP5cNSg2vooz3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFOwmDBjjR11fKsVXuVmgdhFZnKk7RG5CjEKiNFukgYAkoBi2WBKHMMFHKttLyVRg
	 lBUVHP5I+5cJ2SoqWA+nFwfJSbcgIW2aDqylGEKMK6Y/R6sKc37T7g5fBJLuOG1//h
	 YjIqw5IujmMTnv6wyoBuqBu5aEEmjPiST3jWnw9nODD8H/BAllPj49XRupC05KKy+7
	 8h/AgwseMLDul5xdphUH689dFKka4bUa43vPqq/s3ZXsEEJnA6Gox3BpAabgwYU882
	 roTFeFsUa0sBL2zF7ZAZjSSYrcrGzJ+1bny8h3H/CZSeoR+fRx7xlBIz0BVMX2wLJw
	 JNgsBbIALVETw==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 6.1 342/522] thermal: core: Fix thermal zone governor cleanup issues
Date: Sun, 21 Jun 2026 21:25:58 -0400
Message-ID: <20260621212034.0001.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <42c2abbdfdd4ea8e234fbcfc4b37095ebd2c7b36.camel@decadent.org.uk>
References: <42c2abbdfdd4ea8e234fbcfc4b37095ebd2c7b36.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267593-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:rafael.j.wysocki@intel.com,m:ben@decadent.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 228B46ABF06

On Sun, 2026-06-21 at 17:29 +0200, Ben Hutchings wrote:
> > 	result = thermal_zone_create_device_groups(tz, mask);
> > -	if (result)
> > +	if (result) {
> > +		thermal_set_governor(tz, NULL);
> >  		goto remove_id;
> > +	}
>
> The order of initialisation in thermal_zone_device_register_with_trips()
> is quite different between 6.1 and mainline.  Clearing the governor here
> doesn't make sense as the governor has not been set yet.
>
> The proper place for this in 6.1 seems to be in the failure path after
> calling thermal_add_hwmon_sysfs().

Right... looks like it's just a noop.

Although it seems that  the leak it's meant to plug is still covered on the
affected path. When registration fails after thermal_add_hwmon_sysfs() (the
path where the governor *has* been set), the unwind goes through
device_unregister() -> put_device() -> thermal_release(), and the
thermal_release() hunk in this same backport adds thermal_set_governor(tz,
NULL) there:

> > 		tz = to_thermal_zone(dev);
> > 		thermal_zone_destroy_device_groups(tz);
> > +		thermal_set_governor(tz, NULL);
> > 		kfree(tz);

That is the same put_device->release mechanism mainline relies on, so
the governor is unbound before the thermal zone is freed and the leak
does not occur.

--
Thanks,
Sasha

