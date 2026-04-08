Return-Path: <stable+bounces-235277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJGOLa+w1mlWHQgAu9opvQ
	(envelope-from <stable+bounces-235277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:46:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3E3C360F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F98A307411A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D89C374E5B;
	Wed,  8 Apr 2026 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svifh28n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337B37F8A2;
	Wed,  8 Apr 2026 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677482; cv=none; b=RhuX42v2bQDNJD7U+8DpF4vd8/5EHhIGbfYxv6SgB3gvfNnqCTd8K+DBT6TDcK7XP0nyDF2MHfTQTWOHB456QPP2HmY9gGWkomUPSKMS7FzvgXnBqAc6HsNvQpKtglvAGU0uzJ82tBWkU8yz8EB1B2idWPVbvLUVgqd+ofuamOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677482; c=relaxed/simple;
	bh=JUpYxGyPQlp1KuwkrQ6xDUZhhBN+S9yq6i/Oyj1j8Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjM0lZHZNML4wSR8XPTHkErM2NbmzcQ0H7RoFSxesrvQ2lMGycKDmsdWu9LAAhRXdxByZWs7I0mYxgKHGoLM0OgUUN1+nqc8qiMsvk4N714WWLI2/viRHT3MbVpCmR7RxhXFbsz7i/rud4oLc1kIjwHazr7N7NJna8mv2yxM7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svifh28n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A1C19421;
	Wed,  8 Apr 2026 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775677481;
	bh=JUpYxGyPQlp1KuwkrQ6xDUZhhBN+S9yq6i/Oyj1j8Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svifh28n3dFWyH9j6BCiTGtC16JR6vEZz0+zCIKy98bPVfQMagqzgaz7JMi5aqGP7
	 u1lodhiu0T4ESe9NuP5uPLyrKILloLrrINEIEL3U5RpQhSX3oHGGOw1jDjWWJgXR4v
	 +Tc7+aMpZ6Qgo3Jz5VV28mmgYFihB1badrx4f0PI=
Date: Wed, 8 Apr 2026 21:44:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Tugrul Kukul <tugrul.kukul@est.tech>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Pavel Machek (CIP)" <pavel@denx.de>, Ron Economos <re@w6rz.net>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Alex Williamson <alex@shazbot.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 111/160] vfio: Create vfio_fs_type with inode per
 device
Message-ID: <2026040839-around-uplifting-b023@gregkh>
References: <20260408175913.177092714@linuxfoundation.org>
 <20260408175917.326372651@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408175917.326372651@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235277-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,intel.com,redhat.com,google.com,est.tech,broadcom.com,denx.de,w6rz.net,fedoraproject.org,kernel.org,microchip.com,linuxfoundation.org,googlemail.com,shazbot.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1CD3E3C360F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:03:18PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Alex Williamson <alex.williamson@redhat.com>
> 
> commit b7c5e64fecfa88764791679cca4786ac65de739e upstream.
> 
> By linking all the device fds we provide to userspace to an
> address space through a new pseudo fs, we can use tools like
> unmap_mapping_range() to zap all vmas associated with a device.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Link: https://lore.kernel.org/r/20240530045236.1005864-2-alex.williamson@redhat.com
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> Signed-off-by: Tugrul Kukul <tugrul.kukul@est.tech>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Pavel Machek (CIP) <pavel@denx.de>
> Tested-by: Ron Economos <re@w6rz.net>
> Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
> Tested-by: Mark Brown <broonie@kernel.org>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> Tested-by: Peter Schneider <pschneider1968@googlemail.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Acked-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sasha, something went odd with your scripts to pull all of these names
in as "tested-by", right?  The original commit did not say that :(

thanks,

greg k-h

