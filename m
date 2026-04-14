Return-Path: <stable+bounces-237924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIsKHCdr3mm5EAAAu9opvQ
	(envelope-from <stable+bounces-237924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:28:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB15F3FC92C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC4DD301FF98
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123D3ED12F;
	Tue, 14 Apr 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtwTsJZm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925312FF160;
	Tue, 14 Apr 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183855; cv=none; b=CinGQ3BrLGohVtd/z/zgBeqfLCBDAOKqoPqAmOF9qTCvAIPCHNnc6/QhGB0zcy687WKhqTbhTSrWKERhYA9M/NB2uYgAfVUYaUEe+QnYrN0Jb2X43U3Sq51jPnSAduJTNR/LhbkjOUEofwQRIUpbzvbiZcmi1Bc0enXWirzDrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183855; c=relaxed/simple;
	bh=BhJVhuq1ERNvkwltfV/6VfoiFUTjHYKa2RPCsP6TyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFmn+9JNGvg1QEeJ4PQdL4ZFpdnc44jx2Vp28wpV1fnZOxXyJ2oqv4sJc1V4aTpMz4jdKFPtyNL2Chllhaob/V87xa36m2eh9ss7jwN0nHe9K/GwILn9DVlO5ZzjQMDOpXWmhlfZpZZCYme1+bcckgJB6N0qcY1JkQPm++QrSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtwTsJZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FA6C19425;
	Tue, 14 Apr 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776183855;
	bh=BhJVhuq1ERNvkwltfV/6VfoiFUTjHYKa2RPCsP6TyKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtwTsJZmECnOMmXzz1pu14fmjGS7jo/i0TcGo7BN1SS+z8O+wmio03nMm6Vfhe5xN
	 hw9wHMkHEL05J/TsCN1M2o0XZ+aQaFLge/BQDIuK9u+/9QChD91xd3mC3q9nnUsZgs
	 PWQtG7S7c5w26Ub+z30E0QFHohH+d/Fcy1GbwYcrAOHBi53SxaFG7wlm9BGvhlqjC8
	 0s5Exvwz38hkvIaaR6MY144CXFfyCX6Jtb2Y9XjOpBLfHO6/iFc5Q+DayfRgqKvGap
	 3etuWiIhhKbff5hdSv6RbwTG3FDlBCN1yWQijJnQ+CYe1ZDnafydhCbXWqPzJBZ0zE
	 6L3YMmCVYqRUQ==
Date: Tue, 14 Apr 2026 17:24:09 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	stable@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
Message-ID: <ad5qKZjhfAnnpmNV@aspen.lan>
References: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237924-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,gmx.de,matfyz.cz,lists.freedesktop.org,vger.kernel.org,lists.sr.ht,dujemihanovic.xyz];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielt@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aspen.lan:mid,dujemihanovic.xyz:email]
X-Rspamd-Queue-Id: CB15F3FC92C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 09:42:16PM +0100, Duje Mihanović wrote:
> From: Duje Mihanović <duje@dujemihanovic.xyz>
>
> Boards using this backlight chip do not power the backlight off on
> suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
> the backlight core on suspend.
>
> Tested on samsung,coreprimevelte.
>
> Cc: stable@vger.kernel.org # v6.19
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

