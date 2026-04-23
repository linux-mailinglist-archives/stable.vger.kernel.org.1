Return-Path: <stable+bounces-240478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FwFI+wN6mn4sgIAu9opvQ
	(envelope-from <stable+bounces-240478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:17:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA49451DC9
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C4C53004C8E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7A378830;
	Thu, 23 Apr 2026 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DqC1MAhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24837E2F7;
	Thu, 23 Apr 2026 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946603; cv=none; b=rRkNGqscNpXPEtI0bmF9UruBtwpkbf0p0pZYFU72Gt5Xdoq3EmKtZnccLkX8PUL67+fFPZYkalCufl57aDAxtsz7MEOzWV+CmXu24tzNPH2eFZc/NcFG1s2445lSw24u//e7lRkf+YjLj389SG7sOAQjnc/kl0Spvn3w+6SjVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946603; c=relaxed/simple;
	bh=VYLCBxErCbQC+lUCOmPiUpycnDrb9vqsBUk/aL2ZFN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1PiX/K5Ul+UUOzjjH4bL/wGkGUdlNKjdl3lKR1c/dhJuBIRG3lNCoWoIpw96mpWfeF8h8QrYpzgCSgdteL/fzyzN0rNsiqECPSkzvx8zoY3WgmXuxgCEGXDlSXSYqRoRKS36I8pK/vmyf0FiG+s+79iTrF6USUnva4w3uWcM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DqC1MAhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC584C2BCB4;
	Thu, 23 Apr 2026 12:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776946603;
	bh=VYLCBxErCbQC+lUCOmPiUpycnDrb9vqsBUk/aL2ZFN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqC1MAhBl4OTOcEUfpbyy0YP53RtGsgl2gaUiX1gyu26Sb96F2rFCwhGQ+smXIbfW
	 NFzs2gK6b8n1nuyBXSdr8KhHX1+1DCNRvo6YUm2Nsiq2wq2KJizV2v9tZgeFkVXHIc
	 g4nISTVXtCIhBBXV1k2w1pm9M51vf90IjKGIYWsY=
Date: Thu, 23 Apr 2026 14:16:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>,
	patches@lists.linux.dev, stable <stable@kernel.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 189/491] usb: roles: get usb role switch from parent
 only for usb-b-connector
Message-ID: <2026042322-railroad-wrongly-365d@gregkh>
References: <20260413155819.042779211@linuxfoundation.org>
 <20260413155826.144013004@linuxfoundation.org>
 <3868fd19d247624c3fc394d4db227234af9f7ab5.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3868fd19d247624c3fc394d4db227234af9f7ab5.camel@decadent.org.uk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240478-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EA49451DC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:55:42PM +0200, Ben Hutchings wrote:
> On Mon, 2026-04-13 at 17:57 +0200, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Xu Yang <xu.yang_2@nxp.com>
> > 
> > [ Upstream commit 8345b1539faa49fcf9c9439c3cbd97dac6eca171 ]
> > 
> > usb_role_switch_is_parent() was walking up to the parent node and checking
> > for the "usb-role-switch" property regardless of the type of the passed
> > fwnode. This could cause unrelated device nodes to be probed as potential
> > role switch parent, leading to spurious matches and "-EPROBE_DEFER" being
> > returned infinitely.
> > 
> > Till now only Type-B connector node will have a parent node which may
> > present "usb-role-switch" property and register the role switch device.
> > For Type-C connector node, its parent node will always be a Type-C chip
> > device which will never register the role switch device. However, it may
> > still present a non-boolean "usb-role-switch = <&usb_controller>" property
> > for historical compatibility.
> > 
> > So restrict the helper to only operate on Type-B connector when attempting
> > to get the role switch from parent node.
> 
> Is this safe to backport?  It seems like very few device trees on older
> branches have the compatible string that will now be required.

I think it is, as it fixes a bug for those systems that did not properly
enable it.

thanks,

greg k-h

