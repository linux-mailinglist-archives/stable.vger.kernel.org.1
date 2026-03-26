Return-Path: <stable+bounces-230412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEIoLF2fxGki1gQAu9opvQ
	(envelope-from <stable+bounces-230412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:52:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 559FF32E832
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 370613014FEA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FBC34402B;
	Thu, 26 Mar 2026 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E96b6OMM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717A77F39;
	Thu, 26 Mar 2026 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774493523; cv=none; b=pn83FAJBFob1tAebRili3/aTGSHqvc1nGHLxpsHtVZVu9uedwwPwpPXLVGrYQZ8YZZIT1GJiwZcEqC0imi7SHIu2B8H9tT+XOtAlaG8PGhVpHT4+gxeuGQ/804wXUkd69CP1n01AuskB977eE46mmdgwnL64i0kFTltafPn1TkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774493523; c=relaxed/simple;
	bh=A+GXnGT9Ep3iwufn3Pmxa7uHTI+2orro7gkD2bePT7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQQDAesOYrngSXNyO7h0jEtrhreRz0wZ1zanzmWM2G8GT9nD2z4n+4RZtRJ8tjRgpdU5zYbYCw+XeFBaE9vnqbXSq4gSM8IG//Cnf8BMvZHwI/vokAMtL+TNG+XX6kJ+oHP8dcFwDW10id0St8efWhW/w5Y+YkCl591pE2nq7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E96b6OMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94256C4CEF7;
	Thu, 26 Mar 2026 02:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774493523;
	bh=A+GXnGT9Ep3iwufn3Pmxa7uHTI+2orro7gkD2bePT7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E96b6OMMq/PGfVGGxG5F3VmYcRtn3DwFeCyF82CcVS9/vmB9a3WA4IXux2MzLienI
	 +O/VDw+ck3Yrh/h65c4dSafbBUXcYGFqy7xgGiSV6f4nUnkwzgIpEx+4P9md9kFB0O
	 4E2/YaY65xyaWw0tq+8l9FJWzpI+oIAYYlEtrMDRCLRr6l8bIKTtKQUVtwnU4HJRjh
	 IrLYUXLTCnBO27noyggqzgGAAQPExY+tpeOFndnqxyV/jY/rk4NdwHjpir3DiuODKw
	 sqt3ul0ERaBwiiFKbB6WTzR0snVMeltCsP9gYZZ10tNqn4liWsjK0zi+YB2c0F5Luw
	 +nE5n6BwditIg==
Date: Thu, 26 Mar 2026 13:51:54 +1100
From: Dave Chinner <dgc@kernel.org>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: Carlos Maiolino <cem@kernel.org>, Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-xfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfs: start gc on zonegc_low_space attribute updates
Message-ID: <acSfSmE_IBjWl_cR@dread>
References: <20260325124312.26349-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325124312.26349-1-hans.holmberg@wdc.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230412-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 559FF32E832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:43:12PM +0100, Hans Holmberg wrote:
> Start gc if the agressiveness of zone garbage collection is changed
> by the user (if the file system is not read only).
> 
> Without this change, the new setting will not be taken into account
> until the gc thread is woken up by e.g. a write.
> 
> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: 845abeb1f06a8a ("xfs: add tunable threshold parameter for triggering zone GC")
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
> 
> v2:
> - Added a new helper to wake up the gc thread in stead of unparking it,
>   which is required to make this work properly.
> - Added protection against races with unmounts as sysfs gets torn down
>   after the zone info struct is freed. This also avoids unneded
>   wakeups during remount.

Isn't that a deadlock vector?

i.e. unmount takes s_umount, concurrently userspace writes a new
value to sysfs file. sysfs file write blocks on s_umount, unmount
blocks holding s_umount waiting for sysfs file reference count to go
to zero to destroy it?

-Dave.
-- 
Dave Chinner
dgc@kernel.org

