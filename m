Return-Path: <stable+bounces-263406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fDezGSIuMGo4PgUAu9opvQ
	(envelope-from <stable+bounces-263406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:53:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF54688902
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aWpQfsxW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263406-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263406-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDCB3044726
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBC40F8F8;
	Mon, 15 Jun 2026 16:48:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4879407576
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:48:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542111; cv=none; b=EIC2J5GTPxIemT7iYWLxsnqfAbWf6E9jLo/Ca83pnXtg/Xuge4iJE9o9UYgnRb1vmG8yK43GAbBKvu0b/7M8euMHcStBwprGd+TSwssaJqDnhMdPbwd5sZjtjqq639PA5RKpj+qLMEZtFcOHHoKxlXVE2g2MyXNf83DWDSpL4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542111; c=relaxed/simple;
	bh=6ci9UZv/7sLUIT9xs0kssxjZuB9QNhMlDzqw+dicRbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhXLDu3T168DWA0qK2wQ7F9KF5FCG+od3WxfO9LW1Szo+hiH7XB6JlhX21ETVTLPpKqeuv5UebP1oYvr6xqyYOMUaU0+puSI4nEoLfxyAju6IWRyggkFYmddgrPWGpYy4A/scceVR9P6pNad/SB0pkRjPhO72BOYNTSCtUUBRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aWpQfsxW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969751F000E9;
	Mon, 15 Jun 2026 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781542110;
	bh=nXnRO8anjVVDZpkfEONBSfAJFDqfBhT91S9VPEMUj08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aWpQfsxWAgYrsZMjq7MjqxGAsV/rI0FBRkJPadWhixg0uQbyh6FSBao2q02WSflqg
	 Kdq4UNm6OhOqogY/nibd+TGtppr94sgCADuO05VqpUyOvdYG6TRbN9oSXu9mMelDPq
	 T5bsvQGqLQShQGOvp5ETRWsPqxzQsMJn8ugNfwac=
Date: Mon, 15 Jun 2026 18:45:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: stable@vger.kernel.org, sashal@kernel.org, brauner@kernel.org,
	jlayton@kernel.org, w15303746062@163.com
Subject: Re: Please cherry-pick commit 00633c468382 to stable
Message-ID: <2026061545-clubbed-uninjured-1c18@gregkh>
References: <d161697b-7c51-4ad7-b697-7ae3a3a78b9b@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d161697b-7c51-4ad7-b697-7ae3a3a78b9b@stu.xidian.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263406-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:25181214217@stu.xidian.edu.cn,m:stable@vger.kernel.org,m:sashal@kernel.org,m:brauner@kernel.org,m:jlayton@kernel.org,m:w15303746062@163.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDF54688902

On Tue, Jun 16, 2026 at 12:19:13AM +0800, Mingyu Wang wrote:
> Hi,
> 
> Please cherry-pick the following upstream commit into active stable trees:
> 
> 00633c4683828acd5256fa8d5163f440d74bbe71
> 
> It fixes a SOFTIRQ-unsafe lock order deadlock that can lead to a remote
> Denial of Service (DoS) via crafted TCP URG packets in fasync signaling.
> 
> The patch applies cleanly to recent LTS branches.

Now queued up, thanks.

greg k-h

