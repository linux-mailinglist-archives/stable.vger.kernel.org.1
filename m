Return-Path: <stable+bounces-212861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFXRIXyCfGlwNgIAu9opvQ
	(envelope-from <stable+bounces-212861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:05:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5774B9250
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD62D300A747
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FDB2FC89C;
	Fri, 30 Jan 2026 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j/peVqNR"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A302DECA5
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767544; cv=none; b=jDKjhMiS3desM3WMr+bMOLlYzNzYjEHWUQeq0IBE10reAF0aCrGLPpPTKLA7VmZfIIRMxtQfqB0yekIQJpC2yFXPhsrRTLghwPAfaKW4gZ2il9Q5bYtETfXWl8NyHGC6adwPwaL0WM9RXD2PG81IGLdQY/nr0mxutriHr4JCN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767544; c=relaxed/simple;
	bh=bYd0gNIPsQfrRjQ50GYAw4VHaMDTFpCKlop3i6J00yc=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=A3HeilS33YCESjKnIQN8cIBIdUMwivt5acZv1rLGjF/0newcS4N1iPHO/twxDFi9V3hk2IiInraC5RkyeRnWqH6Z7fh01149yV46RbPJAeQkrtDnIX5dqAfnqjUHAjm7KK080IViM3VNVmr272QUK86kR6qWJvqHJAYmjzx0Rts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j/peVqNR; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1769767491;
	bh=bYd0gNIPsQfrRjQ50GYAw4VHaMDTFpCKlop3i6J00yc=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=j/peVqNRKbVUr7VSZw5Rq1yg1tVAapNmoCwySrVLLLf6Zqbs9vBFQAPDr1kmrceeZ
	 RBg7WCljghNxRbMtE4K/DzSPMBYA7vVASsbcmdKNGkioOeEhBdXGCkmZuHRn+xQJCn
	 CRVJ4IyGJLmdTDTRqfkr+w4K3yvXb+8qaIp5NFkw=
EX-QQ-RecipientCnt: 5
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSqhbzcQ9CBTJeqGhrDD4pnhr5tH6LJw/E=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: ZvpNZN00dh91KxFvLzKXzIpru8CqnKa6yLl5EIsXCJo=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1769767485t96c1df8a
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?dGl3YWk=?=" <tiwai@suse.de>, "=?utf-8?B?c2FzaGFs?=" <sashal@kernel.org>, "=?utf-8?B?cGF2ZWw=?=" <pavel@denx.de>
Subject:  [PATCH 6.6] ALSA: usb-audio: Fix missing unlock at error path of  maxpacksize check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 30 Jan 2026 18:04:44 +0800
X-Priority: 3
Message-ID: <tencent_42D789F563D3A21850DD27DE@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_09063379481F265B19AC7AC7@qq.com>
In-Reply-To: <tencent_09063379481F265B19AC7AC7@qq.com>
X-QQ-ReplyHash: 3650666767
X-BIZMAIL-ID: 20175316097290189
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 30 Jan 2026 18:04:46 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NWth7vBa++Gd/u2dW/G8Jx7DeM3yylBJTriUWaf7z3EYXGufa/ndknVU
	FSFqzRL4y4SIGH3jg8/6dPP8KPN1deX6JO23cDwaesMPEOe5Xn+LtMJHINkOVP561+hAVJy
	G3ZdZJZqsO2bsJr9liP9XnVa4zLK6RHnJJjXdeYgM1vOUffwWb77hrl3ltzOw9cojlp3648
	Q+jgH+RxK8kPW80LxbSgvOyVWCjIBaIiRLE16xqsN3PO+CPR1iu5ykUQvU3ONWpOD9fo2gj
	Zk8xeyQUTRGqqswTjez+vP8sdV2BZDfyIPlwtnIZqdYqc9XA+ddmgYutLJqanj4FBhxz7cC
	IZAMXcnIB16EK2u/pUDfEMNsYOb0/nLeLRY2SiHzRgO0KAi7l0HjonLLxOVDzqsExLFSEvo
	Rm+WqWzDKoT+VZGZh5anizL55inmqjiYpApL5n4JU4FllN/D2XkxYAgokBxrkA+feWBMEHv
	F/OqW2LYpFDRBwJBmhFZCwo3J+q1nCiis1rI+Rb7cIUFrTtATHDY26zbaH520NC136lADQ4
	tBDEKbR+jHuk8fGdwNtw2TR+a+KD6/aJqssSL/nhV/XWaWBPvIGAPnQ3lKSvMyVShFuXIDL
	4AiIE8ca/6QYX4KZqDwBlhm5A+VmNs0A1jwJoLxbdPApjhrpcwGfH5XH7xPMLwmdJUC/crw
	jRodq6UHgxocD05wn5XRqJHoQ0S4qsY57DJcW+qerbQKw/RioPiEa6Ujn5T3zeA4Qzehhje
	7F5iVQbESzkVVHmH5OA5vTgtM5Rayxi2XEmwlGDjORSiedZqXTc4lI8z+5F6o+XvxTNfnCs
	FSk+MOEaXAL15ajEuVVOjNtV7YUGTNzjc0fVI315uj28on+Uokm392vQTW521mT0hWKtu67
	Qj2WaCbiqlWz2JY/SB5HUl9Mz9CEf8TcUiL6ng/3LTq8m3Ro3lIoZoBsqIk9Odeuza+XTqm
	8WcA7q7EiVOBCjFButn9oMwYAZGXkvTRUMrEsx5GkpoN7A1g6v5cqRXS1Ll6a5F4zV36HCj
	iknImhXSi5MJb0HolLaMKhwyCC/ac4rvodBf1xTHikkn7RNfVdVYa3SuZmpqbUGwf7Wnl0O
	BCC0WkNuJMg
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
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
	TAGGED_FROM(0.00)[bounces-212861-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: C5774B9250
X-Rspamd-Action: no action

SSBmb3VuZCB0aGF0IHBhdGNoIHdoaWNoIGluIHY2LjEyLjYwIHNob3VsZCBiZSBhcHBsaWVk
IGluIHY2LjYtc3RhYmxlIHRyZWUuDQoNCkZyb206IFRha2FzaGkgSXdhaSA8dGl3YWlAc3Vz
ZS5kZT4NCg0KVGhlIHJlY2VudCBiYWNrcG9ydCBvZiB0aGUgdXBzdHJlYW0gY29tbWl0IDA1
YTFmYzVlZmRkOCAoIkFMU0E6DQp1c2ItYXVkaW86IEZpeCBwb3RlbnRpYWwgb3ZlcmZsb3cg
b2YgUENNIHRyYW5zZmVyIGJ1ZmZlciIpIG9uIHRoZQ0Kb2xkZXIgc3RhYmxlIGtlcm5lbHMg
bGlrZSA2LjEyLnkgd2FzIGJyb2tlbiBzaW5jZSBpdCBkb2Vzbid0IGNvbnNpZGVyDQp0aGUg
bXV0ZXggdW5sb2NrLCB3aGVyZSB0aGUgdXBzdHJlYW0gY29kZSBtYW5hZ2VzIHdpdGggZ3Vh
cmQoKS4NCkluIHRoZSBvbGRlciBjb2RlLCB3ZSBzdGlsbCBuZWVkIGFuIGV4cGxpY2l0IHVu
bG9jay4NCg0KVGhpcyBpcyBhIGZpeCB0aGF0IGNvcnJlY3RzIHRoZSBlcnJvciBwYXRoLCBh
cHBsaWVkIG9ubHkgb24gb2xkIHN0YWJsZQ0KdHJlZXMuDQoNClJlcG9ydGVkLWJ5OiBQYXZl
bCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FTV3RIMEFaSDUrYWViK2FAZHVvLnVjdy5jeg0KRml4ZXM6IDk4ZTlkNWUzM2JkYSAo
IkFMU0E6IHVzYi1hdWRpbzogRml4IHBvdGVudGlhbCBvdmVyZmxvdyBvZiBQQ00gdHJhbnNm
ZXIgYnVmZmVyIikNClJldmlld2VkLWJ5OiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+
DQpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+DQpTaWduZWQt
b2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+DQooY2hlcnJ5IHBpY2tl
ZCBmcm9tIGNvbW1pdCBmZGYwZGM4MmViNjAwOTE3NzJlY2VhNzNjYmM1YThmYjc1NjJmYzQ1
KQ0KU2lnbmVkLW9mZi1ieTogV2VudGFvIEd1YW4gPGd1YW53ZW50YW9AdW5pb250ZWNoLmNv
bT4NCi0tLQ0KIHNvdW5kL3VzYi9lbmRwb2ludC5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9zb3Vu
ZC91c2IvZW5kcG9pbnQuYyBiL3NvdW5kL3VzYi9lbmRwb2ludC5jDQppbmRleCA3MjM4ZjY1
Y2JjZmZmLi5hYTIwMWU0NzQ0YmY2IDEwMDY0NA0KLS0tIGEvc291bmQvdXNiL2VuZHBvaW50
LmMNCisrKyBiL3NvdW5kL3VzYi9lbmRwb2ludC5jDQpAQCAtMTM4OSw3ICsxMzg5LDggQEAg
aW50IHNuZF91c2JfZW5kcG9pbnRfc2V0X3BhcmFtcyhzdHJ1Y3Qgc25kX3VzYl9hdWRpbyAq
Y2hpcCwNCiAgICAgICAgaWYgKGVwLT5wYWNrc2l6ZVsxXSA+IGVwLT5tYXhwYWNrc2l6ZSkg
ew0KICAgICAgICAgICAgICAgIHVzYl9hdWRpb19kYmcoY2hpcCwgIlRvbyBzbWFsbCBtYXhw
YWNrc2l6ZSAldSBmb3IgcmF0ZSAldSAvIHBwcyAldVxuIiwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVwLT5tYXhwYWNrc2l6ZSwgZXAtPmN1cl9yYXRlLCBlcC0+cHBzKTsN
Ci0gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCisgICAgICAgICAgICAgICBlcnIg
PSAtRUlOVkFMOw0KKyAgICAgICAgICAgICAgIGdvdG8gdW5sb2NrOw0KICAgICAgICB9DQog
DQogICAgICAgIC8qIGNhbGN1bGF0ZSB0aGUgZnJlcXVlbmN5IGluIDE2LjE2IGZvcm1hdCAq
Lw0KLS0gDQoyLjUxLjA=


