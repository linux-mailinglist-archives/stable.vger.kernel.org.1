Return-Path: <stable+bounces-223201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGtXF2aLqWl3/AAAu9opvQ
	(envelope-from <stable+bounces-223201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 14:55:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15235212DB5
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F96E30A8455
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5B383C8F;
	Thu,  5 Mar 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YmHNMMiF"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DF3822A4
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718842; cv=none; b=XomYuLVIZvhsFAQ0PqLHm+5BE0JXaqoMWYPYSZeu1Q1RfhuL2BhR9q3UHi6tYmAYnwucrQRfV9NlQn7KznffVojLkqYGE/J2dG1W+uQyZqJYwXt7uWxrBvlNbjaeZ6W5DlCHIisBMBa5y41ogsg48EsxPpkyYMRawbV8fSMIVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718842; c=relaxed/simple;
	bh=VHSP+spYBLa4HhS5qAtiZE0EeSkzP6AJGL804lm/pEg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=tGDPyLSGsKmgOL2NaiPthonjplBvCXRWFCftbogvmBOTaHyYPBe0ywBcNpOh5RjBXLMNaexEQNAOIdM1Xd+tO/j7Ro/njBQLDCSHgvWv9tX2Z4CoZHPq5EnCdRCGsko13fWXXGH8uAmg8kWSsQX3JovKFkdm1PPO7DO2q9IVY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YmHNMMiF; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772718795;
	bh=VHSP+spYBLa4HhS5qAtiZE0EeSkzP6AJGL804lm/pEg=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=YmHNMMiFtQ9AZOknAjgxwFl6aK8LrwSD5n95rCammIazyym0nEba2KFoD+fEB8YQE
	 EM455BygjUzxYRQMCk+r5GHZIjT/tzPo6eKLSy/kNtggobnBMlf1VFXd71O9NJQ8Oo
	 27Q3Ie0iUuHXi5Pwynu2LUBxeo27iojlSxhH5EC8=
EX-QQ-RecipientCnt: 4
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSHNwC2Dqd2M/t+aQldaspwowpDBZ8q7ts=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: MXzD4+JBbPK724EJP2iHb2I+jGu86vFU2bo2LKjqPt2H6nzuhHrYSbcW+CjHRmVB
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1772718788t9da881a6
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?cmVncmVzc2lvbnM=?=" <regressions@lists.linux.dev>
Cc: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?c2FzaGFs?=" <sashal@kernel.org>, "=?utf-8?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>
Subject: [ REGRESSION v6.6.128 ] build failure on x86 because commit 22e460b6333a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 5 Mar 2026 21:53:08 +0800
X-Priority: 3
Message-ID: <tencent_1EDDBDC63EFAE9C27849E987@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 8417239797553185690
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 05 Mar 2026 21:53:09 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NGgULbyAgjAdmOJ3bPv9ZjvtY6iUQ9IQoWJxziqHbCG4dHWshjJg41IY
	gbo0k/a5REuI6HU8WC4H6PJfMZxGtAqNwKHwjeTB58vEPOLEPalGQC7GEs+et4f0MoVjwyQ
	CZHqWWQ3ds93NMVYoZpSGUMbYKzCvzQTG7rErqhZQnvTjAgQwz+6DoH5LbtSJ5mIXY6WqRs
	QeFuZnK5uXllDX4Q1q2cLrz00uLP4UiYItYQ4Px0QY2aOdxuRyMOPN8BOsvSkStHf4vNuWI
	e1Uo9LOJtvMsHftmB/PglMBfBRh53q1oh8bUv/oeT4wQduWzGjiF90cV67L3+LJ2XXFcwXz
	4Sek2bVAHus5s3ikKHF7x4bhhhbuHq3Rzb5rw+drzJg072vNFcWaX2PAR914FC8D+I+OXIc
	QhTN4m6hxHlBpFECNW6QyKWNpDMjG7DSRvfhj0AAud4ZPrKjGkl1LHg8EHnn+g88zIBtoCp
	2RHW5UykS9PWQnf+S+6OdQ+PWx1IvgTr7fdSWNDKV2Kqhtl6O3W5LcMxfnetHQ+pDA3G0Nw
	tPXiwqbpOV+60+y849Y97+JyLW1xkUqmAimtrbc0czlSU6o9Ng0hX75GgG6C0y9Ch35CRHy
	0IST0kwYWB5Nb/WDn0j31G5Fh4oUjLBPGB//RDTiq5VEyoKdEnLA1xUygAwSE2/UDQ/iBdH
	un4chTUDandouy5wJK9pt45RYze0KaDT98untJhJhnDOLFr3F8OpSUg5AtAPSP/3+3htDcu
	Q+Hlfc+9e9LbkNEBWK0NIBfymgrFG+zreQiRmRTvG4L6CPXNC0fONrQWTv1aFqwdl+tJk25
	zxvzYr+AYg24soADcLO7z1YNafLydE4v/XKiC9Bl44zlBkHgnUfDQwhmtzvJuVUjsR1578d
	VuX66huX+D3YHEAGmYNpHkL52ImohrOlmpb/XfB5W/nyZs5ZShTFnWmdWXl92Z88bOdj2rY
	eVWZDWqDgFZo70xS2BYW4PqqxDdNsYZv4Y6t2+kcKA8hYc7fNjS1OOkTE+D2EE0Tnwa1IVz
	KVRQ2vhGnhRRK27s+Hl9H5w8YO5guS5PFg6X8Ava2GpGJExM6vYIULx6rWGj6v7W6tD4CNC
	xNmad7X8gyYuRWENUow4yDOT5U5pfFaFzVa8i1L8qDf2kqAcoRflJ4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 15235212DB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223201-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,qq.com:mid]
X-Rspamd-Action: no action

RGVhciBBbGwsDQoNCnVwZ3JhZGUgdG8gdjYuNi4xMjgsIGJ1aWxkIGZhaWwgaW4geDg2IHdp
dGggb3VyIGNvbmZpZyB3aXRoIHRoZSBjb21taXQ6DQpnaXQgc2hvdyAyMmU0NjBiNjMzM2E1
ZjgxOGIwNDJhYzg5MjAxZjhlNzM1NTU2ZjRhDQpjb21taXQgMjJlNDYwYjYzMzNhNWY4MThi
MDQyYWM4OTIwMWY4ZTczNTU1NmY0YQ0KQXV0aG9yOiBIYXJzaGl0IE1vZ2FsYXBhbGxpIDxo
YXJzaGl0Lm0ubW9nYWxhcGFsbGlAb3JhY2xlLmNvbT4NCkRhdGU6ICAgVHVlIERlYyAzMCAy
MjoxNjowOSAyMDI1IC0wODAwDQoNCiAgICB4ODYva2V4ZWM6IGFkZCBhIHNhbml0eSBjaGVj
ayBvbiBwcmV2aW91cyBrZXJuZWwncyBpbWEga2V4ZWMgYnVmZmVyDQogICAgDQogICAgWyBV
cHN0cmVhbSBjb21taXQgYzU0ODlkMDQzMzdiNDdlOTNjMDYyM2U4MTQ1ZmNiYTNmNTczOWVm
ZCBdDQoNCkJScw0KV2VudGFvIEd1YW4NCg0KY29uZmlnOg0KaHR0cHM6Ly9naXN0LmdpdGh1
Yi5jb20vb3BzaWZmLzQzNDNjMDdiNTU2OTc4MzdmODE2YzcwNjMwOTUxMGMxDQoNCkxvZzoN
CmFyY2gveDg2L2tlcm5lbC9zZXR1cC5jOiBJbiBmdW5jdGlvbiDigJhpbWFfZ2V0X2tleGVj
X2J1ZmZlcuKAmToNCmFyY2gveDg2L2tlcm5lbC9zZXR1cC5jOjM4MDoxNTogZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGltYV92YWxpZGF0ZV9yYW5nZeKA
mSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCiAgMzgwIHwgICAg
ICAgICByZXQgPSBpbWFfdmFsaWRhdGVfcmFuZ2UoaW1hX2tleGVjX2J1ZmZlcl9waHlzLCBp
bWFfa2V4ZWNfYnVmZmVyX3NpemUpOw0KICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fg0KICBDQyBbTV0gIGZzL3pvbmVmcy9maWxlLm8=


