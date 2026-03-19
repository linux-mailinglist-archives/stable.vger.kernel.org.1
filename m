Return-Path: <stable+bounces-227300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOA2I73/u2murAIAu9opvQ
	(envelope-from <stable+bounces-227300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:53:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF52CC394
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E78304F20C
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C042BEFE5;
	Thu, 19 Mar 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+qy7Wel"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA41F4CB3
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928279; cv=none; b=ZpmQX4zYAQ5daaRmmmVMuj51ylD65SvvWXL7q5C/8lV1q5mqZiqt19JykEjPd8Lozzphaqo+rD3lyronuXKehD4ruZBtwW+cp6QAUDq8+A0jagO30DG6p6SoeGSTRYJkj6lE3gaG9GFnuhWUFiq3pnlsVg1Vm6dUwFoNzVCGtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928279; c=relaxed/simple;
	bh=Dd1YOQHS84A9Ginoxaspg1Xq+51SRk1/CYtV9sibmh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5pFaDAH/HjKEffMGzif/gQONqNToYUI+t2nxxcGRMpJOJZdw4j+f86Cc5IbJpxj2wF8odX0N0cF1T9z+Q8zMcYrGWUpSG/5au03hudGzvjFxTez7mpWfxaB2JuuI9Fo9/eLu1zxaBNTff6RquXFTe29/WC90d+4K6sqKr0pZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+qy7Wel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B027C19424;
	Thu, 19 Mar 2026 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773928278;
	bh=Dd1YOQHS84A9Ginoxaspg1Xq+51SRk1/CYtV9sibmh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+qy7WelHDLd53b3DqIdGGy9Vf9g+qB4wsNuPTh1OYO2q0OZM4WE/MVAmmvfIYSSH
	 VjDYsj8Xk/+r1XK9eP8/c2oqOY0ZFqjfH9/87UWtQ8+s6hVD181eJS7HlBVtHc72n5
	 TDMYkQGbzezEQj8DmMMQnVPH8Hv/G5H00Fib3XN8=
Date: Thu, 19 Mar 2026 14:51:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: keenanat2000@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: check if target buffer
 list is still legacy on" failed to apply to 6.6-stable tree
Message-ID: <2026031907-jittery-swung-f589@gregkh>
References: <2026031701-humid-ultimate-853d@gregkh>
 <8dcd0d6e-08a7-4fc7-8ab6-3bc771c27b0a@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dcd0d6e-08a7-4fc7-8ab6-3bc771c27b0a@kernel.dk>
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
	TAGGED_FROM(0.00)[bounces-227300-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.881];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 15EF52CC394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 07:00:21AM -0600, Jens Axboe wrote:
> On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 6.6-stable.

Now applied, thanks.

greg k-h

