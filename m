Return-Path: <stable+bounces-216594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCIKMtX0kGkCeAEAu9opvQ
	(envelope-from <stable+bounces-216594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 23:19:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFA313DB15
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913D130160E8
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8381AA8;
	Sat, 14 Feb 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPytxH/B"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917842F745C
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107536; cv=pass; b=MDtjtB3GObqCE5Ob9tZI5M+LBKsD245/Xa04c2bkBsSwXr5DH1TtYY5F1kpWz1afubqiKRGzopXHBLsZTsS8unr+JOFFdX8vng30EeuznpZ0oRJC2N9Cf2Ib9OhaRk8A9DUVYWmoWd2JaktHtwPBWOWOc0I1vbh564nF0Z0HL9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107536; c=relaxed/simple;
	bh=aLYUkEHd9SSbNnHq6tCKpj0y2iLuJRY+hRfDDQclMPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVx+OPVcgxhXfIu3cHNWjT5ORV20NYxtBSsRvtAk+UqAk3+QLHjtT7dX/L31bX0hjCM6wRuIjW9vRkZbak+Wb6jMqxgDdYoDnH5wzRq0YpL4dlz6expoXPY9QMsBJs7Jop48CDNPCvbMpH+gpavssYDlsJMz6vgy0UkjDkMLKEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPytxH/B; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2baaaeeadebso92868eec.2
        for <stable@vger.kernel.org>; Sat, 14 Feb 2026 14:18:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771107535; cv=none;
        d=google.com; s=arc-20240605;
        b=XG7A6GX9b8nV76CkrGUOXiyvSOgjTKyKmNmjsxDj+RZDikofx0dZ0ti0lskJOOSdqn
         xyBq/wLAjON2SZN0AxLtvI1geM65Ccrnydsgvnwv+eYX9cCp8cv3Jb2nX3xnISduAJ5r
         ZL6CU5SeNFEDQchsDC1G+PuoYih6DgsMaGmkd7GYCUmHbcxU3DLdTo6FIrIeli9TP5d9
         Ij4R54eHhangSed6DO1+zzJAYr+ma3eWVMU+WBdl7t4PKL3zoXAT12ydJGrqMj2OQX/V
         x1tGt1D7lGjcRcXoucO1YcjfRNZkKrT4dqJqlEcfdX1YwKBJphHtixP8Pj0VYlfWHB1O
         AzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkTOOQAA5Rhl6wOanfGy9kxtf17omN8v4sffsu3HOTY=;
        fh=MJXMjpsdFCYwttIS4dV2RB+0YWQ38j/kMFtzQgPXauk=;
        b=Fj0JZC+eSINmr8yAc3yK3GqnXMYtbhBiAjbDf5+KrnTx1S4Td2JjpWc2Tv8ArimI4K
         SoWVOrbzyePG3Cw/EuXgjMuBITo8jGzpOYWsUWMCRLM1306jHCQQMQAXluWZ/gf5tqg2
         b8Sc4blB1RT7MtacCIjwphU6siXlerxcazDijMz82JDQmgnRfDPclYYBlHmj3obkpAtJ
         b1T6g69UMrQMJE997DVsjZpu2Qol0djfiRjdEGD3YE+hPnfele8DtuNrgVMSfqVI3XzV
         O+d6FkT8MQE/zlg1pdmIf8IA7rGiSm4QqW9Ud43ytghrZbvqBk9Gr8BAi0+NjLu27TXR
         GVow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771107535; x=1771712335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkTOOQAA5Rhl6wOanfGy9kxtf17omN8v4sffsu3HOTY=;
        b=YPytxH/BAl1pG1jyXBgzxBcrDu4IqDn9fH0g//SjjS/a5SUyxWGLR6zGtR4f4WgfEn
         lT71a1RIXUlocTFfrhnrnNh1NAFNRavowtCse1H8kK/EwFtTTPm0oYOqTtpiN+Wh/Qka
         E1AD7jq20bptt0T9x/wC6UXVIjey/ttdtGDGRC/+Nqxl8Hq3MQqnVQmKZpI4zvPYHmy9
         1yNvTuu7tacAdrYWkFH9kzRV/l0TFnrHkmuuPcYU4nm4lWFJvtBV/lz+ihrs86LIWDsV
         46KfclBPHMDOzIKCjdvPpepm8qkXBboVBaYkhszK+rCApI7/OOFJjDipqT/9ngVd6nlB
         ssEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771107535; x=1771712335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jkTOOQAA5Rhl6wOanfGy9kxtf17omN8v4sffsu3HOTY=;
        b=HfDzrd7M+B259WroovtYnQLEZ/MLw/UNWf935By7TOqnJxkz6B3ztzEGw7lkcd/idR
         U813lsGc3py/ifTYJkd1ABs0DR7wCtX/Qg8mtFZJda4ZT7ct06wcaOBawYgQFikIITtn
         iGs8Vc4XqAyDfQdIQPnZ9uKPnYxWXz/ydX3y1d3KwYhfOV7VehJLTGQc2kSthbKMtfm/
         dv0q+6VMJOAX4CLOyzxHzPkiUV84kDfDqJ49zsz2iohAeFKxOswjgbsmvLxgeEgBFsSh
         4q4dv2KzBibEtgqnxIH3hkSyIjyIDiokXL8+TvWZJaZIUG91Hszp8ZnBBu27iwjtv6vj
         QF5w==
X-Forwarded-Encrypted: i=1; AJvYcCUwdkl4UPE/Eo4XaN9eBpyzf+XqmTDOPqTi9uowUtUKN+2hPy01cNQ9eqrai5qO9D7CU2IxtoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4loq+PlsUIS+2jLD/FQeogxOMoBIYTiOFhTWNsrZnkf6kv4D
	t3h4jvik8ONIJu3UmwLAOgRu7lnXfAL1r7xD0XK6v4ERXfo8VaCT7ahZTv23zoXBjUgPKpu/618
	5KoKhncH5TVTL5UyjaHwuuX0de9KfSBo=
X-Gm-Gg: AZuq6aJlXfPuEEGuwQnegrDxVVDBbvB7aImtHQjdBOBEu4IFg7vkMo6Kj9vGMl9D21T
	4bE0bNnOzmJg5cjiVg/k41XzUUszF2naTe94CED3HrVp1x7ZmCSDvMVO4UoGf6NKYRSMLWO7mT1
	Gjs1hFwzzSrIektfQHZ1XW9m4cTM7KilxIYx5TpVyjed9mQr752Y2pZQPsM+9ZQv7m47NrnO2KR
	G8uySwGUov/y1hob9zYZF5YciXQRoS0IGLd4j6I4giDJKUHstFYdci2/BUuL4KMfgnYP49N+D8s
	Z53XjGK7R/pKEs2zZSHnNXqtnyk/VeJ33+2EXZdSoE/MjaJ46PLrJxjxbEU8qHiqmJMdpopfJNa
	FBrN8KqrgDLrWImE8IRPt6cI6
X-Received: by 2002:a05:7301:608b:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2baba0dc237mr1177734eec.5.1771107534544; Sat, 14 Feb 2026
 14:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214133337.112720-1-xry111@xry111.site>
In-Reply-To: <20260214133337.112720-1-xry111@xry111.site>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Feb 2026 23:18:42 +0100
X-Gm-Features: AaiRm516VoA-BlaE52MerAybt9vzW03a3XJ43B7kMfls6jQhlQBhFNpxDHrNq5A
Message-ID: <CANiq72naHZT+CuuMBFAoKmzTjVRZpicL+Wo9ai3QY5Rja-v1sA@mail.gmail.com>
Subject: Re: [PATCH v2] rust_binder: Fix build failure if !CONFIG_COMPAT
To: Xi Ruoyao <xry111@xry111.site>
Cc: Alice Ryhl <aliceryhl@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Mingcong Bai <jeffbai@aosc.io>, loongarch@lists.linux.dev, 
	hev <r@hev.cc>, Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216594-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,kernel.org,xen0n.name,aosc.io,lists.linux.dev,hev.cc,vger.kernel.org,linuxfoundation.org,android.com,gmail.com,paul-moore.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,xry111.site:email]
X-Rspamd-Queue-Id: 2BFA313DB15
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 2:34=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/all/CANiq72mrVzqXnAV=3DHy2XBOonLHA6YQgH-c=
kZoc_h0VBvTGK8rA@mail.gmail.com/

Hmm... Wasn't this applied as:

  174e2a339bf7 ("rust_binder: Fix build failure if !CONFIG_COMPAT")

Then there was also this other thread:

  https://lore.kernel.org/rust-for-linux/20260105-redefine-compat_ptr_ioctl=
-v1-1-25edb3d91acc@google.com/

which got applied as:

  68aabb29a546 ("rust: redefine `bindings::compat_ptr_ioctl` in Rust")

Cheers,
Miguel

