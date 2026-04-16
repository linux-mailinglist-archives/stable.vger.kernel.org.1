Return-Path: <stable+bounces-238254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCfXFkd74GnlhgAAu9opvQ
	(envelope-from <stable+bounces-238254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:01:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E397E40A88C
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 505F13037908
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAF37998C;
	Thu, 16 Apr 2026 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr9r3RDR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291C37997A
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319186; cv=pass; b=JskQ/BuI4AedUqAHzuzlHKbY9F2X0oe8khAF7Q9loSwNrZSLy6FTs6U2noZvjy6IqdBQ1nXTQcw1YwxTKJ6q8DNlB38AldHmXVz1c83BPkTngF+gqNOLlvyiHUdU2tXp1mLrsZwQ3df3+IHJ+EtP4wJWgNKfJKUc5wxglSYiYCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319186; c=relaxed/simple;
	bh=JKPf71L+a3LqSTtuaa2E0MYmPTNVdq5Luz6eBlhQBZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozmbRwcAK9oGuSXvmoj07o+7AoqsqwoBYwE+XZ8cszBNmBOIxLEy60AOTNq++hOCSZNee65yZ3JXaSUx10LUVMdPFSmbgi79Zm7mElSWCzTmtwq5tlshnyQpPFryAHYGhz4PeUJ4qSbiGaK09GV/4eMJppNi5z0lxLoNGkiL80E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr9r3RDR; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6714f678bdaso7445247a12.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776319182; cv=none;
        d=google.com; s=arc-20240605;
        b=fUpF15uWU5fMcuQKIrfw8bgJAAWnXtwV9KwEwPM/+Vuy1fOKD3Ec3YhAmy6QkGn29M
         VO0OpHZUf+56dnezVzmkm+VehfaOYodHHSs23XOO/fAaK9vpWy2vQLQb8jBl93ysqpUK
         eBEyTrGwFB8ZMi8ETKsTB5gIo5DKzFwGWL7YIAsl6SltY3s5cBxZovxWM2jnl2PYpfXH
         7L6bzpag5rbKBAsnr8VtCrnU9TeaWtvssd39AKDYqOhnI19ijHiBon/bx6IDqM5ILzb5
         PXDr1++nequ1UGFByO3v2n5IXOEyIRjneSxhueVbYKurVYrlNUYITOUCAq3mFnDpqUzq
         BZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JKPf71L+a3LqSTtuaa2E0MYmPTNVdq5Luz6eBlhQBZc=;
        fh=rfeZEgDVczR4127ukazChfBZTx2uUdOcaYUejRIJ4ew=;
        b=eewm7zOro3gVRCgJ0MaW7udpjJ6X/bTVYP8SeH3EmOhlfR6Djy7k8oIR0JmciwTdUF
         ngigKLVRO+8Rypkem8AyyHYTn4agOEKpQOhacCf9Zf+vL8ViBEwHIXR/PI2OBX+1fL15
         QA3GTiNs37IIKrmbwiIZbmpWhdpaokstHd2aLcX4JKCzqEFH46tcG/N4F92wfe1P1avJ
         DL4+TBVyBZXQF38Yt9a+1WOQP+Jo67Nadpq0GXxc5gBQHuOKliGbOExcNhvC/Ja4/ADF
         gqHZCT5UWBioEEsqLGQMAm/D9gvhIHzuBGngrB9UVT/7wWsjB+KkNvblRZSeRII6zW38
         /vbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776319182; x=1776923982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JKPf71L+a3LqSTtuaa2E0MYmPTNVdq5Luz6eBlhQBZc=;
        b=Yr9r3RDRcYIfEB8+f6iJ1Cx8CHIeXhQM8tITHnuIx8r46ia89c0fGpqfvLW6MAb61j
         j0hDLRBGjYma1OjnBy+AekkY+YlJMNN694LhJ7GS4Vyinnp9MI7K23/z3/450GkhDWnC
         yzFp0wez6hnppLDfXUAJzd5DcZGzA4xyd1LNvvAPzUT3jOV1Z1cfuBsPlYx0tMVlVUZi
         5O2Dfs5G7MdB7nGZxBkRCeeBVbf0v+LbaytWFo3Nh6fZq1t9B1WG9E6aGw8agMsyXnGA
         Dw00aKJPaCWEvNr/Nu0fvjNYp1ZbxbZFNrD4Fxkr5NtDm1RRGwFlskVnVjDoeST6vGEY
         U3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776319182; x=1776923982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKPf71L+a3LqSTtuaa2E0MYmPTNVdq5Luz6eBlhQBZc=;
        b=c/kRA2NnZuDjANtWHVRIgoPjVwbi63sUqWCIymTCGDgGtfFv6fv05ztQXKnGCE2gbK
         HffnLGq6ybae58eWwqLU6s0AVNjAMMSV1g/uI9bxmNnCKAQryqVfy4cZe9ae3id5tqiA
         1ew70RfeLDAskuaOLppNXX6QPCXPYVY8RoSII3dIYHUl+nAOOhSeznU+65NZmKenCWcb
         eZ49kjvt0wjrib4LVgSm/gk0bATY5+jW093zfikQN4f5lG8s6dARyL2Yv/frqN1A/4Se
         9lWJrTlO6Pd53hY4wH77kZz59majBMDPsauhPX4eax2AJ8ay9oo31kILEO0PKt0o1cBR
         6+fA==
X-Forwarded-Encrypted: i=1; AFNElJ/N4enax3Ug//n5XiYHA/kkemhD+mKUbyToHAIKjmP2tXzpMKYTj1Xoy6jetP/CQeeWSNBsxYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjirnRqSOsSRH7Xr5EwKVbWDCDKYPzG+Zew7BEHfVsywv0rRxE
	UCkIt9DMymwVwqdsPNkWwrah+Lv8ZmnLa/10qk6Hgko3MJDcji9NBgUGvgRmk3kfzapMKIFwWA4
	4gUmESOrRdl1qA+329+nq/izr5g2Knbs=
X-Gm-Gg: AeBDiev7mnGQY4HNir60z09Y04mt62pvYsTvmJbhKwOrWnKGBM6sjYcIRuUDcISjoOC
	g+PL4hra3VMSxd6iNl3FqmLCkLGSQUVNBBSp3F+fCJ824p4diMCEhnDi8sYDSl+EXMAgZAenvwh
	bYfcH3h4BiUkaz4yM9GGIVQja/Fwmi8xyD9Z/H3BACrotB+3ooEBXxjujvNzVtGOqhwQ+l0dOKw
	zLG9x7qCu3g8ZkQqN1e6fHn2US6PxpdU6yqQwZixXegf0y1mSx39EGaUbbICQORejQQoGTFoGpI
	lUNiukBWyLWcvvgq
X-Received: by 2002:a05:6402:5213:b0:670:2ca5:bcde with SMTP id
 4fb4d7f45d1cf-6707a47083dmr12515365a12.15.1776319181943; Wed, 15 Apr 2026
 22:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413191110.1508848-1-henrique.carvalho@suse.com> <20260413191110.1508848-2-henrique.carvalho@suse.com>
In-Reply-To: <20260413191110.1508848-2-henrique.carvalho@suse.com>
From: RAJASI MANDAL <rajasimandalos@gmail.com>
Date: Wed, 15 Apr 2026 22:59:30 -0700
X-Gm-Features: AQROBzBvURAag6kkCQysFO300zpgA-jG6N_ldgV9cbORFW2KEzDPMdLmWLWMLMI
Message-ID: <CAEY6_V0yKt1CbbyY44tRqD0VNMpPDA+e+n2C0f-FtOchxx2FYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] smb: client: pass correct from_reconnect to cifs_put_tcp_session()
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	ematsumiya@suse.de, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238254-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rajasimandalos@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E397E40A88C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Rajasi Mandal <rajasimandal@microsoft.com>

