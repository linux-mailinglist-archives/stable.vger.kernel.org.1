Return-Path: <stable+bounces-235954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPemKJOm3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:17:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A303E8FB3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D29F9303FF91
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC1B3A5457;
	Mon, 13 Apr 2026 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT7Nu3DO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93C3A5422;
	Mon, 13 Apr 2026 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067857; cv=none; b=IO9FeHw7LvpaKH6qelKXsy3dohJ4rvOCh8MW8nLGm5Xd4onXjOSys/hzaH/wxK25b6lAwmVC2v+NE/azfvhf55ytaZ1b6Keji4kjt++Xm5Lp1BAJeHlYDesrqEvFQ3OQgCoCA66V+OkmAep4p6/XVi1ykVFiq9sVOQle8oItIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067857; c=relaxed/simple;
	bh=GvPYAtIUKx0iy3T7lnTnQm++/JolSX86/uvIHmCSbTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2cht+9mqxWKrnD8661XcegBlqV38rVdz4QArebSyju0JJFSkOYlk6CAx8tbQxDFBZwcI22ooEINaKB1T8DyC0DnG/ReF4pswL9Wmr+aai9i917mq4Ty4xE0JZgSjJg+czPYHuj/nmRUulmzMNWa7i8GylXaZS4yhxvNYZcgiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT7Nu3DO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ACEC2BCB0;
	Mon, 13 Apr 2026 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776067857;
	bh=GvPYAtIUKx0iy3T7lnTnQm++/JolSX86/uvIHmCSbTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bT7Nu3DOh8on4MLzIxwfPk6cEjIHJzQeGYv3IvhPvq9qtX6huiD8T/JypRw45b1mh
	 sYq7xbMDJM3aFHUV6BUiIFhJkFDovN1CNOP+ELHxGYSo8H46Mj6ipVOhj6I7Eo3+s7
	 b+tyKaZfV8fDaaYcRGHcmLjWpODxkaBRrPDyzd4qpF6u3ASxKuLoTT5bUrpFyiDTF4
	 zqoNmoveBODlhqjFONRq2Lv1gOBSgz23S1MNceAHNntUtBRfkplYhGAA41vK8jFgZM
	 aUqe2TD0uUwo0QcqtRgfOBcHgUHvOYmiBxtgvoAEOxt6j2fPU+CdC6lmccds2rJPL4
	 5o3mj2WuIdTYQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCCNi-00000000n55-37tp;
	Mon, 13 Apr 2026 10:10:54 +0200
Date: Mon, 13 Apr 2026 10:10:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb-serial: fix port device refcount leak when
 device_add() fails
Message-ID: <adylDj3ah4U3QcaK@hovoldconsulting.com>
References: <20260412165311.2578501-1-lgs201920130244@gmail.com>
 <adyT6oW0UgvcEQbX@hovoldconsulting.com>
 <CANUHTR80npU59MrNq=1nYnb-r1ASKv_nG7=NF_G_Ko9-V-XaVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR80npU59MrNq=1nYnb-r1ASKv_nG7=NF_G_Ko9-V-XaVw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235954-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65A303E8FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

[ Remember to avoid top-posting when posting to the lists. ]

On Mon, Apr 13, 2026 at 03:55:09PM +0800, Guangshuo Li wrote:

> This report came from a static analysis result produced by a tool I am
> developing, and my review of the report here was incomplete.

Please mention that in the commit messages.

Johan

