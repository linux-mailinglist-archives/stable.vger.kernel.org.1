Return-Path: <stable+bounces-227969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OtPHVg6wWn2RgQAu9opvQ
	(envelope-from <stable+bounces-227969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:04:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7002F2735
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A23F8300915F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9843A5E73;
	Mon, 23 Mar 2026 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iM4fdvAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455929D267;
	Mon, 23 Mar 2026 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270547; cv=none; b=AP4oErmFXcmE0JXX38oMLMfkv0b7KLyPR1/JWv0DUlG4PvRIDD6j/iVAOblJrUrKQQCSSEsztFrJI9Gm9+Yqn+4oRpuySmxA9kKgbHw5AwJkBA7xL0DZP1GlGIaXwRS4reoux02rzGt2IIBFIQLVopb4jrJS+CZwXDlJrPovkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270547; c=relaxed/simple;
	bh=OPhA88FwPh6dtZLebEoFuPHAidhw++qsmKJLSay4JYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgYk8V5L44cQjmKtG7HSvfYPjZSJypY2+1zO5qpc8al4+mNx6i/Rv2ie9QnjNlsf17FCR6rCeHf/HGW6WEJliPNRpSZ+KFFen9mwNzXKkSfeVhPECEBEq/g1GIO5MFnhreJmp9rlx88QCkV+wTsK8Moy6wdU7szqSvyqkwFMArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iM4fdvAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249BCC4CEF7;
	Mon, 23 Mar 2026 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774270546;
	bh=OPhA88FwPh6dtZLebEoFuPHAidhw++qsmKJLSay4JYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iM4fdvAkkDG2Z5chFrX1tk0HQ5auE+wNWf+ooouKambOo+/mvKsNSUOa/S4MLlAL9
	 QQ1luGp8dJsC8n+4xxSgHx/+t5Fwc24b61nXbIi9cqh434aSPjmXIyeJg8MqZBOcIx
	 7CyQ5gXr0z93DN8BJ1PDXPoCHT7pXcroskOmhQGw=
Date: Mon, 23 Mar 2026 13:55:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: stable@vger.kernel.org, franz.schnyder@toradex.com,
	stable-commits@vger.kernel.org
Subject: Re: Patch "drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is
 not used" has been added to the 6.1-stable tree
Message-ID: <2026032302-unfocused-kisser-9efe@gregkh>
References: <2026031716-vanquish-boots-d9b3@gregkh>
 <CAD=FV=VuMD3K8k_jM3S6du9x8F0rzJ=fdPRFTiOSDEkN+uPWKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VuMD3K8k_jM3S6du9x8F0rzJ=fdPRFTiOSDEkN+uPWKA@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227969-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[toradex.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C7002F2735
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 08:04:13AM -0700, Doug Anderson wrote:
> Hi Greg,
> 
> On Tue, Mar 17, 2026 at 4:54 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used
> >
> > to the 6.1-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      drm-bridge-ti-sn65dsi86-enable-hpd-polling-if-irq-is-not-used.patch
> > and it can be found in the queue-6.1 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> >
> > From 0b87d51690dd5131cbe9fbd23746b037aab89815 Mon Sep 17 00:00:00 2001
> > From: Franz Schnyder <franz.schnyder@toradex.com>
> > Date: Fri, 6 Feb 2026 13:37:36 +0100
> > Subject: drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used
> >
> > From: Franz Schnyder <franz.schnyder@toradex.com>
> >
> > commit 0b87d51690dd5131cbe9fbd23746b037aab89815 upstream.
> >
> > Fallback to polling to detect hotplug events on systems without
> > interrupts.
> >
> > On systems where the interrupt line of the bridge is not connected,
> > the bridge cannot notify hotplug events. Only add the
> > DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> > otherwise remain in polling mode.
> >
> > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type")
> > Cc: stable@vger.kernel.org # 6.16: 9133bc3f0564: drm/bridge: ti-sn65dsi86: Add
> 
> Yes it belongs in the stable tree, but it has a depedency. We need
> commit 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add support for
> DisplayPort mode with HPD") _before_ ${SUBJECT} patch in order for
> thing to work properly.

that commit is also there too, so all should be good.

> 
> I thought I got the syntax right, but maybe I didn't?

You did!

thanks,

greg k-h

