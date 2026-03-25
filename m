Return-Path: <stable+bounces-230317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C3bEmLEw2kVuAQAu9opvQ
	(envelope-from <stable+bounces-230317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:17:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E9323C17
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4331300B99F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142883C9EC0;
	Wed, 25 Mar 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rim5JkWy"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA63C4577;
	Wed, 25 Mar 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437091; cv=none; b=YJbJToGqe5BmwwpNPThKTsEUeXzYNhvDI9gLubq1o7na/F/8ErUBj5u7szrsSPZ8q3foDqxNYYvaIjdle7grHuzx/rUSlUSX3bojne3sDqQCl+5qnaoIQFxpgYZ9/gQy1YAG2kH3SdLUGZjgjQHylnofIidATYKshddZdqsZ+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437091; c=relaxed/simple;
	bh=aELKRBKfojuEQ66PKGCO4GoBtvuTy8kFguZSgNHtm5E=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=hU25WtROA2+Y8n0rLGoIZ6zoY/w1Cv/oyWCrOdFO/F35YFLcWiFEkgvAjA0dJjoFXyo0kRtl33jBCwAhiwPNMp91u00163+x1EdfzfTtwTHev92t8zB5ScGC0/WkZKrivktuJ3AnRS6M8S41NKg96w8TlHAyeqGwwpa3AurJca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rim5JkWy; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774437084; bh=aELKRBKfojuEQ66PKGCO4GoBtvuTy8kFguZSgNHtm5E=;
	h=From:To:Cc:Subject:Date;
	b=rim5JkWyf4WVi51/gIW9AHCCGefIUyV7maT2c94Ys7+lHrSS+caVfq7W6odG+5ZnV
	 4NSu60k1x2cGZ41s1D/Ey7HdbHTWTXDOiLQ1VvBncKwYS8UmuqIUYgQn6sCdNBsETA
	 eSI4uRzYbdZx/fvw8VEpgM0924ruaxfaQzrULOHc=
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: Mkr4TrkwxQ3SeYpQAf9EHqAzrA93dS/h2/kVfilDTei+LntGUICvRon1ZkuJhE
	 N4K7aO/6iZjLepxaC7119ribTSgtdLpDa5S0zJsQtq2mW5n2hJpbmryeRAq+VPrdyDAwgeMiH1Mqa
	 jsi2F5Lw118yegGELB5BH4fVATx55uUKgnFfuJGvh43QTNZYgt+fH6edJdr4pHZBogSNff5FNGnAM
	 3HEH8vAbXtVLDViXYjfe7j0SzHck30ciEKmuz0T0nngCPNq0urL99DyRyL63Pqd7H2f5+duPW/Twg
	 qZ0MXIzfGdO9OEkSXRu4xscpEYTOKbwKM0sd7LW3bheadGx2d+u3O+akkibgRV3HUkUl2eEgqPou8
	 VUGRjpKdMOdjMtZDbYfX/qv1wgNjoxZVNAHk8YKx0c6P+VIi0iTyOie1XpZAE7LWZBYJJxKhluCbh
	 k4kzswYAkHk34C0Xwm5q0Up/L0IFmh6Ebs8vCaDzIAl99ePRqjXx77di8f4tG/b11S+TBoDoDjlf1
	 F9Q3unl3732yHE77Pqe5sk9yLSphTnx9/zDBX9ROqfoHhz+LiBgbM6YtlCxEz5V2GneK3t7yGJApP
	 MHTRhDt42DZsoPDXd3T7G1bVVtH5uOfk5VcZfmJeOmYmNIksTI9s8BnooWEWSRiNKmh/CZ/kWs4OY
	 +2x8sVQRzMMm0CMyEoyCKGE6bEcw4pr2DpppMbR+nQZGrESA9BRvAsZptiY2ZsxzSrmC+gQb9Q//4
	 nmwONbSk4EVv6WGrclcb0gu37iYJzcpqUeey1jWRsCBz55SG+xV8koqJSqW6HisY5J/bajfG+CDo7
	 3l+YPEl20aSr+mRfjanH9aPS9WLYvnVvNzhwj9b+XPq5ysqvgq7JyE4VR5d78E2jzDQVWxmq0YMor
	 vfswoBWyWGmNFZPdH4Hru/PNoC45+VZW/DXTmf6EK7uCZGroiqBERLYZiHLM4je77YlpMm39RYwiY
	 8WvRPB+PtgykbrFj/zRjpOeRPISqfw+Ma5T9QI+8tOC357TImNEgd6Bor6XtmfIxxc7N+GWA==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774437082t1800453
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?ISO-8859-1?B?eGlhbmc=?=" <xiang@kernel.org>, "=?ISO-8859-1?B?Y2hhbw==?=" <chao@kernel.org>, "=?ISO-8859-1?B?amVmZmxleHU=?=" <jefflexu@linux.alibaba.com>, "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?ISO-8859-1?B?c3l6Ym90KzAxNmQ4NjE3OTdmZDcxODQ5MWE4?=" <syzbot+016d861797fd718491a8@syzkaller.appspotmail.com>
Subject: [PATCH 6.1.y] erofs: get rid of z_erofs_fill_inode()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Wed, 25 Mar 2026 19:11:22 +0800
X-Priority: 3
Message-ID: <tencent_4CAC91CB31E29B2052C48E4A15D379060905@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230317-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EXCESS_BASE64(0.00)[];
	TAGGED_RCPT(0.00)[stable,016d861797fd718491a8];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: B75E9323C17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

WyBVcHN0cmVhbSBjb21taXQgNGZkYWRkNWIwZjBjNzIzYzgxMjg0MjQ1NGY4Y2NhMTYxOWYy
ZTczMSBdCgpQcmlvciB0byBiaWcgcGNsdXN0ZXJzLCBub24tY29tcGFjdCBjb21wcmVzc2lv
biBpbmRleGVzIGNvdWxkIGhhdmUKZW1wdHkgaGVhZGVycy4KCkF2b2lkIHRoZSBsZWdhY3kg
cGF0aCBzaW5jZSBpdCBjYW4gYmUgaGFuZGxlZCBwcm9wZXJseSBhcyBhIHNwZWNpZmljCmNv
bXByZXNzaW9uIGhlYWRlciB3aXRoIHpfZXJvZnNfZmlsbF9pbm9kZV9sYXp5KCkgdG9vLgoK
VGVzdGVkIHdpdGggZXhpc3RpbmcgZXJvZnMtdXRpbHMgdmVyc2lvbnMuCgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNDEzMDkyMjQxLjczODI5LTEtaHNpYW5na2Fv
QGxpbnV4LmFsaWJhYmEuY29tCkxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29t
L2J1Zz9leHRpZD0wMTZkODYxNzk3ZmQ3MTg0OTFhOApSZXBvcnRlZC1ieTogc3l6Ym90KzAx
NmQ4NjE3OTdmZDcxODQ5MWE4QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KVGVzdGVkLWJ5
OiBzeXpib3QrMDE2ZDg2MTc5N2ZkNzE4NDkxYThAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNv
bQpTaWduZWQtb2ZmLWJ5OiBHYW8gWGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNv
bT4KU2lnbmVkLW9mZi1ieTogQ2hhbmdqaWFuIExpdSA8ZHJpejJ0QHFxLmNvbT4KLS0tCiBm
cy9lcm9mcy9pbm9kZS5jICAgIHwgMTIgKysrKysrKystLS0tCiBmcy9lcm9mcy9pbnRlcm5h
bC5oIHwgIDIgLS0KIGZzL2Vyb2ZzL3ptYXAuYyAgICAgfCAxOCAtLS0tLS0tLS0tLS0tLS0t
LS0KIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9mcy9lcm9mcy9pbm9kZS5jIGIvZnMvZXJvZnMvaW5vZGUuYwppbmRl
eCAzY2JlZjYzMThiN2IuLjQ4NDU3MjUwNGI0ZCAxMDA2NDQKLS0tIGEvZnMvZXJvZnMvaW5v
ZGUuYworKysgYi9mcy9lcm9mcy9pbm9kZS5jCkBAIC0yODAsMTEgKzI4MCwxNSBAQCBzdGF0
aWMgaW50IGVyb2ZzX2ZpbGxfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkKIAl9CiAKIAlp
ZiAoZXJvZnNfaW5vZGVfaXNfZGF0YV9jb21wcmVzc2VkKHZpLSZndDtkYXRhbGF5b3V0KSkg
eworI2lmZGVmIENPTkZJR19FUk9GU19GU19aSVAKIAkJaWYgKCFlcm9mc19pc19mc2NhY2hl
X21vZGUoaW5vZGUtJmd0O2lfc2IpICZhbXA7JmFtcDsKLQkJICAgIGlub2RlLSZndDtpX3Ni
LSZndDtzX2Jsb2Nrc2l6ZV9iaXRzID09IFBBR0VfU0hJRlQpCi0JCQllcnIgPSB6X2Vyb2Zz
X2ZpbGxfaW5vZGUoaW5vZGUpOwotCQllbHNlCi0JCQllcnIgPSAtRU9QTk9UU1VQUDsKKwkJ
ICAgIGlub2RlLSZndDtpX3NiLSZndDtzX2Jsb2Nrc2l6ZV9iaXRzID09IFBBR0VfU0hJRlQp
IHsKKwkJCWlub2RlLSZndDtpX21hcHBpbmctJmd0O2Ffb3BzID0gJmFtcDt6X2Vyb2ZzX2Fv
cHM7CisJCQllcnIgPSAwOworCQkJZ290byBvdXRfdW5sb2NrOworCQl9CisjZW5kaWYKKwkJ
ZXJyID0gLUVPUE5PVFNVUFA7CiAJCWdvdG8gb3V0X3VubG9jazsKIAl9CiAJaW5vZGUtJmd0
O2lfbWFwcGluZy0mZ3Q7YV9vcHMgPSAmYW1wO2Vyb2ZzX3Jhd19hY2Nlc3NfYW9wczsKZGlm
ZiAtLWdpdCBhL2ZzL2Vyb2ZzL2ludGVybmFsLmggYi9mcy9lcm9mcy9pbnRlcm5hbC5oCmlu
ZGV4IDEyNjk3MDkzMjgwNS4uMWE0ZDA4YTkzMzM5IDEwMDY0NAotLS0gYS9mcy9lcm9mcy9p
bnRlcm5hbC5oCisrKyBiL2ZzL2Vyb2ZzL2ludGVybmFsLmgKQEAgLTQyMywxMiArNDIzLDEw
IEBAIGVudW0gewogZXh0ZXJuIGNvbnN0IHN0cnVjdCBpb21hcF9vcHMgel9lcm9mc19pb21h
cF9yZXBvcnRfb3BzOwogCiAjaWZkZWYgQ09ORklHX0VST0ZTX0ZTX1pJUAotaW50IHpfZXJv
ZnNfZmlsbF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsKIGludCB6X2Vyb2ZzX21hcF9i
bG9ja3NfaXRlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQkJICAgIHN0cnVjdCBlcm9mc19t
YXBfYmxvY2tzICptYXAsCiAJCQkgICAgaW50IGZsYWdzKTsKICNlbHNlCi1zdGF0aWMgaW5s
aW5lIGludCB6X2Vyb2ZzX2ZpbGxfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkgeyByZXR1
cm4gLUVPUE5PVFNVUFA7IH0KIHN0YXRpYyBpbmxpbmUgaW50IHpfZXJvZnNfbWFwX2Jsb2Nr
c19pdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAJCQkJCSAgc3RydWN0IGVyb2ZzX21hcF9i
bG9ja3MgKm1hcCwKIAkJCQkJICBpbnQgZmxhZ3MpCmRpZmYgLS1naXQgYS9mcy9lcm9mcy96
bWFwLmMgYi9mcy9lcm9mcy96bWFwLmMKaW5kZXggZDJkN2ZlODI2MDkxLi5mZjg0NTMzZGEw
YzQgMTAwNjQ0Ci0tLSBhL2ZzL2Vyb2ZzL3ptYXAuYworKysgYi9mcy9lcm9mcy96bWFwLmMK
QEAgLTcsMjQgKzcsNiBAQAogI2luY2x1ZGUgPGFzbSB1bmFsaWduZWQuaD0iIj4KICNpbmNs
dWRlIDx0cmFjZSBldmVudHM9IiIgZXJvZnMuaD0iIj4KIAotaW50IHpfZXJvZnNfZmlsbF9p
bm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQotewotCXN0cnVjdCBlcm9mc19pbm9kZSAqY29u
c3QgdmkgPSBFUk9GU19JKGlub2RlKTsKLQlzdHJ1Y3QgZXJvZnNfc2JfaW5mbyAqc2JpID0g
RVJPRlNfU0IoaW5vZGUtJmd0O2lfc2IpOwotCi0JaWYgKCFlcm9mc19zYl9oYXNfYmlnX3Bj
bHVzdGVyKHNiaSkgJmFtcDsmYW1wOwotCSAgICAhZXJvZnNfc2JfaGFzX3p0YWlscGFja2lu
ZyhzYmkpICZhbXA7JmFtcDsgIWVyb2ZzX3NiX2hhc19mcmFnbWVudHMoc2JpKSAmYW1wOyZh
bXA7Ci0JICAgIHZpLSZndDtkYXRhbGF5b3V0ID09IEVST0ZTX0lOT0RFX0NPTVBSRVNTRURf
RlVMTCkgewotCQl2aS0mZ3Q7el9hZHZpc2UgPSAwOwotCQl2aS0mZ3Q7el9hbGdvcml0aG10
eXBlWzBdID0gMDsKLQkJdmktJmd0O3pfYWxnb3JpdGhtdHlwZVsxXSA9IDA7Ci0JCXZpLSZn
dDt6X2xvZ2ljYWxfY2x1c3RlcmJpdHMgPSBpbm9kZS0mZ3Q7aV9zYi0mZ3Q7c19ibG9ja3Np
emVfYml0czsKLQkJc2V0X2JpdChFUk9GU19JX1pfSU5JVEVEX0JJVCwgJmFtcDt2aS0mZ3Q7
ZmxhZ3MpOwotCX0KLQlpbm9kZS0mZ3Q7aV9tYXBwaW5nLSZndDthX29wcyA9ICZhbXA7el9l
cm9mc19hb3BzOwotCXJldHVybiAwOwotfQotCiBzdHJ1Y3Qgel9lcm9mc19tYXByZWNvcmRl
ciB7CiAJc3RydWN0IGlub2RlICppbm9kZTsKIAlzdHJ1Y3QgZXJvZnNfbWFwX2Jsb2NrcyAq
bWFwOwotLSAKMi40My4wPC90cmFjZT48L2FzbT48L2RyaXoydEBxcS5jb20+PC9oc2lhbmdr
YW9AbGludXguYWxpYmFiYS5jb20+


