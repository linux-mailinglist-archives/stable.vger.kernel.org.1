Return-Path: <stable+bounces-227500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDN/BCYQvWlf6QIAu9opvQ
	(envelope-from <stable+bounces-227500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:15:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B82D7D6B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40F5C301A716
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAE72623;
	Fri, 20 Mar 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iE9u4sfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA6207DF7
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998104; cv=none; b=rdkkoayMGJxhQ/bAyDUFXuIji4sNySQYyDlCCqLbIRj4zHYYhegIbRWyWo0SdWHkEUpSQJKBHa0a6PBVhcYQdfL3bi7Mc0D+0D5NgrVyKxdI7KnmiEfWC9ui3QENu73Mxsb1c38IHUDVreiLKFECilvQvqJFKiYg+jgRTKF31VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998104; c=relaxed/simple;
	bh=B+8/e4Ol1pbk99oKV+CMFBHj46TjrGWJAtXQvHmWIYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scyfnjoLQaRphte04AiUhGW2bAVUtfimy/El5hxSz9UP4RNAJPERKmfHKwTNBRkphb3/P6Qnyqw7hZd67Vy2FmaNz4Zr6cbIUoNkAmh1RpByYvnq+gQnoDHBpmQwRLYMD0Um6uhuR77DjCWONx8tR0GbQdSlNTupcMOOfqrHIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iE9u4sfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEBEC2BC9E;
	Fri, 20 Mar 2026 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773998104;
	bh=B+8/e4Ol1pbk99oKV+CMFBHj46TjrGWJAtXQvHmWIYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iE9u4sfOdp9erHoADAc5ndCRADeKuVuTbyViBkcpCmbSvwam5JDTo2+u6lmi6gYy9
	 zuxfVaODBeZvuxyyDBhjG28ZgF0VUMwpfth/HlDY7sT1Qzv+dSaBLdIeLAXDNRls/K
	 r6PnJaFnlXDMeCDXvk0b5QrbmgJ2zjBr018NIbRQ=
Date: Fri, 20 Mar 2026 10:15:01 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "jkosina@suse.com" <jkosina@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Message-ID: <2026032039-rosy-playmate-f405@gregkh>
References: <2026032053-reviver-stock-9da2@gregkh>
 <MAUPR01MB1154696DABA7DD9EE0D6E99D3B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MAUPR01MB1154696DABA7DD9EE0D6E99D3B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[live.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227500-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.946];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9B4B82D7D6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 09:01:27AM +0000, Aditya Garg wrote:
> The driver doesn't exist for kernels before 6.15 so it's not needed there.

Thanks for letting us know, but backports for newer kernels would be
appreciated :)

greg k-h

