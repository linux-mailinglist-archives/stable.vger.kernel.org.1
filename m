Return-Path: <stable+bounces-273584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 87EDG2mMVGrPnAMAu9opvQ
	(envelope-from <stable+bounces-273584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 08:57:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8749747BE9
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 08:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=nsuNWpxy;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273584-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273584-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E9BA301A519
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806BF356744;
	Mon, 13 Jul 2026 06:54:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812936896D
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925672; cv=none; b=o+L2EYv0k3I9wRfB5xuof5Qtgu0UrwhAcEiCC1JG9Nh/HJFOxBz67ZecuNJKVTwzKQ7Q/RbOAjlLrZZ5twcc1U6ZhDKAQbgm81MDPA4yMsoZjqWA9IX8q9MTGv1UBJofJEZbyrQapFos2wbKM4i7NisP44WA2gQohlJF5OqHaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925672; c=relaxed/simple;
	bh=yIs4xAeu+mwzhPBdB9m/ZElgntT4cp/LRfpFSpKwiXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvfLB6Dy8MQalI2htPdy5FLGzmKlVUzdzjQoMaLKSJOi+CJFkFIjRSUlsVCKhcmvG0x8XDbS/ZAyolZOdSiCSY5gcgPt4KT/a16Fk69hi1NSh7ZwmCkJCmECXxZpdwx1aq4VT3a/9Ov/0jvy06YzFAax88WjD1IiInYXp7SVdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nsuNWpxy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5351F000E9;
	Mon, 13 Jul 2026 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783925670;
	bh=yIs4xAeu+mwzhPBdB9m/ZElgntT4cp/LRfpFSpKwiXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nsuNWpxyK4+X8KKpP5NUBQyIRjdlinLa0qo4CEdCwJDG0NV/E/Ad4NvVXRoC/r3hS
	 E/4+jE47+zcoNYLvKq96i7AJITQ4xzzyrOSJbLIHiFbNyaUUTh9G6WLD4Z7exTS9NX
	 MpRrg2lL4em9LPQ3CjK10N5oq4mDkpLbzP6aouuY=
Date: Mon, 13 Jul 2026 08:53:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Timber <dxdt@dev.snart.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Andy Wu <Andy.Wu@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] exfat: bail prematurely from
 exfat_extend_valid_size() upon fatal signal
Message-ID: <2026071352-bunkmate-anymore-0962@gregkh>
References: <20260713061954.19557-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713061954.19557-1-dxdt@dev.snart.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273584-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dxdt@dev.snart.me,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:yuezhang.mo@sony.com,m:Andy.Wu@sony.com,m:wataru.aoyama@sony.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8749747BE9

On Mon, Jul 13, 2026 at 03:19:54PM +0900, David Timber wrote:
> commit 82a81a7352bcf5f2756ac33d47ee0582737e9a85 upstream.

No this is not :(

confused,

gre gk-h

