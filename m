Return-Path: <stable+bounces-261900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BbcWOCFxJWrtIAIAu9opvQ
	(envelope-from <stable+bounces-261900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 15:24:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77011650A20
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 15:24:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b="Dl81IM v";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261900-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261900-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C255A3017019
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83C3A9D90;
	Sun,  7 Jun 2026 13:24:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7539B971;
	Sun,  7 Jun 2026 13:24:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838683; cv=none; b=Q5ZPZ8aV9lclfNFuxSDqr926ILWeFkwGxGcMU4ohztSccKLzW/UydY6pXSXAYdIa6pcPzWWIvw8q0JSI+bdVV4eFHfEEC2q855aHi2HUYX2UZaksuynNxxedMBiJL3O4lZ0xzzab+sR97ie4k7gEfd3e84NKVsVBnG0KeoAuYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838683; c=relaxed/simple;
	bh=VA1ESUV8h/8/d/qjT/vRMVuax4MwKtKKs5+taCejwZU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kGKG8nsVNT5ff+1sFlsPVix3RUQZvNeBToZUNQyZnf6KWc+QDsZ2kGxYNRlO3H62CTOGdXht8iqk5aQY20NYqJ9oC/fTTuR+QUMz0zSEhx9Q+mH1HouxUt49TrC2+ciGvvsoyxOI3dszVJg4e4CUpbhdc2UJTDNhZc/zLJ2g7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Dl81IMvV; arc=none smtp.client-ip=13.75.44.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=myCX7E31llrE57DLcg93MGslqWvS0eWJEj3T6r4sZ2M=; b=Dl81IM
	vV/vZnVWAE0cvXAEZqV4y/ovrBIkUobjjjpYzEP75Z2CqNI1D7V12NRHz+LDh4Km
	acT9fBy1Q8B7pWuE6KzSvoYQ/nV+XBswvl73Uxz64xulIZjK7gN/+YVFYnJ8/0um
	ZFHesFvW0emS7KCmecYeuT0uyAvzWvg0F+M0k=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQD3CJ4KcSVqdwgUAg--.41669S2;
	Sun, 07 Jun 2026 21:24:26 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf v2 0/2] Keep dynamic inner array lookups nullable
Date: Sun, 07 Jun 2026 21:24:12 +0800
Message-Id: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxwJWoC/y2NwQ6CMBBEf8Xs2TbdhRr05H8YDgVaWKMFWyAaw
 r9b0MxpJi9vFog2sI1wOSwQ7MyRe58KHQ9Qd8a3VnCTOpCik0oRTqGYSWSUu+pMWGhDkOAhWMf
 vXXSDanBQ/sY4VXdbj5tiwzqOYx8++92MO/w356gRdSYpLwqlUaBo/Yv09Wn4EeUY2bfdZKRtJ
 ll7KNd1/QJC2KSYvAAAAA==
X-Change-ID: 20260606-f01-v2-324fb92185a2
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Daniel Xu <dxu@dxuuu.xyz>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780838667; l=2427;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=VA1ESUV8h/8/d/qjT/vRMVuax4MwKtKKs5+taCejwZU=;
 b=UaxguWEC/vPvk3w/PC8y9fC+r/IiZUJO9lYEc4hO2StpqdQdZtPFL3GJoCigUiuxtPLTeLTrp
 tcQYH6rYqfWCewCzoC9JBAJyGdaJYeJxFb5XTCDsaHDk+335MabdXxD
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQD3CJ4KcSVqdwgUAg--.41669S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1xWr43Xr1rArW3WFykKrg_yoW5JrW5pr
	WrWFW3Xr1kAr1fJa1Iyay29FyFgFWkJr1akrn3Jw15Z34rX348XrWF9F4ava4aya43Ww4Y
	v34IqFn09a45AFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUY1v3UUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQELA2okna+SRgAEsk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:gnq25@mails.tsinghua.edu.cn,m:dxu@dxuuu.xyz,m:eddyz87@gmail.com,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:isolodrai@meta.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[gnq25@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-261900-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnq25@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,dxuuu.xyz,gmail.com,linux.dev,kernel.org,meta.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77011650A20

An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
inner map template. The flag allows a concrete inner array with a
different max_entries value to replace the template.

The verifier currently uses the template's max_entries to elide
nullness for a constant-key lookup through the inner map pointer. At
runtime, the lookup uses the concrete inner array's max_entries instead.
The verifier can therefore accept an unchecked dereference even though
the runtime helper returns NULL.

Patch 1 keeps lookups through BPF_F_INNER_MAP array templates nullable.
Patch 2 adds a verifier regression test for the unchecked dereference.

Before the fix, the regression program is accepted and the runtime
reproducer triggers a NULL dereference. With the fix, both programs are
rejected with an invalid map_value_or_null access.

Tested by compiling kernel/bpf/verifier.o and
verifier_map_in_map.bpf.o, and by running the regression program and
runtime reproducer in QEMU before and after the fix.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
v1->v2:
- Update the can_elide_value_nullness() comment to match the changed
  parameter (const struct bpf_map *map).

v1: https://patch.msgid.link/20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Ihor Solodrai <isolodrai@meta.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Nuoqi Gui (2):
      bpf: Keep dynamic inner array lookups nullable
      selftests/bpf: Cover dynamic inner array lookup nullability

 kernel/bpf/verifier.c                              | 15 ++++----
 .../selftests/bpf/progs/verifier_map_in_map.c      | 40 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 6 deletions(-)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260606-f01-v2-324fb92185a2

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>


