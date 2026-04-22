Return-Path: <stable+bounces-240272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKNrFixU6GkcJQIAu9opvQ
	(envelope-from <stable+bounces-240272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:53:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9980442048
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 448E5301E718
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 04:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEE2D97BB;
	Wed, 22 Apr 2026 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCP3d4lr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0D2D9EF0
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833576; cv=pass; b=flj7hYnaU68Yw+MEWi7ThZ9uHwrWttgMcCh6liCLRfddRr1B3oyfCLNMaaPTbLtHFDubS8G7xDXlASBey1cMGj3+Yc/iAfLI6blqWvncctJtjakI/rwiQsrbv4aYmLVjhin02n+osJ+q/ZMUa5i/1Ny/2H6ZMEbPM/BIRTEem7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833576; c=relaxed/simple;
	bh=q0Y5z69t7EnwFRmoQuriHXgrdZschTXv+jqPXtob9f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j25kKe2igaGdV6fYdb+ydaUXMQdMcSdCB7mrXEiTykUEmk0pQksCIzHAUEak5Mmv7C1i4K4wbUdXCcPLGyXriqOeZFa93SiFB4ZWGEIqsJlCO6r8ZKz3nCNere+jFmF8F6Xsroh+2SM6cX9JkHcc8rZOTjFCP1NoKIMTaZtPbL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCP3d4lr; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba60d78aff3so504740066b.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 21:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776833573; cv=none;
        d=google.com; s=arc-20240605;
        b=Kf+IQygL5LcVpWC5F9wA7+zXLWPNcL797ZTvH/YsavqTw4iNfDZhuISwKiFhY2Ox2v
         PRZs1OZaUYxL2e2Hy0GFFoMfZrtDnQFuaLQI5VLxVhVPVA5e/I6BXIG1VxWpTc1x8LEE
         OGgGYrfLdb7SzG3YyU1HPJvJBNgh7Ra51Svle1N9cPVRUZyDCM5nXUDnBAOMUI4E8YOn
         IL4O9I7m7M+3KfdkgSvdxx+x6T6bSM4+KPd6v/lC7dmBE/n6zG45VDYVDBWXnuaNJc85
         RRKHG4EA3KiEQiyG4J6RWkcMRp2sspBKfBKcIhu1tTPd/gEdsSP711A3A+tDlnsydcHU
         /3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Htvix0mRwzhVxf5R0Kf0KLjebkh+Pa0xXAtyZO4Zg+Y=;
        fh=8ZPgIOFxCPRczatWKgwP5WLYuEjAVIbPbZ9X+w+xTNc=;
        b=OF02ShUsjCJHwvnjeUha1YrYZuyOMy+U7YhFG1gxO48VvStFVmePNqQf7GqZuPvbP3
         zV+lW0l148dScCTLGzFX4WFZyV5ZJRgWPgxf0TrNsp8clx6uRLj0G17kqzn512nAbdE1
         LIyQAvoJFiTIB2YQFE6km4nP8ufmuK1P8chuA+1s8DegLrBCp7Uzj5IsUdXiYKr7Omdp
         S76eeh+PXzEGbAxWhF7C11L9BE5bnl98ejNQJBAP1wUQOPy4t7svro9dA4x9ph/PTp8S
         8kYdLOY1z873t0WmKNcE/4Uf2IAtC6pUmqg71hRGZEgjaNhsOJED7skHqWjg2ALd6kHE
         45NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776833573; x=1777438373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Htvix0mRwzhVxf5R0Kf0KLjebkh+Pa0xXAtyZO4Zg+Y=;
        b=tCP3d4lrYB+N6n9YLoONNGOzhjcyb0pRbOc3cMgVjAYsaFF2vLnSnSBP701tsAJbjj
         n4tuB13JcqV93ygi23WPz7zf+5gjpUyvJZpoy6IGj1hCG18DqNHlw8VFtY38148D6cBq
         rj+DUepD+WqTAtqPxXM5CK7lhmn6dZNi5gR6lRlsX3Ix8F2JmeTFFdPzzze2DupXECBZ
         KsSStF4FxJB1nfKa/VcqhyqEjIoqphPQ7tS7X5kXACdw92eQFXjriRZWkNumLTd6gTyt
         5YKIP4YREKgV2fxj5NWalDsqeFPzbmr6U1s1Mz4CxtNVbOldqQCLhodJSCvBE6FmL+4l
         XjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776833573; x=1777438373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Htvix0mRwzhVxf5R0Kf0KLjebkh+Pa0xXAtyZO4Zg+Y=;
        b=mek3DGV/cKFo9Y6z3krX4YgFH0UUl9GKD2V6U3+fC42AmgGH/P9rQzT2kaVxXgHUxr
         czFntm0yQjNUgUzNAEftThavzWivlgKC8jtcbnRxfpp/Y9ja+YlAnFPM7+AXV0yzcGTM
         cDhuHs+jke37ud4nETTwuNVpOd5BM5jvKl8jWzpF9WanMuZNv4EUFDL/520OK7FR77ia
         eaa7SjqjzeJ1gcIdWF/752oEJg/hpP/wZwwvEBmahpE9gzdjW5xUdxPY/p/v082Pr1Zt
         XxIC0gzq8tOpN2jXhuR8/0+rQD/kwNrLUjPX25IpQGqzLvJUOEe8Vf8YFudMLs6qWxHe
         7Gwg==
X-Forwarded-Encrypted: i=1; AFNElJ8lfkJd223XIBN95tgTzrxbddNI8+/Oj3DfXAHy05inxPZDz6cmp1+WTbjlW3MnAkszB90tHdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wJFh0z5zY3eXHUCI+RSLgwCpuafEHfc6QY/y5qzkzovW/hqx
	gN940sAki8JgGcx93jCIvzDpsMC91Hf7J5dPL+//1UvOc9S8lViC/5vUoMN2XblTm9mqF0U3IkK
	XDr14i6opvYKBQXpbNZYDhAeopYD6gnTRhHi9
X-Gm-Gg: AeBDietlMddajm/dHWQpeYVGkN0CKr/8QEozS/LK4nsmnU7I4lrxcd+ROoekvpN3zsz
	OrKICnZb3MmT3Z1fR7hJM/cSFkZbTmUp19l62xe+3TQv+BnxUdMJZVUBwnbKWX6655fdcKNgDhX
	/iZ4igMGu/HC0TFCZxXPralyNXQQeEVcdSkGeNNsbWBH8HDbryhsDZWY7E4GwxCH8MP0yIPJyiP
	Nr1rCS5Uu8DlG863zX29IFMilv86jTG5vtMV+BaYQJpQTS6TsRyQnblQlMBYpxAsTSWTkC6IAs/
	Q/O0qsjT+4ViEM0H1fq+BMHdY/TVjJusT8NktGJBMHnlcq10V+EvbPTCBV/hMgA=
X-Received: by 2002:a17:907:1c27:b0:ba7:c8bf:dd94 with SMTP id
 a640c23a62f3a-ba7c8bfe835mr543875066b.33.1776833572885; Tue, 21 Apr 2026
 21:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
 <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com>
 <CAOQ4uxhUn6oCBuVJqZu+FcMx8XeAQHZbXFAGon4Xeg2SPLJW_A@mail.gmail.com>
 <CAOdxtTaWWu_7eJWu68zf28zHQP3Y--vXTfbGFsceO47BpN3qxA@mail.gmail.com>
 <CAOQ4uxhCNhGinePrnkSfT9Mtf4o5FmBX7mTA2m4miCMOt3mJqA@mail.gmail.com>
 <CAOdxtTZGFxaayJpqsiFQrWBqXvDn7oyxSL3_9TWP919k0FhWTg@mail.gmail.com> <CAE6nXrPes8T9Cn4ihTt43qmtgCCZvmMwYXo-yG_HJgNO7y+vVg@mail.gmail.com>
In-Reply-To: <CAE6nXrPes8T9Cn4ihTt43qmtgCCZvmMwYXo-yG_HJgNO7y+vVg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Apr 2026 06:52:41 +0200
X-Gm-Features: AQROBzA7_yt5-Xb5zZQao-gRyDtlaRD1k1RwPo-4_dBxDZOooY6wSqAWKd1j_dA
Message-ID: <CAOQ4uxhfwOU7O_vEQsAvRGV-v3_Dk1RcMnwGx-xOpx-FYjoKcg@mail.gmail.com>
Subject: Re: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: Samuel Karp <samuelkarp@google.com>
Cc: Chenglong Tang <chenglongtang@google.com>, Derek Taylor <ddtaylor@google.com>, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 
	Kevin Berry <kpberry@google.com>, overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240272-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9980442048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 1:54=E2=80=AFAM Samuel Karp <samuelkarp@google.com>=
 wrote:
>
> We can fix the test case for the "volatile" option and expect either
> "volatile" or "fsync=3Dvolatile". Existing use within containerd beyond
> the test code involves us producing the "volatile" option and passing
> it to the mount syscall (or _not_ passing it, depending on the
> situation). This seems like it should still work if "fsync=3Dvolatile"
> is an alias rather than a replacement.  However, containerd is not in
> full control of the mount options; as part of snapshot (layer)
> management external snapshotter implementations can provide mount
> options to containerd which containerd then passes to the kernel.  The
> protection in RemoveVolatileOption will break if a newer snapshotter
> produces "fsync=3Dvolatile" and provides it to an unpatched version of
> containerd.  I think the breakage scenario then becomes new kernel +
> new snapshotter (producing the new option) + old containerd.
>

Even if kernel always shows "volatile" in show mount options
the scenario you described will break containerd but that would be
a snapshotter regression (w.r.t. containerd) not a kernel regression.

As I explained before, overlayfs could add a new mount option
fsync=3Doff which has similar "do not reuse this workdir" semantics.
I explained the correct fix to this situation.

Thanks,
Amir.

