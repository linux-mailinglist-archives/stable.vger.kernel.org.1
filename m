Return-Path: <stable+bounces-245837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zh5LGuRRA2pq4gEAu9opvQ
	(envelope-from <stable+bounces-245837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:14:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841C524743
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4825030B44BC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776ED3C585C;
	Tue, 12 May 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFImzR8f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136B27E1A1;
	Tue, 12 May 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602203; cv=none; b=WLVEm+9W3MEnVX+IkIjHca4BmkmfMaie/BI1fwuDzfLh6ZAm07rxkA6/M2kOKe2biMz+hWageqq768x6cdA3IaxftE12qvcen8e3g0pHhwSVdXy+Dr81KQxEdgi/0FNZmamG2Ujn0nKkCcmcaCbnqiB3GZYOU2XosgciOcl+gzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602203; c=relaxed/simple;
	bh=YluAjRFwmtGZThKS1YGUEmIUZ5eCiHWm3Y+KM5faHo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dfnW5vDeax9MYyF25O1qZjEejUR9969kFkWG0L0d9Bm9Z337srJifpYkWq7wGpPNHxqWQZU6y1LnfD0No9qsSybv0+/NA6VccT806uOfu5QfxbxhImHaKPg/Bl1gB2HHVr/UmWU0uC2YA0xXAFbqhw75HjUK4j/GdrosCwUEWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFImzR8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9DFC2BCB0;
	Tue, 12 May 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602202;
	bh=YluAjRFwmtGZThKS1YGUEmIUZ5eCiHWm3Y+KM5faHo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LFImzR8fRq2NU+DMjgQyzjM/Iuez2bV5TYCnI4hxNKrMzNm2gm77K7aYpJ1+JOo+D
	 gJv0SWd9wiPSQIEaxjZuHQrji0zoVvKNyphbupJWx4f+qH6jF0YHXuhU8OS+3RAayv
	 /oIbScLQ88h4tx+5x/XGT98WKxwJoMO5RhLZFLjgTKTvul8Ds1lrw1OEvi/SSDxcbb
	 Kgy2CvTfmYCfsaZFNrZDMI75qDWn+XE+mQEIIcOoQ276XOuF9DdpINZD+sp7BaOFKY
	 MnsXojiI7ICupxoPvIpCZF267Bbw4hMb10tGy6O5R3ZTaf/vVQ4LTnl+EkaEnkZ1AN
	 i0SC0AlAwisNw==
Date: Tue, 12 May 2026 18:10:00 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: marcus.folkesson@gmail.com, benjamin.tissoires@redhat.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: pxrc: fix slab-out-of-bounds read/write in
 pxrc_raw_event()
In-Reply-To: <20260508133311.3995013-1-jinmo44.yang@gmail.com>
Message-ID: <888704q0-o278-n257-2p94-04qp3sqp61s8@xreary.bet>
References: <20260508133311.3995013-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1841C524743
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245837-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Fri, 8 May 2026, Jinmo Yang wrote:

> pxrc_raw_event() accesses data[7] without verifying that the buffer is
> large enough. A device that sends a report shorter than 8 bytes causes
> an out-of-bounds read (priv->dial = data[7]) and an out-of-bounds write
> (data[7] = priv->dial) on the report buffer, corrupting adjacent slab
> memory.
> 
> This can be triggered from userspace via /dev/uhid by creating a virtual
> device with VID 0x1781 / PID 0x0898 and sending a short UHID_INPUT2
> report.
> 
> Add a size check at the top of pxrc_raw_event() to bail out when the
> report buffer is shorter than 8 bytes.
> 
> Fixes: a2dccedac664 ("HID: pxrc: new driver for PhoenixRC Flight Controller Adapter")

Where is this tag coming from?

No such hash exists in Linus' tree, and the commit that actually added the 
driver has a different shortlog.
Is this some LLM halucination?

-- 
Jiri Kosina
SUSE Labs


