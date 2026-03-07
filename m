Return-Path: <stable+bounces-223418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPr7MP/9q2mfiwEAu9opvQ
	(envelope-from <stable+bounces-223418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 11:29:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6566322B0D7
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 11:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17FF73010507
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6AF374753;
	Sat,  7 Mar 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQZVGDp5"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024C336892
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879357; cv=none; b=e6PxKSXhtPE8FNp1x8A9B/Vv/0yOhDVFlG7sA2vPCA/PZeZpeaIiAyjrbWf7WBWiyEkrwzaLoSaNjny8q4jSmy4VS1V1ugA3uV186YMpQtQXEYUaH7RvsXh0USvXKAgPSOSmPijxj56gKLGZcBIpgEe/JNdy/5zNApfmIUtf+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879357; c=relaxed/simple;
	bh=ZqnMWuFNvDkRIvArOV8O4w1Fh9L2ypA0GJte+TskoUE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sxBAX7ltQgg23Wp2iudJFozsWQRCmhAC5lAqXwpl4iOzDps8da+iKRI6YcyrT7wXqRXaUbDeGFC/O+gGsg5rzCSsTW0M3Te6uS3ZYNzkmzZLlScOeQJzpJEPyYBcGvhNSZxOkUeJzuIsCTvg35FSlxM5rSyY33fcUuZjMpvFV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQZVGDp5; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772879343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqnMWuFNvDkRIvArOV8O4w1Fh9L2ypA0GJte+TskoUE=;
	b=tQZVGDp5gMZZ3dXdl6jjDpsk42lJFnH2jc/EYHQZE9N+n9WBCSRYi45Ttqouspz9cwRorj
	HYpHVEypXZC+gzoVdu7LKRv5SLU7sMwEpXCu5d4q2gcTtsvEsRODynKDJB1rIw25TF2pku
	jrYmH/A64iT0EicNtzCKSh6cnyNAq4g=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH RESEND 2/2] thermal: sprd: Fix raw temperature clamping in
 sprd_thm_rawdata_to_temp
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20260307102422.306055-2-thorsten.blum@linux.dev>
Date: Sat, 7 Mar 2026 11:28:30 +0100
Cc: stable@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <688F36E4-511F-4C41-9EB8-5B14BA410AE3@linux.dev>
References: <20260307102422.306055-1-thorsten.blum@linux.dev>
 <20260307102422.306055-2-thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6566322B0D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,arm.com,gmail.com,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On 7. Mar 2026, at 11:24, Thorsten Blum wrote:
> The raw temperature data was never clamped to SPRD_THM_RAW_DATA_LOW or
> SPRD_THM_RAW_DATA_HIGH because the return value of clamp() was not =
used.
> Fix this by assigning the clamped value to 'rawdata'.
>=20
> Casting SPRD_THM_RAW_DATA_LOW and SPRD_THM_RAW_DATA_HIGH to u32 is =
also
> redundant and can be removed.
>=20
> Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver =
support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> drivers/thermal/sprd_thermal.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> [...]

Feel free to squash them as they touch the same file and fix the same
commit.

Thanks,
Thorsten


