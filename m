Return-Path: <stable+bounces-230690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFB/IvO1xmnoNwUAu9opvQ
	(envelope-from <stable+bounces-230690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:53:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C6347DFC
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D52E3114DE5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E735DA70;
	Fri, 27 Mar 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="S8rahmQO"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070F35836D;
	Fri, 27 Mar 2026 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630017; cv=none; b=moc8M5RqeOZ+QdB9st83NW5kdkew+36pgshf9mqczQ8/PkIF2kMfCX7vJNcj5JIxXx8l5CQBQLqqk606qxgpu9rdCCT8VeXK8c7h8TQX15AExdnif1G0gq0NW85hobKmaqxUYiUqQrjwMpjytTobWlSwyTXWZN3xB5DA6VOOLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630017; c=relaxed/simple;
	bh=wohXqDGk7Z1RD9kbBN7gbSivjh2qLtElRyl+H0MeHmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJESY4NjU/HGgYGSau1KSOvvludCuLytvK6PkHXzphtPhyTtGZggC24JylRPu5IR0MY2iJzAk5XQ0F/Gq6p9YwLl+0MihwZxZVbwEhS3vnmPVlme8jPKRJq816OPH/vTOUZQztcnmuZfa7ohr/ThzMVKb5zYwk7PJ0ydG/XyyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=S8rahmQO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6+p84I+dufFeYRWkA87WTcUlR5WvMECiOcTYPoz6Vok=; b=S8rahmQOPhsOv3sO8XmJDWyp+P
	9t8X0uhKof+StRHr5MPnsTjcAp8xI7eKDS/25uANc9rVpZi25FjghxCu4h6/1nWHFn56XDW4US7dM
	8lwpDVP3YS6Ykmy+3ts4nNu35hqLE4e7y6ZUIjz+0fgxJRhJz/hzb82zGmWdOoViztCE5kqXbVtHm
	tu4xRBhCQNyGRRq58t89GN6i5HiS5Sy4fu/cZ/vxYbAAtWvoMv+G2B2Cyx1BDuUOD5oggJuxkVQoP
	8edu9Ox1KuNbaYQb4Xj/2GsylNbLynvvnb5OZwcOrWNeWb0hVcDEyUBI8WeXIiVjAnIRijBhD0d6V
	FBbFLXvw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w6AKa-00AlXB-90; Fri, 27 Mar 2026 16:46:44 +0000
Date: Fri, 27 Mar 2026 09:46:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] xfrm: clear trailing padding in build_polexpire()
Message-ID: <aca0YEL_PC3GFySl@gmail.com>
References: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-230690-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A2C6347DFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 02:58:00PM +0900, Yasuaki Torimaru wrote:
> build_expire() clears the trailing padding bytes of struct
> xfrm_user_expire after setting the hard field via memset_after(),
> but the analogous function build_polexpire() does not do this for
> struct xfrm_user_polexpire.
> 
> The padding bytes after the __u8 hard field are left
> uninitialized from the heap allocation, and are then sent to
> userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
> leaking kernel heap memory contents.
> 
> Add the missing memset_after() call, matching build_expire().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

