Return-Path: <stable+bounces-235756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIb4H8SL2mnd3ggAu9opvQ
	(envelope-from <stable+bounces-235756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:58:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93C3E1289
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A663301C936
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506DA3B774F;
	Sat, 11 Apr 2026 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kndfICZh"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A21A681D
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775930303; cv=pass; b=XaTIPw2wy/GYwYtclx68RUJfwWx4tfgv8vNJoFwYZ3/ohKp62EWLpkk+psYsrmOGcILb6bEBfR/k29nSn2oH3K2UiZ3C+OcLQJlPYzcV0ew6RWQSogH4DUGkmIVGsUmdtMNf2zMZaIgvjiDM0/9SdAOgCrclDVTEofh/9RDJ3J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775930303; c=relaxed/simple;
	bh=K9cNahQL7sU3k6YTlTe4h+cxu2W+ZHClkJ+CtHxghjQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=B89iMI8S7tuXitUYooCO1LqCMzc56VgwXUrlnK0550NIjNHFOw/1iZLJ5RCkgX2BqebRIecXYQqnqbd9sgQV+mzOYjW1aLO4fd/zI/LllLiSz/k2n1I8nfa7cRPXwnAtLHVraXuSgN21M9a09V3alMMyBeBE8Y1EKB/MYYMdj20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kndfICZh; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56db40716b9so161566e0c.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775930300; cv=none;
        d=google.com; s=arc-20240605;
        b=ewbFLoH1Sasz64OiQ5UjawXTygmCPxIQqbURkDa7lGEbVvEdLef90lPLlpfDfqm/ax
         rHnlF+a6BlSla6z4gKLXT5jvbiFuIiUFxK7anvMxEbxEKlPhs0rSfwLTaopG6KHo61C/
         px9dJVMf7aUH/i5rjiu7nBm3TrfQfY/x3m/4TvTb5q+zhSyIHMxaE22PjsRkhzP/w0UZ
         s60twyoL3RY2/HmKKgMP2u8N1TTPNrjO+a1zKdt0w01wOasl/+w0V2KO2JWTzhKliHPG
         57IvhY2H7StAOGaQr792aiu0lHf9LMHqNmUPQxz3asNpypoF4eSj3zmtdybDrW4vTzAi
         K83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=FQ9FMt2GgCLKM11biLesryR+G33OllgKjO21lfayfy8=;
        fh=4S4HyBGzQBQkQt7JVe3X2WOv35uGE7zdCfNBC2waqLo=;
        b=IYzcF09DsP/X5pWCbYlYUcoqkXYmn5deP6owOmJC6sbpu1iYX0LhVak/8tgRIsf8hn
         usMdPsNHhTph/SyxSZkD+vqQbaLXOWdacQNHKaM9n8its/2/LAfyPgWR6WkQtjlPTUr7
         w6zVU9UHf3MTKpIwi8Npt8dRXKwlNse4D/hPSunKEfcCplJsFbxaN6Oc5e5mx988lG0V
         PZDj2xytU8mxdj03t6v2r/Jg/qz3YLrJ/DgqWqEoU07EgorUqEV8AH0KsUuv6lQOiPY2
         yytijm1QgaBF8YMfjLYU226+HkA7hAGRNpR1JTN1HiFK1wMuBZ8jCLNPImN2360Tjx6m
         5p5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775930300; x=1776535100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ9FMt2GgCLKM11biLesryR+G33OllgKjO21lfayfy8=;
        b=kndfICZhttip+fX8FmKYYHNFF5k4HaUFdTaQOab8uOiFuPyvsd1+fALtpa1GJzzZEb
         qB/vx4yQIQjEXTMFoN7K+MgCpKRwVgWJjN63ihh8l3P+mspcwVSsC0zGecN9LUP2P8hu
         JDHi0uyTW8NSOYj8afPfGwi4hO56oi1c581yCLqz3KcMGTigbj8YPQag4VddSz7RxP59
         v1bX+1eG3VxkGKy3T87h/4isic7WEYfmYynhUUNYBUQETWJLp4Ybtfh5FOdKR7dQD8om
         d6oCU6u9Tsz8kPR6rW1ltgPk037SoQ3bNuuYnwJwaY0zvYU+d3pBLXc0xpQgsu0znMOM
         7ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775930300; x=1776535100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ9FMt2GgCLKM11biLesryR+G33OllgKjO21lfayfy8=;
        b=j2IPgrIhFE2HIpGRBTG2DkBxEUgIjAcrzSo1+ByB7PcGMkcGbKMNvR+2dxHgvccQiU
         CZeTHF+00iRk3ISRJDCG0HfS2q5Eo06G90RL6EnEWjfI+L4CjAKfj7bHOu13Nk3sDU7w
         EMgsRT/8I73HAgIsXh29Cd7Uga2EzICQq8XV/R7qNY/r1pcguODVmaetEPWR3eG9ITla
         QATLBIll2RzUf0ZU7LwDmzcegnLrxvKNNECoZz9vJ7sYmgq7w23veYoBVMf+5vsoXmS8
         FVUN7qNqUkxSYPJFiBkDKwss30N75QqwLvyGEQ2xidF9Nxp+3B+VuktFdZA61vZfCwq3
         qupg==
X-Forwarded-Encrypted: i=1; AJvYcCVYBUliQtkZUSm1eaHUOkvFGsBt5nyq9hNHE4S9XQDmsbLRt5o6d3XBFdXucGJ+ZLrXzDJsS2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPfEnTVtUryIQicq3djXUx9JPgr3qzZCTbyy9SqG08dVt60ET
	VEOa0C7bq/6MCptO1CD2LkZUzP7Baax89s2TrYOVVWVXe4O0T8ZhxO9TiJ/zi83m/7DZ8z+ujo4
	OV4pjJc+NqCQxZRApXF8660rKVkq6Ed1Pj7aRUP0=
X-Gm-Gg: AeBDiesAKKz9mnSTqanPHHjdW6c2q67rFDAH/aMRN6RMsIq15s1xQ5sRCooO/RY6Qlq
	AsRR6r7x71apzvxc1L/Xr/RYiZWPe50jYgcmrBFGSvtjJV4j4KAonCkGkO5tXcVct/o1x+XvoLf
	nvRE8zuXKrjBwARRIzAHCGYovabn/G90LgrewDaZPSJpP8NUnlw1iTfwJ4lsiKtTu52f+Pkl88G
	uOlSNV2kYNeu4JrBVIGC057M4omPjJMce/oqOpeheh9hOhRIgHzotBCl7Alw9cwU0MnE/zEbnby
	0R/JXScclEpPDyewAHSEIYapE5uZALmWL81j+4QJLkixca+utw==
X-Received: by 2002:a05:6122:3a01:b0:56f:4a47:6c9e with SMTP id
 71dfb90a1353d-56f4a478d9dmr853373e0c.2.1775930300446; Sat, 11 Apr 2026
 10:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Sat, 11 Apr 2026 23:28:08 +0530
X-Gm-Features: AQROBzC2X93QqIGjFT303XQHdrnkn9J_7FXOpIDUFvz6B4Lnw5sv8iW1g1B5zBA
Message-ID: <CALFbBidSiJTD2zdczQ1_mxv8Xm9Pqspnz8LDppHp2hudkLSoxw@mail.gmail.com>
Subject: MAX3420 UDC: out-of-bounds read/write via unvalidated wIndex in USB
 SETUP packet
To: linux-usb@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235756-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BA93C3E1289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I am reporting an out-of-bounds read and write in the MAX3420 USB
Device Controller driver. The issue arises from using a
host-controlled wIndex field from a USB SETUP packet as a direct index
into a fixed-size endpoint array without validating that the index is
within bounds.

The driver handles USB control requests originating from an external
USB host and therefore must treat all request fields as untrusted.

1. VERSION AND ENVIRONMENT

Research kernel: v7.0.0-rc7
Architecture: x86_64

Observed unpatched as of April 11, 2026

2. VULNERABILITY PATH

USB host (attacker-controlled SETUP packet)
 ->
MAX3420 hardware (SUDFIFO register)
 ->
max3420_handle_irqs()
 ->
max3420_handle_setup()
 ->
spi_rd_buf(..., MAX3420_REG_SUDFIFO, ...)
 ->
udc->setup =3D setup
udc->setup.wIndex =3D cpu_to_le16(setup.wIndex)
 ->
dispatch:
   -> max3420_getstatus()
   -> max3420_set_clear_feature()
 ->
wIndex masked and used as endpoint index
 ->
out-of-bounds access into udc->ep[] when the derived index exceeds the
array bounds

No validation of the derived index is observed along this path.

3. VULNERABILITY DESCRIPTION

The endpoint index is derived as:

    id =3D udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;

USB_ENDPOINT_NUMBER_MASK is 0x0f, producing values in the range 0=E2=80=931=
5.

The backing storage is:

    struct max3420_ep ep[MAX3420_MAX_EPS];

where:

    MAX3420_MAX_EPS =3D 4

Valid indices are therefore 0=E2=80=933. Values >=3D 4 will index beyond th=
e
bounds of the array.

4. SOURCE CODE ANALYSIS

4.1 Untrusted input propagation

    spi_rd_buf(udc, MAX3420_REG_SUDFIFO, (void *)&setup, 8);
    udc->setup =3D setup;
    udc->setup.wIndex =3D cpu_to_le16(setup.wIndex);

The SETUP packet contents are populated by the USB host and copied
into driver state without validation. The wIndex field is later used
in control flow and memory access decisions.

4.2 Direct indexing into fixed-size array

    ep =3D &udc->ep[udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK];

and:

    id =3D udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
    ep =3D &udc->ep[id];

There is no check ensuring the derived index is less than
MAX3420_MAX_EPS before dereferencing.

4.3 Affected call sites

The pattern appears in:

- max3420_getstatus()
- max3420_set_clear_feature()

Both paths derive an index from wIndex and use it to access udc->ep[].

4.4 Existing checks are not sufficient

    if (udc->setup.wIndex & USB_DIR_IN)

This condition only evaluates the direction bit and does not constrain
the endpoint number. It does not prevent out-of-bounds indexing.

4.5 Invariant violation

Regardless of protocol expectations, memory safety requires that any
externally influenced index used for array access be validated against
the array bounds.

Here, the code assumes the masked value is valid without enforcing
that constraint, which can lead to out-of-bounds access if unexpected
values are received.

5. IMPACT

Out-of-bounds read:

In max3420_getstatus(), fields are read from ep. If the index is
out-of-bounds, this may result in reading adjacent memory.

Out-of-bounds write:

In max3420_set_clear_feature(), fields within ep are modified
(including locking and state flags). If ep is out-of-bounds, this may
result in writes to unrelated memory.

Memory corruption characteristics:

Because ep[] is embedded within struct max3420_udc as a fixed-size array:

- out-of-bounds indexing accesses memory beyond the array within the same s=
truct
- this may overlap adjacent struct members depending on layout
- further out-of-bounds accesses may extend beyond the struct into
surrounding memory depending on allocation context

Trigger:

A malformed USB control request can supply an out-of-range wIndex
value, for example:

    bmRequestType =3D 0x02  (TYPE_STANDARD | RECIP_ENDPOINT)
    bRequest      =3D SET_FEATURE
    wValue        =3D ENDPOINT_HALT
    wIndex        =3D 0x0007
    wLength       =3D 0

This produces an index of 7, which exceeds the valid range [0=E2=80=933].

6. VALIDATION EXPECTATION

The driver processes externally supplied USB control requests and
should validate fields before using them in memory access operations.

Other UDC drivers typically constrain endpoint indices or validate
request parameters before indexing fixed-size arrays. The absence of
such validation here suggests a missing bounds check.

7. SUGGESTED FIX

Validate the derived endpoint index before accessing the array:

    id =3D udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;

    if (id >=3D MAX3420_MAX_EPS)
            goto stall;

This check should be applied consistently in both:

- max3420_getstatus()
- max3420_set_clear_feature()

8. AFFECTED VERSIONS

Affected: all kernels including the MAX3420 UDC driver
Fixed in: not yet patched

9. REACHABILITY ANALYSIS (CODE-LEVEL)

The vulnerable access is reachable through the standard USB control
request handling path.

9.1 Interrupt entry point

USB SETUP packet handling is triggered from the IRQ path:

    max3420_handle_irqs()

Relevant code:

    if (epirq & SUDAVIRQ) {
        spi_wr8(udc, MAX3420_REG_EPIRQ, SUDAVIRQ);
        max3420_handle_setup(udc);
        return true;
    }

Receipt of a SETUP packet (SUDAVIRQ) directly invokes max3420_handle_setup(=
).

9.2 SETUP packet ingestion from hardware

The SETUP packet is read directly from hardware:

    spi_rd_buf(udc, MAX3420_REG_SUDFIFO, (void *)&setup, 8);

    udc->setup =3D setup;
    udc->setup.wValue =3D cpu_to_le16(setup.wValue);
    udc->setup.wIndex =3D cpu_to_le16(setup.wIndex);
    udc->setup.wLength =3D cpu_to_le16(setup.wLength);

No validation or bounds checking is performed on wIndex before storing it.

9.3 Dispatch into request handlers

Standard USB requests are dispatched as follows:

    case USB_REQ_GET_STATUS:
        return max3420_getstatus(udc);

    case USB_REQ_CLEAR_FEATURE:
    case USB_REQ_SET_FEATURE:
        return max3420_set_clear_feature(udc);

This dispatch occurs without validating the endpoint index derived from wIn=
dex.

9.4 Out-of-bounds access in max3420_getstatus()

    ep =3D &udc->ep[udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK];

No bounds check is performed before dereferencing ep.

9.5 Out-of-bounds access in max3420_set_clear_feature()

    id =3D udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
    ep =3D &udc->ep[id];

No validation ensures id < MAX3420_MAX_EPS.

9.6 Array bounds vs index range

Array definition:

    struct max3420_ep ep[MAX3420_MAX_EPS];
    #define MAX3420_MAX_EPS 4

Valid indices: 0=E2=80=933. Index derivation produces values 0=E2=80=9315. =
Values >=3D 4
result in out-of-bounds access.

9.7 End-to-end reachability

    USB host =E2=86=92 SETUP packet
        =E2=86=92 MAX3420_REG_SUDFIFO
        =E2=86=92 spi_rd_buf(...)
        =E2=86=92 udc->setup.wIndex (unvalidated)
        =E2=86=92 max3420_getstatus() / max3420_set_clear_feature()
        =E2=86=92 ep =3D &udc->ep[id]
        =E2=86=92 out-of-bounds access when id >=3D 4

This path requires only a valid USB control request targeting an
endpoint and does not rely on undefined behavior or malformed packet
structure.

10. RUNTIME EVIDENCE (USERSPACE HARNESS)

Hardware emulation for the MAX3420 SPI controller is unavailable in
QEMU. A userspace harness was constructed that reconstructs the
vulnerable struct layout and control flow from max3420_udc.c verbatim,
feeding attacker-controlled SETUP packet fields directly into the
dispatch path. AddressSanitizer confirms the out-of-bounds write at
the exact offset predicted by the struct layout analysis.

Build:

    gcc -fsanitize=3Daddress,undefined -g -O0 -o max3420_poc max3420_oob_ha=
rness.c

Trigger packet (wIndex=3D0x0007, derived id=3D7):

    bmRequestType =3D 0x02
    bRequest      =3D SET_FEATURE
    wValue        =3D ENDPOINT_HALT
    wIndex        =3D 0x0007
    wLength       =3D 0x0000

ASan output:

    max3420_oob_harness.c:154:26: runtime error: index 7 out of bounds
for type 'max3420_ep [4]'
    ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c78019e0680
    WRITE of size 1 at 0x7c78019e0680 thread T0
        #0 max3420_set_clear_feature  max3420_oob_harness.c:163
        #1 run_test                   max3420_oob_harness.c:223
        #2 main                       max3420_oob_harness.c:282
    0x7c78019e0680 is located 168 bytes after 280-byte region
    SUMMARY: AddressSanitizer: heap-buffer-overflow in max3420_set_clear_fe=
ature

Struct layout confirms ep[4] overlaps irq_registered at offset 256.
ep[7] lands 168 bytes past the struct boundary. The harness source is
available on request.

Regards,
Pavitra Jha
jhapavitra98@gmail.com

