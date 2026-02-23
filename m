Return-Path: <stable+bounces-217691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id egjOEr3um2lO9wMAu9opvQ
	(envelope-from <stable+bounces-217691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:07:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E7172024
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A41933018C17
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157213AA2D;
	Mon, 23 Feb 2026 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS3LFArE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA03EBF22
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771826872; cv=pass; b=QzktP3an3onNYhjUZq2mwx9kE8nF8pq5dtDtGfRV1YgakbqSbxHQ1zqzHgG5tXnEFDWcBTnN7T1AtN3ut5DIWk4K6tUqQ5P5p3aULaTUiiOVR1Yxhnt9KTChYntUGCqK+sCdwCKi5uLqxYhdL7Gls92MoGSVttfuuSkVi31q7u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771826872; c=relaxed/simple;
	bh=2YM/LoEPcPIJzD87Ai500N3mIQS25s5TvBcxjEwN4yk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mq138xYQWj/phNMCkZRvdetodU04gW1WG4zvpggDGxGDZo7E3sudzc/8+9eSmOgp1L3BXZ/9bSpSQIuk3s1tLFU/5tKczdf9ESGd5mhKlDlCiemZDBtCEGWF3UnR9ogkq0EJAB8im3agZPpf24hdREwD1sbYvxp6bvAGqhfdcMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS3LFArE; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79818c7600eso23565227b3.0
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 22:07:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771826870; cv=none;
        d=google.com; s=arc-20240605;
        b=h6SA1rzD0TBEkIWKZCTlR4OJrKLzPoufCLHhjTFeYgDDMriTuDY5tOA9IjhagbBWjb
         7Lr7X7CgND8p4SCih59soPGSZjCXrfbYEgzmdD5jnLxZBpGDsa4Zs9W0/oTpclLAliQy
         D1257KlXEhAQV2DSGXk3VgbZIqcSWYdsXhrvvkldrwfNpOng+R4evIWh472efc7lpGQf
         gxAKRceoKX2WNUdGlfCtGdUvQSpuw/kyh8uMnvSsONYedGtxYiPtRvBq5ltCK74PCn0o
         ZvHbcK1BAFcqEV3b+HL6J9+TI+NIhwCjjASbUqWBsRfZL/XH+5iDIgwWjXgnZTtkIqu4
         Wijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MRVRqGtRv1VMucwY0EQy7dZhk5C1r0QHFDuby6AYJRk=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=hdyWCHWUmK+/x3YlxAcRyl0MksjQEIWRpsbazb71wDrB02e+yQ3euzzK5o5caZPuWC
         vimFVZuEZsLv+ePx1zm0yvetCU4yS4jI0XErcMZjK0Ou7gyQAO9DUzLpAGg7bLMDAGTN
         bqgVADpFxv7b3qEtCor2J+rWEQJmkXbmaN2dHVkW9KYNzTwF6AyCS/pqza00k4A5Fook
         1nR6g+nPqQZvri3dt4VUOhd/6/1OAOQ0oNbkmPnEzDY3zB4afPV2BwO57SSWrn0RApsp
         GbnTKwzcsaPsIJl86cgXqrGvS6fbOCyuUIoJKCAlCN0FSbbVnTNme9PgRKhKjrSxwlRK
         ulHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771826870; x=1772431670; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRVRqGtRv1VMucwY0EQy7dZhk5C1r0QHFDuby6AYJRk=;
        b=bS3LFArEeG12xGvjhhcpl8MNaJhMsprFHwxH2xNU3RIJIvbs7FQ+JfH8J/rUkS+lY6
         tdxkiG414RFOpJyAodHeyOjdUEnbBXfGLIxEQY48xt5VONCFM8VLaJTyKLIYQyOZP6x5
         eCJ4rn/Tr0XQ+wpkPiKKkrG7CNr8w1uTP/Tp4Zqu5iK/VRuxvLoQr9cJb5aq3LnplG9K
         PWOq++rQEX5Ji1K8d2oQ1FG+mXUPjLYoZeUCEJKoAMnjeimWKjo/EPIcfygGy31LDVcy
         9LBH49BDuzjX8cSw8zFRJfW2ePa5MpTIBO+s9SCv5cRz9EzlzPgLwXP7i/SUKVaqNAOT
         yLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771826870; x=1772431670;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRVRqGtRv1VMucwY0EQy7dZhk5C1r0QHFDuby6AYJRk=;
        b=vqNBnaINarxlE1R4zMcQTKrg9k8La2H6HtepKkZ53xtnxmTXGwEWdkK9rm2pfswRsu
         Fzd/wsyN887gYBF8jXVOkDFoheS7lUUvCNlduh2Ak+7nSGy+aSFWZoCKHWexJ6fvCWoW
         Y+oELetSvprm91+YC1dj//UColdaUTyy7l9O7MvHPU5Xz5VFkbmq2fySg9Bprcaj82N1
         UXmBMQF0GZYEANNzoXYe/Pmp4n9td+Z8rVqES4J/qFGiQ2Tp9+FIOBmGT33sfpeqWq+5
         NVUas9QMNn744ILKNtX+k6mzuWHdwDC0tbzX2v+uXEtlo4EneiGbGUnDN8+TT7pTkaPD
         3iKg==
X-Gm-Message-State: AOJu0Yx/3tPe2IJR/gV8SzMLdaSplzGosAQMik8FC9PF/j6ZVYl3/0f6
	NGxWuUTqQtsKXBdoNzQLg1zG18JjGXC9bZDlUifD3ldacYdcjw0EXcF0AnkM8vEZzeMvnroO2iA
	tr0evJ9sk7pVaiDXzkInYpmyDkL1Mw4SW8kXL
X-Gm-Gg: ATEYQzxpjg3IfC2Q/jabZFF0bzW0L/+iaW6W7zpcV8QuB13jqULZt1d/RSWfi0oT10O
	vDyVrirvNB/zhzAg8S5w2v6mCaCGH3hAOIjPDzRpIP4pYla+l5b3T/pmqMBtVFenqcct/TaOgEX
	WiPa9wEKFmFNDI75T67LIATyxOUvKB192+sqVeU94elH9ftXAp5fspBL07Sq8SHrI/pzcfrFd8Z
	b5FF0W78BBT0bFxGj9Z2/emcdv5qRx88C3jvgoVk0DSOVUNjPTtUEnL3Q0PwMUXhnpjPIxgK++9
	8OfCpcafXKJVFLeiQwTjshpqtWGBwP/hHYyUfTHSPMjLak1d02SHgjAfgWGCpYkT+ZohWw==
X-Received: by 2002:a05:690c:c512:b0:78f:f32e:8b5b with SMTP id
 00721157ae682-79828ac4e7emr71749557b3.0.1771826870197; Sun, 22 Feb 2026
 22:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amine Khemissi <aminekhemissi61@gmail.com>
Date: Mon, 23 Feb 2026 07:07:38 +0100
X-Gm-Features: AaiRm53ihEMU5m6SdyPAkYz8HqmP0pfoxhV8p-DDpKwefwNXsG6IcjVo2Jxu3Bk
Message-ID: <CAEc6xTVu-sG=Xb+LuDf4SFXChmKDC1f1ZOhZKP6Am_+2DMy=pw@mail.gmail.com>
Subject: [PATCH 5.10] scsi: backport fix for NULL deref in scsi_queue_rq
To: stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000033d3cf064b7797e3"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217691-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aminekhemissi61@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B09E7172024
X-Rspamd-Action: no action

--00000000000033d3cf064b7797e3
Content-Type: text/plain; charset="UTF-8"

Hi,

This backports the fix for CVE-2021-47552 to 5.10 LTS.

The patch applies cleanly and has been tested on 5.10.0+.

Thanks,
Khemissi

--00000000000033d3cf064b7797e3
Content-Type: application/octet-stream; 
	name="0001-scsi-backport-fix-for-NULL-deref-in-scsi_queue_rq-to.patch"
Content-Disposition: attachment; 
	filename="0001-scsi-backport-fix-for-NULL-deref-in-scsi_queue_rq-to.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mlyrvxe90>
X-Attachment-Id: f_mlyrvxe90

RnJvbSBjNjQ3NGFkODI4MWYyODhlMDRhMGU0ZGQ3NWIwMGRiNjRlZGRiMzM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogS2hlbWlzc2kgTW9oYW1tZWQgZWwgQW1pbmUgPGFtaW5la2hl
bWlzc2k2MUBnbWFpbC5jb20+DQpEYXRlOiBTdW4sIDIyIEZlYiAyMDI2IDIxOjU5OjI4IC0wODAw
DQpTdWJqZWN0OiBbUEFUQ0hdIHNjc2k6IGJhY2twb3J0IGZpeCBmb3IgTlVMTCBkZXJlZiBpbiBz
Y3NpX3F1ZXVlX3JxIHRvIDUuMTAueQ0KDQpUaGlzIGJhY2twb3J0cyB1cHN0cmVhbSBjb21taXRz
IDM1ZmU2ZmE1N2I5OSBhbmQgNmNhOTgxOGQxNjI0IHRvIDUuMTAgTFRTLg0KDQpUaGUgb3JpZ2lu
YWwgZml4IHByZXZlbnRzIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIHNjc2lfcXVldWVf
cnEoKQ0Kd2hlbiBhIEJTRyBpb2N0bCBpcyBpc3N1ZWQgd2l0aCBhIHplcm8tbGVuZ3RoIHJlcXVl
c3QgYW5kIGEgTlVMTCBjbW5kDQpwb2ludGVyLiBXaXRob3V0IHRoaXMgZml4LCBhIGxvY2FsIHVz
ZXIgd2l0aCBhY2Nlc3MgdG8gL2Rldi9ic2cvKiBjYW4NCnRyaWdnZXIgYSBrZXJuZWwgcGFuaWMu
DQoNClRoZSBjcmFzaCBvY2N1cnMgaW4gc2NzaV9jb21tYW5kX3NpemUoKSB3aGVuIGl0IGRlcmVm
ZXJlbmNlcyBhIE5VTEwNCmNtbmQgcG9pbnRlci4gVGhpcyB3YXMgY29uZmlybWVkIG9uIGtlcm5l
bCA1LjEwLjArIHdpdGggYSAxMDAlDQpyZXByb2R1Y2libGUgZXhwbG9pdC4NCg0KQ1ZFLTIwMjEt
NDc1NTINCg0KU2lnbmVkLW9mZi1ieTogS2hlbWlzc2kgTW9oYW1tZWQgZWwgQW1pbmUgPGFtaW5l
a2hlbWlzc2k2MUBnbWFpbC5jb20+DQotLS0NCiBkcml2ZXJzL3Njc2kvc2NzaV9saWIuYyAgICB8
IDYgKysrKysrDQogaW5jbHVkZS9zY3NpL3Njc2lfY29tbW9uLmggfCAyICsrDQogMiBmaWxlcyBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zY3Np
X2xpYi5jIGIvZHJpdmVycy9zY3NpL3Njc2lfbGliLmMNCmluZGV4IDAzYzZkMDYyMC4uNGU4NmJm
ZDNlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Njc2lfbGliLmMNCisrKyBiL2RyaXZlcnMv
c2NzaS9zY3NpX2xpYi5jDQpAQCAtMTE3NCw2ICsxMTc0LDEyIEBAIHN0YXRpYyBibGtfc3RhdHVz
X3Qgc2NzaV9zZXR1cF9zY3NpX2NtbmQoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2LA0KIHsNCiAJ
c3RydWN0IHNjc2lfY21uZCAqY21kID0gYmxrX21xX3JxX3RvX3BkdShyZXEpOw0KIA0KKwkvKiBD
aGVjayBmb3IgTlVMTCBjb21tYW5kIHBvaW50ZXIgKi8NCisJaWYgKCFjbWQtPmNtbmQpIHsNCisJ
CXNjc2lfcmVxKHJlcSktPnJlc3VsdCA9IERJRF9OT19DT05ORUNUIDw8IDE2Ow0KKwkJcmV0dXJu
IEJMS19TVFNfSU9FUlI7DQorCX0NCisNCiAJLyoNCiAJICogUGFzc3Rocm91Z2ggcmVxdWVzdHMg
bWF5IHRyYW5zZmVyIGRhdGEsIGluIHdoaWNoIGNhc2UgdGhleSBtdXN0DQogCSAqIGEgYmlvIGF0
dGFjaGVkIHRvIHRoZW0uICBPciB0aGV5IG1pZ2h0IGNvbnRhaW4gYSBTQ1NJIGNvbW1hbmQNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL3Njc2kvc2NzaV9jb21tb24uaCBiL2luY2x1ZGUvc2NzaS9zY3Np
X2NvbW1vbi5oDQppbmRleCA1YjU2N2I0M2UuLjFkOWRjYWRiMyAxMDA2NDQNCi0tLSBhL2luY2x1
ZGUvc2NzaS9zY3NpX2NvbW1vbi5oDQorKysgYi9pbmNsdWRlL3Njc2kvc2NzaV9jb21tb24uaA0K
QEAgLTIxLDYgKzIxLDggQEAgZXh0ZXJuIGNvbnN0IHVuc2lnbmVkIGNoYXIgc2NzaV9jb21tYW5k
X3NpemVfdGJsWzhdOw0KIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQNCiBzY3NpX2NvbW1hbmRfc2l6
ZShjb25zdCB1bnNpZ25lZCBjaGFyICpjbW5kKQ0KIHsNCisJaWYgKCFjbW5kKQ0KKwkJcmV0dXJu
IDA7DQogCXJldHVybiAoY21uZFswXSA9PSBWQVJJQUJMRV9MRU5HVEhfQ01EKSA/DQogCQlzY3Np
X3Zhcmxlbl9jZGJfbGVuZ3RoKGNtbmQpIDogQ09NTUFORF9TSVpFKGNtbmRbMF0pOw0KIH0NCi0t
IA0KMi41MS4wDQoNCg==
--00000000000033d3cf064b7797e3--

