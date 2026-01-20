Return-Path: <stable+bounces-210483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I0sKmFkcWmaGgAAu9opvQ
	(envelope-from <stable+bounces-210483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:42:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A445F9FC
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96B0F7C135D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2E40FD8A;
	Tue, 20 Jan 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnl04pfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6F39903F
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906857; cv=none; b=klSSrWhD2RXjUoCL/BOXzDiiVW9JaQNHIBJc6QPkVIvoJZLFZOFdF0dRqgFBZdz+NeeJNBjycrl+MgOyUeVv3ShveGwfV8NCtkPJmpQCYEy0Z8RBLDkEwFW7xvGC6ruVmU++raJ8ZjvKU9ub72lLkt9eIseYyJwHbkmcOiszDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906857; c=relaxed/simple;
	bh=yn5BTG+DuZvt2OZBNjq98biiKTXmNBrJkBZ9WYzifVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uj1GcfADjqjMQuKmMINTrxTaDXhfwUUnch4KDLnlp8LfFALicM1M+3gR3rDvyi5lyh9GprunvQ3x4XX40zU/q/8TSgQwg8fp/V9AvTlyh509bW+ZLvf0CAJOjs0MyeNBPsj/QJBtdCvGReBNJDGFqTdWUUPFwB+GrAeJse+Pg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnl04pfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962F6C16AAE;
	Tue, 20 Jan 2026 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768906856;
	bh=yn5BTG+DuZvt2OZBNjq98biiKTXmNBrJkBZ9WYzifVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnl04pfOP/XagqaGnHQfuO8Rmf5hplraQBerIHkcK6TtHfdznHbz5mGyCCioa25At
	 CIukiEgdN4FV4Lz/aNnbDPG9kiKZAVffN/GU6gr0zbdzFGaC9kOGWCaTeuEF4I35SI
	 XENKh4z4wuS8/uozixueG8ZPBDfVJeFmJ7SWBxtY=
Date: Tue, 20 Jan 2026 12:00:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yasushi SHOJI <yashi@spacecubics.com>
Cc: stable@vger.kernel.org
Subject: Re: SPI NOR: Request for Inclusion in v6.12
Message-ID: <2026012000-sulphuric-carton-2253@gregkh>
References: <CAGLTpnJhAgNThT=gWcpLEEFvNBwav+N=4Kf1yQK2O7T823MzEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGLTpnJhAgNThT=gWcpLEEFvNBwav+N=4Kf1yQK2O7T823MzEw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[36];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210483-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 12A445F9FC
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 07:12:32PM +0900, Yasushi SHOJI wrote:
> Hello,
> 
> Please consider including the following patch series in the v6.12 LTS release.
> These patches fix issues with the Spansion S25FS-S family of SPI NOR:
> 
> - e8f288a115f48: mtd: spi-nor: spansion: SMPT fixups for S25FS-S
> - f74de390557bf: mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
> - 653f6def567c8: mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook
> 
> These patches have been tested on my Xilinx / AMD Versal boards.
> 
> Tudor Ambarus of SPI NOR subsystem maintainer allowed me to submit
> to the stable tree in this conversation.
> https://lists.infradead.org/pipermail/linux-mtd/2025-November/111104.html

That seems like a "new feature", why not just use the 6.18.y kernel tree
instead?  It is the next LTS release.

Also, we can not take patches only for older kernels, otherwise you
would have a regression when upgrading to newer ones.

thanks,

greg k-h

