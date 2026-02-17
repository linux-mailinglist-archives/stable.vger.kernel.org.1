Return-Path: <stable+bounces-216780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN/DNHlKlGn0BwIAu9opvQ
	(envelope-from <stable+bounces-216780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:01:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6D14B19C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4821301DACE
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC7324B38;
	Tue, 17 Feb 2026 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UyTsIDI1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932726ED31
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326070; cv=none; b=R5Q+fcmcqRNPap+PBLT64sAmpXVLTHmMyEWErSQzH+RLsk5jKDxJv+mR3ocqPjVNJL6gelxTUObAk8NH0DLqCOZqzXORZGU54cyT2PxNmMDHOWdDLvGjCX42j4dYCewO7aSWcMRkMs9FY0SNsovnkjPPdK2NnLxLm2PtOitgHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326070; c=relaxed/simple;
	bh=cY6RArae1vSHTU3hpPf13Z3D4ryuyAgsdqP704una7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxjKCDEcKNRaUVGBSXMEt9/45FbN3dMcxjmgpeBjLDRtDTxWdsl8Tp7vIEnY4Bd21RGVCRqYUd12VXEIwWYHG015r4bv3T4+iklYKfS6j8yz3iWFBsVl65twUokZt5DzQPatRdXU2cYR/vbTG7/kLP4j6sI20+1yZnJhDsT46KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UyTsIDI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE2CC4CEF7;
	Tue, 17 Feb 2026 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771326069;
	bh=cY6RArae1vSHTU3hpPf13Z3D4ryuyAgsdqP704una7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyTsIDI1W+37KUPyEEdgyqwj1w1D1BtGTDB8xO2OSUvZB9vo/Ftx1GjPgmV6Zd5OR
	 V8bETHvp3dHHJcND1uU8riRuoJLPLm43KXxvf0p9R3lLofRUpTnbBgpOeBiVECV7Uv
	 o6pBligbxCnx7ActWvk+Nti59xc36kSRs9Ix5imU=
Date: Tue, 17 Feb 2026 12:01:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Washington <joshwash@google.com>
Cc: stable@vger.kernel.org, Ankit Garg <nktgrg@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6.y] gve: defer interrupt enabling until NAPI
 registration
Message-ID: <2026021745-sweep-dioxide-a823@gregkh>
References: <20260213211702.447894-1-joshwash@google.com>
 <20260213211702.447894-4-joshwash@google.com>
 <2026021654-catsup-occupier-6753@gregkh>
 <CALuQH+UsbSxrOwkdUba=AFO7dDOrdtLmM5NOpQ__ASNW0GF5pg@mail.gmail.com>
 <CALuQH+Xsai9RWAwinJ6uG6Q9a_ocyaLrq2LtjY=6oVgFctK52w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALuQH+Xsai9RWAwinJ6uG6Q9a_ocyaLrq2LtjY=6oVgFctK52w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216780-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3BC6D14B19C
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 11:00:01AM -0800, Joshua Washington wrote:
> Hello,
> 
> I was also wondering if the way I'd sent the patches was okay, with
> major.minory.y patches for each of the stable kernels, or if I should
> send them differently in V2. Lore seems to have grouped all 4 patches
> into a series, which seemed a bit odd to me, but was probably related
> to the fact that I'd only used a single send-email command.

Either is fine, that's the least of our worries when taking stable
backports :)

thanks,

greg k-h

