Return-Path: <stable+bounces-244323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJnZC0zj+mmGTgMAu9opvQ
	(envelope-from <stable+bounces-244323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:44:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B64D6BC0
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82AD0304AA91
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 06:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192F323417;
	Wed,  6 May 2026 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXoF9oww"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7231F9B5;
	Wed,  6 May 2026 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049859; cv=none; b=ICEPN8ClDPACCdORxRGYdc8675bTD0GQRNsiuaZGlfUe8wLKLzHgAEGVLjxDkwA2wCWLlGkFM2kOFVIWoy0a1iZQpbQeTfDrkw+2d9D6rh83UHkyDo9k2SQbPZWA8doUBDa/wQNfJI0KOpNOFLEIZm1GVAOc3o3pP5f8th2ShHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049859; c=relaxed/simple;
	bh=uJ+0Y5CUIX/Tppv23mh4BVCIU+d4MEc4VXwpDVnamdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsX96Zg6ZxZ/Ad9mV8liXZBc6PRR5v21YsJdjjLhDgcQvVe1UyYaoo61UJDaNZqJtrnHVh3jn9ts4lySNSTsUmZOFW+NrvTAeNSnwnTSI54io9dCyAKyvHTsbS9Mztsrhm8InLSEiPKUVxXzDKWzjd5vK2+oN850wBNgegCQHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXoF9oww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3465C2BCB8;
	Wed,  6 May 2026 06:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778049859;
	bh=uJ+0Y5CUIX/Tppv23mh4BVCIU+d4MEc4VXwpDVnamdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXoF9owwOGkNeZdBqzLoupDGuDk66DB88WvvjVfL5H+W/G0xUxxa59KXXuq0jE/MS
	 DFa9QhPd3enm3AkokzWk5id5A0pBGS8nECGdJEAQz/blPGbDC7AT7AHI364/mn5BGH
	 Y1KEw0LdlKkgPtScnkhc5vlS+gWJfKpgFfIVFqbsNZsjBUxLAePcX4bofoPLkQK2ha
	 +h8mZcT7+ebERNtBuHmdlhK6DrkGpn3k2KUlGiBLyeCg4u46aE6EGBQHC1MAWEo/qV
	 braf0GK8mB7usYlTfVLXIgsQNACPiSdXvI7wntAC+eG0E31BnoOouj9SyMkhfqVWdN
	 ST6nZP4JG+T8w==
Date: Wed, 6 May 2026 08:44:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v4 00/13] media: iris: Add support for glymur platform
Message-ID: <20260506-rugged-beluga-of-gallantry-a2e41e@quoll>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
X-Rspamd-Queue-Id: 9F6B64D6BC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244323-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linux.dev,kernel.org,linaro.org,gmail.com,8bytes.org,arm.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 12:29:21PM +0530, Vishnu Reddy wrote:
> Glymur is a new generation video codec that supports dual hardware cores
> along with additional power domains and clocks.
> 
> This series adds platform specific support in the iris driver to handle
> the extra cores, power domains, and clock requirements introduced by
> glymur. Add support for firmware loading through context bank firmware
> device.
> 
> Dependencies and merge strategy:
> 
> Patch[1]: It's a generic fix, media maintainer can pick this independently.
> 
> Patch[2-3]: DT binding, DT maintainer can pick this independently.

No, this goes with media, please follow submitting patches.

> 
> Patch[4]: Iris VPU bus, media maintainer can pick this independently.

Then do not put it inside other media patches. Just like I said on
teams chat - focus how this is perceived by recipients.

Best regards,
Krzysztof


