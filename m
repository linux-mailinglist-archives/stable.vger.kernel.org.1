Return-Path: <stable+bounces-120367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C9A4EC9D
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 20:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544028E353C
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F52E3394;
	Tue,  4 Mar 2025 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="q6wpYuBZ"
X-Original-To: stable@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8712E3364
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110795; cv=pass; b=IMSk890326gq+OZlwzH72ZQ27L3szsJXFcy8Y1wTBdnebsigwrZKxFLLuY6pIeXoS1Dqn3QGKhYxFP3q49hlxIUWET/vYkAWp89FBSIMZQTp8lpPXoSLPELWwbc80ngjFvyVb/WVI/A40A/SX/0nI94z+jXqbn1qx3q1LMhhpyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110795; c=relaxed/simple;
	bh=UK/tA22zmyaxSkT4eckr4JBqqqNE2ElQdzBIYYiXgYM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yhjdbg+Kx7ExTGWWSDfkUzuBeOtaPshcgKdEtziKr4776N6KFiZrjf59/my85dUfnypHoQ9JISY+7bW8IPHB0Ax0FyqbON5RQBA1q4Lwp5YjtkCGkjzKJCaV+W9gsUx1mxgPL0X1N6XsILsOuzb+TNPW8IpFmR65FrBSwB8QMgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=q6wpYuBZ; arc=none smtp.client-ip=193.201.238.219; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id C966440D9770
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 20:53:11 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=diehl.com header.i=@diehl.com header.a=rsa-sha256 header.s=default header.b=q6wpYuBZ
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fg75XzhzG0QC
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 18:26:59 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 95AD54274D; Tue,  4 Mar 2025 18:26:51 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=q6wpYuBZ
X-Envelope-From: <linux-kernel+bounces-541119-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=q6wpYuBZ
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 729C542B7F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:05:43 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 505852DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:05:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446111892BD1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3436D1EEA3C;
	Mon,  3 Mar 2025 08:05:25 +0000 (UTC)
Received: from enterprise01.smtp.diehl.com (enterprise01.smtp.diehl.com [193.201.238.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DF1E9B3C;
	Mon,  3 Mar 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989121; cv=none; b=G1kRiymyb075BWsd9nT7y7sFqWvkg4obUpyQCiTak9QDzTAFJJj4O6tJEjDYV6YRWZzTBYwklCnQ4/huD3mKxJa1KzHQOW4twuOFhtm3eZIJiWmjG6KlEdYUhtVTZUn7JSVQTYKOprRnpDHjVynMLMMplJYPrjyVxezxencijEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989121; c=relaxed/simple;
	bh=UK/tA22zmyaxSkT4eckr4JBqqqNE2ElQdzBIYYiXgYM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jJIYpfe/q9Epg6+Xp9kH1fDFLaboXCl/l6hPtyXCeiBjbZJlKlQUucaS2OB4xCAYkPUOiXjUsh5QHSLsaXw9GTaSrJf1X0sBjJy2qYxOfowBSexKqoB7bD8NAcQRF0OKMlbs/JBe1Iz7dJtBXjaJTajEnpkYXyVW95nLBiRMvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=q6wpYuBZ; arc=none smtp.client-ip=193.201.238.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1740989119; x=1772525119;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=UK/tA22zmyaxSkT4eckr4JBqqqNE2ElQdzBIYYiXgYM=;
  b=q6wpYuBZwCP176LD8Nf1d8/9xU5Dud6sEMPBCofG7j7bLGka1ilNJI+D
   vMl9QtBYxmvnlPcpMR5NJ3Hys4ePtXwudyYnyVg5dBisv2EqRf7ewwEWh
   muRJ12G6V3i2Nu4sZ0gKCBhjL6I3WaLipS4MQHm8/2NE6M42O/Kd06jOL
   hSG71fZzrPNE3D6ZWIxbN0qC5cfs8lz5Q0ZgYE/jacJDI2pdN1uNwbQLM
   6UfxOwFRut9yz9K7KlzUVrXpJwvguS+KmlbLdZb4mBBpZlg6wwduvAnHd
   9a5XRskF/MEZ+ARDIFa7KLWB/yoSYElSrlzxG5tFjTHMaiYxsjgPveO6g
   g==;
X-CSE-ConnectionGUID: 9bLDDy9JSmilP2KQQCS5Cw==
X-CSE-MsgGUID: DCldqlNpSfKkBLJ6Fxr7zw==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:3Ici+a9nbHVqbu7qVlsbDrUDg3+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 GoXCG3XOfqKZzb3ed8jO4XjoR5TsMDdm9djS1FuqisxFiIbosf7XtnIdU2Y0wF+jCHgZB89s
 59OOoGowOQcFCK0SsKFa+C5xZVE/fjWAOK6UKicZ3wZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvnrRC9H5qyo5WtD5gdmPJingXeF/5UrJMNGTU2OByugKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAb+0Teeo5iXBYtQR8/Zwehxrid+
 /0U3XCEcjrFC4WX8Agrv7u0JAklVUFO0OevzXFSKqV/xWWeG5fn660G4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr7O85J6XW7hOvcEiKPGxH7omkUo95i6MWJ7KQbibK0nLzeVz8Bx1o+lvOa2GI
 cEecyIpYBXNYxkJMVASYH48tL7wwCCiKHsD7gvO/cLb4ECKpOB1+LTgNtvOPNuRWchPmk+eq
 krK/mn5BlcRM9n3JT+tqyvw17GXxnqlMG4UPJGT8vJzhHuL/WIwCzcydwWVsePmmFHrDrqzL
 GRRoELCt5Ma+02sS9ThQxyQrXiCsxMaXdcWGOo/gCmJy6zJ80OaC3ICQzppdtMrrok1SCYs2
 1vPmMnmbRR0rLSfTX+16LiZt3WxNDITIGtEYjULJTbp+PG6+Mdq00mJFZA6S/bdYsDJJAwcC
 gui9EAW74j/R+ZRv0ln1TgrWw6Rm6U=
IronPort-HdrOrdr: A9a23:9tqQW6O3I1ERDcBcTjejsMiBIKoaSvp037By7TEVdfRUGvb2qy
 ncpoV+6faSskdqZJhAo6H6BEDuewK+yXcY2+Qs1NSZLXTbUQmTXeNfBOLZqlWKcREWndQy6U
 4USchD4arLbGSS4/yX3CCIV/gK+p2/y4aD7N2us0tFfEVFQJsl1jxeICW8OSRNNXZ77NECZf
 2hD4J81lydUGVSY8SgDHwMX+zOvMTRkpjrewQLCnccmXGzZB2TmcfHLyQ=
X-Talos-CUID: 9a23:FMK4PGyOOQxYopXpLCnUBgVFEOQJXmyM7kzVIkuAU0VQcZauFHSPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AzMAKFw96bZxEDlk81xz5s+uQf+tD56i3DGYVqps?=
 =?us-ascii?q?luOOgF3JeKy3CniviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="114960316"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] pps: fix poll support
Thread-Topic: [PATCH] pps: fix poll support
Thread-Index: AduMEuWWjZq5gVT8TFeQQ5VVonTADA==
Date: Mon, 3 Mar 2025 08:05:16 +0000
Message-ID: <1685f34c60384aadab4f87ffb3303755@diehl.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimerprocessed: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GBS-PROC: JH31JkgOAVpzNaKNEwNMTZD10pQpBCF/FwmdsWj+MxeMaScRc3cd0m42Vjc9X9Nt
X-GBS-PROCJOB: V0DzXfKTxAGyax/Zn/Lb7c/WcXd6SeP58GoaHo6Kh3wB/dxpQyMKb+Zx2kQ3+2Wq
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fg75XzhzG0QC
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715472.81@UzbNVbjA7o20ZY50shlh8A
X-ITU-MailScanner-SpamCheck: not spam

W0JVR10NCkEgdXNlciBzcGFjZSBwcm9ncmFtIHRoYXQgY2FsbHMgc2VsZWN0L3BvbGwgZ2V0IGFs
d2F5cyBhbiBpbW1lZGlhdGUgZGF0YQ0KcmVhZHktdG8tcmVhZCByZXNwb25zZS4gQXMgYSByZXN1
bHQgdGhlIGludGVuZGVkIHVzZSB0byB3YWl0IHVudGlsIG5leHQNCmRhdGEgYmVjb21lcyByZWFk
eSBkb2VzIG5vdCB3b3JrLg0KDQpVc2VyIHNwYWNlIHNuaXBwZXQ6DQoNCiAgICBzdHJ1Y3QgcG9s
bGZkIHBvbGxmZCA9IHsNCiAgICAgIC5mZCA9IG9wZW4oIi9kZXYvcHBzMCIsIE9fUkRPTkxZKSwN
CiAgICAgIC5ldmVudHMgPSBQT0xMSU58UE9MTEVSUiwNCiAgICAgIC5yZXZlbnRzID0gMCB9Ow0K
ICAgIHdoaWxlKDEpIHsNCiAgICAgIHBvbGwoJnBvbGxmZCwgMSwgMjAwMC8qbXMqLyk7IC8vIHJl
dHVybnMgaW1tZWRpYXRlLCBidXQgc2hvdWxkIHdhaXQNCiAgICAgIGlmKHJldmVudHMgJiBFUE9M
TElOKSB7IC8vIGFsd2F5cyB0cnVlDQogICAgICAgIHN0cnVjdCBwcHNfZmRhdGEgZmRhdGE7DQog
ICAgICAgIG1lbXNldCgmZmRhdGEsIDAsIHNpemVvZihtZW1kYXRhKSk7DQogICAgICAgIGlvY3Rs
KFBQU19GRVRDSCwgJmZkYXRhKTsgLy8gY3VycmVudGx5IGZldGNoZXMgZGF0YSBhdCBtYXggc3Bl
ZWQNCiAgICAgIH0NCiAgICB9DQoNCltDQVVTRV0NCnBwc19jZGV2X3BvbGwoKSByZXR1cm5zIHVu
Y29uZGl0aW9uYWxseSBFUE9MTElOLg0KDQpbRklYXQ0KUmVtZW1iZXIgdGhlIGxhc3QgZmV0Y2gg
ZXZlbnQgY291bnRlciBhbmQgY29tcGFyZSB0aGlzIHZhbHVlIGluDQpwcHNfY2Rldl9wb2xsKCkg
d2l0aCBtb3N0IHJlY2VudCBldmVudCBjb3VudGVyDQphbmQgcmV0dXJuIDAgaWYgdGhleSBhcmUg
ZXF1YWwuDQoNClNpZ25lZC1vZmYtYnk6IERlbmlzIE9TVEVSTEFORC1IRUlNIDxkZW5pcy5vc3Rl
cmxhbmRAZGllaGwuY29tPg0KQ28tZGV2ZWxvcGVkLWJ5OiBSb2RvbGZvIEdpb21ldHRpIDxnaW9t
ZXR0aUBlbm5lZW5uZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSb2RvbGZvIEdpb21ldHRpIDxnaW9t
ZXR0aUBlbm5lZW5uZS5jb20+DQpGaXhlczogZWFlOWQyYmEwY2ZjICgiTGludXhQUFM6IGNvcmUg
c3VwcG9ydCIpDQpDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDUuNCsNCi0tLQ0KIGRyaXZl
cnMvcHBzL3Bwcy5jICAgICAgICAgIHwgMTEgKysrKysrKysrLS0NCiBpbmNsdWRlL2xpbnV4L3Bw
c19rZXJuZWwuaCB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bwcy9wcHMuYyBiL2RyaXZlcnMv
cHBzL3Bwcy5jDQppbmRleCA2YTAyMjQ1ZWEzNWYuLjk0NjMyMzJhZjhkMiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvcHBzL3Bwcy5jDQorKysgYi9kcml2ZXJzL3Bwcy9wcHMuYw0KQEAgLTQxLDYgKzQx
LDkgQEAgc3RhdGljIF9fcG9sbF90IHBwc19jZGV2X3BvbGwoc3RydWN0IGZpbGUgKmZpbGUsIHBv
bGxfdGFibGUgKndhaXQpDQoNCiBwb2xsX3dhaXQoZmlsZSwgJnBwcy0+cXVldWUsIHdhaXQpOw0K
DQoraWYgKHBwcy0+bGFzdF9mZXRjaGVkX2V2ID09IHBwcy0+bGFzdF9ldikNCityZXR1cm4gMDsN
CisNCiByZXR1cm4gRVBPTExJTiB8IEVQT0xMUkROT1JNOw0KIH0NCg0KQEAgLTE4Niw5ICsxODks
MTEgQEAgc3RhdGljIGxvbmcgcHBzX2NkZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsDQogaWYg
KGVycikNCiByZXR1cm4gZXJyOw0KDQotLyogUmV0dXJuIHRoZSBmZXRjaGVkIHRpbWVzdGFtcCAq
Lw0KKy8qIFJldHVybiB0aGUgZmV0Y2hlZCB0aW1lc3RhbXAgYW5kIHNhdmUgbGFzdCBmZXRjaGVk
IGV2ZW50ICAqLw0KIHNwaW5fbG9ja19pcnEoJnBwcy0+bG9jayk7DQoNCitwcHMtPmxhc3RfZmV0
Y2hlZF9ldiA9IHBwcy0+bGFzdF9ldjsNCisNCiBmZGF0YS5pbmZvLmFzc2VydF9zZXF1ZW5jZSA9
IHBwcy0+YXNzZXJ0X3NlcXVlbmNlOw0KIGZkYXRhLmluZm8uY2xlYXJfc2VxdWVuY2UgPSBwcHMt
PmNsZWFyX3NlcXVlbmNlOw0KIGZkYXRhLmluZm8uYXNzZXJ0X3R1ID0gcHBzLT5hc3NlcnRfdHU7
DQpAQCAtMjcyLDkgKzI3NywxMSBAQCBzdGF0aWMgbG9uZyBwcHNfY2Rldl9jb21wYXRfaW9jdGwo
c3RydWN0IGZpbGUgKmZpbGUsDQogaWYgKGVycikNCiByZXR1cm4gZXJyOw0KDQotLyogUmV0dXJu
IHRoZSBmZXRjaGVkIHRpbWVzdGFtcCAqLw0KKy8qIFJldHVybiB0aGUgZmV0Y2hlZCB0aW1lc3Rh
bXAgYW5kIHNhdmUgbGFzdCBmZXRjaGVkIGV2ZW50ICAqLw0KIHNwaW5fbG9ja19pcnEoJnBwcy0+
bG9jayk7DQoNCitwcHMtPmxhc3RfZmV0Y2hlZF9ldiA9IHBwcy0+bGFzdF9ldjsNCisNCiBjb21w
YXQuaW5mby5hc3NlcnRfc2VxdWVuY2UgPSBwcHMtPmFzc2VydF9zZXF1ZW5jZTsNCiBjb21wYXQu
aW5mby5jbGVhcl9zZXF1ZW5jZSA9IHBwcy0+Y2xlYXJfc2VxdWVuY2U7DQogY29tcGF0LmluZm8u
Y3VycmVudF9tb2RlID0gcHBzLT5jdXJyZW50X21vZGU7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9wcHNfa2VybmVsLmggYi9pbmNsdWRlL2xpbnV4L3Bwc19rZXJuZWwuaA0KaW5kZXggYzdh
YmNlMjhlZDI5Li5hYWIwYWViYjUyOWUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3Bwc19r
ZXJuZWwuaA0KKysrIGIvaW5jbHVkZS9saW51eC9wcHNfa2VybmVsLmgNCkBAIC01Miw2ICs1Miw3
IEBAIHN0cnVjdCBwcHNfZGV2aWNlIHsNCiBpbnQgY3VycmVudF9tb2RlOy8qIFBQUyBtb2RlIGF0
IGV2ZW50IHRpbWUgKi8NCg0KIHVuc2lnbmVkIGludCBsYXN0X2V2Oy8qIGxhc3QgUFBTIGV2ZW50
IGlkICovDQordW5zaWduZWQgaW50IGxhc3RfZmV0Y2hlZF9ldjsvKiBsYXN0IGZldGNoZWQgUFBT
IGV2ZW50IGlkICovDQogd2FpdF9xdWV1ZV9oZWFkX3QgcXVldWU7LyogUFBTIGV2ZW50IHF1ZXVl
ICovDQoNCiB1bnNpZ25lZCBpbnQgaWQ7LyogUFBTIHNvdXJjZSB1bmlxdWUgSUQgKi8NCi0tDQoy
LjQ3LjINCkRpZWhsIE1ldGVyaW5nIEdtYkgsIERvbmF1c3RyYXNzZSAxMjAsIDkwNDUxIE51ZXJu
YmVyZw0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBBbnNiYWNoLCBSZWdpc3RlcmdlcmljaHQ6IEFu
c2JhY2ggSFJCIDY5DQpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIENocmlzdG9mIEJvc2JhY2ggKFNw
cmVjaGVyKSwgRGlwbC4tRG9sbS4gQW5uZXR0ZSBHZXV0aGVyLCBEaXBsLi1LZm0uIFJlaW5lciBF
ZGVsLCBKZWFuLUNsYXVkZSBMdXR0cmluZ2VyDQoNCkJpdHRlIGRlbmtlbiBTaWUgYW4gZGllIFVt
d2VsdCwgYmV2b3IgU2llIGRpZXNlIEUtTWFpbCBkcnVja2VuLiBEaWVzZSBFLU1haWwga2FubiB2
ZXJ0cmF1bGljaGUgSW5mb3JtYXRpb25lbiBlbnRoYWx0ZW4uIFNvbGx0ZW4gZGllIGluIGRpZXNl
ciBFLU1haWwgZW50aGFsdGVuZW4gSW5mb3JtYXRpb25lbiBuaWNodCBmw7xyIFNpZSBiZXN0aW1t
dCBzZWluLCBpbmZvcm1pZXJlbiBTaWUgYml0dGUgdW52ZXJ6dWVnbGljaCBkZW4gQWJzZW5kZXIg
cGVyIEUtTWFpbCB1bmQgbG9lc2NoZW4gU2llIGRpZXNlIEUtTWFpbCBpbiBJaHJlbSBTeXN0ZW0u
IEplZGUgdW5iZXJlY2h0aWd0ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24sIEJla2FubnRnYWJlLCBB
ZW5kZXJ1bmcsIFZlcnRlaWx1bmcgdW5kL29kZXIgUHVibGlrYXRpb24gZGllc2VyIEUtTWFpbCBp
c3Qgc3RyZW5nc3RlbnMgdW50ZXJzYWd0LiBJbmZvcm1hdGlvbmVuIHp1bSBEYXRlbnNjaHV0eiBm
aW5kZW4gU2llIGF1ZiB1bnNlcmVyIEhvbWVwYWdlPGh0dHBzOi8vd3d3LmRpZWhsLmNvbS9tZXRl
cmluZy9kZS9pbXByZXNzdW0tdW5kLXJlY2h0bGljaGUtaGlud2Vpc2UvPi4NCg0KQmVmb3JlIHBy
aW50aW5nLCB0aGluayBhYm91dCBlbnZpcm9ubWVudGFsIHJlc3BvbnNpYmlsaXR5LlRoaXMgbWVz
c2FnZSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBhcmUgbm90
IGF1dGhvcml6ZWQgdG8gcmVjZWl2ZSB0aGlzIGluZm9ybWF0aW9uIHBsZWFzZSBhZHZpc2UgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBieSByZXBseSBlLW1haWwgYW5kIGRlbGV0ZSB0aGlzIG1lc3Nh
Z2Ugd2l0aG91dCBtYWtpbmcgYW55IGNvcGllcy4gQW55IGZvcm0gb2YgdW5hdXRob3JpemVkIHVz
ZSwgcHVibGljYXRpb24sIHJlcHJvZHVjdGlvbiwgY29weWluZyBvciBkaXNjbG9zdXJlIG9mIHRo
ZSBlLW1haWwgaXMgbm90IHBlcm1pdHRlZC4gSW5mb3JtYXRpb24gYWJvdXQgZGF0YSBwcm90ZWN0
aW9uIGNhbiBiZSBmb3VuZCBvbiBvdXIgaG9tZXBhZ2U8aHR0cHM6Ly93d3cuZGllaGwuY29tL21l
dGVyaW5nL2VuL2RhdGEtcHJvdGVjdGlvbi8+Lg0K


