Return-Path: <stable+bounces-216720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGzSDDE8k2kg2wEAu9opvQ
	(envelope-from <stable+bounces-216720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:48:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A5B145C11
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1E213009886
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F8311956;
	Mon, 16 Feb 2026 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un6vkLHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C267A937;
	Mon, 16 Feb 2026 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256878; cv=none; b=hQSxBap9xYpCNMuSVhl3KkNrZwb4YSsF/zLM/y5jtf8wBnj1Ef/yj2lIzgj354NmbWK6gtVBW9mvtkTLocBgWJGCxLPA0pu6H+vzfdv4BCg9pnq3vnpzyQFJA5vQDGlnwjarQm72X7RGIfrCAN8woZEs3vW4w+SFY1DwkwaSWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256878; c=relaxed/simple;
	bh=CdeISCK8ATxFSA2FnwD7G5CTs9I7sjnJTKo65pKHHAY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=J1QQQVLwJebT3wGfl3USXJ+NDwSJZpuoL8s2PritHjbGPeh7TUWcXFEd54gfwbSVqEwthGTO2Im0CcF7V+saSSi2MhTbNZ4T5elo2ep4WjBCIW9F80yA6ziDBijJEPN1Z3zw0Z/IQmGe9ZjctPtabJEdoUZ14n/FShojqlADf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un6vkLHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62F3C116C6;
	Mon, 16 Feb 2026 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771256877;
	bh=CdeISCK8ATxFSA2FnwD7G5CTs9I7sjnJTKo65pKHHAY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Un6vkLHOY7xHfv+IUVMsx0RN140zqhqY1LRSSUpE8bVFDjXxX/drkWFTYVTEcn6/c
	 WbZZurF4hG0pnBT2J5eePRAk/hTRk0wuMGV57MzsTVjy3bVtEB8VkOqqGuGdl2gGpq
	 L4EHWQcaa8kx6UctL9UA0NRXMLKP3Jjv9Ho0tOt9i36RTwk3g7Hyn6/PwfBIawJ19b
	 yrRCZUVQJ6TPFT6VHfr2R3MiiCb1ffRfvCRcHoMj17cjWZrGTHLnesfO/9VNN6+aNY
	 HLVBzjlXpXkx+DEYfa/ebyfLb9DQULSE9URaaoWIdxMxStp54a+IeYyqFN7hAIVHV0
	 wTkHqTVUpID1A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 16:47:52 +0100
Message-Id: <DGGI5PT256ZX.E11J217J4EEK@kernel.org>
Subject: Re: [PATCH 6.12 00/24] 6.12.72-rc1 review
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>, <patches@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
 <akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
 <patches@kernelci.org>, <lkft-triage@lists.linaro.org>,
 <pavel@nabladev.com>, <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
 <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <achill@achill.org>, <sr@sladewatkins.com>
To: "Mark Brown" <broonie@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260213134704.728003077@linuxfoundation.org>
 <bde6d2f9-f554-49f1-9af8-084c4cdea035@sirena.org.uk>
In-Reply-To: <bde6d2f9-f554-49f1-9af8-084c4cdea035@sirena.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216720-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7A5B145C11
X-Rspamd-Action: no action

On Mon Feb 16, 2026 at 3:27 PM CET, Mark Brown wrote:
> On Fri, Feb 13, 2026 at 02:48:19PM +0100, Greg Kroah-Hartman wrote:
>> Gui-Dong Han <hanguidong02@gmail.com>
>>     driver core: enforce device_lock for driver_match_device()
>
> This breaks boot on at least the Arm Juno platform, upstream it
> introduced regressions on quite a few systems due to drivers registering
> in the probe of other devices.  That's obviously not a great pattern but
> a regreession is a regression.

Just for reference, I've also sent the following to the stable patch apply
notice:

"This commit reveals a few driver bugs resulting in deadlocks without the
following fixes:

  - 1. ed1ac3c977dd ("iommu/arm-smmu-qcom: do not register driver in probe(=
)")
  - 2. 730e5ebff40c ("gpio: omap: do not register driver in probe()")
  - 3. https://lore.kernel.org/lkml/20260212235842.85934-1-dakr@kernel.org/

The third one will hopefully be picked up by the clk folks soon.

(1) should be required since v6.11, (2) since (basically forever) v2.6.22 a=
nd
(3) since v5.11.

We should also consider that we do not know if (especially older) stable tr=
ees
have similar cases that we did not catch in linux-next."

- Danilo

