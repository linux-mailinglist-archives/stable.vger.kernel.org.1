Return-Path: <stable+bounces-223250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFuGMp6oqWlSBwEAu9opvQ
	(envelope-from <stable+bounces-223250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:00:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9792150D9
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B74309E297
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1063CB2D3;
	Thu,  5 Mar 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="d5HyHeOO"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51F262BD
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726359; cv=none; b=pEalFNct7nt0qcsHwuaDbZkYxUHvSIQjpkOIK0BmkIhnSRGOLFcywA6FlSdI0Y5j22dJNf7NL7QlfIRM0DciIqGG/4bcX0hd94eunkj+/Sh3hkbo5chi8UXnPhSVtcRl/YrURQsqoVtXlQDhHsomdBxnI4jz5sk5mlSqjXIPDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726359; c=relaxed/simple;
	bh=I1meZNh+BiNepSvnJPVUQy8FDRlcccIhL0PBmHAFLGc=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=UbbfvISYfPla/CK91G3YutwOKSDgBcYS5hsEjwua46ULCIZRayDjogpST+JpPVyjfot0EETPNtOgl6ng7U5u1XjYIi15wr3rl1f5wIUouiDJ2yQYjgqByQt5GFIBcUTut2W3pxR0PYEqqgLBEW0LoK6d7QGOGag0kaNOHkIZ73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=d5HyHeOO; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772726286;
	bh=I1meZNh+BiNepSvnJPVUQy8FDRlcccIhL0PBmHAFLGc=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=d5HyHeOO/RQz6ZtAR2tZcsokPXIWE5Qck0u48iFgTLxnvwfZhRa75ChTDQGicuL8R
	 V6I41ECEV0j3IZ8/IqEHCe5YD9O+p64mpibB8rRCHd0ZuFlUO08k9FujnQhbMxdt4/
	 oxjNkqLpL2SWMdSAnD6aUjMPTCNWG6q6w7AhE/h4=
EX-QQ-RecipientCnt: 5
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSHNwC2Dqd2M/t+aQldaspwowpDBZ8q7ts=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: BwGsXqMA5ZG3nHuPfj/KtL6UnHVnNSKTWKRz1P2EUAU=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1772726284t6d3630ea
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?VGhvcnN0ZW4gTGVlbWh1aXM=?=" <regressions@leemhuis.info>, "=?utf-8?B?cmVncmVzc2lvbnM=?=" <regressions@lists.linux.dev>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Subject: Re: [ REGRESSION v6.6.128 ] build failure on x86 because commit 22e460b6333a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 5 Mar 2026 23:58:03 +0800
X-Priority: 3
Message-ID: <tencent_160637F6605A44E80C18F34B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_1EDDBDC63EFAE9C27849E987@qq.com>
	<2d32f010-787c-4541-9217-9b08df32b1b9@leemhuis.info>
In-Reply-To: <2d32f010-787c-4541-9217-9b08df32b1b9@leemhuis.info>
X-QQ-ReplyHash: 1334635717
X-BIZMAIL-ID: 3163466203530119632
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 05 Mar 2026 23:58:05 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MMnP0fEUKo/h/L8WjTyRZK8rhStyKcaJC54Tumc5nSAakt6Ds2xtD+PH
	yLXALkmktUpmHLHZe5oGzDNqukLAIF7jJ/iyFh4HXCipRKyHEf5ntnjFAD4yXKKTo6XWWVk
	JZAagCWxyeKK+01M9J0rRbYkKHunZCACzVux9Gem0RvA0Cij6XU3gXTNzQHCoV977CT2wDR
	/s5uyJoUh9AXUJRX+QJgJ40p6e4mUFeq2OUe40YwLIXdVOSvSlfJ5lVVpjhdtBkSlF9XK9f
	qqE8LpRgt7U6dX5M/X8p2q4nod4Zu1GcH2D6zZvH9c8bfQ2ttGSOQtX98hFpKA25v1Hy7ET
	pvUu38281PKfwXHsKPs9NGSc8VfzQxkF6WhQu7oEluK8JbLIx8XS6ntW0jR3ZRNSA4GlX3B
	wUrjPfPYcC7dBYF1jjLAY6m18aw9GmB0AkBJ0fBA3yky544iJXlQepaoX8JpYrHG9l4Es0t
	j+7lCfdDgjnHbEG9uE3iZbDkaK2ZRomhnsh1GvEhDleFj0szVKEwi+oph7jajUaFA77lTaj
	bbQboDCoRc6ZRZ1rgUA0VTUYcc4zVhaGSSp7aYv1kDjLcdjrJpudaW8nXXQt/SjHGmw94HW
	s5YHwd7CQsJbpXd6x8dTxOF81WmS/CYYaO6zUk+NpqQnwWCKbhS0pvDyNmAbuddsIgQdCok
	m9siL0W0s+BwteABt5Dy1lRicm0gZaAauV+j4OfAI7VOdShxGzEjIQ/k8dzPUYjGWiI38TB
	40/zeyZOmj9awGayZ36jedv4bZZhOLqP53FcRIfTGP2ejIxd1p41lrmXYYys0bIj3syGymB
	+OuW02z+M6T9rF4ZyVOpixo7NkwUnen7HKQs7LN3rF0v42+yKEjkwokRNoVV2cOgPNFwmMk
	yMqJk+IrdCA96JUzc3VguUsAIS1avNmnezWDMz4Zd/13QlZRJyzL0AITzrG/RTT2KzRtNfN
	SrToMOt5xhaA72tK0FaJpeLv+8szVxGpXw1Q7Ronm34pHI19i3sbMURsP7+xqYxgWl3m5qJ
	adgC7maxA8lXAiV4alaxokoxAfaBk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 3A9792150D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223250-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

VGhhbmtzIGZvciB5b3VyIG5vdGljZSwNCkkgdGVzdGVkIHRoZSB2Ni42LjEyOSBhbmQgdjYu
MTIuNzYgd2l0aCBvdXIgY29uZmlnLA0KdGhlIGJ1aWxkIHByb2JsZW0gaGFzIGJlZW4gc29s
dmVkLg0KDQpCUnMNCldlbnRhbyBHdWFu


