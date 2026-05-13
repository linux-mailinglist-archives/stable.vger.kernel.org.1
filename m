Return-Path: <stable+bounces-246759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC45FSMbBGpxEAIAu9opvQ
	(envelope-from <stable+bounces-246759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:33:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E52DF52E1CF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23930304698C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355C3D4116;
	Wed, 13 May 2026 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn8terCI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984F2BEC55;
	Wed, 13 May 2026 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653980; cv=none; b=bB/SwhWNzU+sYkeyfH/EpqUwWRuUwlxPQqmkqFSEUTcuFZ+QYfM4elniL3affB3iNIquciwWKy1hlL6ICuIy+mw3EYfNSVLQZ3IUzPnEjbI+eFi7XtrfU2PYym1q41JdXrx2el6Amkrem544cPsmKHBUQ2OcKrg1YmZeACEQh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653980; c=relaxed/simple;
	bh=07Qgn89ErG2GzIr75mP7BvjV3SrEQGTuF7ev2g8smFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8cF+sfJ8YTdVJ+ox3R4mEut79pUNno7oQ/2ZR7Nri7pKOIpY32mKYj5D9B1Lbv5SI0Vc+qOEEEOTjcKeO+RseQco5sW6dbQej2vzixmdr4dze+QhqZfZQk9aNQWvp/KVw34Yc0IRStzyS/IPKJDzWUsQorv5/pne77T2TupWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn8terCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786B5C2BCC6;
	Wed, 13 May 2026 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778653980;
	bh=07Qgn89ErG2GzIr75mP7BvjV3SrEQGTuF7ev2g8smFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn8terCIqY55wZVBpkXI91LQF27aL7N/uwWBlTyz/NokVHO3JT56UjBqVZ3PUbVAC
	 ijUW4wCD2LIgFiYk7+4fJxX+KU7RyiRT5BcTAnGDxbCs9Xp7j1Ko67a6qDqlPpGrEB
	 Hg2CsWqy9iBC0F1LGkHJl/Z+PdzZOsy9jchaMzhmQ4pqGlh32RsZIWM7o/NA+V9nhX
	 TvBEUdGS+qBFSzpelDPhuvUj+EPSLTfs9P2q7U6cbLuL2MWWSCv9KZI/Kwr8tlYNC3
	 3yuSjWcGxk9odveEQk1mHvA2qyxetzJhmtdTZl78TzyEmBbsCEp8q6iUJZGLVRRYfH
	 2Xd+kHZnu94BQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wN39N-00000004H1o-355Z;
	Wed, 13 May 2026 08:32:57 +0200
Date: Wed, 13 May 2026 08:32:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH v2] power: supply: max17042: fix OF node reference
 imbalance
Message-ID: <agQbGQTlkIFz0GbM@hovoldconsulting.com>
References: <20260407123338.2677375-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407123338.2677375-1-johan@kernel.org>
X-Rspamd-Queue-Id: E52DF52E1CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,puri.sm,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246759-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Action: no action

Hi Sebastian,

On Tue, Apr 07, 2026 at 02:33:38PM +0200, Johan Hovold wrote:
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
> 
> Fix this by using the intended helper for reusing OF nodes.
> 
> Fixes: 0cd4f1f77ad4 ("power: supply: max17042: add platform driver variant")
> Cc: stable@vger.kernel.org	# 6.14
> Cc: Dzmitry Sankouski <dsankouski@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Changes in v2:
>  - add missing driver name to patch summary prefix

Can this one be picked up now?

Johan

