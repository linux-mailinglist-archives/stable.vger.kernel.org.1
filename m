Return-Path: <stable+bounces-263624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MJcmLlLzMGptZQUAu9opvQ
	(envelope-from <stable+bounces-263624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:55:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06068CAB0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=a+X7Fd5I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263624-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263624-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46E7304EBA7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA49313E30;
	Tue, 16 Jun 2026 06:55:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07A8635D
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592912; cv=none; b=dwNHCJMhlPuCAFhNu69lKT6zpXSH8D4pJLOZlW8ytzXLgGRHD0TssonBchfyfl9KGjQYEFWnSMFnB/umVF/2HLmUCNdXdWfiEgVOQDNdMuX8wT6IdbpyajMwtVhfmrRDYOGhVllQspuHGrMKpHg9MulCUdXaflDkop6br2j9FO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592912; c=relaxed/simple;
	bh=OSWThRm2vBAxCkWJG8g/gU8ZVz29W3H1kZ5XIYhH/LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8no6baRlJmpCxJtjDteEWaMHQi4geyJSw7uz9GNA23yCXR61ntjXvvWI7xCxowHLSuNaaVOwohZOIH53f/LL3ZdN5PfYaqMdBMK9qSt9G92PoCipfcutiBju+6byDwI4B9dHhaochYG6HECzID6c3SMFI0lBexG/IKLJI0NX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+X7Fd5I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B8A1F000E9;
	Tue, 16 Jun 2026 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781592910;
	bh=zAG40Q9Ze50z+6ILAlRQbM5+7IqVmWpSAyElEov8uOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+X7Fd5IkVhh8b8lqMpWLQRjMS1VR0+uadcpdyK446obA97bjyeZVSwReDwjlMOgy
	 Jw14o2SX4gmkTKnhvjctoENA02Y2hLrhkX/nl+DVgAyw1agay9Z5aivwWyFubMcboB
	 5VaR40W2hwwC5JVJkMIpptZIaFphzPShFPzVpQZo=
Date: Tue, 16 Jun 2026 12:24:05 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] batman-adv: tp_meter: fix tp_num leak on
 kmalloc failure" failed to apply to 6.1-stable tree
Message-ID: <2026061640-citable-dreamily-8662@gregkh>
References: <2026051520-obnoxious-editor-0139@gregkh>
 <3081197.VdNmn5OnKV@sven-l14>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3081197.VdNmn5OnKV@sven-l14>
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-263624-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sven@narfation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C06068CAB0

On Fri, May 15, 2026 at 11:10:30AM +0200, Sven Eckelmann wrote:
> On Friday, 15 May 2026 10:45:20 CEST gregkh@linuxfoundation.org wrote:
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> @Greg, I will take care of backporting the failed batman-adv patches in an 
> hour or so. The steps you provide in the mail are always super helpful to stay 
> focused and do everything step by step. 
> 
> But I've noticed that on a shell with "extended_glob" enabled, the shell tries 
> to match the last parameter because it sees the '^' character. Maybe you could 
> also quote it too:
> 
> -git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> +git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'
> 
> Btw. I've just disabled it here on my shell. But maybe this is still 
> interesting for others

Ah nice catch, I'll go update my script to put the '' in there, thanks.

greg k-h

