Return-Path: <stable+bounces-213037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDtqJYNjgGne7gIAu9opvQ
	(envelope-from <stable+bounces-213037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:42:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C2C9C07
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0568D301692A
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033E285CBA;
	Mon,  2 Feb 2026 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vc0kA0OA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE77261593;
	Mon,  2 Feb 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021523; cv=none; b=EozBzlkICQQlcSv9GMk8tfL2g+ZMS8pBGI9ybtsWDMgt57nfIe7CNxIdcDi5sW+HXFtbNA81tpEk43vqp3QYxIr6c+JctyjLiBHa25SSnaIwe7rFdOnPdh/9pESHiWJ847tOLlnXODJLhOFWH4KF0N8GHueUssqAOBWfLYrcmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021523; c=relaxed/simple;
	bh=tgfrlt2AFI+A4VLCdvM4K3Wp5ESLbNDRj3shGLm9ATs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICoPpS3e3q0pcEz82f0FhohFXBqInB7hSePCv6LFJ4NK0+aDr7Hdn8fIGzN1eOsgyyStcTmcw3uVvdiNO18qzN7O27nwv53LCJyB8PlAlUR7fDt5+ntVoS4WTzoeCzWJtGHHnlagXgPXirG/o/geB9boJr++1q0+bzkAdHcDojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vc0kA0OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A6AC116C6;
	Mon,  2 Feb 2026 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770021522;
	bh=tgfrlt2AFI+A4VLCdvM4K3Wp5ESLbNDRj3shGLm9ATs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vc0kA0OAfwTyYNigfI6OByEfg7h3Lc7uWgPZnCX5NWiki6nXBumAyutJqr4NJS3o6
	 ItvZ3SAnk9/Ecn2GyehCldzqR+uNQgOeeVwmnCBrVRs5u05+qn9g+D5mg4H+ms1xQI
	 SApXpVDq0pZJep6ixV3wjYnDyKd1ztgGPM+2s648=
Date: Mon, 2 Feb 2026 09:38:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: straube.linux@gmail.com, dan.carpenter@linaro.org, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] staging: rtl8723bs: fix null dereference in
 find_network
Message-ID: <2026020213-exonerate-error-b3d8@gregkh>
References: <20260202063808.664468-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202063808.664468-1-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213037-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,kernel.org,lists.linux.dev,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 396C2C9C07
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:38:08AM -0600, Ethan Tidmore wrote:
> The pwlan variable has the possibility of returning NULL and is not
> checked for NULL and then later dereferenced.

dereferenced where?  Not in this function :)

Please be more specific as to what exactly you are fixing here.

thanks,

greg k-h

