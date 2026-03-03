Return-Path: <stable+bounces-222879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOAOAHbdpmnRXwAAu9opvQ
	(envelope-from <stable+bounces-222879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:09:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B11EFEB7
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14420309D97B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029E423A6B;
	Tue,  3 Mar 2026 13:08:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE27423A76;
	Tue,  3 Mar 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543302; cv=none; b=ZmVZdtNtonpl23u+igc+0nFZf3IzRJSraOlaT6nbso7P2k8mlhW7/BoD0OD2qLXaVVTAj11sf216vI5QG0f95EnszOslqcshk7BvwDXrWKVUDKBndvBQaUVdNCOnAEgI+daEG9O3Q0NY9Xyj1PCKjyNxqfH7WB59Hqzf3Glchj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543302; c=relaxed/simple;
	bh=mf5fgCsvf7IvcoV7wY/cjlg9lZh+yY4zUXZ+flLTPvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv8H7WwyI0H+YKqLwAJGtk4ubmzSdau18dBDrDkSUQnDlVQaGz+bFiXAq1fCEugK2Vc19mOQuXTkVho/qhXXopXWUZHS8KYFN90AGCGc1/XEGV3kXdUVOxj0jYZ4GC9kKGa8Xjt8WjRL8/FqNvz7kfWVpBnunfx0JHBPfeM2Nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DEF3497;
	Tue,  3 Mar 2026 05:08:14 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7643E3F73B;
	Tue,  3 Mar 2026 05:08:19 -0800 (PST)
Date: Tue, 3 Mar 2026 13:08:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Rahul Sharma <black.hawk@163.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/2] Fix patch backport review
Message-ID: <aabdPVl_2PSvbn0p@J2N7QTR9R3.cambridge.arm.com>
References: <20260303015047.2014999-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303015047.2014999-1-black.hawk@163.com>
X-Rspamd-Queue-Id: B53B11EFEB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222879-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.166];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 09:50:45AM +0800, Rahul Sharma wrote:
> This patch series is to backport the fix d2907cbe9ea0
> ("arm64/fpsimd: signal: Fix restoration of SVE context")
> to 6.12.y and the first patch
> ("arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state")
> is its dependence.

Neither of these need to be backported to the v6.12.y stable tree.

In the v6.12.y stable tree CONFIG_ARM64_SME depends on BROKEN, and these
patches only matter when CONFIG_ARM64_SME=y. I think we should leave
that BROKEN in the v6.12.y stable tree given that suddenly enabling SME
for distros could cause all sorts of surprises.

If you are going to backport patches I have written, please CC me on
those backports.

Mark.

> Mark Rutland (2):
>   arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state
>   arm64/fpsimd: signal: Fix restoration of SVE context
> 
>  arch/arm64/kernel/signal.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1
> 

