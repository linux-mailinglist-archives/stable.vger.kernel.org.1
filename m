Return-Path: <stable+bounces-260831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qNp9AixfI2r1rQEAu9opvQ
	(envelope-from <stable+bounces-260831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 01:43:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCEB64BD75
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 01:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=1g4.org header.s=protonmail2 header.b=Jo7sFCSa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260831-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260831-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=1g4.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1BDF30191A9
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 23:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00E3F7AAD;
	Fri,  5 Jun 2026 23:43:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C53F7A96
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 23:43:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703010; cv=none; b=YDUz+c6kbrzofHhUfTjcnjGACzFNhR79Wg2ENHz3muvqr+4ozxy7Qt2vKijjXFsUfCU9LleLK7aknozZJtqiMssn5wcDdnIcOx8ahBGshYAntuIX1sCsaIra/otvXBHvk6PiI+aA3gmnHaM4YLI/RiBd+1dNYEoL/gi3eIOgA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703010; c=relaxed/simple;
	bh=XqaMC4QJHzJfNuNZl27qnxcRQ4zvu2haZ0ONbw2UfnQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nVK/dXveOAWMWQhpDUXc4IWcxiqdLqrWmuPt11+BOASV3yQIT4oczyQE6cJOmG3DHJQHCYHR0wykNGG3uBKBVVr35EcB9IvD1GMJVtsgZjVWMJ7Rv3O6QzORqM4wEmUVnubb+rMj+DhRMl3Ykagx1F91KIlBpd7KPxpVmqIvlVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=Jo7sFCSa; arc=none smtp.client-ip=109.224.244.117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1780702998; x=1780962198;
	bh=GDmaKRINflE3ApzE9mtFtjTCGWEOrjRY35R1+EIHEE8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Jo7sFCSaLkKMD99RW32Go7dh0dvoa4Eqxz862H9l14hmrd30Z+xH2V6QM4VBKhIr3
	 44iXOEszHDv4ksCT9ozIc9KCmiMnNAWpm+WKBARxY+FSfRm+OfUltfF+GYJFOa9CO7
	 4nP9E4pPPJAmMyLzTF3cUPxRtox8SoqmNCnsoyFIe8XNY5fpAaE3p9y/TLECkBiW1x
	 7Q7RjBYfJQRu4Lbxrn+wXljl9crZNT6vVz2Op7ch5EWb778nu26HbXETkGZ3R6eSRx
	 5IcFhNmVScl7v//ctvaycdv5W8wvvOrzSW/BMt5KGjTIxA9Hsgz49UM7UtM4zIq6WD
	 y1q8w2cNq+siw==
Date: Fri, 05 Jun 2026 23:43:09 +0000
To: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, houtao1@huawei.com, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH bpf] bpf: Validate BTF repeated field counts before expansion
Message-ID: <20260605234301.1109063-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 152161ac773fdfeb69882a3579aec1226bef6a93
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:houtao1@huawei.com,m:linux-kernel@vger.kernel.org,m:p@1g4.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[p@1g4.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260831-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[1g4.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BCEB64BD75

btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
and btf_repeat_fields() expands repeatable fields from array elements
into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().

The remaining-capacity check performs the expanded field count calculation
in u32. A malformed BTF can wrap that calculation, causing the check to
pass even when the expanded field count exceeds the scratch array
capacity. The following memcpy() can then write past the end of the
array.

Use checked addition and multiplication before copying repeated fields
and reject impossible counts.

Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating bt=
f fields")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 kernel/bpf/btf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..510aa32847da 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3668,7 +3668,7 @@ static int btf_get_field_type(const struct btf *btf, =
const struct btf_type *var_
 static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 =09=09=09     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
 {
-=09u32 i, j;
+=09u32 i, j, total_cnt, total_repeats;
 =09u32 cur;
=20
 =09/* Ensure not repeating fields that should not be repeated. */
@@ -3686,10 +3686,9 @@ static int btf_repeat_fields(struct btf_field_info *=
info, int info_cnt,
 =09=09}
 =09}
=20
-=09/* The type of struct size or variable size is u32,
-=09 * so the multiplication will not overflow.
-=09 */
-=09if (field_cnt * (repeat_cnt + 1) > info_cnt)
+=09if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
+=09    check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
+=09    total_cnt > (u32)info_cnt)
 =09=09return -E2BIG;
=20
 =09cur =3D field_cnt;
--=20
2.54.0



