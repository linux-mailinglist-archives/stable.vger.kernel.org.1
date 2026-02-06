Return-Path: <stable+bounces-214605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHh5HXKFhWmqCwQAu9opvQ
	(envelope-from <stable+bounces-214605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 07:08:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8603FA917
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 07:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF83F303277C
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE6A30CDBD;
	Fri,  6 Feb 2026 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Af8JijjG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBE30C62C
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358089; cv=none; b=i8Uaxxjjte/mSXcwamNA1aPTjdq3ahR6riPbk5df3cstwxFnFUjQkE+zHUJ7EmH6YxrXWckmtAGEdRHhqRJkity7iF/khQrhVrFB29ZEoSPid2T7BvxV3MI/OEICVdezXYJnESSkvyN2Tq4l6kRq1w57w5MPQIqwLqLko7vmik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358089; c=relaxed/simple;
	bh=HIKNjkfz7R3TRzElJZiu3Qs8NOccCiiVXLyFUzdr6kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEYcIn9b3DceBhGDJgumLNM6bSNOJRktsPkQ5nGkW8UsH3PxKBJBBndRHMD2LAHzxWsvrej6TuIpTeWIrjL0X5KM9LehLZmB48e4GmX3smuq1q2vIcv7Yo2rX3SAOaIzw1gW8UFnc7N61Z+Qdn3QvxVO7X3pQD76f57stmNqV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Af8JijjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29351C16AAE;
	Fri,  6 Feb 2026 06:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770358088;
	bh=HIKNjkfz7R3TRzElJZiu3Qs8NOccCiiVXLyFUzdr6kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Af8JijjGSsT9znNh09wPAjtPDhBhulVQW9qC8FCsY64q9wJFSlMGRe6IBtS3Rrnxi
	 IzfX5B6iRecvfakfocgB+rE5USNwnXW9kIY1wdPGHoZpMnHnVZIiy6vFtIqbIdk85y
	 ydZs/O9UWKaWNoFCCD+0akxkX4HIFx8BH+ZSqNd0=
Date: Fri, 6 Feb 2026 07:08:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangchen200426@163.com
Cc: zhangchen01@kylinos.cn, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: HCI: Fix hci0 not release in usb disconnect
 process
Message-ID: <2026020654-wildfowl-jogging-756d@gregkh>
References: <20260206054240.297057-1-zhangchen200426@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206054240.297057-1-zhangchen200426@163.com>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-214605-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: D8603FA917
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:42:40PM +0800, zhangchen200426@163.com wrote:
> From: zhangchen <zhangchen01@kylinos.cn>
> 
> If hci_resume_dev before hci_unregister_dev, the hci command will
> timeout and the reference count of hdev will not reset to zero.
> Then the node "hci0" will not release.
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

