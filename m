Return-Path: <stable+bounces-253693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oODUBIvgD2ocRAYAu9opvQ
	(envelope-from <stable+bounces-253693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 06:50:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B495AEC78
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 06:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F049302A6A1
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37577359A90;
	Fri, 22 May 2026 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ox9os61X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92E1A2545;
	Fri, 22 May 2026 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425130; cv=none; b=BmC7kcNxq+zUGwUmVRSwJ0avpsX7o77qxIeAke1tEhnqOdUCoWJ9mJ7Zfkxc3fZLws0WHv/AU7kHbIN3JQ9Zb/Y5tFAwyNwY6kSJ+nn1cyODxaA3yVoY4KscmH65v8UCYza/9AuUF0V18SHdIU+WTwpBSJqnpGax7Fa5Frezh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425130; c=relaxed/simple;
	bh=8p6iBNtk8angBKBKqbsbPWFI+lK9qFn54AQTeK+Lc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kstl50aqE1qFmrWaDkJpfwhYM6n8gZTqri0ZMVAHUJUuW5HgDtZmelKIYtMM6YXiU9AOW3ehNxfa9d5IT14YA2nGxbSbk5TqF5tZkUOjYPo0OLJuObPguRwg/SaQfwNY+42D5i0Ze3iVDgwptaUcBUaQvtQ2fM5RSYpsbqBmwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ox9os61X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3921F000E9;
	Fri, 22 May 2026 04:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779425128;
	bh=5zZBaruX0Piz4UoErSW+hQ/KWw5I5ffCqqnYncPENuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ox9os61XqtCkTk4YemKO2DIwEW63EngHLfgEgHj0U5fprQoD2jc4ckcC69y592/UU
	 1I/auMAVFfFrBbcxfsygQ2FFarFCS2z2SmE5KKBhhGpxUkle31j4TvoIu6CzSFQjbQ
	 H9dBxb8rR7RYbaLQI0LhAdMrgcWSWnXpKPQEVf4Y=
Date: Fri, 22 May 2026 06:45:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: oneukum <oneukum@suse.com>, carvsdriver <carvsdriver@gmail.com>,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH RFC] USB: cdc-acm: Fix bit overlap and move quirk
 definitions to header
Message-ID: <2026052217-willfully-snowplow-1f80@gregkh>
References: <20260506093213.1473262-1-guanwentao@uniontech.com>
 <2026052144-unwritten-washing-df27@gregkh>
 <tencent_59BCDC255EB2B97F0CAB385D@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_59BCDC255EB2B97F0CAB385D@qq.com>
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
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253693-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 89B495AEC78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:03:02PM +0800, Wentao Guan wrote:
> > On Wed, May 06, 2026 at 05:32:13PM +0800, Wentao Guan wrote:
> > > The VENDOR_CLASS_DATA_IFACE and ALWAYS_POLL_CTRL quirk flags added in
> > > commit f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10
> > > INGENIC touchscreen") were placed inside the acm_ctrl_msg() function
> > > rather than in the header with the other quirk flags.  Then, their
> > > values (BIT(9) and BIT(10)) collided with NO_UNION_12 which is already
> > > BIT(9).
> > >
> > > Move the definitions to drivers/usb/class/cdc-acm.h where they belong
> > > and shift them to BIT(10) and BIT(11) to avoid the overlap.
> > >
> > > Fixes: f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen")
> > > Cc: stable@vger.kernel.org
> >
> > Why is this needed for stable?  What bug does this "fix"?
> I see that there is a bug that NO_UNION_12 and VENDOR_CLASS_DATA_IFACE use same bit.

Then send this as a non-RFC patch, as obviously we can not take RFC
patches :)

