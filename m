Return-Path: <stable+bounces-247780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNj/BNkmB2oEsQIAu9opvQ
	(envelope-from <stable+bounces-247780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73224550E7A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C6CA3014422
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5347ECF3;
	Fri, 15 May 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="VNe4a24T"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DC3D25C2
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853015; cv=none; b=KAUev56NoG4XSEgt+R1Gj7fQaxQ0K9eCH9dQ8VCz/vmalEyk1Em1MAOcjMMfCdVkO6RNn1+JwkOHxVu0J4CTznmzGLcuXejOtNrYLwtK6x1HCEzgbxnOMSOA7mIYS5PjgoLhxb4iHL3x5RSG8IV4witMpTvxg5PJAkbRZNL7GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853015; c=relaxed/simple;
	bh=ZEg2d9eqFNuGRVB6U6xKsWX37Xu3/zlduxhhY8iE/iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgHGosaWaI1Pub2D1T2Mq4hUJqbke/C0B3oOUr1k8zV+uui90JgEFIlCltTgNPuH0ltajHdbzTSjch56L4GCQtyp51TuPcQr6xENCRq/EibXP5nucGqBHtvkQ8L1lbIGTizxT4TFYm+Xpm5UZ56BELLBcu0Sw7qrw8KwYB///Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=VNe4a24T; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=12907; t=1778852964;
	x=1779457764; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	02=3A100=3A8400=3A1127=3A8b22=3A4c38=3A4ad1]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v26.0.2)=20=0D=0A=09with=20ESMTPSA=20id=20md5001005278633
	.msg=3B=20Fri,=2015=20May=202026=2009=3A49=3A22=20-0400|Message-
	ID:=20<140786c6-e788-4860-95fc-7dbaf30eb51f@auristor.com>|Date:=
	20Fri,=2015=20May=202026=2009=3A49=3A58=20-0400|MIME-Version:=20
	1.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PATC
	H]=20rxrpc=3A=20Fix=20read+write=20past=20skb_headlen=20in=20sof
	t-ACK=20parser|To:=20Michael=20Bommarito=20<michael.bommarito@gm
	ail.com>,=0D=0A=20David=20Howells=20<dhowells@redhat.com>,=20Mar
	c=20Dionne=20<marc.dionne@auristor.com>,=0D=0A=20"David=20S=20.=
	20Miller"=20<davem@davemloft.net>,=20Eric=20Dumazet=0D=0A=20<edu
	mazet@google.com>,=20Jakub=20Kicinski=20<kuba@kernel.org>,=0D=0A
	=20Paolo=20Abeni=20<pabeni@redhat.com>|Cc:=20Simon=20Horman=20<h
	orms@kernel.org>,=20linux-afs@lists.infradead.org,=0D=0A=20netde
	v@vger.kernel.org,=20linux-kernel@vger.kernel.org,=20stable@vger
	.kernel.org|References:=20<20260513180907.2061972-1-michael.bomm
	arito@gmail.com>|Content-Language:=20en-US|From:=20Jeffrey=20E=2
	0Altman=20<jaltman@auristor.com>|Organization:=20AuriStor,=20Inc
	.|Disposition-Notification-To:=20Jeffrey=20E=20Altman=20<jaltman
	@auristor.com>|In-Reply-To:=20<20260513180907.2061972-1-michael.
	bommarito@gmail.com>|Content-Type:=20multipart/signed=3B=20proto
	col=3D"application/pkcs7-signature"=3B=20micalg=3Dsha-256=3B=20b
	oundary=3D"------------ms020308080609080203090606"; bh=ZEg2d9eqF
	NuGRVB6U6xKsWX37Xu3/zlduxhhY8iE/iU=; b=VNe4a24TcllwObSJ3O5r0xGj3
	ok494nJsY32BSjjhMHMT6Spp9/2oYmHcpbF7eG+upR7exvrYKQOJ9URbmCQsuWY9
	6VB3/W8exdnnpC/bv1FsoNrdiZQqOsxAH0cY3dSgVrLERFNLokGcZIEpi/aNKhOZ
	O2xNYwjQNPEX+OmO5s=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Fri, 15 May 2026 09:49:24 -0400
Received: from [IPV6:2603:7002:100:8400:1127:8b22:4c38:4ad1] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2) 
	with ESMTPSA id md5001005278633.msg; Fri, 15 May 2026 09:49:22 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Fri, 15 May 2026 09:49:22 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:1127:8b22:4c38:4ad1
X-MDHelo: [IPV6:2603:7002:100:8400:1127:8b22:4c38:4ad1]
X-MDArrival-Date: Fri, 15 May 2026 09:49:22 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1595c475f5=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <140786c6-e788-4860-95fc-7dbaf30eb51f@auristor.com>
Date: Fri, 15 May 2026 09:49:58 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rxrpc: Fix read+write past skb_headlen in soft-ACK parser
To: Michael Bommarito <michael.bommarito@gmail.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260513180907.2061972-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20260513180907.2061972-1-michael.bommarito@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020308080609080203090606"
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: 73224550E7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_AS(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,auristor.com,davemloft.net,google.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247780-lists,stable=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,auristor.com:mid,auristor.com:dkim]
X-Rspamd-Action: no action

--------------ms020308080609080203090606
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8xMy8yMDI2IDI6MDkgUE0sIE1pY2hhZWwgQm9tbWFyaXRvIHdyb3RlOg0KPiByeHJw
Y19pbnB1dF9zb2Z0X2Fja3MoKSBidWlsZHMgYSByYXcgYHU4ICphY2tzID0gc2tiLT5kYXRh
ICsgLi4uYA0KPiBwb2ludGVyIGFuZCB3YWxrcyBpdCBmb3IgYHNwLT5hY2subnJfYWNrc2Ag
aXRlcmF0aW9ucywgcGVyZm9ybWluZyBhDQo+IHJlYWQtbW9kaWZ5LXdyaXRlIChzaGlmdHJf
YWR2X3JvdHIpIG9uIGVhY2ggYnl0ZS4NCj4NCj4gVGhlIGNhbGxlciByeHJwY19pbnB1dF9h
Y2soKSBvbmx5IHZhbGlkYXRlcyB0aGF0IHRoZSBieXRlcyBleGlzdA0KPiBzb21ld2hlcmUg
aW4gdGhlIHNrYiAoYG9mZnNldCA+IHNrYi0+bGVuIC0gbnJfYWNrc2ApIGFuZCBiZXN0LWVm
Zm9ydA0KPiBsaW5lYXJpc2VzIHRoZSBoZWFkIHdpdGggc2tiX2NvbmRlbnNlKCkuICBza2Jf
Y29uZGVuc2UoKSByZXR1cm5zDQo+IHdpdGhvdXQgcHVsbGluZyB3aGVuIHRoZSBza2IgaXMg
Y2xvbmVkLCB3aGVuIHBhZ2VkIGRhdGEgZXhjZWVkcyB0aGUNCj4gbGluZWFyLWhlYWQgdGFp
bHJvb20sIG9yIHdoZW4gZnJhZ3MgYXJlIHVucmVhZGFibGUuICBPbiBhIG5vbmxpbmVhcg0K
PiBza2IgdGhhdCBzdXJ2aXZlcyB0aGUgY29uZGVuc2Ugc3RlcCAoY2xvbmVkIGJ5IEFGX1BB
Q0tFVCBjYXB0dXJlLA0KPiBmcmFnX2xpc3Qtc3R5bGUgYWZ0ZXIgSVAtZnJhZ21lbnQgcmVh
c3NlbWJseSwgb3IgcGFnZWQtZnJhZyByZWNlaXZlDQo+IG9uIHJlYWwgTklDcyksIHNrYi0+
ZGF0YSBjb3ZlcnMgb25seSB0aGUgbGluZWFyIGhlYWQuICBUaGUgcGFyc2VyDQo+IHRoZW4g
d2Fsa3MgcGFzdCBza2JfaGVhZGxlbihza2IpIGludG8gc2tiIHRhaWxyb29tLCBza2Jfc2hh
cmVkX2luZm8sDQo+IG9yIHRoZSBuZXh0IHNsYWIgb2JqZWN0LCBkb2luZyBpbi1wbGFjZSAx
LWJ5dGUgc2hpZnRzIG9uIHVwIHRvIDI1NQ0KPiBhdHRhY2tlci1jb250cm9sbGVkIG9mZnNl
dHMgcGVyIEFDSyBwYWNrZXQuDQo+DQo+IFNpYmxpbmcgcGFyc2VycyBpbiB0aGUgc2FtZSBm
aWxlIGFscmVhZHkgdXNlIHRoZSBzYWZlIHBhdHRlcm46DQo+IHJ4cnBjX2V4dHJhY3RfaGVh
ZGVyKCksIHJ4cnBjX2V4dHJhY3RfYWJvcnQoKSwgcnhycGNfaW5wdXRfc3BsaXRfanVtYm8o
KSwNCj4gYW5kIHRoZSByeHJwY19pbnB1dF9hY2tfdHJhaWxlcigpIGNhbGwgc2l0ZSBhbGwg
dXNlIHNrYl9jb3B5X2JpdHMoKQ0KPiB3aXRoIGV4cGxpY2l0IGxlbmd0aCBjaGVja3MuICBU
aGUgc29mdC1BQ0sgY2FsbCBwYXRoIGlzIHRoZSBsb25lDQo+IGRpcmVjdC1kZXJlZiBzaXRl
Lg0KPg0KPiBBZGQgYW4gZXhwbGljaXQgcHNrYl9tYXlfcHVsbCgpIGNoZWNrIGJlZm9yZSBp
bnZva2luZyB0aGUgcGFyc2VyIHNvDQo+IHRoYXQgdGhlIGxpbmVhciBoZWFkIGlzIGd1YXJh
bnRlZWQgdG8gY292ZXIgdGhlIFNBQ0sgYml0bWFwLiAgT24NCj4gYWxsb2NhdGlvbiBmYWls
dXJlIHJldHVybiByeHJwY19wcm90b19hYm9ydCgpIHdpdGggdGhlIHNhbWUNCj4gZXByb3Rv
X2Fja3Jfc2hvcnRfc2FjayBkaXNwb3NpdGlvbiB0aGUgZXhpc3RpbmcgbGVuZ3RoIGNoZWNr
IHVzZXMuDQo+IHNrYl9jb25kZW5zZSgpIGlzIHJldGFpbmVkIG9uIHRoZSBwYXRoOyBpdHMg
dHJ1ZXNpemUtYWNjb3VudGluZyBzaWRlDQo+IGVmZmVjdCBpcyBpbmRlcGVuZGVudCBvZiB0
aGUgbGluZWFyaXNhdGlvbiBndWFyYW50ZWUgdGhhdA0KPiBwc2tiX21heV9wdWxsKCkgbm93
IHByb3ZpZGVzLg0KPg0KPiBUaGUgYnVnIHNoYXBlIHdhcyByZXByb2R1Y2VkIHVuZGVyIFVN
TCtLQVNBTiBpbiB0d28gY29tcGxlbWVudGFyeQ0KPiBoYXJuZXNzZXM6DQo+DQo+ICgxKSBB
IGttb2QgdGhhdCBsaWZ0cyB0aGUgcGFyc2VyJ3MgaW5uZXIgc2hpZnQgbG9vcCB2ZXJiYXRp
bSBhbmQNCj4gICAgICBleGVyY2lzZXMgaXQgYWdhaW5zdCBhIGttYWxsb2MoNDcpIGJ1ZmZl
ci4gIEtBU0FOIHJlcG9ydHMgYQ0KPiAgICAgIHNsYWItb3V0LW9mLWJvdW5kcyByZWFkIG9u
IHRoZSBmaXJzdCBieXRlIHBhc3QgdGhlIGFsbG9jYXRpb246DQo+DQo+ICAgICAgICBCVUc6
IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMgaW4gcnVuX3J4cnBjX3NvZnRfYWNrc19sb29w
KzB4NTIvMHg3NA0KPiAgICAgICAgUmVhZCBvZiBzaXplIDEgYXQgYWRkciA2M2E3MDMyZiBi
eSB0YXNrIGluc21vZC8zNw0KPiAgICAgICAgIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hl
IGttYWxsb2MtNjQgb2Ygc2l6ZSA2NA0KPiAgICAgICAgIGFsbG9jYXRlZCA0Ny1ieXRlIHJl
Z2lvbiBbNjNhNzAzMDAsIDYzYTcwMzJmKQ0KPg0KPiAoMikgQSBzZWNvbmQga21vZCB1c2Vz
IHRoZSBpbi1rZXJuZWwgcnhycGMgQVBJIHRvIGFsbG9jYXRlIGEgcmVhbA0KPiAgICAgIHJ4
cnBjX2NhbGwsIGJ1aWxkcyBhIG5vbmxpbmVhciBob3N0aWxlIEFDSyBza2IgKGxpbmVhciBo
ZWFkPTQ2LA0KPiAgICAgIHBhZ2VkIGZyYWc9NzksIHNrYi0+Y2xvbmVkPTEsIG5yX2Fja3M9
NjApIGFuZCBkcml2ZXMgdGhlDQo+ICAgICAgdXBzdHJlYW0gcnhycGNfaW5wdXRfY2FsbF9w
YWNrZXQoKSAtPiByeHJwY19pbnB1dF9hY2soKSAtPg0KPiAgICAgIHJ4cnBjX2lucHV0X3Nv
ZnRfYWNrcygpIGNoYWluIGRpcmVjdGx5LiAgU2l4dHkgMHhBQSBzZW50aW5lbA0KPiAgICAg
IGJ5dGVzIHBsYWNlZCBpbiB0aGUgbGluZWFyLWhlYWQgdGFpbHJvb20gYXJlIGFsbCByaWdo
dC1zaGlmdGVkDQo+ICAgICAgdG8gMHg1NSBieSB0aGUgdW5tb2RpZmllZCB1cHN0cmVhbSBy
eHJwY19pbnB1dF9zb2Z0X2Fja3MoKSBvbg0KPiAgICAgIGEgc3RvY2sga2VybmVsLiAgT24g
dGhlIHBhdGNoZWQga2VybmVsLCB6ZXJvIG9mIHNpeHR5IHNoaWZ0IC0tDQo+ICAgICAgcHNr
Yl9tYXlfcHVsbCBhYm9ydHMgdGhlIGNhbGwgYmVmb3JlIHRoZSBwYXJzZXIgcnVucy4NCj4N
Cj4gTm90ZTogdGhlIHJlYWwtcGF0aCBkZW1vbnN0cmF0aW9uIGRvZXMgTk9UIHByb2R1Y2Ug
YSBsaXRlcmFsDQo+IEtBU0FOIHNsYWItb3V0LW9mLWJvdW5kcyBzcGxhdCwgYmVjYXVzZSB0
aGUgb24td2lyZSBuQWNrcyBmaWVsZA0KPiBpcyBhIHU4IChtYXggMjU1KSBhbmQgdGhlIE9P
QiBzaGlmdCBzdGF5cyB3aXRoaW4gdGhlIHNhbWUga21hbGxvYw0KPiBzbGFiIG9iamVjdCB0
aGF0IGhvbGRzIHNrYl9zaGFyZWRfaW5mby4gIFBlci1ieXRlIGNvcnJ1cHRpb24gb2YNCj4g
c2tiX3NoYXJlZF9pbmZvIGFuZCB0aGUgbGluZWFyLWhlYWQgdGFpbHJvb20gaXMgdGhlIGFj
dHVhbA0KPiBwcm9kdWN0aW9uIGVmZmVjdC4NCj4NCj4gQSByZWdyZXNzaW9uIGNoZWNrIG9u
IGEgZnVsbHktbGluZWFyIEFDSyBza2IgY29uZmlybXMgcHNrYl9tYXlfcHVsbA0KPiBpcyBh
IG5vLW9wIG9uIHRoYXQgcGF0aDsgdGhlIHBhcnNlciBjb250aW51ZXMgdG8gcmVhZCBpbi1i
b3VuZHMuDQo+DQo+IEZpeGVzOiBkNTdhM2ExNTE2NjAgKCJyeHJwYzogU2F2ZSBsYXN0IEFD
SydzIFNBQ0sgdGFibGUgcmF0aGVyIHRoYW4gbWFya2luZyB0eGJ1ZnMiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBvcnRlZCB2aWEgaW50ZXJuYWwgc291cmNlLWF1
ZGl0IHBpcGVsaW5lIG9uIDIwMjYtMDQtMjEuDQo+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xh
dWRlLW9wdXMtNC03DQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgQm9tbWFyaXRvIDxtaWNo
YWVsLmJvbW1hcml0b0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIG5ldC9yeHJwYy9pbnB1dC5j
IHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL25ldC9yeHJwYy9pbnB1dC5jIGIvbmV0L3J4cnBjL2lucHV0LmMNCj4gaW5k
ZXggMjRhY2ViMTgzYzJjLi41MmFjZTBmOThkMDYgMTAwNjQ0DQo+IC0tLSBhL25ldC9yeHJw
Yy9pbnB1dC5jDQo+ICsrKyBiL25ldC9yeHJwYy9pbnB1dC5jDQo+IEBAIC0xMTczLDYgKzEx
NzMsOCBAQCBzdGF0aWMgdm9pZCByeHJwY19pbnB1dF9hY2soc3RydWN0IHJ4cnBjX2NhbGwg
KmNhbGwsIHN0cnVjdCBza19idWZmICpza2IpDQo+ICAgCWlmIChucl9hY2tzID4gMCkgew0K
PiAgIAkJaWYgKG9mZnNldCA+IChpbnQpc2tiLT5sZW4gLSBucl9hY2tzKQ0KPiAgIAkJCXJl
dHVybiByeHJwY19wcm90b19hYm9ydChjYWxsLCAwLCByeHJwY19lcHJvdG9fYWNrcl9zaG9y
dF9zYWNrKTsNCj4gKwkJaWYgKCFwc2tiX21heV9wdWxsKHNrYiwgb2Zmc2V0ICsgbnJfYWNr
cykpDQo+ICsJCQlyZXR1cm4gcnhycGNfcHJvdG9fYWJvcnQoY2FsbCwgMCwgcnhycGNfZXBy
b3RvX2Fja3Jfc2hvcnRfc2Fjayk7DQo+ICAgCQlyeHJwY19pbnB1dF9zb2Z0X2Fja3MoY2Fs
bCwgJnN1bW1hcnksIHNrYik7DQo+ICAgCX0NCj4gICANCg0KQWJvcnRpbmcgdGhlIGNhbGwg
YmVjYXVzZSBza2JfY29uZGVuc2UoKSB3YXMgdW5hYmxlIHRvIGNvbnNvbGlkYXRlIHRoZSAN
CnJ4IGFjayBwYWNrZXQgZGF0YSBpcyBhbiB1bmZyaWVuZGx5IHRoaW5nIHRvIGRvLg0KDQpB
cyBzdWdnZXN0ZWQgYnkgdGhlIGNvbW1pdCBtZXNzYWdlLCBjb3B5aW5nIHRoZSBkYXRhIGJl
Zm9yZSBwcm9jZXNzaW5nIA0Kd291bGQgYmUgYSBmcmllbmRsaWVyIHNvbHV0aW9uIHRvIHRo
ZSBpZGVudGlmaWVkIHByb2JsZW0uDQoNCkplZmZyZXkgQWx0bWFuDQoNCg0KDQo=

--------------ms020308080609080203090606
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DTAwggY0MIIEHKADAgECAhBAAZimBAJ19t4m6OTgn3OxMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTE0
MB4XDTI1MDgxNDAwMzg1N1oXDTI3MTEwMTAwMzc1N1owgcwxKDAmBgNVBAUTH0EwMTQxMEMw
MDAwMDE5OEE2MDQwMjY3MDAxMEYyNjIxGTAXBgNVBGETEE5UUlVTK05ZLTM1ODIyMzcxFTAT
BgNVBAoTDEF1cmlTdG9yIEluYzEZMBcGA1UEAxMQSmVmZnJleSBFIEFsdG1hbjEPMA0GA1UE
BBMGQWx0bWFuMRAwDgYDVQQqEwdKZWZmcmV5MSMwIQYJKoZIhvcNAQkBFhRqYWx0bWFuQGF1
cmlzdG9yLmNvbTELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDKtXD1tqgXxlJvgI10FM0ZvyWukq2IeXgVhbgOk4k4PbRk1TvrGB04QatXac9soW7yHv6R
hoovQ+URaXBEpBYxOE8Tsx+XfKZNkGbWj9bEdWgi8HPb33rf8eKFuhjx1QEv/YtD7lGIp7Rh
KWC5kBfvyut8o3XJmJF0hCR1m663wsttrn89dwZczLU4JUjbTF0ukM0DbDk55ItDB4dXnW/u
RfhrVuemMvbDily+etLCWsuJjtrjRBCQ805eYRHq5LonX3oNLdXituSHXLKvq+uChgFN/veD
HKpeBnBWmoNtOQnV8fsq5NCz/WswIACeZj+xGmZsWx7fyuzee78ZePfBAgMBAAGjggGhMIIB
nTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIE8DCBhAYIKwYBBQUHAQEEeDB2MDAGCCsG
AQUFBzABhiRodHRwOi8vY29tbWVyY2lhbC5vY3NwLmlkZW50cnVzdC5jb20wQgYIKwYBBQUH
MAKGNmh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY2VydHMvdHJ1c3RpZGNhYTE0
LnA3YzAfBgNVHSMEGDAWgBTC1ESZoHHPSFa+DI5oOFynt/dFvDAjBgNVHSAEHDAaMAkGB2eB
DAEFAwIwDQYLYIZIAYb5LwAGAgEwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL3ZhbGlkYXRp
b24uaWRlbnRydXN0LmNvbS9jcmwvdHJ1c3RpZGNhYTE0LmNybDAfBgNVHREEGDAWgRRqYWx0
bWFuQGF1cmlzdG9yLmNvbTAdBgNVHQ4EFgQUY4JHedU4owyskKPvw4gOjSyBJZUwKQYDVR0l
BCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMMMA0GCSqGSIb3DQEBCwUAA4IC
AQCeOjCscMFctL6UG8WBsFMIOHc7MpbrX7EIvO34SGVKhrbqS1RTIBQiVVWnQ4VI6qVw/n9d
adUv4o1/F23s0uXE8/lGJAGn51kkw1xHU+0PGODOTWvAQOiPhSmaXG5xM4BgleroGggumd8f
HRSKFK7DIdWcMMNbS6LpMAOUfXYzNBvcHbAcjJMHQ7N8pNXdEQDB9c6yIw4paVD6XDE5VFhL
df6749jGqSWXpyTMjXzrPMaDyxKiNOtsUrdT/fh8+Xx84nGpwiV9PA9/cGSAPcAc/qMBgPb4
Qj9met/RUvCHPWr68Zlirgx48W/7TTZFhXKZg3U+zCj4ASOfLJ6WT4PPoM+eLHbB402WNMFk
QDmWBH4bMqUcbQWxarMxdQ/jHKTsJIkvg+rTCbWbDm7hgJbnPEZrJEghy69Opa9+F1HB90AQ
mb41N1PLZytu8pCGBJufyqjzNU0eyWkHJCwHDLFhoCENk/vujFCmsJUSh7a6ZMPSXf3PR4TP
Kkcgs9JBT0dyPGHEfC/Lp9ZHTGSO6zswK1BddBufYi3xqHNBO/s7ft6gpNvht7oKUhVcjM7E
mQCA6t2ok44PNfeG8rJZxiDv04IruCbzLFwkPczWS5uCIuP3PWCfVtMnUPDamMVWAr4Ui/s6
fy3TZbPUAPDjFRi7zpkFIKHlCS/HIHNR6Gr1lzCCBvQwggTcoAMCAQICEEABif/SaQvad8Lp
1U2SCE0wDQYJKoZIhvcNAQELBQAwSjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEnMCUGA1UEAxMeSWRlblRydXN0IENvbW1lcmNpYWwgUm9vdCBDQSAxMB4XDTIzMDgxNjE5
Mjg0NloXDTMzMDgxMjE5Mjg0NVowOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQDoqfW8senk2X/L7Viky0ZgZYnwlxqsE/vDQWARa1i7gZ0wRJ7ZOWIbjYDccsGFBhCb
8VLx1dershozyPcOizZ1LxAhstZhpz8KvKc4bHhu1+6ZJftmrDyAELLRu1gkPS0BvongGBin
xoTNo0XwafmS67jFRtYHe2VQSLvy0t9xRUsgdEeYgCUAnKO5eRVQMmBBNhnsTFtO5FzNmNKn
uw/TDcBbOpGrQ1FSCuOZTHw3njDtZGqiRXSruX3MCpV190CefwryeGLXCsawSz2wMQZkqtjY
V9Au73Zrqg1yDVj9KGKoRnJ8cUcg1Inxs/+Bo3xcM43y2h10yDrSWFTfvPSQhUJwYKHCYJSV
QLFbeH9vxFJeLlewivaKQMGEg8PpnjevzDu8PVVzr9gkWcLubhztussqdAPF+dvyXIYJb/7l
6idZkS4NeHAsrAtcv+UF+SGzSS5F28s376Kx35LUaJeOW4hQOjSj/118F9cyYAd2WlgGdBda
K2PSvH7aANZQfyEhNNMzk2GP83pHXXeXy+09LkTcIlgXr2rrXepxP+WBp+Ihu4Jh5uZWQkpG
UUNqKSjxIpUJ6sDIIgGIqSY/uBFSp2ff+4OLLS3Z+XQ9gBu1Szd3kQ8PrGXAI5DXayXjM9Yp
psHld3OojXhoOsLdCji+be0mAgvbNa6AaSJcT7RF3QIDAQABo4IB5DCCAeAwEgYDVR0TAQH/
BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsGAQUFBwEBBH0wezAwBggrBgEFBQcw
AYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEcGCCsGAQUFBzAChjto
dHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2NvbW1lcmNpYWxyb290Y2Ex
LnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djBfBgNVHSAEWDBWMFQGBFUd
IAAwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZp
Y2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3Zh
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
--------------ms020308080609080203090606--


