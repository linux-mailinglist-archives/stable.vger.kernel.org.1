Return-Path: <stable+bounces-217905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKcaGAyXnWnwQgQAu9opvQ
	(envelope-from <stable+bounces-217905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:18:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D79186D1E
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29461304483E
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6B396D0D;
	Tue, 24 Feb 2026 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M4IZx3ZA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3645396B8D
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935495; cv=none; b=BIJR4MIVrb1HTErIzB/XVlOP/mAsY5lJzRtBbwVrDYA7MifN0op4x4RPnGfN5riuDJTxfNv5c6g4h7NWgKT1oVJNf5Qcv7sjAhRtRJ8t3FHHvjQcrPE0InKyr15bbYJ+BoFzSEIjfeyCysSvlpeGRff9tCrWQdUKhRHRlHbDXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935495; c=relaxed/simple;
	bh=mGFDCB6zIv5f/4lsb2IncY3zWh7oM4on0XtIB/lD4Ww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CPnytVgxsI16ur6Ydg1LiBQw5LU5geuKVAnIcgzM0upBLGNpE9VBjDJZ3JHVYKw4d0NFOoD57cDbWw3SactgNOewAXKsCY9h5R3iU/aBOHMBJkR6OeVLjJqMZvXljiKzeo++tMYBseVOPr+HFkb7b/Zrd5owEHrwZDKk30m5jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M4IZx3ZA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4376de3f128so3885339f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 04:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771935488; x=1772540288; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VcA092cXLqsFEZwXz9GnwUVN7DiPeez0PcJ7v+ltPI=;
        b=M4IZx3ZAr0KT0TRy2oRZhcRLmom6Xrl2UGYTOH4PxMV/+HCK+QUJgERjwao7ItS8SG
         dflLBfYVNyVS62qrwCztAQ9YiK9cqZBThhZ3dEOX72u8U0hCfEf5DpuNcbD1ULrKMLza
         p7PZpHG94EcjjibJJtRyzRTtqAc/Z0pDQvFpBQG2epO3kDJZPcJGgUKFSvn2LbXl7/MM
         JZ+TBaJiPjWkgNf/Q5HQSG1/CAaX4TrxXWyFTK9pwVbCrjsiGycoC/lpaf/qzqNiaaSQ
         7TJPzwmFJYnWTepIlG94U1ZMu1dCY/I4BYBlvzx5/zWCrOXTabCvHFwcaOv9v+Rtw6DP
         yn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935488; x=1772540288;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VcA092cXLqsFEZwXz9GnwUVN7DiPeez0PcJ7v+ltPI=;
        b=UtWWzLml1lr86afnCTaZl0i//GQDCUc/Q+LJL7kMQTi8EYDM2ApgyOFmpJvuAYQn5h
         kBfi7qcg1l0i1ky3piGmAa6DSCzegI+Xqt8K3hHA8pYocfnzwxIyADyEIExZcM71Tf1W
         cH/uVkLmcfcBoPxBREFnCEWleaLlM0fTOs9v2sRnymgvfX2D8jC6LdUk1xDiFeYDWQsw
         9ktLz8nlYMGNSvqHW62cauecMf7cFU6+wIdFHbPWynMiqaltZlBumOD492rslEnN+SuL
         kc7euZUtfdTPwTfvqRhHmLpRk+auGW/RjQM/kcGNzVriBOeBM+GTcIkh8DwFKK/UUQ3l
         uKug==
X-Forwarded-Encrypted: i=1; AJvYcCUdYg2k6pF0mkxnRw6rUpV9khN9GdCOFFovFrfCU5Ipw0xnfZpOCZGe95KZM4hjDhX+wk0Bl5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ37qeEnKbN6KWdgTK4YzNGMrEYUxaFwNm5wDhV++I1rlsiD1e
	KHKzGjFbpj90WVYldFfJaqGBmlvNTLJO2+0OkykJ5vJ/OOoCh5cTj74v/GYAxdj03X8=
X-Gm-Gg: AZuq6aLSHtowTdybPZfU4kt3c3aZ0jBb4c0H1dnotAWGBhcSUyxS59ZVoNeX84OAk+P
	xBIBwJmnIRz+GH66Yr2rEgbPM3rQe/owaxKyOf6dReDWg9Q8LBzfpN0iZw9mNgu+E8NFMUN1q2M
	FtHRcr4xsovMDt0qMDneoUd4e3BgzlhM0A1m9A2ITrT3TrIDdrVlIudGfNmrYRUcdvg5Bi8abyo
	QQgZSVIOVrhMCnHgADqWJAcTPR+BM8F+NcgdVpxextgRP/iaqPdxmirN2l5qDe/4sKoiKRmPko2
	zt1dhxF+yG15ahS1q4vVCqULBBrikmhSE4cpT5RlrBE8QojcLgtQu44axo6dhe6hfvFCe1hz+ov
	X34QQTpfq0e9rzwcTd1/K7IHYz/qmbsGQMCetA7m4Auh8Ck4jjHym2N8S9kezbO0bjpvfLUUCBC
	JWb7Oe+J8gkIsL/F3k
X-Received: by 2002:a05:600c:1e1d:b0:483:702f:4633 with SMTP id 5b1f17b1804b1-483a95bd8fdmr210996605e9.4.1771935487969;
        Tue, 24 Feb 2026 04:18:07 -0800 (PST)
Received: from localhost ([177.95.18.0])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e58f9aeasm12352785e0c.11.2026.02.24.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 09:18:04 -0300
Message-Id: <DGN6PFT94YHU.3S3UXTP82975E@suse.com>
Subject: Re: [PATCH stable 6.12 0/5] Backport selftest for "bpf: Check
 skb->transport_header is set in bpf_skb_check_mtu"
Cc: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
To: "Harshit Mogalapalli" <harshit.m.mogalapalli@oracle.com>, "Shung-Hsi Yu"
 <shung-hsi.yu@suse.com>, <stable@vger.kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-ge2f19458bd3f
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
 <bd0277b7-4a19-46a4-9f06-96d48cbc89d8@oracle.com>
In-Reply-To: <bd0277b7-4a19-46a4-9f06-96d48cbc89d8@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217905-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B5D79186D1E
X-Rspamd-Action: no action

On Tue Feb 24, 2026 at 4:53 AM -03, Harshit Mogalapalli wrote:
> Hi,
>
> On 24/02/26 13:08, Shung-Hsi Yu wrote:
>> This patchset backport the corresponding BPF selftests for commit
>> d946f3c98328 ("bpf: Check skb->transport_header is set in
>> bpf_skb_check_mtu"), which has already been included since 6.12.63.
>>=20
>> The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
>> bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
>> additionally depends on network namespace support for BPF selftests
>> added by Bastien, otherwise the MTU in root networking namespace will be
>> set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
>> Marli=C3=A8re for figuring out the dependency.
>>=20
>
> Note:
> I have recently learnt that ideally we are supposed to run upstream=20
> latest kselftests on stable kernels as well. If a feature is not=20
> supported the kselftests are meant to be skipped.

That is not true for BPF, from my (limited) experience.

>
> https://lore.kernel.org/all/a45eaddb-9e17-4e82-8a78-a1d1f6e3d735@linuxfou=
ndation.org/
>
> Thanks,
> Harshit
>> Bastien Curutchet (eBPF Foundation) (4):
>>    selftests/bpf: ns_current_pid_tgid: Rename the test function
>>    selftests/bpf: Optionally open a dedicated namespace to run test in i=
t
>>    selftests/bpf: tc_links/tc_opts: Unserialize tests
>>    selftests/bpf: ns_current_pid_tgid: Use test_progs's ns_ feature
>>=20
>> Martin KaFai Lau (1):
>>    selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when
>>      transport_header is not set
>>=20
>>   .../selftests/bpf/prog_tests/check_mtu.c      | 23 ++++++++-
>>   .../bpf/prog_tests/ns_current_pid_tgid.c      | 49 +++++++------------
>>   .../selftests/bpf/prog_tests/tc_links.c       | 28 +++++------
>>   .../selftests/bpf/prog_tests/tc_opts.c        | 40 +++++++--------
>>   .../selftests/bpf/progs/test_check_mtu.c      | 12 +++++
>>   tools/testing/selftests/bpf/test_progs.c      | 12 +++++
>>   6 files changed, 98 insertions(+), 66 deletions(-)
>>=20


