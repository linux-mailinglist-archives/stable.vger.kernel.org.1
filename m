Return-Path: <stable+bounces-268109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id saEjImqeO2rNaQgAu9opvQ
	(envelope-from <stable+bounces-268109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:07:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 141246BCD0D
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:07:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=iz6X31Nu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268109-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268109-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5518304D740
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668130569F;
	Wed, 24 Jun 2026 09:02:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC926E71E;
	Wed, 24 Jun 2026 09:02:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291736; cv=none; b=DQyvm91WKBwoHqd/7M4J8jfLA7rwlEgRXKgJmDpQtWsf5wFc2DjxbV7EE5khySJf9hVEAx1CKct1uxjlLCbx32kNz7SkTGqsoYfvp4AiGPSSzbFFFzohmOwPIMPoxjlJtaZuqrY+YB8j42yk9yxo736S9RRCUKbMmSAxxK331uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291736; c=relaxed/simple;
	bh=Q1eJUiBPMyXO/I3sKWO4XtAQqKuB9o45TUZUXyPAJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3HvC+j8pWIhgX764eGXiqS9NreOXVg1/dOdHPctUbchP5RIHc48y70dKpVuP6QJSlyu2Yhn9qYoR7hIwYs+iaav8+I3RF+k7QGXXLU0ppmnxtgxwnW2qTQNrE4wJPV3FOiFYsWWVcxC0lO0ytCM1SKNRiDZ34myYvbdECPflsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iz6X31Nu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8034D1F000E9;
	Wed, 24 Jun 2026 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782291735;
	bh=MzpkBY9YszNy1v3sP8Rq4XsT3ktn4Jvsz54kXjM8chw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iz6X31NulWUlj2fZZPtIh7OShrv0xcQ3yZ9L6yv3VVfcI16OO06yaw0nd4QAq6yTO
	 MtPk4HCLqU44/LkrDx1ko7hr1+CjC3BFehLriyScliw63deRo+r5N9cJ6Jj2gLFXqk
	 CZS4NbLoR7SJ5ARH4AfGsByTiIoE7RjjSgnxpeZg=
Date: Wed, 24 Jun 2026 11:01:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: iklatzco@gmail.com, 00107082@163.com, patches@lists.linux.dev,
	peterz@infradead.org, sashal@kernel.org, stable@vger.kernel.org,
	yeoreum.yun@arm.com
Subject: Re: perf: Fix dangling cgroup pointer in cpuctx
Message-ID: <2026062455-obtrusive-sandbox-d6d1@gregkh>
References: <20260616145120.525872058@linuxfoundation.org>
 <20260624080310.2502480-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624080310.2502480-1-guanwentao@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268109-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,163.com,lists.linux.dev,infradead.org,kernel.org,vger.kernel.org,arm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:iklatzco@gmail.com,m:00107082@163.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 141246BCD0D

On Wed, Jun 24, 2026 at 04:03:10PM +0800, Wentao Guan wrote:
> Hello, 
> 
> I noticed your backport missed - 'event->pending_disable = 1;',
> which different than upstream version, is that true?

I have no context here at all :(

