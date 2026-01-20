Return-Path: <stable+bounces-210482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAIWH7uNcWkLJAAAu9opvQ
	(envelope-from <stable+bounces-210482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:38:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D57706100B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD29C68ACAA
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328C728B7DB;
	Tue, 20 Jan 2026 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Gd2r1VL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24A4343D8A
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906552; cv=none; b=awMOJBOQeWcXlP7957PqCp6Um+0c/EJfCzZSXVK9D+Jgd/X/3GBISPojORUD5V3pDUfxZNPxJ7NSK3G9gtZm28CZ0vTj+E3qz/PC1dLJz1wi57b53gsF5Cnfjrg5CwHFbnaO2/fLSXut/eUXDfLBPJ189644iufJXJzsXbxMPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906552; c=relaxed/simple;
	bh=dFSKLz3xjl2nFSsIG17b1zc0kDfm0cHGv3ANM4vW1yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikv1Kaa7sX1VmDcie7/K3w9IUkpw01oTiVeUcgUjmYwIHxP7mjORNA1BugcwNYJC5Ms+5wnZGZhiGWMJ2hU/CzEv2YU+dPdWM6v5MQe/Ka1AB/lzByNzSPCpigDLe1zx5mDq+n8AX5ZAPoJSVwFh7qdbmSuoRfNWe84P1EY1bBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Gd2r1VL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29EDC16AAE;
	Tue, 20 Jan 2026 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768906552;
	bh=dFSKLz3xjl2nFSsIG17b1zc0kDfm0cHGv3ANM4vW1yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Gd2r1VLCGPbO/63hBTdISdUE6Rf6KqwN4Y4TdLE9wNnaci0YfL8OfCw8w0zlChE+
	 nvnU0xGbrJZ483Ln/hJ2xxcNPzZpuiWrwHQQKWO3RsyQdYOkktTWoGXx+mM5K6l0rq
	 dWt/g4NCIX9/9OshC7erqJhQhqlws3eo+Vmhr1Xw=
Date: Tue, 20 Jan 2026 11:55:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sam Halliday <sam.halliday@gmail.com>,
	Sasha Levin <sashal@kernel.org>, 1122193@bugs.debian.org
Subject: Re: Please apply commit f28beb69c515 ("HID: usbhid: paper over wrong
 bNumDescriptor field") to down at least 6.12.y
Message-ID: <2026012042-civic-composure-93a9@gregkh>
References: <aWo8F_XxsfmmpAYz@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWo8F_XxsfmmpAYz@eldamar.lan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[39];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-210482-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,bugs.debian.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: D57706100B
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 02:24:39PM +0100, Salvatore Bonaccorso wrote:
> Dear stable maintainers and Benjamin,
> 
> Back on beginning of december Sam Halliday reported an issue with ZWO
> EFWmini in Debian (https://bugs.debian.org/1122193) which got reported
> in https://lore.kernel.org/linux-usb/aT7TPAInuBOXctEZ@eldamar.lan/ and
> subsequently fixed by Benjamin with f28beb69c515 ("HID: usbhid: paper
> over wrong bNumDescriptor field").
> 
> The fix landed in 6.19-rc5, can you pick it please as well for stable
> series, at least down to 6.12.y (but not checked for older ones, maybe
> Benjamin can confirm until to which stable series it should go).

Now queued up, thanks.

greg k-h

