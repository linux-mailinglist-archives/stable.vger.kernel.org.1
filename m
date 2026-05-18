Return-Path: <stable+bounces-249168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vFw3A6B4CmqF1wQAu9opvQ
	(envelope-from <stable+bounces-249168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:25:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675905650D2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0938A302F73B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6FF3537FD;
	Mon, 18 May 2026 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GZchvjGj"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD134252B;
	Mon, 18 May 2026 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071004; cv=none; b=hlxxf2+oxnZ3uISSw/eILfHnacsVgafkMiV53mszAe/CUpDKs8YG5J+OgTJFYwzMesEa6SaMKRLcAR9+/xWxHHUvN3rBTNwPiqK6fT3ytIec7e39yJs1yPBdwYawKuUhhT59g22hN0iozj3tHl0HHDCJgBDzn/0OsHZv97e0ILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071004; c=relaxed/simple;
	bh=I1Op4CwLvDbWIxcfGkebHPCoScSMbOGQXbJlutSUWLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=fdqX10Ii3TeCBW9irzY78YzVckq3gZYA3QXPsOSQ09/QpBgzfbj3rgJdHkI92iOtunHJb3Z8Z2j5CCWkmkOtTIj4dnuEyWi6M1JVpP6eMzNBiOi+T/lehQlVeoqHpRf34L/egDOBCG+2Cg4qk5XWl5ewdiXGuL4tgJDZbvUlihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GZchvjGj; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=I1Op4CwLvDbWIxcfGkebHPCoScSMbOGQXbJlutSUWLw=; b=G
	ZchvjGjEUjNMgjm0EKvFdbKrojaawiOgvfPLt20HWnQRV4yBEg7UirjEu1YIcc31
	rixtwA00BILuL0yCHiB+qRHja3+aX8hRPmtcQEm/LOsncrs7kDyUVJ/xZZPgyPam
	U1rA5+D+q6yDRGYHSZAQFa7uItNR3A1YkHbxsaf5xQ=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-124 (Coremail) ; Mon, 18 May 2026 10:22:15 +0800
 (CST)
Date: Mon, 18 May 2026 10:22:15 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
	melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank
 disable and timer callback
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <2026051633-skyward-parrot-cdd3@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
 <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
 <2026051633-skyward-parrot-cdd3@gregkh>
X-NTES-SC: AL_Qu2cC/ycv0Eo4yCbZukfmU0Qguw9Xcq5uPkj34FWN5t8jAvp5C0KcnBkF0HIze+BMCOAuyS4cSFE6/lLUql7RY0zMjg6SCYDH/nzU6ccMpk01w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <397754a7.224c.19e38e42006.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fCgvCgDXlyfXdwpqSjKhAA--.648W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4xcwFGoKd9eYxgAA3O
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Queue-Id: 675905650D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249168-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action

CgpBdCAyMDI2LTA1LTE2IDE3OjUxOjU5LCAiR3JlZyBLSCIgPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPiB3cm90ZToKPlRoZXJlIGlzIG5vICJtaW5pbWFsLXJpc2sgcG9saWN5IGZvciBzdGFi
bGUgdHJlZXMiLiAgQW5kIGlmIHRoZXJlIHdhcywKPnRoZSBsZWFzdCBhbW1vdW50IG9mIHJpc2sg
d291bGQgYmUgdG8gdGFrZSB0aGUgcmV2aWV3ZWQgYW5kIHRlc3RlZAo+cGF0Y2hlcyB0aGF0IGFy
ZSBhbHJlYWR5IGluIExpbnVzJ3MgdHJlZSwgYW5kIE5PVCB0YWtlIGFueXRoaW5nIHRoYXQgaXMK
Pm5vdCBhbHJlYWR5IHRoZXJlLCBhcyA5MCUgb2YgdGhlIHRpbWUgdGhhdCB3ZSBkbyB0aGF0LCBp
dCBjb21lcyBiYWNrIHRvCj5iaXRlIHVzIGhhcmQuCj4KPlNvIHBsZWFzZSwganVzdCBiYWNrcG9y
dCBhbGwgdGhlIG5lZWRlZCBjaGFuZ2VzIGhlcmUuICBPdGhlcndpc2UgaG93IGFyZQo+d2UgZ29p
bmcgdG8gZGVhbCB3aXRoIHRoZSBtZXJnZSBjb25mbGljdHMgZm9yIHRoZSBuZXh0IDQgeWVhcnMg
aW4gdGhpcwo+ZmlsZT8KPgo+T3IsIGdldCB0aGUgbWFpbnRhaW5lcnMgb2YgdGhpcyBmaWxlIHRv
IGFncmVlIGFuZCByZXZpZXcgdGhpcyBvbmUtb2ZmCj5jaGFuZ2UgdGhhdCBpdCBpcyBhY2NlcHRh
YmxlLiAgQXMgdGhleSBhcmUgZ29pbmcgdG8gYmUgdGhlIG9uZXMgZ2V0dGluZwo+dGhlIGJ1ZyBy
ZXBvcnRzIGFuZCBub3QgaGF2aW5nIHRoZWlyIHBhdGNoZXMgYXBwbGllZCBvdmVyIHRoZSB5ZWFy
cywgbm90Cj5hbnlvbmUgZWxzZSA6KQoKSGkgR3JlZywKCkdvdCBpdC4gQWZ0ZXIgbG9va2luZyBk
ZWVwZXIgaW50byB0aGUgZGVwZW5kZW5jeSBjaGFpbiwgYmFja3BvcnRpbmcgdGhlIG1haW5saW5l
IGNvbW1pdCAoMDJlMjY4MWZmZTFhKSB3b3VsZCBpbmRlZWQgcmVxdWlyZSBwdWxsaW5nIGluIHRo
ZSBlbnRpcmUgbmV3IERSTSBnZW5lcmljIHZibGFuayB0aW1lciBpbmZyYXN0cnVjdHVyZSB0byA2
LjE4LnkuIAoKVGhhdCBzY29wZSBpcyBqdXN0IHRvbyBsYXJnZSBhbmQgY29tcGxleCBmb3IgdGhp
cyBzcGVjaWZpYyBpc3N1ZS4gU2luY2UgYSBvbmUtb2ZmIHBhdGNoIGlzIG5vdCB0aGUgcmlnaHQg
YXBwcm9hY2ggZWl0aGVyLCBJIHdpbGwganVzdCBkcm9wIHRoaXMgcGF0Y2ggYW5kIGFiYW5kb24g
dGhlIGJhY2twb3J0IGVmZm9ydCBmb3IgNi4xOC55LgoKVGhhbmtzIGZvciB5b3VyIHRpbWUgYW5k
IHRoZSBxdWljayByZXZpZXcuCgpUaGFua3MsCk1pbmd5dQoK

