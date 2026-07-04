Return-Path: <stable+bounces-271940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vgS2HSnxSGqhvgAAu9opvQ
	(envelope-from <stable+bounces-271940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 13:40:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A07076ED
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 13:40:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=JrGYbzLm;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271940-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271940-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C6F3011588
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189E37EFFF;
	Sat,  4 Jul 2026 11:40:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAD353A8F;
	Sat,  4 Jul 2026 11:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783165222; cv=none; b=dG5YVl3LFZYZk5alfzpP540/k+c3NOjJK2NnDPFwBC3BB2+Fg61hd/8pSCfZkHqOU+8C/Mrho8JI4labaIWNgW+VyhrGHEYxYi+ZHcqtyldLIb3xeI1eEN/3jSIUC9Wk5P8kGLwTF/IzITCUwZ8UnUDnMoRqIaVU2AflLh4NC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783165222; c=relaxed/simple;
	bh=aE5A1S5gklmcHc//5DJ280a+ExrMB1eOZzzwltVzW+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz2cgBWvysXeyZWwSpvZWYUKAeClIr5Gq0qsHbGApja9aCn37cyfgnl+yjexX4PGfA02l0vlPdHv3jR9+y3umz5b48aaKfgZPs279y6WHXGqySw3c/rfkbBpiZvhC3bRjoJ0W8w57oziDLuZEmKK0G1YiZ8fWxIREynpUCokO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JrGYbzLm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB151F000E9;
	Sat,  4 Jul 2026 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783165221;
	bh=aE5A1S5gklmcHc//5DJ280a+ExrMB1eOZzzwltVzW+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JrGYbzLm7hlkxr6QA6BFBQzQQb2A5SaFiPDrf2tOiVsufnuJqB3swNntrHElwjoeA
	 S7s/46EXJvGSPRTRXnBgh1LqiK/x1axLetLxVSIkXH+zc0HO12+CewkdU4QM98sA5Y
	 IYHgbIlIrXJmEMIKtwqz+fncCplBw/4Dm/cL58OM=
Date: Sat, 4 Jul 2026 13:40:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: maher azz <maherazz04@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
Message-ID: <2026070400-broadways-designer-ea0b@gregkh>
References: <20260528194657.359703301@linuxfoundation.org>
 <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
 <2026062933-storeroom-amusement-0b66@gregkh>
 <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
 <2026070446-blank-duckbill-13ec@gregkh>
 <CAFQ-Uc8AAEGw90BPximQm3cLzB+KiH_PXr-UZEPK9nvueMGtSg@mail.gmail.com>
 <2026070406-squander-geography-213a@gregkh>
 <CAFQ-Uc8CDnGUH3xhjaVBd+Dr=+b7Lfu1SUrGGh2gQ17WW+gqxQ@mail.gmail.com>
 <2026070421-overflow-voyage-73b8@gregkh>
 <CAFQ-Uc9JvsHVCgj6ydVrg++hA4CCxw+FuQYfKzBC65HyuJNMoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQ-Uc9JvsHVCgj6ydVrg++hA4CCxw+FuQYfKzBC65HyuJNMoQ@mail.gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maherazz04@gmail.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:sgarzare@redhat.com,m:mst@redhat.com,m:avkrasnov@salutedevices.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-271940-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B03A07076ED

On Sat, Jul 04, 2026 at 12:34:20PM +0100, maher azz wrote:
> I’m using gmail directly. I’m requesting a CVE to refer to it directly as
> im going to disclose the poc on my accounts so people know about it
> and patch

You keep sending html email :(

And are you sure you are sending it to the correct email address?

