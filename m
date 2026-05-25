Return-Path: <stable+bounces-254069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOmKKl3KE2rFFwcAu9opvQ
	(envelope-from <stable+bounces-254069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:04:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC25C59E1
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A77F300A748
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ED4306B3D;
	Mon, 25 May 2026 04:04:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out198-45.us.a.mail.aliyun.com (out198-45.us.a.mail.aliyun.com [47.90.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C328E0;
	Mon, 25 May 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779681877; cv=none; b=InwxUKcFee082yA/oODd/K71M05z9PEeRhDVYAu7KjnIkTiidFFAmz3abOR62hzI+dT0yT6MZYrucA20OTUivU3fRSdd/y7MSrIeT+DBQlZL13ZlIbqEl+0aMoH1jtdOTplN6+gaCZMPr1xXYwW53nPedE3x3oFlqMXEMrXVFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779681877; c=relaxed/simple;
	bh=HE9U58GZgMIjnm0OatsP8ZOy28V7bEY4DNb7XNlex9g=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=Yhkrp2asr+UgdTvAiklfJXwmMw7a81/HJrGziheqkAos/qnPPmU4uZaGLtp1NGE30cfKhjFPVFmmIqH772IEdHtSye1HDsiXz4Ntm4l9TlZ7VBKi7PytAN+7bDEUKTbOE41AOdI68uy97N1oDITtQKcjrku6YFPlRnpyH3k4ToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1609595|-1;BR=01201311R121S07rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0148758-0.000317564-0.984807;FP=3739503386867361111|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=zhang_wei@open-hieco.net;NM=1;PH=DW;RN=7;RT=7;SR=0;TI=W4_0.2.3_0B53580D_1779681078360_o7001c199k;
Received: from WS-web (zhang_wei@open-hieco.net[W4_0.2.3_0B53580D_1779681078360_o7001c199k] cluster:ay29) at Mon, 25 May 2026 11:58:49 +0800
Date: Mon, 25 May 2026 11:58:49 +0800
From: "=?UTF-8?B?5byg5beN?=" <zhang_wei@open-hieco.net>
To: "Sean Christopherson" <seanjc@google.com>
Cc: "kvm" <kvm@vger.kernel.org>,
  "pbonzini" <pbonzini@redhat.com>,
  "mlevitsk" <mlevitsk@redhat.com>,
  "naveen" <naveen@kernel.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "stable" <stable@vger.kernel.org>
Reply-To: "=?UTF-8?B?5byg5beN?=" <zhang_wei@open-hieco.net>
Message-ID: <b4dd2e22-2364-40ed-a06f-4082adb309d1.zhang_wei@open-hieco.net>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gS1ZNOiBTVk06IERpc2FibGUgQVZJQyBJUEkgdmlydHVhbGl6YXRpb24g?=
  =?UTF-8?B?b24gSHlnb24gRmFtaWx5IDE4aCAoZXJyYXR1bSAjMTIzNSk=?=
X-Mailer: [Alimail-Mailagent revision 57][W4_0.2.3][null][Unknown]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <ahBScosf2jUlKdAt@google.com>
x-aliyun-mail-creator: W4_0.2.3_null_MC4YXhpb3MvMC4yNy4y3M
In-Reply-To: <ahBScosf2jUlKdAt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [2.14 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254069-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[open-hieco.net];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	NEURAL_SPAM(0.00)[0.004];
	HAS_REPLYTO(0.00)[zhang_wei@open-hieco.net];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang_wei@open-hieco.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 07DC25C59E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCBNYXkgMjIsIDIwMjYsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cj4gSUlVQywg
ZmFtaWx5IDE4aCBpcyBjYXJ2ZWQgb3V0IGVudGlyZWx5IGZvciBIeWdvbiwgY29ycmVjdD8gIEku
ZS4KPiB0aGVyZSdzIG5vIHJpc2sgb2YgZGlzYWJsaW5nIElQSSB2aXJ0dWFsaXphdGlvbiBvbiB1
bmFmZmVjdGVkIEFNRCBDUFVzPwoKWWVzLCB0aGF0IGlzIG15IHVuZGVyc3RhbmRpbmcuCgpUaGUg
b3JpZ2luYWwgSHlnb24gZW5hYmxlbWVudCBbMV0gdXNlcyBGYW1pbHkgMThoIHRvZ2V0aGVyIHdp
dGggdGhlCkh5Z29uR2VudWluZSB2ZW5kb3IgSUQgdG8gZGlzdGluZ3Vpc2ggSHlnb24gRGh5YW5h
IGZyb20gQU1EIEZhbWlseSAxN2gsCmFuZCBleHBsaWNpdGx5IHN0YXRlcyB0aGF0IG9ubHkgSHln
b24gaXMgZXhwZWN0ZWQgdG8gdXNlIEZhbWlseSAxOGguICBTbwp0aGlzIHNob3VsZCBub3QgYWZm
ZWN0IHVuYWZmZWN0ZWQgQU1EIENQVXMuCgpJIGNhbiBhZGQgYW4gWDg2X1ZFTkRPUl9IWUdPTiBj
aGVjayB0b28gaWYgeW91IHByZWZlciBtYWtpbmcgdGhlCmRlcGVuZGVuY3kgZXhwbGljaXQuCgpb
MV0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzc2NDQ4MS8KClRoYW5rcywKVGluYQ==

