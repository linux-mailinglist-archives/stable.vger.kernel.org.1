Return-Path: <stable+bounces-236086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MeKN+rw3GnZYQkAu9opvQ
	(envelope-from <stable+bounces-236086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:34:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052B3EC99D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49036301FC8E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D713CC9F6;
	Mon, 13 Apr 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IHDTvyRD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C531B838;
	Mon, 13 Apr 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087202; cv=none; b=RXuRrlc7neYNq/spJkTQEa9VMWa4YceCa37+RzWkKTTLQEB0fRhQtcP/QjxqJ/vg/e3uNAc1rLuWnE0SlZhgJ95aUJ0HNDD2diw6PbVHDp/f3bOUxw1HcoM8ODXEZyiw2ygvDqOi5a6I7YGryOoBwXQMhgc8yN5lF9IDGJSR7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087202; c=relaxed/simple;
	bh=RGoZ0kAv/HIA5tdh+NMoNMfUmNT/RqGCY7/2guxi8Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtb8qKK402FH++Qnn1yBsq830ILOdFWkFUzwUCbHy20gXcrji8vSiBzVscS5Ne89qIWYsa8hn5z5GD5j8z6EsqXFD96Jgw0nFUrTqOKoA4+NRbRIwm3tQVZm1UzVY24jPRURIjEXyzMvEbG8leJYT2GH2b50120bHgyaOdjaDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IHDTvyRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7C8C2BCB1;
	Mon, 13 Apr 2026 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776087202;
	bh=RGoZ0kAv/HIA5tdh+NMoNMfUmNT/RqGCY7/2guxi8Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHDTvyRDE3WSwBk1xO9U6TZmQvfdJH63ZqQRXS5xECfan33vXrUVzEHG90u2kV7Fn
	 UylDAJIxPnJdQlMf+2JKWCEhBBy39FUZ9K0avT2ls5CZm3Ud4F/olNHgxFeOYUSWUW
	 4stFN1G0CrnrpDYN+hrfNNUQcQLaD/E1a+LnwX3c=
Date: Mon, 13 Apr 2026 14:55:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	Friend <netdev@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
Message-ID: <2026041330-groggy-ruse-5e27@gregkh>
References: <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <2026040331-evasion-walk-f572@gregkh>
 <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <2026040349-chowtime-freeload-5ca4@gregkh>
 <DM3PPF63A6024A9E931C940F849C60FAF9EA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <58f6e74d-480e-4e0c-aa66-68dfc1de7421@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f6e74d-480e-4e0c-aa66-68dfc1de7421@leemhuis.info>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-236086-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6052B3EC99D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 01:58:56PM +0200, Thorsten Leemhuis wrote:
> On 4/3/26 15:00, Korenblit, Miriam Rachel wrote:
> >> From: Greg KH <gregkh@linuxfoundation.org>
> >> On Fri, Apr 03, 2026 at 12:44:48PM +0000, Korenblit, Miriam Rachel wrote:
> >>>> -----Original Message-----
> >>>> From: Greg KH <gregkh@linuxfoundation.org>
> >>>> On Fri, Apr 03, 2026 at 11:08:46AM +0000, He, Guocai (CN) wrote:
> >>>>> No, The mainline have no this issue.
> >>>>> The changes of 0c4f1c02d27a880b is not in mainline.
> >>>>
> >>>> That does not make sense, that commit is really commit e1696c8bd005
> >>>> ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") which is in
> >>>> all of the following releases:
> >>>> 	5.10.252 5.15.202 6.1.165 6.6.128 6.12.75 6.18.14 6.19.4 7.0-rc1
> >>>> confused,
> >>> The change is indeed in mainline, but the locking situation in
> >>> mainline is totally different (that mutex does not even exist there)
> >>> Therefore, the issue is not supposed to happen in mainline.
> >>
> >> Ok, does that commit now need to be reverted from some of the stable branches?
> >> If so, which ones?
> > 
> > From every version which is < 6.7.
> 
> Greg, do you still have this in your todo mail queue somewhere? Just
> wondering, as last weeks 6.6.y released afics lacked a revert of
> e1696c8bd0056b ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") --
> and I cannot spot one in your public stable queue either.
> 
> These are the commits that according to Miri need to be reverted if I
> understood things right:
> 
> v6.6.128 (4d7a05da767e5c), v6.1.165 (0c4f1c02d27a88), v5.15.202
> (31344ffecd7a34), v5.10.252 (d91240f24e831d)

It is, yes, my queue is huge :(

It's fastest if someone sends me the reverts and I can easily apply them
that way.  Otherwise it takes me a bit to do each one manually :(

thanks,

greg k-h

