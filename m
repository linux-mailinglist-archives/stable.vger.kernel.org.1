Return-Path: <stable+bounces-240133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEMhBUxd52l87AEAu9opvQ
	(envelope-from <stable+bounces-240133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:19:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F2343A079
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 379DF3014FDA
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D663A4F27;
	Tue, 21 Apr 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgrStmFh"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D5231832
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770375; cv=pass; b=piYInZVP7sO4Jl5burTQ/uCorECwmNOPQT1W58G9srrkNAMJ4rmlnSr+8OYSBpzV/K2QC03YLsmHl+pe4RuQLj4Zt3TwejCe0flw4/zDn/F149ZRUWZmL8o7+QtRshILaizAXJEvxh7074T+5vX1JHQpV/jpOPXDz17masxtOd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770375; c=relaxed/simple;
	bh=jvHB0tpXLL67tt7aZ4GBhjJYCz/hwel69VLAp+NB8Ic=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tHNWiZuKQyden5Y36nR1ZNJ8Dzqbu+zEZ6OcKXDvq9np4HTIJ6Vg2Cztn/MA86BrTBBup5lpaYe15jbVnNm14ds91TAfx/QUSPEcyFqSwgHad2coGXHaokPJay6kHaWPRfiqfSV/C/Y87Jecm5WypPXhGcDfrfwPtwZVYcNL8Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgrStmFh; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c373ee97fso114812c88.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 04:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776770374; cv=none;
        d=google.com; s=arc-20240605;
        b=aXB216Y9yznBCiJ0AVl6SHLDkIZu1r2+gFmmOH/ymVfpZXjVIRbmoBR4KO2kiJA2UJ
         IQ6BCC9loSQEzyXQEjtTjRY9GiKghdrOZ4dQkjGC87wGiGPlAYEbIRsuBTOfboSodGTV
         hANw8wNHyW65m5u59Ef5FFWX/7fNBVDh1yJ9rFDyPy63Ec/8YhZYQGSanbWigLbTE1RV
         GLwSJKBV1/TmrJTzRr8+WQtDLCQTxp/uoeOdiNrXjcj16JvL1+ofwDpsACLkwi9/xoJt
         bbc0S40+0zGE6m7ugFWX6WIIeqa8utbBPTbJCTGSLbJT/1Q+M0UGYrHS9XpUBnCEEPcV
         RD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xqUnRX8dW8RdIIKAQHBXv+iPDb7VMQOQ+WS2QfdoqP8=;
        fh=JDGG7ZayOHq+Rk5JjpwWhgLnkLiyHUGE2YsoPjDwqB0=;
        b=QlJGjMQ8NTLVCkELeNbDJ2huVpnm+GXeGqTUk5U8Qv0be4rOCgkxtwT188ra6Pqiy0
         5XSC6NNOTbJPPb9MBzgfWsZBzm75D2IhzpTAc/dbcYyedEyKDn1IFCqFNtGfqNAbaKNG
         lnE3Ha7ue2so2EAyXZ7ii+zu77e67QmVopRjCFZo4aVtLGimulHwtDr72DQMre9qd1ih
         0lpzR/mM83zDVjV+PnLbGn9czSB8swv1fWdS9VS/9fQYbN6zk85xYCtXwZofv4GTbU43
         9W5DZFBCk48gm8ME8ksTg2pi0S9Yxy2tpi22BEKAP7J2rXCQRZpNl8oF0+/pVWtE21XL
         X8EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770374; x=1777375174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xqUnRX8dW8RdIIKAQHBXv+iPDb7VMQOQ+WS2QfdoqP8=;
        b=QgrStmFhn1bIXkKFlLozV5Sk6FDyl59Y/gvxUZT5VHIRRekGMQOHZ5RvoTzVVHNTip
         DOugjoNJF/Apzzk+A4eK6USrvv4DNk9EP9rufIZoUu2Cmxfh6Zhit6KoFiXtwunmY73Y
         hk9zFgc2nKqOrztOnfc6Bq92XlwViSrhzh0wiLFq2N8kQBF/gQiyb8kCL6CkUaGwz4tK
         Wpj176Blz+CrmmtNk3Rkpn1kL1Tvo7QKYIWJfQkA2EKjDL+vbWIsEW4fkGjro80EBEc3
         uubHY1/eYdGU2Dv1hdEYdgTT1I9DfmozyhQPVix7+084Hn7g3ZqSW1maV1K+lTEIxnUD
         FE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770374; x=1777375174;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqUnRX8dW8RdIIKAQHBXv+iPDb7VMQOQ+WS2QfdoqP8=;
        b=oG3u3t0AlVwxOhVqUXdOf4X16YwdOUJzkm3hlNytSfL2fpLG904H5TtUL/S10/jnJ2
         9voMplI2dtVSNumj7srJiwqhPRezBE+x0QZkkC/MlZlb7xuTvB7wHEDp5L2faXBjyk6y
         yHiajCOYkd9WbWL83JrK33Qf24+FH4Kfykr5LiiXiGJfBd1N7pq79leeqcaQdDuPN7n7
         1XRZxOgLu5ew17RcktmYMzAJzKZ44mCbqhMxAfhBR4BR72CcTAPc6ZIEKx7JYD0THZiX
         Akg4TYD222OdRzNp+osEj4ZJxsDr3TFHCru+OwMuf0+4XycoNj7P89/yo3gaP0fFK2yh
         KZhQ==
X-Gm-Message-State: AOJu0YxaYSr39nuvSlbz2SWrjCNGSJ6GuGXjaQFpVvJhOt0cknu9d+Wh
	ANLlA0+JAuU+1VR2AGblM4CCWJGWpy07iC7D+7SdJ2Y33I/1CJHa+e8JZrMwopOi7/l+vtuUk+j
	rKbGi9J7DcLhrtzd8O4/useB2NtKptmceTsRlQRA=
X-Gm-Gg: AeBDieu3piLny/4uid6hGq6kqXNmulblk3GMdQGzke1UvV1eLATDn1RJpWgoAu1UtR0
	tgsbU9Qpkx/rdNf3bzyFKzG7+06bbWyTAhhlY9x5EGl3LczCYqT74gVv/oipdHsPn7lNsPZyXmW
	5DrGKQlCC4bjSB7P6GdkGxGieZTTPais7mA6yo8dXxyo3Of5sDxHIXNyVSIuMdUStEzhl1JMP0b
	N2zqjJXMsU16ETeOWFIcT8cVBc0xRDakdWbwkxRe6ZLErP8/5D7A77DsXogrOqEFrGkvC2D/Zp2
	uG5DAujsu8f5yk7E7CDS8SC4l+AgZyFaOgW6B+uhS+RH5glPw6uuHKgNT8XeF1CvPuZ27z3DPSY
	lRcBzeZ6H3tZczjDjZvWTnOKeJLn3ceeXpCBirKQ1nw5G
X-Received: by 2002:a05:7300:e9db:10b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-2e6b55a8630mr1682892eec.0.1776770373605; Tue, 21 Apr 2026
 04:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Apr 2026 13:19:21 +0200
X-Gm-Features: AQROBzCRQ4d_HZtiqcwbiuJrOypsymY-L2f7pzkuHVSAiEIU4HYpdYKlUlKJEKI
Message-ID: <CANiq72nBCnXY5rmD6N4GBO-rfX2ZVd=PE2kcDscq15jEbLWs+w@mail.gmail.com>
Subject: Consider b2603f8ac821 for 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240133-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7F2343A079
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg, Sasha,

Please consider backporting to 6.12.y:

  b2603f8ac821 ("rust: warn on bindgen < 0.69.5 and libclang >= 19.1")

It adds a warning to the Rust toolchain checks (very early in the
build) that applies to 6.12.y.

It is not a big deal, but it could avoid confusion if someone hits the
toolchain bug (I noticed we don't warn when I was testing something
else with another toolchain for 6.12.y).

I also plan to send another similar warning to mainline, so I will
also tag for backport that one.

Thanks!

Cheers,
Miguel

