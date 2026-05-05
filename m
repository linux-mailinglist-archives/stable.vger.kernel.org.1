Return-Path: <stable+bounces-244132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8mdKDvbl+Wl1FAMAu9opvQ
	(envelope-from <stable+bounces-244132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:43:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB594CDC83
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E40430CCF7B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6684B43CEDE;
	Tue,  5 May 2026 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FOmUElxC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A34438FF3;
	Tue,  5 May 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984537; cv=none; b=CIsO5n8sJ6LlNis9sFpEhkcLJYa0d4WFpBs1pkXXDACaXR8p2p13yIPalKWkCh15vDEn9xTBmprVzPeUPqB/tRfz9Ac8/JdXHHMaYNcUvt0MXS5zidCoRrO77M6fAqifOnYZg4cjKoZ9JIlXZTQjYfttTIZNJy5gF22ahRo7OLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984537; c=relaxed/simple;
	bh=e0zSPkYDRDbdxTlWqJrToeMt/VilyRq2zQd9CNuk2A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiMFISnazbXuyA8zYGRNY9j3/n9EvOQIUukv0ZOd390oYoieKvQgqLzUxyePPOpLml8eufKuIXsO3kWIpzgKxMEmEHJgAbe+L4NMSBQ1L9h0lksoAhs7KEaug9LNm42kEGX1Lx4yKhJfWbFaO//DgL8p+Jqk/pJtpeB/K1rR/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FOmUElxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F49C2BCB4;
	Tue,  5 May 2026 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777984536;
	bh=e0zSPkYDRDbdxTlWqJrToeMt/VilyRq2zQd9CNuk2A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOmUElxCpSH5OGcfIZRZ0D5KlkuM67xDfxlPq4DBgHqxeI2yxSALAFbPdfSxdgLUP
	 LvqcV36vC7JvxFf2H7xiAs1xKZ+ek2pbJUG3hw2oaSVX0/PZZVnhd32l6hA+nFMfCr
	 bcTUJ+fEkgvNOL4aOUdH1tBpotrHRLqzpw+YG4k0=
Date: Tue, 5 May 2026 14:35:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunseong Kim <yunseong.kim@est.tech>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	David =?iso-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>,
	Roland =?iso-8859-1?Q?Kov=E1cs?= <roland.kovacs@est.tech>,
	"ysk@kzalloc.com" <ysk@kzalloc.com>,
	"42.4.sejin@gmail.com" <42.4.sejin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Message-ID: <2026050517-parking-pyromania-70a1@gregkh>
References: <20260426201205.465809-1-yunseong.kim@est.tech>
 <2026050435-glider-undrafted-71d7@gregkh>
 <59f615b6-eea4-4186-8e63-d60a57ed7822@est.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59f615b6-eea4-4186-8e63-d60a57ed7822@est.tech>
X-Rspamd-Queue-Id: AFB594CDC83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244132-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 12:30:48PM +0000, Yunseong Kim wrote:
> Hi Greg,
> 
> On 5/4/26 14:05, Greg KH wrote:
> > On Sun, Apr 26, 2026 at 10:12:05PM +0200, Yunseong Kim wrote:
> >> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I did NOT write this commit.
> > 
> >> [ Upstream commit e9acda5 ]
> > 
> > Please use the full commit id.  And get the authorship right :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Thank you for the code review. I’ll fix it and send a v2.
> 
> Additionally, last week I submitted a few patches to the checkpatch.pl
> script—currently, all backport tags(following stable kernel rules
> Option 3) using <sha1 40 length> pattern are triggering false positives:
> 
>   https://lore.kernel.org/lkml/20260505112320.362715-2-yunseong.kim@est.tech/

Checkpatch should not be needed to be run on stable kernel backports, so
I don't really think that is necessary.

thanks,

greg k-h

