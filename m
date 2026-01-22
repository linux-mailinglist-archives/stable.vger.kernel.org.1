Return-Path: <stable+bounces-211242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMa8LN0ycmmadwAAu9opvQ
	(envelope-from <stable+bounces-211242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:23:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB167E0E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B93704E8CC8
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307F2E6CB8;
	Thu, 22 Jan 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJmedX27"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086AE23EAA0
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090493; cv=none; b=DGu3nfTdKY035GLVO04OX3BJnnQvKg5huW3jQ234Vd8gorQz1NuDYjUyQ+NZpBdaOOKYl4w6zrEQo6oFpy97CrNShD+0L0NHWMW43OqnHaIuXFn09f3/f3VRnoC5tcaU5d+jHTuEMFsZEtf+wRrnnlbsWSSBLyuOc0dw9FQJeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090493; c=relaxed/simple;
	bh=GsezXbcW7vkXRaC8b0n/WwsZg1VPE2PKyPrbCMKn6i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYLZyOzTKwRO/jGvQPa4vVtopyPoqCFm1iL6LtsSEiHFWfOUbaBqLGJLYFONpGb/H0iIBlL6ibaBo2ErfIfdHqxqY79hWAh2zMO8jYpzOidU974bQRlRSJNaVdggJ03i8vCam+kPn++5AqaHCpQFcW7S2Qf5bsOP0cTHMfDpGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJmedX27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4181AC116C6;
	Thu, 22 Jan 2026 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769090492;
	bh=GsezXbcW7vkXRaC8b0n/WwsZg1VPE2PKyPrbCMKn6i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJmedX270iHFatD0HZwetq/j5hxx7az0eiMNe1V8/s1p4FyExL9GSOr1DHMok3i5q
	 QqaLjfQtGuObLyeADyA6jixVS0ECqd43KXLHUc5nVYR92aGB43McuixL0VHam1xs+s
	 4lxV8LX8knh5KM/feIv5lAxEBXK46lsm+Sjv1u+M=
Date: Thu, 22 Jan 2026 15:01:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6 1/1] bridge: mcast: Fix use-after-free during router
 port configuration
Message-ID: <2026012240-prowling-kindle-fd7d@gregkh>
References: <20260119121726.1376464-1-lee@kernel.org>
 <20260122110337.GA3831112@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122110337.GA3831112@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211242-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,7bfa4b72c6a5da128d32];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 52BB167E0E
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:03:37AM +0000, Lee Jones wrote:
> Intentional top-post - quoting everything!
> 
> I see that the v6.12 version was applied and is now queued, however this
> one still remains.  Was that intentional or was this missed?

Intentional, I only caught up on 6.12.y and 6.18.y trees at the moment.
Older ones are still in my queue to process, this patch being one of
those not gotten to yet.

thanks,

greg k-h

