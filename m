Return-Path: <stable+bounces-245320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAPFNUU2AmocpAEAu9opvQ
	(envelope-from <stable+bounces-245320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:04:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32F5156C3
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B9D3070208
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DC37DE9E;
	Mon, 11 May 2026 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aptt7u6g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B9379EFE;
	Mon, 11 May 2026 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529830; cv=none; b=DGpdVD1UcrgTNVLN9bt4RG5r9QYT1MP9Xwkbl1cL0plKJ1d9bDRi05L8S21+P7ebMZE4SNJ0tQhJHgzWRFDDtksFzf7kir+LEIuaD9TbT+e++boQjtJzI0TuzlbcLaScvOiW+z4d7Wk6xRZWkCLmogFwJ3LfyykEIgzI37uIqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529830; c=relaxed/simple;
	bh=8XwYDCtIn+1Nq0iWWts1S6dN9BtelZvjzK1bdkUzriE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMqUq//SQO1EJO9IN17USBRfmXyi/UXRiQ8p5TTLNVnMDwkBSwXfaKl9CIoQiJ7K3K/vw00ayTD1GY54ughZO5craDfNJ0lMY242p29mcOjgLxRlLPUtB7YAHBEY8eAIOvlttPRP42y9FVrH+GEvMtkuFlctLJEbR0vRePkmgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aptt7u6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01462C2BCF5;
	Mon, 11 May 2026 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529830;
	bh=8XwYDCtIn+1Nq0iWWts1S6dN9BtelZvjzK1bdkUzriE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aptt7u6gOxaC+d5bbO8OcxiBRbHjvNu0PkpfaR2UrubHvoUevDI8GxLZdJzWuDZAU
	 jZHSXP6Z3D5PREP7FL91Pc0XIVLN0Jg0+3SjDpfheZ7hv1H3mAOLR7tdNe8vpk1e6l
	 U6PZF4xfhWS4BTrDQrKTKErB0tbzZYNCExLpjdiIFdmdv5mmHbBamzLF4PB/xRythD
	 IQNoQH71RlQsW6M02zEGDyIazE2g0rQhoMI/Iek+b6CkyYBaYK3ztOmtmPwNMfDXbx
	 PTP4u2Y5v8TkXTRCNQsefccoDPmF23w9el4k3N3DzBPVUNEndN9NKRj/3tnUT7zzT3
	 lliVcadAtfDUw==
Date: Mon, 11 May 2026 13:03:49 -0700
From: Kees Cook <kees@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Daniel Gomez <da.gomez@samsung.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] params: bound array element output to the caller's
 page buffer
Message-ID: <202605111302.40979F986B@keescook>
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
 <20260507082103.94473-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507082103.94473-1-pengpeng@iscas.ac.cn>
X-Rspamd-Queue-Id: 5A32F5156C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samsung.com,suse.com,google.com,atomlin.com,yandex.ru,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245320-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 04:21:03PM +0800, Pengpeng Hou wrote:
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Yeah, this is a good first step. I'd really like to change all these
get/set ops here and for sysfs, etc, to use seq_buf, but that's a much
larger change. In the meantime, let's do this.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook

