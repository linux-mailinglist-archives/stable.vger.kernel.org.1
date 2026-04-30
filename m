Return-Path: <stable+bounces-242170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJjJBvmK82md4wEAu9opvQ
	(envelope-from <stable+bounces-242170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:01:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE874A6279
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6AB8300A672
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9346AF0F;
	Thu, 30 Apr 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oEqQXJYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0D2DEA61;
	Thu, 30 Apr 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568069; cv=none; b=uolsS/5N7t9lbTr26Kfe+uYeGdJSq5ywsssaM1pSSxjEEn42z1i2Ca0XoraCvPFiQC0CJw3O22Y5ZLa3s5gtxcC68Yvd5ho3JcHiVP57/EStn0zSHrCuhQE8aeKy6DlcABy/7oBvh2R4Visn8ZTTmlPpTQC4we9Y/aRAf/vlS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568069; c=relaxed/simple;
	bh=kL1s/oOPrvI+U0yMcAdhPsvUAzlIXr058tup6YODNuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE+86j8LKEV4OFwBS85dF08oLtp4xyMEJUnSKmLVT6ZdZDtUNy9Ari5IFNgizl6jJzVHof9CpW9mvA6lniWYcVtdF3kNw2aUcunPTo/RWxGkCwVVYF3yYWEFGrVmV2pW3TMKm9Chpp2J29hk51unUzQcYkX4+StgeMNoQe1PJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oEqQXJYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C736C2BCB3;
	Thu, 30 Apr 2026 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777568068;
	bh=kL1s/oOPrvI+U0yMcAdhPsvUAzlIXr058tup6YODNuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEqQXJYkOshCiOStItTTG0IJzuoiDCFSBYX9v8My6c27TuLs6XczYnbT7QIu5hR+x
	 Eq8quhnemUcSx6ORwfqDlucasyE3NIjMGYnsw94YD30OGst67rxwc6GdogxFkUyYKz
	 dkGaoM2dHfhDd4YC4Weg7978umMLUmuawt0a+Sv4=
Date: Thu, 30 Apr 2026 18:54:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
Subject: Re: [PATCH] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Message-ID: <2026043015-dayroom-engraver-3176@gregkh>
References: <20260430152658.60745-1-95986478+SnailSploit@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430152658.60745-1-95986478+SnailSploit@users.noreply.github.com>
X-Rspamd-Queue-Id: 5AE874A6279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242170-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,SnailSploit];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 06:26:58PM +0300, SnailSploit | Kai Aizen wrote:
> From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

Again, a valid email address please.

thanks,

greg k-h

