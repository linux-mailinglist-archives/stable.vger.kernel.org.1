Return-Path: <stable+bounces-249353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLDvCGhOC2o7FQUAu9opvQ
	(envelope-from <stable+bounces-249353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2A571B0C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 396A93023E22
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF7D481642;
	Mon, 18 May 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcY3k3e1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11B283FD4
	for <stable@vger.kernel.org>; Mon, 18 May 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125860; cv=pass; b=tszqdCy+/pRXEcsmZG1OW/19+WUEomgsrwY5XX3W2yVlmx5ERS8KZkGWtxClgznO1ni6oxcHfqjPKisQv6JkidU77K6SgvPYI6S6MrqtlZR5/bt9aL2G2VSOgOyegf3KFMA6ePCAwaAsiKQIa6IVmjo/3E/7Zi+MHc0jYYktMCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125860; c=relaxed/simple;
	bh=/+eYJXH7gN4r65YNa1ZSXuRYVlMzoV2VqXvUAVRKLoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlR5VQbRVY+o22yjbj74S4J6w1rbIASeZt3X3OA5rxQnqwWKbDIF903+90p7AP4pdtrDhwyEw5JahAg2gqSztUah++7lfQbkej2gVZ3QlSCGrZ5pTHhO3RktFxM/RIB48v5HCqVa5B5SU8kk2/67+/sscF27RM+Vh0M8XRra/uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcY3k3e1; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso2638837a34.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 10:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125859; cv=none;
        d=google.com; s=arc-20240605;
        b=U5q1EN+jYfWAyVOF5ht/z07JT9xG85G9xcvI4bpA8uWsMIckmP6+BY7WeDjdvhOi4h
         O0HdHcREIyehdROHSVWQE7gYNwocXc1Om4Wi81PYq8Ev+qHSWEp/33tInZDyuqFvBp86
         qsfVcCPMjUpdYEFROTdYmL86PLee0vz8h4uGwg6/uKip8AsTgY8YrO6RXig/zJYx8q/V
         5aR17r6GKf9bgIuIng7gcNkNGNSREgQT7uX0H5Vjx5tyYDyN9C3ozzgxbpKawXtSiXbG
         Vj5LpZkDSGgzwBw6KLrHY6x0BbRJ/lv61uOfR7Ry2IiIj48f+akOm06PuIKSQExf6hJ9
         Vi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9hWrHG+EnJK1J/mM03YaROFyv2LHSAJiWvpkEvHUvW8=;
        fh=UZWXgjgJEqC53e4XWuBGUBRyYKJzC9dEe1+xVodsMSY=;
        b=NXsXJnVw2VvxpX571s+akeYxsPenJA2ILKkqP2Mf4ZMrU/E+IhPLia+mXFIUdfXqPx
         8x5GnjIJU/MfRsdsKtOQyOD3jmiRuT6zOubLpcsYOZ7V2Ayeg3GJBlpZ4jfsOUjN10X7
         EoY7kmBSg99JZV94FQHIph4riDHBQeS4mSTlkaqKeQRtEuFp0hqaiCiDjo/Vc5NUxSZz
         fuIK0Ds4h5QMXaOeBqt1NirfWVZIi5DhsL6eYYdVkYC3CTKMV3uv/xhVXlDm4e8F1oMS
         bJjUsbDQuflAhoQjIIdy6GBwPZaOo4Y8QY9jp/V/Zm4oaWSugLuocs4geIDxrnZ2Pq+J
         /YlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125859; x=1779730659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hWrHG+EnJK1J/mM03YaROFyv2LHSAJiWvpkEvHUvW8=;
        b=FcY3k3e1hOQU/GOumeuL9KDWzexXSdoFAYuI9S86/EfhgvwtJ8JTQZCg/CO6qP1VsC
         McOufRaFq1lE42lpDebyJRLkLKtkO3eCBi5g5i3soj9VVvOF9T2fD78oV4K0yYtoio6n
         Xodz/1qZZzCm4cX7l6S2mI8DtM3zirDBGIiS3hT2PLJYiq2LqeYNhLyxjZUr6laocU9I
         DPPwcpXSk/cP7TR4w6hpYoppRrnCWaoBD0opuwaDSskpq4nzlLhzEx1UdijHAatUVX8Y
         GswQQljZZs7y5efCxag9rnovnPpGkWGB1E5w0+qQpJ9JuXE1p2xBrnQIvPZDEwbVmEfU
         Fusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125859; x=1779730659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hWrHG+EnJK1J/mM03YaROFyv2LHSAJiWvpkEvHUvW8=;
        b=m+KK7AbhLSvCszKLsSnw4o2pMQH6vGOFkj8AycT3du25gESYAGRYYCPROKZ5b0DT8t
         pXVlvJGD5DwDyir6F0A17/GfVbYNrsyzat4ZhBjwEq5gzxnQ2SQwqBkpp0BZLKAgRVTz
         oVBJ1JkIa2PElNBoiCHc6Y550FqG0pnHx7FXORG9JK5xLvjkFJrSRXg5fjbPQzg+RxAO
         Fm6aZDOm8gT9a6i6Fav1ScFn6c1p9rcF+E/U8yi3WrcSQeeLbfyUA72b0sealvRu6SeJ
         nP/HSCoweiRJYsQbz7PhL2uBNVSvu6VIbFSq54zIU1Tnp98CV0J8PVrx8RQDTryuHEHT
         LpWw==
X-Forwarded-Encrypted: i=1; AFNElJ8iKBKLUcUiHZIEHGjuGoJ9Yg0KFwfZkq2joALfCsd9nVFxS3EmLCU+F0hTTY5T+A0pbCZ1EqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYicE7A54XVTIvLDwHMeI/cfIXRiJ/AXHC69HckpOXYlmbQKU
	1iSstq4GOuUajguLavFrnaf94P+he3y1HUP57Sos16XT5WoxUJ9R8LZogvKgJ4770iSXbgZ7UKc
	BssRWyD6X0Sy55EAwBTz6scm1SvneVbE=
X-Gm-Gg: Acq92OHCqVOMrJRgL3QZX5XkgyOKldKEefUhxIsY4rLIMXBflYH0iGS5i164GTLzkOE
	5hWZ5wRZG5Mp/Q42TE3EnXi7Xt7mgGterjDvZTL+9YwKpqwZXac233a4ddRIc9Do/Ks9fFl16a/
	7yAp60LY7DFHbtTD61pWcwbeUVIEauQwjIs4zdBBAG4XkxaK48RtDONwzeieSPWCdb+IRyFom3R
	IrWa5hfDkdoHQ7l1r8azuwypkNqEfpfJNkOea1cGojYKRkj3gVruUaAxaQcCYHrSOA3F8iKBap7
	tQJdTX7twyLsON+MGq7vmz7/aVkJPOpj1UvNXg==
X-Received: by 2002:a05:6820:1625:b0:69b:544f:b2e1 with SMTP id
 006d021491bc7-69c942ae156mr10711381eaf.2.1779125858555; Mon, 18 May 2026
 10:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517201814.222563-1-devnexen@gmail.com> <agsu4MoBYWPFEmpZ@devvm7509.cco0.facebook.com>
In-Reply-To: <agsu4MoBYWPFEmpZ@devvm7509.cco0.facebook.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 18 May 2026 18:37:27 +0100
X-Gm-Features: AVHnY4KnGBZIa09cahFXfBDEftiTT5hR2qvTT-rV9LDxP_wZ2F78wgLrb5sFiVE
Message-ID: <CA+XhMqzBHE5_zzqRhWnjo5K32S6rK78RgF_YvM-ut9O+XYbFig@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: reject TX dma-buf with non-page-aligned
 size or SG length
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-249353-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BEE2A571B0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > If the real exported already export page-aligned, why does it need
  > to go into net/stable?

  That sentence was meant as "this won't break legit callers", not
  "the OOB is unreachable" =E2=80=94 sorry, badly phrased. The reachability
  doesn't depend on the exporter: bind accepts any dmabuf->size,
  allocates tx_vec sized size / PAGE_SIZE, and net_devmem_get_niov_at()
  indexes tx_vec[virt_addr / PAGE_SIZE] with only "virt_addr <
  dmabuf->size" as the check. size =3D N*PAGE_SIZE + r lets iov_base
  =3D N*PAGE_SIZE pass the bound check and read tx_vec[N]. dma-buf
  itself doesn't require dmabuf->size to be page-aligned; rejecting
  that layout is the bind path's job, not the exporter's. I'll rewrite
  the commit message around that.

  > why not do this check on both rx and tx?

  You're right on the SG-length check =E2=80=94 RX runs the same
  num_niovs =3D len / PAGE_SIZE with gen_pool covering the full byte
  len, so a non-page-multiple non-final SG entry is malformed there
  too (no OOB, but still wrong). v2 will hoist it out of the TX
  branch. The size-multiple check stays TX-only =E2=80=94 tx_vec is the onl=
y
  allocation sized off dmabuf->size / PAGE_SIZE.

  Also taking Bobby's nit, dropping the bool todevice.

Cheers

