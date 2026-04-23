Return-Path: <stable+bounces-240468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L+0GcsE6mn5rgIAu9opvQ
	(envelope-from <stable+bounces-240468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:38:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E48BA451627
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73EF5301CA57
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828573E7146;
	Thu, 23 Apr 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUMu0To9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6B37F742
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944297; cv=none; b=hpPw8dFHVQURFNo2ftRQ18Muf4vGSXQuJlkR4Xx8X4AkENPkfY4oIlNsXrs2z8EI49jwaG3qs9AMVbk6S4HHtBBFMITjoEIr9TiYxDIs1unRF8hi0f0hwh4maFsQYK/sV4XybcR+lvOMofUlvywpWUq3magFLJvsLbgLYapMzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944297; c=relaxed/simple;
	bh=JyXsF9DkdksbA3Spny9jUArO2LigwGZV/98MXweKegU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQWaE7cwCo7KJ6541sU1RdKdip5Gkmc89Aei1bEZbWWg76s6LqJ1lugscNWtFRsnqa225ZJbuilZl+6hzDpgixFiUn/No/jq5XOd/KEELqgDXOn7rYmHXNEsJTL/H8FJLt4EKmIcUlD9e+UVIG56uiD71J4G6nJSN9K2TSZLd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUMu0To9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9DBC2BCB3;
	Thu, 23 Apr 2026 11:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776944297;
	bh=JyXsF9DkdksbA3Spny9jUArO2LigwGZV/98MXweKegU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUMu0To9O5OErZ+nU30CK9D2+qnjqLC9P3Q3RVBF+Q3B2L8Bz2JahiO31/4e00KyV
	 Y1H5VbWba1xIKPDz3R8P5qnEV1tfeYNTEyrrisDKpOisbXAiD4x8jX5wrGjScz2I0+
	 BHnazEmUps2/hQyvw8TK4kXHlcZnZ3Ve8QJLYjp8=
Date: Thu, 23 Apr 2026 13:38:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: stable@vger.kernel.org, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@cjr.nz>, Aurelien Aptel <aaptel@suse.com>,
	samba-technical@lists.samba.org
Subject: Re: [PATCH v2 5.15.y] cifs/dfs_cache: Fix NULL pointer dereference
 on session connection failure
Message-ID: <2026042305-various-upstart-3780@gregkh>
References: <20260319144325.438788-1-ghadi.rahme@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319144325.438788-1-ghadi.rahme@canonical.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240468-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E48BA451627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 04:43:25PM +0200, Ghadi Elie Rahme wrote:
> [ Upstream commit 6916881f443f67f6893b504fa2171468c8aed915 ]

Still not the right id or patch :(

