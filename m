Return-Path: <stable+bounces-245195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIDMKUjQAWrbkAEAu9opvQ
	(envelope-from <stable+bounces-245195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:49:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B550E329
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DDAF309EE8F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D639D6CB;
	Mon, 11 May 2026 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="votjO450"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A89370D69;
	Mon, 11 May 2026 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503385; cv=none; b=FY3jJjUEB6i4R3eWqCgDdkVTdium/OJe4zRfGxgz60Be54ncGAss9s/bHWMCyLut3DPu+35bN/+97pwL9jfA2rVUgFZeDWviwYQlOQgxsG8JTM3zgXEogKWUmefFrVGXcvxkzsMOxo+LjIUhEL53ibTE9h1PsxGPGzryeqxu9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503385; c=relaxed/simple;
	bh=kEh3ZMa0fd/LZcQOD42d4AjqK7iaw/I2FabCleunhzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVCoFGrIPm+ZKpZpG8gUimwXvQe+9mpCMfFa2D+56+JPvxvfsTT3Qw/+/1BUuh0ZkrMKTiOze7lMWVfQBE7zFHHChm7eUx49BtCBeVGBn03b4kOlidPsTXEx0gscEIy3LOxlhyaHo+/YynVMtdzep3zrW7GDoNQmN/UG/o1iph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=votjO450; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD20DC2BCB0;
	Mon, 11 May 2026 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778503385;
	bh=kEh3ZMa0fd/LZcQOD42d4AjqK7iaw/I2FabCleunhzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=votjO450GAZurM/EMRlTMNBtEGrRNHaoaas2hZCTdG7wLCRYWnDkI5HM/ShKI851e
	 a3dsGDFCUmMGvBK+JjVmJoBnh7HsmoZ6uDl8EcvV77FjkiQcJErnAVldVIhDBsbuw8
	 honyflk9iWnVkTfuurZgs+VR5pZdypgS35Z8GFH8=
Date: Mon, 11 May 2026 14:43:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	error27@gmail.com, stable@vger.kernel.org, luka.gejak@linux.dev,
	hansg@kernel.org
Subject: Re: [PATCH v7 0/2] staging: rtl8723bs: fix OOB reads in OnAuth() and
 OnAuthClient()
Message-ID: <2026051148-broom-rut-4391@gregkh>
References: <2026050453-scorer-rebate-3898@gregkh>
 <20260505211316.3837020-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505211316.3837020-1-hossu.alexandru@gmail.com>
X-Rspamd-Queue-Id: 283B550E329
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245195-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,sashiko.dev:url]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 11:13:14PM +0200, Alexandru Hossu wrote:
> v7, addressing the sashiko review comments on v6.

Some more comments on your patch 2/2:
	https://sashiko.dev/#/patchset/20260505211316.3837020-1-hossu.alexandru@gmail.com

thanks,

greg k-h

