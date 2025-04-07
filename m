Return-Path: <stable+bounces-128583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D234A7E653
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C87116C5E1
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69D2135D8;
	Mon,  7 Apr 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHjkiQCJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994B20A5D6
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042439; cv=none; b=q+nWlIRbuH4bXP+vRS36GS/2U/OZjkvsIgbTkfTJej3nGIH+yUTCE+nM+RQ68BxwVEL6YR1F+/aTlaKhGBVC1qj+su9p9K1smOcGYSOAUp+1Hx9RfRexHUuVvsHR8RkteS05o6FDlP0XGIw+/3f2/bkKRP6StU5BMmypFiQZCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042439; c=relaxed/simple;
	bh=yXGsrki8kfI3lKdKj8xB169bMsZdM/bVZ17mJE+rFZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLT+v3DOyomET+N6hhDWVDpbPzqs3gKI5b3ZoO21aPru90Mjn/qmPA/EZYJep+2Cv2KlEgaiRxkQM4tsmW85fQlM/mNxuSa1Vk5BuM7+2IgN5vIwE7wnsBRdJssjWM3WL37J4dsFIPSYr3UumR08lDdhfFYz33Thut2NjYS8R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHjkiQCJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47681dba807so539861cf.1
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744042436; x=1744647236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A/poKUEFANRwqNUNfr6r+UCigCdwi2GG/NsmqPgzHw=;
        b=wHjkiQCJoHzUnoJtARD1Cyg/Ws5fiuBUPr4r1cxQo+4Ftv+I3CfuoHlZjJjoXvN9wh
         q+EKEdemVUvPvRdHSM8ERwRtqWF8W4MI6S6Z0kAmU+XY0ionNLRE6hGjbf90hfqWqkG7
         77ipWBbPR+0bRPWfFzV32onKuAPgLHU98bMIaH7yOKbhl3muUPaWvQzEx+GdIRdlW8zl
         pGtGum0P86HdEEd4zgXsLlM4+kQ/c4GvbY9P0130EDTnTLHJeLT8BMet0nem5Jbs0M4i
         MPPc8w0aobaQFlm1VVMIA88h2vtIG8lOQ0YmlPi1o3Q+TLTwhhlIb9aIIsfE6jhKbJ1H
         a+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042436; x=1744647236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A/poKUEFANRwqNUNfr6r+UCigCdwi2GG/NsmqPgzHw=;
        b=ZDQTV60aQVTirvBau0KxaIJlJIrxOBJmoh6h6g0GMPHfq6VzM/VlcofDvqKwHJC6m4
         KIuTAGqFdF1vG0JzwuyuKfP4sAsYZ0fPfSfXIeNrYRd1/C/gq8Z4bmebPFCSKeX/CRDU
         VWweJttXbAqSnRhuwKuPD/EaDcSvGzjA7btAQFu+Xq6pm6IZNp+IH3bk5WL7m6sUOk83
         eOc/bEgSnapy8mEvnPq/fL8tQVnUlaYgrSkWmP22INpDzeChvfRYzGXxRibMI3uGWGYE
         hbMfXjyvHpWVzCqYvzHZYIZJmZ3pgoS6NRz6in1keq6sQlgDvl7T55fuMH9GM5Sb9vDd
         P7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRlTeCgsmTY1l1B6LZNrkveTcjPrAsJkA3ZQXuV+5ebnEjQKjHwlEVdfPbQQTcrR49i/04RIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADIwe3odTfRe0Lvx2XN22Cs5sQDNAGlimdNPi2+AMd65IUfGd
	asuu67EpAp4nxlteaM9kavbGVb2sLMLzJtpNxfMnZD0T0pz9yc1ibOovNmVtd42LFPrPjTr7Zb7
	psIZ9yuIyZeLDvirlrMYx2jpdRBg3sKCvyVMn
X-Gm-Gg: ASbGnctvl70P2eO9U8BZC7NLhD1e5UFsmX6cGgEQjtD0DHl2o+JtCB02RiuwSztpXyI
	Y2aWgBNm4FY+2lGU3PKX4SQRZSn7TEhoPB3d93hWxaZv0TjLCbQ+nL8NW47BAvDSeXMcJeSCcNZ
	ixpec5qD8Pjz9KlRgl6u8M2F4k
X-Google-Smtp-Source: AGHT+IF3a3W7UoOSom3xcvtXGYUBqQmM2SLodWt6ZxO2hwyK4IY71dJPZFsCUxiYi9eTkWJmo/9y1LSlkGOx/1yk1Xw=
X-Received: by 2002:a05:622a:188d:b0:477:1f57:5493 with SMTP id
 d75a77b69052e-47953fbaeb5mr10131cf.20.1744042436227; Mon, 07 Apr 2025
 09:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330164229.2174672-1-varadgautam@google.com>
In-Reply-To: <20250330164229.2174672-1-varadgautam@google.com>
From: Varad Gautam <varadgautam@google.com>
Date: Mon, 7 Apr 2025 18:13:44 +0200
X-Gm-Features: ATxdqUEQc0bEHpn3hRXswH0d1qmEjsD8jwNtw3664JDWyonAkuYzF_Nvjd3_iSE
Message-ID: <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 6:42=E2=80=AFPM Varad Gautam <varadgautam@google.co=
m> wrote:
>
> With `CONFIG_TRACE_MMIO_ACCESS=3Dy`, the `{read,write}{b,w,l,q}{_relaxed}=
()`
> mmio accessors unconditionally call `log_{post_}{read,write}_mmio()`
> helpers, which in turn call the ftrace ops for `rwmmio` trace events
>
> This adds a performance penalty per mmio accessor call, even when
> `rwmmio` events are disabled at runtime (~80% overhead on local
> measurement).
>
> Guard these with `tracepoint_enabled()`.
>
> Signed-off-by: Varad Gautam <varadgautam@google.com>
> Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO access=
ors")
> Cc: <stable@vger.kernel.org>

Ping.

> ---
>  include/asm-generic/io.h | 98 +++++++++++++++++++++++++++-------------
>  1 file changed, 66 insertions(+), 32 deletions(-)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 3c61c29ff6ab..a9b5da547523 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -75,6 +75,7 @@
>  #if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MM=
IO__))
>  #include <linux/tracepoint-defs.h>
>
> +#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(tracepo=
int)
>  DECLARE_TRACEPOINT(rwmmio_write);
>  DECLARE_TRACEPOINT(rwmmio_post_write);
>  DECLARE_TRACEPOINT(rwmmio_read);
> @@ -91,6 +92,7 @@ void log_post_read_mmio(u64 val, u8 width, const volati=
le void __iomem *addr,
>
>  #else
>
> +#define rwmmio_tracepoint_enabled(tracepoint) false
>  static inline void log_write_mmio(u64 val, u8 width, volatile void __iom=
em *addr,
>                                   unsigned long caller_addr, unsigned lon=
g caller_addr0) {}
>  static inline void log_post_write_mmio(u64 val, u8 width, volatile void =
__iomem *addr,
> @@ -189,11 +191,13 @@ static inline u8 readb(const volatile void __iomem =
*addr)
>  {
>         u8 val;
>
> -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
>         __io_br();
>         val =3D __raw_readb(addr);
>         __io_ar(val);
> -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -204,11 +208,13 @@ static inline u16 readw(const volatile void __iomem=
 *addr)
>  {
>         u16 val;
>
> -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
>         __io_br();
>         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
>         __io_ar(val);
> -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -219,11 +225,13 @@ static inline u32 readl(const volatile void __iomem=
 *addr)
>  {
>         u32 val;
>
> -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
>         __io_br();
>         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
>         __io_ar(val);
> -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -235,11 +243,13 @@ static inline u64 readq(const volatile void __iomem=
 *addr)
>  {
>         u64 val;
>
> -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
>         __io_br();
>         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
>         __io_ar(val);
> -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -249,11 +259,13 @@ static inline u64 readq(const volatile void __iomem=
 *addr)
>  #define writeb writeb
>  static inline void writeb(u8 value, volatile void __iomem *addr)
>  {
> -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
>         __io_bw();
>         __raw_writeb(value, addr);
>         __io_aw();
> -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
>  }
>  #endif
>
> @@ -261,11 +273,13 @@ static inline void writeb(u8 value, volatile void _=
_iomem *addr)
>  #define writew writew
>  static inline void writew(u16 value, volatile void __iomem *addr)
>  {
> -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
>         __io_bw();
>         __raw_writew((u16 __force)cpu_to_le16(value), addr);
>         __io_aw();
> -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_)=
;
>  }
>  #endif
>
> @@ -273,11 +287,13 @@ static inline void writew(u16 value, volatile void =
__iomem *addr)
>  #define writel writel
>  static inline void writel(u32 value, volatile void __iomem *addr)
>  {
> -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
>         __io_bw();
>         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
>         __io_aw();
> -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_)=
;
>  }
>  #endif
>
> @@ -286,11 +302,13 @@ static inline void writel(u32 value, volatile void =
__iomem *addr)
>  #define writeq writeq
>  static inline void writeq(u64 value, volatile void __iomem *addr)
>  {
> -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
>         __io_bw();
>         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
>         __io_aw();
> -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_)=
;
>  }
>  #endif
>  #endif /* CONFIG_64BIT */
> @@ -306,9 +324,11 @@ static inline u8 readb_relaxed(const volatile void _=
_iomem *addr)
>  {
>         u8 val;
>
> -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
>         val =3D __raw_readb(addr);
> -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -319,9 +339,11 @@ static inline u16 readw_relaxed(const volatile void =
__iomem *addr)
>  {
>         u16 val;
>
> -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
>         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
> -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -332,9 +354,11 @@ static inline u32 readl_relaxed(const volatile void =
__iomem *addr)
>  {
>         u32 val;
>
> -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
>         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
> -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -345,9 +369,11 @@ static inline u64 readq_relaxed(const volatile void =
__iomem *addr)
>  {
>         u64 val;
>
> -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
>         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
> -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
>         return val;
>  }
>  #endif
> @@ -356,9 +382,11 @@ static inline u64 readq_relaxed(const volatile void =
__iomem *addr)
>  #define writeb_relaxed writeb_relaxed
>  static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
>  {
> -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
>         __raw_writeb(value, addr);
> -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
>  }
>  #endif
>
> @@ -366,9 +394,11 @@ static inline void writeb_relaxed(u8 value, volatile=
 void __iomem *addr)
>  #define writew_relaxed writew_relaxed
>  static inline void writew_relaxed(u16 value, volatile void __iomem *addr=
)
>  {
> -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
>         __raw_writew((u16 __force)cpu_to_le16(value), addr);
> -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_)=
;
>  }
>  #endif
>
> @@ -376,9 +406,11 @@ static inline void writew_relaxed(u16 value, volatil=
e void __iomem *addr)
>  #define writel_relaxed writel_relaxed
>  static inline void writel_relaxed(u32 value, volatile void __iomem *addr=
)
>  {
> -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
>         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
> -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_)=
;
>  }
>  #endif
>
> @@ -386,9 +418,11 @@ static inline void writel_relaxed(u32 value, volatil=
e void __iomem *addr)
>  #define writeq_relaxed writeq_relaxed
>  static inline void writeq_relaxed(u64 value, volatile void __iomem *addr=
)
>  {
> -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
>         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
> -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_)=
;
>  }
>  #endif
>
> --
> 2.49.0.472.ge94155a9ec-goog
>

