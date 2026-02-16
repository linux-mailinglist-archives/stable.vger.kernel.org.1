Return-Path: <stable+bounces-216679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF2hJG3nkmlSzwEAu9opvQ
	(envelope-from <stable+bounces-216679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:46:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 210951420DE
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA3E300A8CD
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B60284881;
	Mon, 16 Feb 2026 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mlqJyPd1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D42798E8
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235178; cv=none; b=Cv4tWVYWOAKADkSzoSaLh58o7QLbQjX/SjfSIZIQDnm1nDMe2A+wfL7Ltp8I5J6yZwkT7zsgPINrCyNUPKLcocsdkCDlb3K2Yo2OezVi6bPVod08COpaZJETP4UZaJXCJXkc+Y+cY9jTJ8x3+IhTewDKHIo3z/aYdc4we4IQjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235178; c=relaxed/simple;
	bh=7y8SJvZoVxK5vpsWKcK/KCyPUHHEIuQePp76p4SqzsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi2QodLAUs+FJNsRqJyCZIAsiOFPAnO7bQ5YQamBqroez0CGkf4ECaxbAanF1NRAsYRGgH6q19Xe7Cf+rO9ne/olOcJsE4xQMINVjoxQm0H662LcPrOxOIz6lD7dJr0FmU6nEumfGIucALSDz1UvHmJimIsPmWJIGAUcxLZdH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mlqJyPd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF26C116C6;
	Mon, 16 Feb 2026 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771235177;
	bh=7y8SJvZoVxK5vpsWKcK/KCyPUHHEIuQePp76p4SqzsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlqJyPd1v8EzRkG6FNQRmLTGaGmaUf9atPOlqvZg3AbQKTVgy7nlrPduSYybN0mDt
	 PFItEw8jE4yhiQy4WwBlZdQb9VDRmnDUEZne/vzepeuVy1hp2VgnTjY0V1kah0s8qq
	 Qxf65OjccRuLsD73lfgNToMjjWhB/EeDbqGYWAq0=
Date: Mon, 16 Feb 2026 10:46:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: stable@vger.kernel.org
Subject: Re: Request 2 bnxt_en patches for 6.12
Message-ID: <2026021608-showing-engross-1ac5@gregkh>
References: <CACKFLik3qQ46i3_wRpm0OnaNnMcMc-hVNrFt_0U9yzzjNrm4VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKFLik3qQ46i3_wRpm0OnaNnMcMc-hVNrFt_0U9yzzjNrm4VA@mail.gmail.com>
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-216679-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 210951420DE
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 04:06:01PM -0800, Michael Chan wrote:
> I'd like to request these 2 patches to be applied to the 6.12 stable kernel:
> 
> 8ff617513996 ("bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code")
> 0fcad44a86bd ("bnxt_en: Change FW message timeout warning")
> 
> Without the patches, an annoying warning message is always logged when
> the bnxt_en driver is loaded for every device.  With the patches, the
> warning will be more restricted and logged when necessary.

All now queued up, thanks.

greg k-h

