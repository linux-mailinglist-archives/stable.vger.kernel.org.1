Return-Path: <stable+bounces-217693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOh3KHf2m2lI+QMAu9opvQ
	(envelope-from <stable+bounces-217693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:40:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E711723CE
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACDED302206E
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F40D345754;
	Mon, 23 Feb 2026 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z15Vhlon"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89C3451C8
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828783; cv=none; b=MjbZJ6RVU3I42r/AgGqjBHMrDW54f1mZLZsbTfizR8822HfweRja7lpJGXiV19xdRt+qza70EKN6tOFNQ0tRgKjTgfmpirnTXdJ7L1wI0lnbvdID1x8bqMLsGWjZK9tbVQEGNBzAglo4MVFOgP8KK+iDxLgiygbR1b//H6HOzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828783; c=relaxed/simple;
	bh=NWGMBTzMFeGcR+aAAxbUyCcPNjajbO3iGKmo81ElPkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaD6HbOUeN8FuZtRSFo3hr5flMCXoom087GEPZcQvknNArF43akLxcBpn92xcOztDJ7DItcyEkpZggPO64GhMDuDOfw3X4v/Dg2IfHp50Msx5LPSODn3vHC2uuX7FOPrWfUySKKDgDbRazFnP+8G451dozvR2QVNFCdlBU8xbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z15Vhlon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89885C116C6;
	Mon, 23 Feb 2026 06:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771828782;
	bh=NWGMBTzMFeGcR+aAAxbUyCcPNjajbO3iGKmo81ElPkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z15VhlonNDUdNapbAdLqR+q9uH6QIPZ/Y2X33pyyURpObsjRgDV/8RJh3hT0nW7zK
	 c9cveeHcTFwbtO7ecibir7JC+YJe4Sp5LzlPlsQ2ckg4tOWxwfcVxpLuYY6CjUIi8B
	 XiZRTLSYEboew5QIZ+rCN82+f3z/Yt/G+nZj10dc=
Date: Mon, 23 Feb 2026 07:39:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amine Khemissi <aminekhemissi61@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10] scsi: backport fix for NULL deref in scsi_queue_rq
Message-ID: <2026022354-skincare-paragraph-b377@gregkh>
References: <CAEc6xTVu-sG=Xb+LuDf4SFXChmKDC1f1ZOhZKP6Am_+2DMy=pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEc6xTVu-sG=Xb+LuDf4SFXChmKDC1f1ZOhZKP6Am_+2DMy=pw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-217693-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 48E711723CE
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 07:07:38AM +0100, Amine Khemissi wrote:
> Hi,
> 
> This backports the fix for CVE-2021-47552 to 5.10 LTS.
> 
> The patch applies cleanly and has been tested on 5.10.0+.
> 
> Thanks,
> Khemissi


Please do not send attachments.  Please provide both backports, as
individual patches, like are in the main kernel branch.  See the
archives of this mailing list for lots of examples on how to do this.

thanks,

greg k-h

