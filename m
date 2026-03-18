Return-Path: <stable+bounces-227170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHQ/LK0Yu2k+fAIAu9opvQ
	(envelope-from <stable+bounces-227170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:27:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02E2C2F72
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8865305184D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4BF37A4AF;
	Wed, 18 Mar 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj5labwN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A82D1913
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869226; cv=none; b=Vtf+sZSTeRE/GH4ufhL0O7ukyC9kimGvNnSp5Pn15AUkvXYiuWeAWk+qiEHxGbvYYVfpo70ws95NTJfWmJ3We3oFVtVFUmetLSGuytXe3Qd8Pxn99WvWFPhzmUu0A+ug92FX9PkWLqELh2n4By50fnNb/B7AKZJaD3GoLKBd/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869226; c=relaxed/simple;
	bh=Xr+C74xxua0GI8VvFXF3clyb2cK8vhcWqio1qy4kzfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLC/Wf5SWnH1+ph/1SpsP5mIEG2tTcItDbD829pe038zBvBAdeJAmqMVYCG9U8ZBhsJq+VTel7r9JITOjULPZOeqBrxpBuB6T9kOsdUd1mUwzp2ilRRL490MY6tQM5YBBMC0LBqNCd57SBkOJC8AOpVhmqvWUaBivrX2uXgyrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj5labwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1136C19421;
	Wed, 18 Mar 2026 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773869226;
	bh=Xr+C74xxua0GI8VvFXF3clyb2cK8vhcWqio1qy4kzfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sj5labwNzHpY3gR5enHCLwOZ2cIqO3L70tVYToqe64Uw0lNLeKQH8sR15waD1F8tI
	 UtOje9IWNentZcLv6zpp9x7ku2OLLHiE1LHC6fTrW0ODxtjE8nOy6pFKnLKYUV3haR
	 DGAFlk3OKHf8+9tOH+4IU1WcytlJHa1v/4OY6IuQETOc2E5NE8CxqpKO08VIMZwIUs
	 ulftyVouu5nzKuamiLmOKyzYx1XC9bhY7gw2gR425hDpYSijddH/Zc8IZ1XaNPIF/1
	 Us8c50iEigkSvNKxHVpk0xA+02mzJgIh2XvO1TwlYeziTue/Rd/iB/DZrJGNZT5cEV
	 ua9/6TH8PWz0w==
Date: Wed, 18 Mar 2026 21:27:03 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: gregkh@linuxfoundation.org
Cc: kuba@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] net/tcp-md5: Fix MAC comparison to be
 constant-time" failed to apply to 6.18-stable tree
Message-ID: <20260318212703.GA2013993@google.com>
References: <2026031756-likewise-lumpiness-6c88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031756-likewise-lumpiness-6c88@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-227170-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 3C02E2C2F72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 01:01:56PM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I already did this a week earlier.

- Eric

