Return-Path: <stable+bounces-269623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s1RAMWP3QWpnxQkAu9opvQ
	(envelope-from <stable+bounces-269623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DF6D5E7D
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:41:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xk3zsgAT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269623-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269623-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E16EC30143E9
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B066037BE7A;
	Mon, 29 Jun 2026 04:40:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3D37C906;
	Mon, 29 Jun 2026 04:40:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782708059; cv=none; b=lZx+Ckj27e4JoUQIwuHjIVOlnJFzIIyMx7h2SBJDLRGm7KWRfuMERn5AorlvWvWy+6HJJuaAH2Ec3Yc1vJ3WleZN74ylJdhJZKfJF9V3hz4BNazuZ9lCnFVQU3dULC0Q5KD7IRlyJ4HhWf8fJsqVTKx5rMgVYBN5/2KPlGZJ8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782708059; c=relaxed/simple;
	bh=GbD7Yt0R73XGNv2oV3X+HxcHQQQCo8Re9ZwX8wAL7RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khr5CoMVtVRlQE267xJJScgZwvGg0KAHHQZf/FPFxW/Wp2kPiWDs6TCErj02EKZGe36ifVY5W32nviKNrZhzhy+dVArsPwBA06HnT2XUq+uVngiewWNSvMltTlzOHsgi/ovNTwvgoflvZGYJbOrh//WbxG/vpBnrjPsQ89VaMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xk3zsgAT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620541F000E9;
	Mon, 29 Jun 2026 04:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782708058;
	bh=juRt5His1elSw5Wu+cmbKhJ8HAatx2f2zCsUzDUWQn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xk3zsgAT8y7hNSQUE1z+L6lI/dmLJpACUq8cUrbco9t9+jsunD+gWNgNWnxOQoWB+
	 jBFqsfaZJ+h0KFM+nThBeP0juwasHDe0fkyQXjF7ulwUSu4F+BTIUvZs0ASpf7OXVG
	 fqq6wIwgx2jLgJqTVY8unat/j1urQijhWAcLOjxk=
Date: Mon, 29 Jun 2026 06:39:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: maher azz <maherazz04@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
Message-ID: <2026062933-storeroom-amusement-0b66@gregkh>
References: <20260528194646.819809818@linuxfoundation.org>
 <20260528194657.359703301@linuxfoundation.org>
 <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-269623-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maherazz04@gmail.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:sgarzare@redhat.com,m:mst@redhat.com,m:avkrasnov@salutedevices.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,gregkh:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F7DF6D5E7D

On Sun, Jun 28, 2026 at 08:31:35PM +0100, maher azz wrote:
> Hello,
> 
> Is there a CVE assigned to this issue already? Thank you for patching it.

<formletter>

Please see:
        https://www.kernel.org/doc/html/latest/process/cve.html
for how kernel CVEs are assigned.

</formletter>

