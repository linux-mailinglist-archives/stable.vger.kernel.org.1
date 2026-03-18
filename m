Return-Path: <stable+bounces-227029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOAWMsSPumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:43:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 735212BAFC9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888713070DC5
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D153CD8CA;
	Wed, 18 Mar 2026 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D0EW7el+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05B63CE4B4;
	Wed, 18 Mar 2026 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833959; cv=none; b=J7ObhkxIioolxuLL2mhjSnrcLaJub5jHFC2/FHzDmDWk5bUT3keS5h3gg8rAPtjVB98yUBkYYCbReMUAMAyJZ7da02OPQ8TI5UO1nU+/G4ValTTOc8fMbflD9RLzeILv5puIPVUvdx/BZ/FOknO7kX0nMkXqptiARYCcoHjEKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833959; c=relaxed/simple;
	bh=V34B6isW0gCZivCi9M0hWAynRG/F8saYHB58i9fTKSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEuzDhFh///XaNGWtw6D/dn7SQcQ4Cc4lpAUelAZD/eYZ4szdV7Hy1iEgS5nHdi251WJ8LBJpehUMt69h3flkSThSqOHPc2LE0ZenJpuIdhPtx4HYmFgqx/ZNEEIqoL5G9n1Gd3ScB5WwOwO6PO8M2rbxCGYwkhLOH5FsBMW0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D0EW7el+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BDBC2BC9E;
	Wed, 18 Mar 2026 11:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773833958;
	bh=V34B6isW0gCZivCi9M0hWAynRG/F8saYHB58i9fTKSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0EW7el+Q9Is4m8ixpYvpiRJdL8voWmgeioPHQaa0CLTYlD8dP5bacdSma20K2QQ3
	 GVxSvbjXGkOzwoxJpw0W1IFW3fjNqel3CIl2nMoj/oklkMpAQPwU1yCE9cOKAzAf3p
	 5QRvgmfJoUFuq0FujpU5+uCO+oIGMp0m+oPEhTvw=
Date: Wed, 18 Mar 2026 11:08:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: ZhengYuan Huang <gality369@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, cm224.lee@samsung.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	r33s3n6@gmail.com, zzzccc427@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: reject non-directory inode in f2fs_get_parent() to
 prevent null-ptr-deref
Message-ID: <2026031816-numbing-unsorted-f21d@gregkh>
References: <20260318090410.3368669-1-gality369@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318090410.3368669-1-gality369@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227029-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,lists.sourceforge.net,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 735212BAFC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:04:10PM +0800, ZhengYuan Huang wrote:
> [BUG]
> When accessing a crafted f2fs filesystem via open_by_handle_at(2), a
> KASAN null-pointer dereference is triggered deep inside the fscrypt
> inline-encryption path:

Does the f2fs fsck tool catch this issue when run on the corrupted
image?

> The bug is reproducible on next-20260313 with our dynamic
> metadata fuzzing tool that corrupts f2fs metadata at runtime.

That is not a valid threat model, sorry.  If you can modify a filesystem
image while it is mounted, this is the least of your worries :)

thanks,

greg k-h

