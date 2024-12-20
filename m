Return-Path: <stable+bounces-105396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887AE9F8D2D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 08:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D589163D48
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 07:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568941A840E;
	Fri, 20 Dec 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bYPbdfFr"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB761A83F5
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679393; cv=none; b=AkJ10fTo2yne0IygFuHqnto2k/cN9AkehfJxtuj+XlLwYIK4hmVhxVp5i0tSoDcfh0f2Edbvf8bT9H/bMFZZFoiqtcMPPPWNyd/jZx9uuAlydxNZH94lO7I+UY4jYiPXTycHDoSNe1/S1K92uqRqr50DTsk1a7mUYDt4g1Z1Z7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679393; c=relaxed/simple;
	bh=g0iuGFdA/H/46B1uyj3RgnvtcGbmHZotQLduJXrQf4Y=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=to1MGvfhZvGSpR26Hcram0kK3NgLtqdZp2hlQn25TjIInQlMDko71Nm7gQKufFQd5tJc5jUc7Zq1J38bd/dAyiXwMYgrN50X8GYTS4LrIHMhlXaH0LqIDjqowlM8C10LRdY0bxMQRFgBPU4cj478sqkcgYHhtJsj3LS/d49BNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bYPbdfFr; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID:
	Content-Type; bh=g0iuGFdA/H/46B1uyj3RgnvtcGbmHZotQLduJXrQf4Y=;
	b=bYPbdfFrm4h3hpgdRwq7Z9ZRk4fv7o5XnmDN7z6Xu1/0aw/L4J4bIYDPmf3lQa
	eMc3x7dETmXwbR4a/lQDntF1GBvfdVnXo8i0OdKLVWjZqGJHhIpUHhUc7XgTRSic
	GtHrTlXE604zzOIbB39bpRekFN0SXbKigkVO07lCyYh+I=
Received: from ccc-pc (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAXBNw+G2VnSdi5AQ--.28416S2;
	Fri, 20 Dec 2024 15:22:40 +0800 (CST)
Date: Fri, 20 Dec 2024 15:22:39 +0800
From: "ccc194101@163.com" <ccc194101@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: jpoimboe <jpoimboe@kernel.org>, 
	peterz <peterz@infradead.org>, 
	stable <stable@vger.kernel.org>, 
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: Re: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs noreturns.
References: <20241218212707.zjli7be5qtamdfkx@jpoimboe>, 
	<20241219055157.2754232-1-ccc194101@163.com>, 
	<20241219225859.fw6qugbyoagrx63a@jpoimboe>, 
	<20241219225937.7jjii4kg4hc3d5rm@jpoimboe>, 
	<202412200927046763162@163.com>, 
	<2024122027-reexamine-wrist-fdbe@gregkh>
X-Priority: 3
X-GUID: 2EC2F596-B019-4728-968B-A4A1A627F666
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.317[cn]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202412201522381762344@163.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:_____wAXBNw+G2VnSdi5AQ--.28416S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUenmRDUUUU
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiTRa73mdlFh2e1wAAs+

Pk9uIEZyaSwgRGVjIDIwLCAyMDI0IGF0IDA5OjI3OjA2QU0gKzA4MDAsIGNjYzE5NDEwMUAxNjMu
Y29tIHdyb3RlOgoKCj4+ID5BbHNvLCBpZiBpdCdzIGZvciB1cHN0cmVhbSwgcGxlYXNlIGNjIGxr
bWwuCgoKCj4+IAoKCgo+PiAKCgoKPj4gTWF5IEkgYXNrIHdoYXQgaXMgTEtNTCdzIGVtYWlsIGFk
ZHJlc3MKCgoKPgoKCgo+UGxlYXNlIHVzZSB0aGUgdG9vbCwgc2NyaXB0cy9nZXRfbWFpbnRhaW5l
ci5wbCB3aGljaCB3aWxsIHNob3cgeW91IGhvdwoKCgo+dG8gZG8gdGhpcy7CoCBBbHNvLCB0aGVy
ZSBpcyBhIGdyZWF0ICJob3cgdG8gd3JpdGUgYSBmaXJzdCBrZXJuZWwgcGF0Y2giCgoKCj50dXRv
cmlhbCBhdCBrZXJuZWxuZXdiaWVzLm9yZyB0aGF0IHlvdSBwcm9iYWJseSBzaG91bGQgZ28gdGhy
b3VnaCBmaXJzdAoKCgo+YXMgd2VsbC4KCgoKPgoKCgo+Z29vZCBsdWNrIQoKCgo+CgoKCj5ncmVn
IGstaAoKCgpUaGFua3MhCgotLS0tLS0tLS0tLS0tLQoKQ2hhbmdjaGVuZyBDaGVu


