Return-Path: <stable+bounces-229974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULjVA9p0wWl5TQQAu9opvQ
	(envelope-from <stable+bounces-229974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:14:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD32F99C0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3B6530B4898
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC63C2764;
	Mon, 23 Mar 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="dLHhCDWd"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A533BFE34;
	Mon, 23 Mar 2026 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284518; cv=pass; b=rLMS6FAlknDKUAKWDR1eJK+QbM7Ea0A/BoJZtSWoLYQAzrrq9YSdYyQoWx3ccS6E/RhvzVPjJ2SoVqOO+7HXq5ZpFKsWnPrtBpjZw1poiyD59WmMghC7T5zCoYJ3tjvnmRlJNgGWQKQUuW3QjC+aTdIsp5dOpFz5TTR6RG6CXRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284518; c=relaxed/simple;
	bh=vLkitsin3lDqtkqjZQ2znIuW91wlP+ot4ojlzdgsSug=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=h6lUX4ycyU75kpAzuhOXTcVOxXAY4MrOJ01kemq7yJse8ulm8ygcYuVnJ9JWoO70NeT28rYLshTVTDXTvwhYMZOdRUAsALl7Yx6pVnGBnUu2Zg/2r6JGfxzCaDqCOKZU99ovPMYsJxYR2nvzti1sSW+Q93BhZU5dCd9xyeP4njM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=dLHhCDWd; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774284501; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TUr8chheOvYFMZxGGYScjnN+EsYrP5DvaQA6zT9fmDaScNNQVdiZRK/vBfaUvs9cqNYJbwsQHDAIa51x42XHo0r6/dieyC6FGfhTEl8qJFN5sG5b7GhxdAtNpSLSlfWakHQm6fLDbr54EMmkhhv6wQkiIgzVRVqTWGiVM/eDZz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774284501; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xuIcoUTBkBsZgUn7ZrvmHbUUe+AYpBylLNG6S3yEuAA=; 
	b=H5yDN/olrH2qhebEP05H5BiLoV1FT9l12HySF3PVURXVOYs+TMGUR52/XaBRYndsycr1X2VGGnvg4vWaUSKU3224yGLq8kKgxwm0pbGjszrs/kdiCCXmWJaBGSlER16Sru/n3JzEPyYl9ucv2KNlwt9lPY6epeSop/+5e5eKKm8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774284501;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xuIcoUTBkBsZgUn7ZrvmHbUUe+AYpBylLNG6S3yEuAA=;
	b=dLHhCDWdAnlY4xWHugxDQ+jhBSGVh0FCYNrqVzeP44ASiliqjtgH37/+LzTgyEs5
	Mob/sv7ZB2dCH4YT5ENVMUJ6EUy0MD6vvaHkTV5uQtePuabNnl8ceu1IKdWGL6khBgE
	6m+k7G6RBtRKWLXoMoQeDKNZdTOlPcur0QkN+WoM=
Received: by mx.zoho.eu with SMTPS id 1774284499534665.7592129103313;
	Mon, 23 Mar 2026 17:48:19 +0100 (CET)
Date: Mon, 23 Mar 2026 16:48:19 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
CC: damon@lists.linux.dev, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bv3_1/3=5D_mm/damon/sysfs=3A_fix_param=5Fctx?=
 =?US-ASCII?Q?_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260323152453.81603-1-sj@kernel.org>
References:  <20260323152453.81603-1-sj@kernel.org>
Message-ID: <0E185D9C-311B-47C5-AF28-06F8D1235926@objecting.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.95 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[objecting.org,quarantine];
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229974-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,web.de];
	DKIM_TRACE(0.00)[objecting.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A6DD32F99C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 23 March 2026 15:24:52 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Mon, 23 Mar 2026 09:25:52 +0100 Markus Elfring <Markus=2EElfring@web=
=2Ede> wrote:
>
>> > Markus these patches are already merged
>
>It's still in mm-hotfixes-unstable=2E  We can still make changes if neede=
d=2E
>
>I understand what Markus is suggesting is adding another goto label to ma=
ke
>the flow cleaner=2E  Because this is a hotfix that aims to be also applie=
d to
>stable kernels, I think the change is better to be as simple as possible=
=2E
>Adding another goto label could make it better, but I'm concerned if it w=
ill
>make porting difficult=2E
>
>IMHO, it is better to do that as a followup cleanup, rather than make cha=
nge
>into the hotfix=2E  Let me know if this change is somewhat critical and I=
'm
>missing that=2E
>
>>=20
>> Are there still development interests for the application of a better g=
oto chain?
>
>Sure, if it makes it better, why not? :)
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]



Also, unconnected to our topic!


I've tried to backport Damon to 4=2E19 (for a personal android thing, and =
failed! Of course)

Can I have a bit of help if that's fine with you? The tree is based on Git=
Hub a bit


V/R


Josh Law

