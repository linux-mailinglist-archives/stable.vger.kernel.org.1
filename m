Return-Path: <stable+bounces-211852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FzrD5bgeGkGtwEAu9opvQ
	(envelope-from <stable+bounces-211852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:58:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B52D197403
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F15F300D44E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD935D617;
	Tue, 27 Jan 2026 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY51Gr6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CF1E8836;
	Tue, 27 Jan 2026 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529382; cv=none; b=L6ISEleMZKOtovmSwBmAfJPDded8Rpb1Knq7ORz8F3RGPK1/21QfctwiM0IPmWT4O7vAuY0p7tdCjOx5nVVqwzV4L2Xn+9a0OnxQFyhpCuAl59VRh7YtLas6pgxe9V4/5XiisnyyCyaz1Hwtb9aDzastcM92wlzIfBsoNd0GKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529382; c=relaxed/simple;
	bh=Vsw2KdcG+jNPcOze8yBFFd5tT4lfuIXClv+3kx4q/4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUVkyN/hDnhMXIuK3kE6lT30B1FfI7oHH4M1Uq9zW3AyxMIifQMYNTN0df3WpvmqOJNLEMyAs5j6SJnJFvEeDTK+oaoDcU/J1k5jNqoz4oo47H+HDPrerpuRXQwtO9/bX/mKI1Xq5RlShbVjSIDymLIL+QNFWJ9ArJhzPIWv+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY51Gr6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5692AC116C6;
	Tue, 27 Jan 2026 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769529382;
	bh=Vsw2KdcG+jNPcOze8yBFFd5tT4lfuIXClv+3kx4q/4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GY51Gr6xwzl+MCnjwtkYPCbv4Q/Hr4Yj0JTyrZM7GC4+TqE9QsOGCIAwicyhzjnqz
	 xpemhWx7FW+AizUhiWt6j+VFaUM8SUpS5AK4Hy1MKPMuMlmf8HkLGs9zR1Mj8EPK8G
	 0rgtWDmbuucINvO5BZ58+jquuE8nAYsEcJacXLFCMPT15fmEwimBmWHgAfcTpcPqIV
	 YZt+ALPuB/sEcyX36vGGHA+qgLE01VH5C94uQdGdNIwQ1QkeiU3lyZOqfPE58fX3mr
	 UxEiPJGxgk7xOasfSeJFL5cdVdZ2YzcINhKySNVN+IseoSS8FvyJYlmUyRHy0hfwEy
	 lERF5klFLQrZA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vklQN-00000000719-0EV5;
	Tue, 27 Jan 2026 16:56:15 +0100
Date: Tue, 27 Jan 2026 16:56:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] mux: mmio: fix regmap leak on probe failure
Message-ID: <aXjgH6RCFq8y97-3@hovoldconsulting.com>
References: <20251127134702.1915-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127134702.1915-1-johan@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211852-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: B52D197403
X-Rspamd-Action: no action

On Thu, Nov 27, 2025 at 02:47:02PM +0100, Johan Hovold wrote:
> The mmio regmap that may be allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 6.20?

Johan

