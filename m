Return-Path: <stable+bounces-210773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJHSIYgGcWmPcQAAu9opvQ
	(envelope-from <stable+bounces-210773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:02:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E475C5A43F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3293A86CD2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904B48AE3E;
	Wed, 21 Jan 2026 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkUCO1pY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDD2FE05D
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007410; cv=none; b=cOpmMek6AuMIMFaMfSMD+NOp4rgBaIST7ow7RFe4RrEkU2KSJb5wgBC8n0crMX3jdJ2hUzszW51B6mCKkPqahZhePCAPjCq0/eEFGwhaEtskulUKls0klMxeWy+WANyqZcFdk3P1IVIj/wsH7myncMyDLGJqDmoLTzRwsZeH7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007410; c=relaxed/simple;
	bh=ubt/GC8+HJuv8fHGORPih8E/lsYgGz3Y3CUp9H4eju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL54YhczBjWKjhPR2NMw3xjhp70YMuQX8tHJchHL+O84r2WIw2E8M3oAVQIotoaq1xkGz4/RG8rrVsuMpi10uhYnoOihy8XPb21BCTvvM+FC3gQ1/Ojs8cLStluAeX/tkNDHyy/seiS8MwjrSoa/nbKCVyGI/mNU1NSwsWnyk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkUCO1pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1424C4CEF1;
	Wed, 21 Jan 2026 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769007410;
	bh=ubt/GC8+HJuv8fHGORPih8E/lsYgGz3Y3CUp9H4eju4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkUCO1pY85o6A30SjsSatz4YCcqBqtmXJ4tWeuK1rSgITNyBDRVWxOyoHuMFUxJ8r
	 vr42rrm5PwlnIbyQpxsF+Ei9HhIp6zp74+8Mqk3EdwcPyvLQ6hI+u0H3BA75Szf+ww
	 ZDV5MPkp4vbni4Fng/re4/lp2NLcLiXDeihbZJRM=
Date: Wed, 21 Jan 2026 15:56:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Zhang, Lixu" <lixu.zhang@intel.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>,
	"benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
	"Wang, Selina" <selina.wang@intel.com>
Subject: Re: [STABLE BACKPORT REQUEST] HID: intel-ish-hid: Fix resume
 blocking and compilation warning
Message-ID: <2026012139-sprain-departed-d493@gregkh>
References: <SJ0PR11MB5613A3AD2B49FC9104423D729396A@SJ0PR11MB5613.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5613A3AD2B49FC9104423D729396A@SJ0PR11MB5613.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210773-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E475C5A43F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 03:41:21AM +0000, Zhang, Lixu wrote:
> Hi stable team,
> 
> I would like to request a backport of the following commits to stable:
> 
> Commit 1: 0d30dae38fe01cd1de358c6039a0b1184689fe51
> Subject: HID: intel-ish-hid: Use dedicated unbound workqueues to prevent resume blocking
> 
> Commit 2: 3644f4411713f52bf231574aa8759e3d8e20b341
> Subject: HID: intel-ish-hid: Fix -Wcast-function-type-strict in devm_ishtp_alloc_workqueue()
> 
> Upstream: Merged in mainline
> Target stable: 6.18.x
> 
> Reason for backport:
> These two commits should be backported together as the second one is a fix 
> for the first one.

Now queued up,t hanks.

greg k-h

