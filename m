Return-Path: <stable+bounces-247803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIHhC2c1B2rftQIAu9opvQ
	(envelope-from <stable+bounces-247803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:01:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B7551D1F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A05300CC10
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE3C3B3C19;
	Fri, 15 May 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zboMgFpb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353F3B6C06
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856961; cv=none; b=JPt8fgWzDuchylhesqgGa1gRXR/52WONWiwEEIw3Igl8xWrM4dHfRWHfd9ZldwCocIQa7wvMPNsLM00NjcWhxsl7KfKjHfOfH3FVl2goI9pQD9uwzuvB2aEjm0LnwUFTUO5eIIXEcLsXEEMrVc0CqSdbcHofkyL+SCB4+IpOHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856961; c=relaxed/simple;
	bh=Y6pDNQAhyp9Ndo03kz7FU5Y8oHHsz0N4c4/rdHRFt/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oafatFGJYQdIa+F4iNiknc+BWsrWQdPL78Dx0HBHxOkLrZ7leG+8YfYZXF7tNS9/oGvBbK2ym+g4oyOygUg70SkFpRDHT7tZS7MFVp0lAv2yAysMcb5arYTNZmap0oK29vv26ci4JVtwRs604HeVqpgaf7nK0300NCUULZ8ok3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zboMgFpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF51C2BCB0;
	Fri, 15 May 2026 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778856961;
	bh=Y6pDNQAhyp9Ndo03kz7FU5Y8oHHsz0N4c4/rdHRFt/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zboMgFpb4bBEIziMjd8JDhd4YbHPhVEEgDnNNsZhxSNUTEDyZRLjPRjFwPxFT470z
	 wdmM/T8bJ/OBDcjAV7+Zu2E+DqoFAXX3Foaj7DaZAEFADVktD2Ee+GN99d8eXr51wY
	 Fbn95PC8rhHlsoU2VfYruRl5XLgHy/sL5wJULwEs=
Date: Fri, 15 May 2026 16:56:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunseong Kim <yunseong.kim@est.tech>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	David =?iso-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>,
	Roland =?iso-8859-1?Q?Kov=E1cs?= <roland.kovacs@est.tech>,
	ysk@kzalloc.com, 42.4.sejin@gmail.com
Subject: Re: [PATCH 6.6.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Message-ID: <2026051556-transport-unplanted-581d@gregkh>
References: <20260426201144.465734-1-yunseong.kim@est.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426201144.465734-1-yunseong.kim@est.tech>
X-Rspamd-Queue-Id: 029B7551D1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247803-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, Apr 26, 2026 at 10:11:44PM +0200, Yunseong Kim wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

No, I did NOT write this commit :(


