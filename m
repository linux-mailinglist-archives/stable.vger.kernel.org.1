Return-Path: <stable+bounces-204579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35517CF16F2
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 23:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7388300D484
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F131BCA1C;
	Sun,  4 Jan 2026 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdVLfaek"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8D52F88
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767567138; cv=pass; b=A+gccZ3k8tkfkPpioRuEI74t262gSWT/vF/D8WE25B3SQqtx5o9rrNbelDuMotZsofh5mCy2KBp65FuKRU9NqyxzanZ8agyO1PeWDfku9MunRaa9MhRdH1ePy3LBW2Mtn3fZmLgkFODD6iE3EKIy7Qs0zUwsyH+9ukTo7s3dESQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767567138; c=relaxed/simple;
	bh=uqXxBwHWbo5Zo2JzoF8qIRz4tma0TMZGEbKFIlYif2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JG2nqKj2cQ3qawNPZ987ZiKtBTeYiPtlGOAgrmOtxzBRh/PVFLhTxGdaUGdhC7SMbO4RuUv+QTs/YRuGKFgiQmgV0Rw+gLgTtuGYTkb3iRqT6TPwIgPxvIbPfkWCLYHq+omUANLcyM6rNPZlHv1gVBp9cgnzUgoYjBgsRUwiUVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdVLfaek; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0f3d2e503so25878835ad.3
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 14:52:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767567136; cv=none;
        d=google.com; s=arc-20240605;
        b=hOPQ5O9L0u/CAMK9u16tkFPqg56jMCoESKcnQ3EoiUjCJw/5axbS0ppB9IUZqQ3EvX
         L0f1m9tjdblOQVhr77n5CgLHITxkXorsS+nlkOsuavtjlr602drhqcKZkMN04fnuL0Ja
         VNf/aHwxwID6+8BEWAKTctDHjuJ8Myrctkyu6fTtQrHdObEZ7pUPF7Y7wYk1ma4Wutxb
         DzzRaFV06sPzuyatysYNmaCLBSoSXFPDyqMBvtJOvTx1TGG4OYTv7zi5+y/Rmse0rwoi
         2RtBD1lhyQV3Vs70DKL24e9bSecAl3ovahqhGF0ZOCtci8wGS6Dag5RNbPEUwNOzWWfc
         WGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UsPcJFBVO34YaALgg6l28DTs0EvBvSjIA/gYP9VDYDc=;
        fh=vMlFAgrPpCCx33TClyIayTOLRdbTEXMHBdHt+xhGZW0=;
        b=fe6HhCsOwd/LZxZ1dwOq1QMSFoQdZT43+sZzBkkqeBL3KvOjkzzuydw+9oN6av8jei
         IMuRDXVupVovRY+L6eM5XoaE1z4R9JM+M0YOeP9B9cd9RdTcM/auTpmymUEk0BiIBoyG
         csPQJKI+CIxTyak9Jo8OWiinSBs39oil0ZZnECFYoDu+xuXjPSFpUNtSzJAkMta7IxFi
         V/Wt4qUyHZKqunlldI7VaNLDYGS5mhT+JWOr7gHJViGiHv9vlz5PxQ1EOukkPN5uxRut
         OAEkgY/lUHbxnngMIJds3q8KBKpCk07vUHt+SZIMz5Oe909j2mnDQ0GA348bnzQ2CF2h
         jQtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767567136; x=1768171936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsPcJFBVO34YaALgg6l28DTs0EvBvSjIA/gYP9VDYDc=;
        b=LdVLfaek/YNyA3ETVjdi/g37YYBM5s/hUajDREw1YoYkwEAJf4v3xql63rZESUg32v
         lHxlLoeWW7iBNR4GJxsPFBN2hHKtpFl/lURAJN/K0i4j0Tr2TPY0UIdewQ2BDZV5eLcx
         yOgm5SBOSzBxk1nzfjz+mgVi3CYwz+YxXNNot6a0A2I1hNSrSslEbJQ5Ry3U9oyAnBt1
         4X5KUD07WOMrvKyjGDNy0rxaniN7WwrkpIyz8xI8mGqf5WgYaT/b7nd5e7Q41deeH44H
         M4aWSZxIRC/izE9ihpDoLesw9oaWhAJbOCgk6fVcFifFkrI5c732Jdw2VEY//WfkCtUC
         7Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767567136; x=1768171936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsPcJFBVO34YaALgg6l28DTs0EvBvSjIA/gYP9VDYDc=;
        b=gCOwk1YFFLt1gRr/DYS2NDWnnXoAYQ5tPrley+aJ03YbXw5WtMoTnmGd0MOPRLXMcA
         VdmmOeo4tJyB/fSRH3eReXq6ke+E1W24jxsmzai2B0ej7b6+UOp5fEL0M8iOFoPHsW9S
         ZYKKSSkZOwaQRLjC1BtLzuERxqZlBqLm2EQUrz0TfCuYOwX/MbQEjSOlk2e3szFJFLyV
         zRSCKPWCjdhL52gPP+0KRCuKO7PC+UgnFgprEmHfkwLjpvBgKFLQktsz+Gm08O70/hOe
         KPwkhuUWUTIM1eSr+ETDsiN54/D0BrdinGUSui74eq7Up+atzdmBhIwT7Z+9FqJOhlsU
         u8sw==
X-Forwarded-Encrypted: i=1; AJvYcCXi+pGl1s2IkElWB8x2K6yLpIT9snrIskVYdrnFGVkMcwgMVe537m3HfBb5dwa3A3ZuqLiB/zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtyZYBoTn/fZVkxPViJidvYLiA5/sf2vB22EPjhn2HNleHg43
	B2XW65b1/Rv8v/JqExmiiY5KV1nLTbXnpVX4f7xutBgrz8KhbKpiEFu4A5jr8FXBi6uKNx/Ul7T
	0nn1JfgNE3LczLM1brxV8rgVo2MHegZ2cxwKR
X-Gm-Gg: AY/fxX7/PCoxBOHUP2r0jcpIevwz17fj0dh0QhX5TtuF9vIJiiztK8YOzjqZ10wtwvK
	wJor89dZt8R0FlcQzUuJY6vBGybmcYUls9COnXstIKjp0H/Tlckg/sGgx23rnPwpp5pB+i3f3q5
	P6RK5xOEADX56+2TxfxLr2s1AfFTjNIRqYhdQfNM/VAwz3YPKAYtA4iZYJs8uItcg4uh9XWggje
	LhEOPusU9sjg36MxIJ6QBvYEof1llzZOtSRWTZyKimn9LSAEODI8u9qIhb2OWwjsaz0E9E94f1Z
	VGgzLDxXApT+g92yFu4JB8SBrupobPcRypcWuzhoBsleKiGdm4LQmbZRrztrKzOgwuhVok8uken
	LrIVj5Wb19FDG
X-Google-Smtp-Source: AGHT+IFjdWlI9fa28xyoXsTLzHJFvlMuYEku1ExWWMX5x34jQA9POry0CbaNKye+0KUFSfKOCmEfIIkvCxCvYTnHbiA=
X-Received: by 2002:a05:7300:881a:b0:2a4:3593:5fc6 with SMTP id
 5a478bee46e88-2b05ea06747mr22789159eec.0.1767567136240; Sun, 04 Jan 2026
 14:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <JH0PR01MB5514E3DB07FC77EF0AF59C38ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
In-Reply-To: <JH0PR01MB5514E3DB07FC77EF0AF59C38ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 23:52:02 +0100
X-Gm-Features: AQt7F2ptinLbLv5jyCFNxUUG1phYplvDiy_yksKwWS37bjOuiwPX9B1GSRWCK6Y
Message-ID: <CANiq72nCxJ=+4to31xYGQOASqtsRYws-bFoc3qGuh5sMyG7ExQ@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: rbtree: fix incorrect description for `peek_next`
To: WeiKang Guo <guoweikang.kernel@outlook.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 10:10=E2=80=AFAM WeiKang Guo
<guoweikang.kernel@outlook.com> wrote:
>
> The documentation for `Cursor::peek_next` incorrectly describes it as
> "Access the previous node without moving the cursor" when it actually
> accesses the next node. Update the description to correctly state
> "Access the next node without moving the cursor" to match the function
> name and implementation.
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1205
> Fixes: 98c14e40e07a0 ("rust: rbtree: add cursor")
> Cc: stable@vger.kernel.org
> Signed-off-by: WeiKang Guo <guoweikang.kernel@outlook.com>

This was sent earlier at:

    https://lore.kernel.org/rust-for-linux/20251107093921.3379954-1-m180802=
92938@163.com/

So I picked that one. I merged the tags there.

Thanks a lot for sending it, nevertheless!

Cheers,
Miguel

