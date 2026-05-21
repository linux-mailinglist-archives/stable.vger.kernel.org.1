Return-Path: <stable+bounces-253480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOJvMbzGDmqzCAYAu9opvQ
	(envelope-from <stable+bounces-253480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:47:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8FF5A1659
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 346013027760
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115613A759F;
	Thu, 21 May 2026 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uhGQP3hp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520E39E194;
	Thu, 21 May 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352802; cv=none; b=LJx1GE02Tqs/ngu2qAdVcBUM2sBFMR/wKiDhQ/Akf6rdGK7vubsiup+v5WdwrA083xmCZVpaYSD2ZQ3sIKDlkfza+ZDaRlOf7ADQ8d5riZgjokG0rZk8lm25JHI34H6T76J06Tmar7PSeJ+f0dBaO5AiuqaU7IuEWgSQWAba6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352802; c=relaxed/simple;
	bh=uRDRrbAw3gGoh02+/l85dyv5a3nrCdO1AhWDZ131m6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtGuyadYsplVk7bKzofKGNSKRBm9cQKC7fJoAVA6yk2NfpWktC5WLz7UMqZj39oDsT5UtGzm5m+ZBUxjTmZwnV8bFFXGrShEAOHldUdZKh190malOphACCbzTqB1z0/Nwe5rrx9O6dGu+fYJtGKgU6olxSUgHYmBCDLM5/qPHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uhGQP3hp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4791F00A3B;
	Thu, 21 May 2026 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779352797;
	bh=uRDRrbAw3gGoh02+/l85dyv5a3nrCdO1AhWDZ131m6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uhGQP3hpWo2oDPosN0y3jqBSWWXEWIJQDpsEUPeeldYfKdlRtwtLUyMrclWe4LvJh
	 7+rphzcv5XEaNncqV4YrPSY4J69EtrKQT1uP+TuAH1jkFytyq2Zv5HEIfEBseIQD70
	 XV7YYlbMV6AtDOQto0MQNYPtOSDkIiJqIplzNtj0=
Date: Thu, 21 May 2026 10:40:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 0/3] staging: rtl8723bs: fix OOB reads and heap
 overflow in IE parsing
Message-ID: <2026052139-illicitly-corset-8711@gregkh>
References: <20260511165743.1588637-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511165743.1588637-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253480-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 6F8FF5A1659
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 11, 2026 at 06:57:40PM +0200, Alexandru Hossu wrote:
> v5, addressing the sashiko review comments on v4.

Still more comments:

https://sashiko.dev/#/patchset/20260511165743.1588637-1-hossu.alexandru@gmail.com

