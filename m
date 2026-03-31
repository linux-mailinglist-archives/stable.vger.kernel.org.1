Return-Path: <stable+bounces-231397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN8JEsWry2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:11:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965FA3688AD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21A73017C25
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2053ACF02;
	Tue, 31 Mar 2026 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7nrizL1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041E3A7829;
	Tue, 31 Mar 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955232; cv=none; b=fl8QbjjbSy9f0tLrBDzSAog9oitBqRf82ESUC61DN5pSARdsTQHEhu+ODWRIBPeTEkq36AwazQdj4Q2GikvEDR53s77wS7gMuklRGHrwvqVakQYQ20D6offMugy+4ZxgDtRirNZybeVkKgcy14uR5Yo8JNYoJ8c39ifjd4fjcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955232; c=relaxed/simple;
	bh=7p7V+/wKgxTlXHrEKHNBoGb3g9MM4EwVBa7PcPZH70s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odPDaREP6hM98XohJ+PvY4nNioNjy/41VLb2Tn7v+WPcSAWlfrSah4ijD3/T++3gM83ezd2h3qvYzcYL8UOIgUmzLH6lVWawblnD3VDDUsKZkARKXhIq5ZilLCYJXD3BmN6cljehpQqEDZuQ18tP2uulftEr1i7klqPQG3+ibRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7nrizL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07F2C19423;
	Tue, 31 Mar 2026 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774955232;
	bh=7p7V+/wKgxTlXHrEKHNBoGb3g9MM4EwVBa7PcPZH70s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7nrizL1di2VXMjk1Cw/Eq97VxF3h7OZgw8/Z3EA1fWsFKK8xNtOLVkdRlFN/132n
	 iBhKERUZKydtfiGtTa2pEGvnaNNHgX/aShmcc8PVFkB4znq6I9MbNpwoWUSlm3TdFL
	 8omn8KYUT87z3jiQwoU3b9Vc1X7hZ0OneBhF0ptA=
Date: Tue, 31 Mar 2026 13:07:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/460] 6.12.78-rc1 review
Message-ID: <2026033102-sharply-mop-d638@gregkh>
References: <20260323134526.647552166@linuxfoundation.org>
 <8aa3ace8-33ba-4914-b615-c165fbd146af@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa3ace8-33ba-4914-b615-c165fbd146af@roeck-us.net>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231397-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 965FA3688AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 02:02:33AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On 3/23/26 06:39, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.12.78 release.
> > There are 460 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Since v6.12.64, various architecture/image combinations fail to build
> with the following error.
> 
> Error log:
> sound/soc/codecs/ak4458.c:631:13: error: 'ak4458_reset' defined but not used [-Werror=unused-function]
>   631 | static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
> 
> This is seen if the driver is built with CONFIG_PM=n.
> 
> Problem is that ak4458_reset() is only called from inside code
> protected with CONFIG_PM, but declared outside it. This was
> introduced with commit 47c4976513f1 ("ASoC: ak4458: remove the
> reset operation in probe and remove").
> 
> The problem is not seen in later kernels which also have commit
> 9f9c8e9064ea ("ASoC: ak4458: Convert to RUNTIME_PM_OPS() & co").
> That commit has not been backported to v6.12.y.

Now backported, thanks.

greg k-h

